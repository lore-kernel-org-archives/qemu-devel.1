Received: from eggs.gnu.org ([2001:4830:134:3::10]:53215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fJes5-0003g3-IV
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fJes2-0007ZY-EY
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:52:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46116
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.ibm.com>)
	id 1fJes2-0007YZ-75
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:52:30 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4IChrSc039497
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 08:52:29 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j1xba2ja0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 08:52:28 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.ibm.com>;
	Fri, 18 May 2018 06:52:27 -0600
References: <20180517192325.8335-1-danielhb@linux.ibm.com>
	<20180517192325.8335-4-danielhb@linux.ibm.com>
	<87vablgxhz.fsf@dusky.pond.sub.org>
From: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Date: Fri, 18 May 2018 09:52:23 -0300
MIME-Version: 1.0
In-Reply-To: <87vablgxhz.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <a5065f6d-1c55-5a0d-9000-de8d920ef088@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v7 3/3] qmp.c: system_wakeup: runstate and
 wake-up support check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com



On 05/18/2018 05:48 AM, Markus Armbruster wrote:
> This affects both QMP and HMP.  Let's rephrase the title to
>
>      qmp hmp: Make system_wakeup check wake-up support and run state
>
> Can do that in my tree.

I can rename the commit name, and handle the other suggestions you
made below, in the respin I'll end up making due to the changes
about to happen in patch 1. No problem.

I've cited 'query-target' all over the patch series too. All these 
references
will need to be changed with the new API of the flag (query-machines seems
to be the favorite so far). It's easier to just resend everything 
up-to-date.


Thanks,


Daniel

>
> Daniel Henrique Barboza <danielhb@linux.ibm.com> writes:
>
>> The qmp/hmp command 'system_wakeup' is simply a direct call to
>> 'qemu_system_wakeup_request' from vl.c. This function verifies if
>> runstate is SUSPENDED and if the wake up reason is valid before
>> proceeding. However, no error or warning is thrown if any of those
>> pre-requirements isn't met. There is no way for the caller to
>> differentiate between a successful wakeup or an error state caused
>> when trying to wake up a guest that wasn't suspended.
>>
>> This means that system_wakeup is silently failing, which can be
>> considered a bug. Adding error handling isn't an API break in this
>> case - applications that didn't check the result will remain broken,
>> the ones that check it will have a chance to deal with it.
>>
>> Adding to that, recent changes in query-target added a new flag called
> "... the commit before previous extended query-target with a new flag..."
>
>> wakeup-suspend-support that indicates if the guest has the capability
>> of waking up from suspended state. Although such guest will never
>> reach SUSPENDED state and erroring it out in this scenario would
>> suffice, it is more informative for the user to differentiate between a
>> failure because the guest isn't suspended versus a failure because the
>> guest does not have support for wake up at all.
>>
>> All this considered, this patch changes qmp_system_wakeup to:
>>
>> - check if the guest has the capability to wake-up from suspend. If
>> not, error out informing about the lack of support;
>>
>> - make the runstate verification before proceeding to call
>> qemu_system_wakeup_request, firing up an error message if the user tries
>> to wake up a machine that isn't in SUSPENDED state.
>>
>> After this patch, this is the output of system_wakeup in a guest that
>> does not have wake-up from suspend support (ppc64):
>>
>> (qemu) system_wakeup
>> wake-up from suspend is not supported by this guest
>> (qemu)
>>
>> And this is the output of system_wakeup in a x86 guest that has the
>> support but isn't suspended:
>>
>> (qemu) system_wakeup
>> Unable to wake up: guest is not in suspended state
>> (qemu)
> The examples are a nice touch.
>
>> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.ibm.com>
>> ---
>>   hmp.c          |  4 +++-
>>   qapi/misc.json |  3 ++-
>>   qmp.c          | 10 ++++++++++
>>   3 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/hmp.c b/hmp.c
>> index ef93f4878b..d177d14cc9 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -1156,7 +1156,9 @@ void hmp_cont(Monitor *mon, const QDict *qdict)
>>   
>>   void hmp_system_wakeup(Monitor *mon, const QDict *qdict)
>>   {
>> -    qmp_system_wakeup(NULL);
>> +    Error *err = NULL;
> Blank line between declaration and statement, please.  Happy to touch
> this up in my tree.
>
>> +    qmp_system_wakeup(&err);
>> +    hmp_handle_error(mon, &err);
>>   }
>>   
>>   void hmp_nmi(Monitor *mon, const QDict *qdict)
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index efba0449a6..73bfc3e436 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json
>> @@ -1247,7 +1247,8 @@
>>   #
>>   # If the guest has wake-up from suspend support enabled
>>   # (wakeup-suspend-support flag from query-target), wakeup guest from
>> -# suspend. Does nothing otherwise.
>> +# suspend if the guest is in SUSPENDED state. Returns an error
>> +# otherwise.
>>   #
>>   # Since:  1.1
>>   #
>> diff --git a/qmp.c b/qmp.c
>> index 25fdc9a5b2..5366e963ad 100644
>> --- a/qmp.c
>> +++ b/qmp.c
>> @@ -205,6 +205,16 @@ void qmp_cont(Error **errp)
>>   
>>   void qmp_system_wakeup(Error **errp)
>>   {
>> +    if (!qemu_wakeup_suspend_support()) {
>> +        error_setg(errp,
>> +                   "wake-up from suspend is not supported by this guest");
>> +        return;
>> +    }
>> +    if (!runstate_check(RUN_STATE_SUSPENDED)) {
>> +        error_setg(errp,
>> +                   "Unable to wake up: guest is not in suspended state");
>> +        return;
>> +    }
>>       qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
>>   }
