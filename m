Received: from eggs.gnu.org ([2001:4830:134:3::10]:56605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnR0E-0007JS-PM
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnR09-0006JK-TY
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:03:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dnR09-0006J6-Ng
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:03:25 -0400
References: <20170830170601.15855-1-david@redhat.com>
	<20170830170601.15855-9-david@redhat.com>
	<20170831164142.607711ec.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9beeb7d0-edb8-2227-3182-9275567b2fb5@redhat.com>
Date: Thu, 31 Aug 2017 17:03:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170831164142.607711ec.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 08/11] s390x: allow only 1 CPU with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>

On 31.08.2017 16:41, Cornelia Huck wrote:
> On Wed, 30 Aug 2017 19:05:58 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Specifying more than 1 CPU (e.g. -smp 5) leads to SIGP errors (the
>> guest tries to bring these CPUs up but fails), because we don't support
>> multiple CPUs on s390x under TCG.
>>
>> Let's bail out if more than 1 are specified, so we don't raise people's
>> hope.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 7754e3eaf9..eff96808c4 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -23,6 +23,7 @@
>>  #include "hw/s390x/css.h"
>>  #include "virtio-ccw.h"
>>  #include "qemu/config-file.h"
>> +#include "qemu/error-report.h"
>>  #include "s390-pci-bus.h"
>>  #include "hw/s390x/storage-keys.h"
>>  #include "hw/s390x/storage-attributes.h"
>> @@ -56,6 +57,11 @@ static void s390_init_cpus(MachineState *machine)
>>      if (machine->cpu_model == NULL) {
>>          machine->cpu_model = s390_default_cpu_model_name();
>>      }
>> +    if (tcg_enabled() && max_cpus > 1) {
>> +        error_report("Number of SMP CPUs requested (%d) exceeds max CPUs "
>> +                     "supported by TCG (1) on s390x", max_cpus);
> 
> Make this a #define, so we can just flip the switch when smp support is
> ready?

As an alternative: yield a warning?

> 
>> +        exit(1);
>> +    }
>>  
>>      ms->cpus = g_new0(S390CPU *, max_cpus);
>>  
> 


-- 

Thanks,

David
