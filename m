Received: from eggs.gnu.org ([2001:4830:134:3::10]:36858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eRGs7-0008JE-TN
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:19:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eRGs3-00065H-Pb
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:19:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47724
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eRGs3-00064j-Js
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:19:43 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBJCJ2j1106535
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 07:19:40 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ey1xxa231-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 07:19:39 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 19 Dec 2017 05:19:38 -0700
References: <20171218184428.15074-1-danielhb@linux.vnet.ibm.com>
	<20171218184428.15074-2-danielhb@linux.vnet.ibm.com>
	<87efnr81qs.fsf@dusky.pond.sub.org>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 19 Dec 2017 10:19:32 -0200
MIME-Version: 1.0
In-Reply-To: <87efnr81qs.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <a4277edc-37f6-8673-1883-b30f793d9d43@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qmp: marking qmp_cpu as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>



On 12/19/2017 08:12 AM, Markus Armbruster wrote:
> Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> writes:
>
>> qmp_cpu is a nop that was created a while ago in commit 755f196898
>> ("qapi: Convert the cpu command") for the sake of compatibility,
>> due to the existence of hmp_cpu.
> The compatibility argument makes no sense to me, but it's the reason the
> commit documented.
Reading the thread that added it back in 2011*, I am guessing that the
compatibility argument is based on the premise that every HMP command
should have a QMP counterpart. This also makes sense considering the
QAPI FAQ page I've mentioned a few days ago.
>
>> Today, there is no need or requirement to keep it as is. QMP is
>> meant to be as stateless as possible, thus any QMP command that
>> needs a specific monitor CPU setup should provide it in its
> s/should/must/
>
>> arguments, instead of relying in the current QMP monitor state.
>>
>> This patch flags qmp_cpu as deprecated in qemu-doc.texi,
>> qapi-schema.json and changes qmp_cpu body to show a deprecation
>> message if used.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> The "deprecation message" is actually a hard error.  This is unusual.
> When we deprecate an interface, we don't normally make its use fail, we
> just warn.  QMP doesn't provide a good way to warn, though.
>
> Let's compare behavior:
>
> 0. Status quo                       do nothing and succeed
> 1. Your patch                       fail with GenericError
> 2. Your patch less error_setg()     do nothing and succeed
> 3. Immediate removal                fail with CommandNotFound
>
> Does the difference between 1. and 3. matter at all?  Or is it just
> deprecation cargo cult?

Good point. If both the deprecation message and the removal will
result in error for the user ....

>
> Here's my take on it.  I'd prefer 3. Immediate removal.  I'd also be
> fine with 2. Your patch less error_setg(), followed by removal after the
> customary deprecation period.  1. plus later removal just doesn't make
> sense to me, but it's really no big deal, so if you guys want it...

It all goes down to whether we consider qmp_cpu, a QMP command that does
nothing since its creation and apparently no one ever used it, a 
feature. If it's a
feature, then I vote for (2) and removal after 2 releases following the 
regular
deprecation policy.

If we consider that applying the policy to qmp_cpu is more trouble than 
it's worth,
I'll gladly resend this patch removing it entirely and rewording the 
qemu-doc.texi
entry to mention that it was removed because it did nothing and it was of
no use for anyone.



danielhb

>
>> ---
>>   qapi-schema.json |  5 ++++-
>>   qemu-doc.texi    | 10 ++++++++++
>>   qmp.c            |  2 +-
>>   3 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 18457954a8..b51b89e19b 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -1052,7 +1052,10 @@
>>   #
>>   # Since: 0.14.0
>>   #
>> -# Notes: Do not use this command.
>> +# Notes: Do not use this command. It was deprecated in release 2.12.0 and will
>> +#        be removed, with no replacement, at any time in the future. QMP
>> +#        commands that rely on the current CPU monitor should specify it as a
>> +#        parameter.
>>   ##
>>   { 'command': 'cpu', 'data': {'index': 'int'} }
>>   
>> diff --git a/qemu-doc.texi b/qemu-doc.texi
>> index f7317dfc66..09e6c5046a 100644
>> --- a/qemu-doc.texi
>> +++ b/qemu-doc.texi
>> @@ -2516,6 +2516,16 @@ subsystem image.
>>   The ``convert -s snapshot_id_or_name'' argument is obsoleted
>>   by the ``convert -l snapshot_param'' argument instead.
>>   
>> +@section System emulator machine protocol commands
>> +
>> +@subsection qmp_cpu (since 2.12.0)
>> +
>> +The ``qmp_cpu'' command was implemented in release 0.14.0 as a functional
>> +no-op, remaining as such up to release 2.12.0 when it was deprecated and
>> +flagged for future removal. No replacement will be provided: any QMP command
>> +that uses the current CPU monitor should, instead, specify the CPU in its
>> +parameters.
>> +
>>   @section System emulator human monitor commands
>>   
>>   @subsection host_net_add (since 2.10.0)
>> diff --git a/qmp.c b/qmp.c
>> index e8c303116a..d8543d713d 100644
>> --- a/qmp.c
>> +++ b/qmp.c
>> @@ -115,7 +115,7 @@ void qmp_system_powerdown(Error **erp)
>>   
>>   void qmp_cpu(int64_t index, Error **errp)
>>   {
>> -    /* Just do nothing */
>> +    error_setg(errp, "qmp_cpu is deprecated, do not use this command");
>>   }
>>   
>>   void qmp_cpu_add(int64_t id, Error **errp)
