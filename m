Received: from eggs.gnu.org ([2001:4830:134:3::10]:48161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fW2xL-00064c-JO
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fW2xJ-0001sA-4q
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:01:11 -0400
References: <20180621163522.100968-1-borntraeger@de.ibm.com>
	<f21788b0-6417-dddb-fd5e-9dd9d17cfc66@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9e4312c4-4694-e15d-84be-7bcd35decb6b@redhat.com>
Date: Thu, 21 Jun 2018 19:01:04 +0200
MIME-Version: 1.0
In-Reply-To: <f21788b0-6417-dddb-fd5e-9dd9d17cfc66@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390/ipl: fix ipl with -no-reboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

On 21.06.2018 18:51, Christian Borntraeger wrote:
> 
> 
> On 06/21/2018 06:35 PM, Christian Borntraeger wrote:
>> kexec/kdump as well as the bootloader use a subcode of diagnose 308
>> that is supposed to reset the subsystem but not comprise a full
>> "reboot". With the latest refactoring this is now broken when
>> -no-reboot is used. This for example break virt-install from
>> iso images.
> 
> Its even worse. With this patch I can IPL with --no-reboot, but
> virt-install still creates an xml like
> 
>   <on_poweroff>destroy</on_poweroff>
>   <on_reboot>destroy</on_reboot>
>   <on_crash>destroy</on_crash>
> 
> With you patch a "soft reset" still seems to trigger an qapi event
> so that libvirt kills the guest due to that...

Either


> 
>>
>> We need to mark these "soft" reboots as ok for rebooting.
>>
>> Fixes: a30fb811cbe9 (s390x: refactor reset/reipl handling)
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  hw/s390x/ipl.c          | 8 +++++++-
>>  include/sysemu/sysemu.h | 3 +++
>>  vl.c                    | 2 +-
>>  3 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 0d67349004..ade6896af6 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -535,7 +535,13 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
>>              ipl->iplb_valid = s390_gen_initial_iplb(ipl);
>>          }
>>      }
>> -    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>> +    if (reset_type == S390_RESET_MODIFIED_CLEAR ||
>> +        reset_type == S390_RESET_LOAD_NORMAL) {
>> +        /* ignore -no-reboot */
>> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET_FORCE);
>> +    } else {
>> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>> +    }
>>      /* as this is triggered by a CPU, make sure to exit the loop */
>>      if (tcg_enabled()) {
>>          cpu_loop_exit(cs);
>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>> index e893f72f3b..345369d924 100644
>> --- a/include/sysemu/sysemu.h
>> +++ b/include/sysemu/sysemu.h
>> @@ -44,6 +44,9 @@ typedef enum ShutdownCause {
>>                                       turns that into a shutdown */
>>      SHUTDOWN_CAUSE_GUEST_PANIC,   /* Guest panicked, and command line turns
>>                                       that into a shutdown */
>> +    SHUTDOWN_CAUSE_GUEST_RESET_FORCE,/* Guest reset that should ignore
>> +                                        --no-reboot. This is useful for reset
>> +                                        like actions as s390 kexec/kdump */
>>      SHUTDOWN_CAUSE__MAX,
>>  } ShutdownCause;
>>  
>> diff --git a/vl.c b/vl.c
>> index b3426e03d0..722c3b9963 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -1674,7 +1674,7 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
>>  
>>  void qemu_system_reset_request(ShutdownCause reason)
>>  {
>> -    if (no_reboot) {
>> +    if (no_reboot && reason != SHUTDOWN_CAUSE_GUEST_RESET_FORCE) {
>>          shutdown_requested = reason;
>>      } else {
>>          reset_requested = reason;
>>
> 

Maybe

SHUTDOWN_CAUSE_GUEST_RESET_FORCE -> SHUTDOWN_CAUSE_GUEST_RESET_INTERNAL

diff --git a/vl.c b/vl.c
index b3426e03d0..198285be4b 100644
--- a/vl.c
+++ b/vl.c
@@ -1628,7 +1628,7 @@ void qemu_system_reset(ShutdownCause reason)
     } else {
         qemu_devices_reset();
     }
-    if (reason) {
+    if (reason != SHUTDOWN_CAUSE_GUEST_RESET_INTERNAL) {
         qapi_event_send_reset(shutdown_caused_by_guest(reason),
                               &error_abort);
     }


Or revert ;)

-- 

Thanks,

David / dhildenb
