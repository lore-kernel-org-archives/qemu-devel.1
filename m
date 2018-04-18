Received: from eggs.gnu.org ([2001:4830:134:3::10]:37912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f8nlq-0006yD-Kf
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f8nlk-0001yl-M9
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:09:14 -0400
References: <20180412192602.13430-1-david@redhat.com>
	<7283d8e8-67ca-4450-d06c-c39c6981273d@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3ee4320b-a9a4-2c2d-e326-b681d6579a95@redhat.com>
Date: Wed, 18 Apr 2018 16:09:06 +0200
MIME-Version: 1.0
In-Reply-To: <7283d8e8-67ca-4450-d06c-c39c6981273d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] s390x: refactor reset/reipl handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On 18.04.2018 16:08, Thomas Huth wrote:
> On 12.04.2018 21:26, David Hildenbrand wrote:
>> Calling pause_all_vcpus()/resume_all_vcpus() from a VCPU thread might
>> not be the best idea. As pause_all_vcpus() temporarily drops the qemu
>> mutex, two parallel calls to pause_all_vcpus() can be active at a time,
>> resulting in a deadlock. (either by two VCPUs or by the main thread and a
>> VCPU)
>>
>> Let's handle it via the main loop instead, as suggested by Paolo. If we
>> would have two parallel reset requests by two different VCPUs at the
>> same time, the last one would win.
>>
>> We use the existing ipl device to handle it. The nice side effect is
>> that we can get rid of reipl_requested.
>>
>> This change implies that all reset handling now goes via the common
>> path, so "no-reboot" handling is now active for all kinds of reboots.
>>
>> Let's execute any CPU initialization code on the target CPU using
>> run_on_cpu.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>
>> Did only a quick check with TCG. I think this way it is way easier to
>> control what is getting reset.
>>
>>  hw/s390x/ipl.c                     | 44 ++++++++++++++++++++++++---
>>  hw/s390x/ipl.h                     | 16 ++++++++--
>>  hw/s390x/s390-virtio-ccw.c         | 49 +++++++++++++++++++++++++-----
>>  include/hw/s390x/s390-virtio-ccw.h |  2 --
>>  target/s390x/cpu.h                 | 26 ++++++++++++++++
>>  target/s390x/diag.c                | 61 +++-----------------------------------
>>  target/s390x/internal.h            |  6 ----
>>  target/s390x/kvm.c                 |  2 +-
>>  8 files changed, 127 insertions(+), 79 deletions(-)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index fb554ab156..f7589d20f1 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -26,6 +26,7 @@
>>  #include "qemu/config-file.h"
>>  #include "qemu/cutils.h"
>>  #include "qemu/option.h"
>> +#include "exec/exec-all.h"
>>  
>>  #define KERN_IMAGE_START                0x010000UL
>>  #define KERN_PARM_AREA                  0x010480UL
>> @@ -484,11 +485,22 @@ IplParameterBlock *s390_ipl_get_iplb(void)
>>      return &ipl->iplb;
>>  }
>>  
>> -void s390_reipl_request(void)
>> +void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
>>  {
>>      S390IPLState *ipl = get_ipl_device();
>>  
>> -    ipl->reipl_requested = true;
>> +    if (reset_type == S390_RESET_EXTERNAL || reset_type == S390_RESET_REIPL) {
>> +        /* let's always use CPU 0 */
>> +        ipl->reset_cpu = NULL;
>> +    } else {
>> +        ipl->reset_cpu = cs;
>> +    }
>> +    ipl->reset_type = reset_type;
>> +
>> +    if (reset_type != S390_RESET_REIPL) {
>> +        goto no_reipl;
> 
> Could we please avoid goto in this case and simply put the code below
> into a "if (reset_type == S390_RESET_REIPL)" block?
> 

Sure, I wanted to keep changes this RFC minimal for better overview.

>> +    }
>> +
>>      if (ipl->iplb_valid &&
>>          !ipl->netboot &&
>>          ipl->iplb.pbt == S390_IPL_TYPE_CCW &&
>> @@ -505,7 +517,32 @@ void s390_reipl_request(void)
>>              ipl->iplb_valid = s390_gen_initial_iplb(ipl);
>>          }
>>      }
>> +no_reipl:
>>      qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>> +    /* as this is triggered by a CPU, make sure to exit the loop */
>> +    if (tcg_enabled()) {
>> +        cpu_loop_exit(cs);
>> +    }
>> +}
> 
>  Thomas
> 


-- 

Thanks,

David / dhildenb
