Received: from eggs.gnu.org ([2001:4830:134:3::10]:40933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fXmjc-0006zP-6f
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fXmjW-0001hk-7X
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:06:12 -0400
References: <20180625115352.6889-1-david@redhat.com>
	<20180625115352.6889-6-david@redhat.com>
	<70637e9f-6fd6-a92e-0d2e-878f23460ac3@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <384da416-9ce3-30aa-7bff-0ff0652cb8f4@redhat.com>
Date: Tue, 26 Jun 2018 14:06:00 +0200
MIME-Version: 1.0
In-Reply-To: <70637e9f-6fd6-a92e-0d2e-878f23460ac3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 5/9] s390x/tcg: properly
 implement the TOD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

>> +    td->base = *tod;
>> +
>> +    td->base.low -= time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
>> +    if (tod->low < td->base.low) {
> 
> Just a matter of taste, but I'd rather use "td->base.low > tod->low"
> here instead (since the operations before and after the if-statement are
> related to td->base).

Changed.

> 
>> +        td->base.high--;
>> +    }
>> +
>> +    /*
>> +     * The TOD has been changed and we have to recalculate the CKC values
>> +     * for all CPUs. We do this asynchronously, as "SET CLOCK should be
>> +     * issued only while all other activity on all CPUs .. has been
>> +     * suspended".
>> +     */
>> +    CPU_FOREACH(cpu) {
>> +        async_run_on_cpu(cpu, tcg_s390_tod_updated, RUN_ON_CPU_NULL);
>> +    }
>>  }
>>  
>>  static void qemu_s390_tod_class_init(ObjectClass *oc, void *data)
>> @@ -34,10 +58,24 @@ static void qemu_s390_tod_class_init(ObjectClass *oc, void *data)
>>      tdc->set = qemu_s390_tod_set;
>>  }
>>  
>> +static void qemu_s390_tod_init(Object *obj)
>> +{
>> +    S390TODState *td = S390_TOD(obj);
>> +    struct tm tm;
>> +
>> +    qemu_get_timedate(&tm, 0);
>> +    td->base.high = 0;
>> +    td->base.low = TOD_UNIX_EPOCH + (time2tod(mktimegm(&tm)) * 1000000000ULL);
>> +    if (td->base.low < TOD_UNIX_EPOCH) {
>> +        td->base.high += 1;
>> +    }
>> +}
> 
> Nit: It would be sufficient to do this in the realize() function instead.

Then I'll have to overwrite the realize function and store the
parent_realize function - something that I want to avoid if not really
necessary.

(for now it was also done in the cpu initfn, so that should be fine)

> 
>>  static TypeInfo qemu_s390_tod_info = {
>>      .name = TYPE_QEMU_S390_TOD,
>>      .parent = TYPE_S390_TOD,
>>      .instance_size = sizeof(S390TODState),
>> +    .instance_init = qemu_s390_tod_init,
>>      .class_init = qemu_s390_tod_class_init,
>>      .class_size = sizeof(S390TODClass),
>>  };
> [...]
>> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
>> index dd5273949b..be341b5295 100644
>> --- a/target/s390x/misc_helper.c
>> +++ b/target/s390x/misc_helper.c
>> @@ -28,6 +28,8 @@
>>  #include "qemu/timer.h"
>>  #include "exec/exec-all.h"
>>  #include "exec/cpu_ldst.h"
>> +#include "qapi/error.h"
>> +#include "tcg_s390x.h"
>>  
>>  #if !defined(CONFIG_USER_ONLY)
>>  #include "sysemu/cpus.h"
>> @@ -39,6 +41,7 @@
>>  #include "hw/s390x/ioinst.h"
>>  #include "hw/s390x/s390-pci-inst.h"
>>  #include "hw/boards.h"
>> +#include "hw/s390x/tod.h"
>>  #endif
>>  
>>  /* #define DEBUG_HELPER */
>> @@ -138,25 +141,32 @@ void HELPER(spx)(CPUS390XState *env, uint64_t a1)
>>  /* Store Clock */
>>  uint64_t HELPER(stck)(CPUS390XState *env)
>>  {
>> -    uint64_t time;
>> +    S390TODState *td = s390_get_todstate();
>> +    S390TODClass *tdc = S390_TOD_GET_CLASS(td);
>> +    S390TOD tod;
>>  
>> -    time = env->tod_offset +
>> -        time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
>> -
>> -    return time;
>> +    tdc->get(td, &tod, &error_abort);
>> +    return tod.low;
>>  }
>>  
>>  /* Set Clock Comparator */
>>  void HELPER(sckc)(CPUS390XState *env, uint64_t time)
>>  {
>> +    S390TODState *td = s390_get_todstate();
>> +    S390TODClass *tdc = S390_TOD_GET_CLASS(td);
>> +    S390TOD tod_base;
>> +
>>      if (time == -1ULL) {
>>          return;
>>      }
>>  
>>      env->ckc = time;
>>  
>> +    tdc->get(td, &tod_base, &error_abort);
>> +    tod_base.low -= time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> 
> So the tdc->get first adds the time2tod, and then you subtract it here
> again? Can't you simply use td->base.low directly instead?

That might be a good idea, previously I had tdc->get_base(), but dropped
it because it cannot be implemented for KVM.

Simply accessing the member here should be fine. Thanks!

> 
>>      /* difference between origins */
>> -    time -= env->tod_offset;
>> +    time -= tod_base.low;
>>  
>>      /* nanoseconds */
>>      time = tod2time(time);
>> @@ -164,6 +174,14 @@ void HELPER(sckc)(CPUS390XState *env, uint64_t time)
>>      timer_mod(env->tod_timer, time);
>>  }
> 
> ... I found only nits, so with or without my suggested modifications:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 


-- 

Thanks,

David / dhildenb
