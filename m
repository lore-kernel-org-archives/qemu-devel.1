Received: from eggs.gnu.org ([2001:4830:134:3::10]:60591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fIwo3-0001PW-MN
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fIwo0-0001Ox-K1
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:49:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53352
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.ibm.com>)
	id 1fIwo0-0001OR-Dr
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:49:24 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4GDi71t019537
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 09:49:23 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2j0m4f5mpb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 09:49:23 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.ibm.com>;
	Wed, 16 May 2018 09:49:22 -0400
References: <20180515140944.15979-1-danielhb@linux.ibm.com>
	<20180515140944.15979-3-danielhb@linux.ibm.com>
	<8736ytue1w.fsf@dusky.pond.sub.org>
From: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Date: Wed, 16 May 2018 10:49:16 -0300
MIME-Version: 1.0
In-Reply-To: <8736ytue1w.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <6679359f-4a84-4eb1-c32b-997d47a3d4ea@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/2] qga: update guest-suspend-ram and
 guest-suspend-hybrid descriptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, dgilbert@redhat.com



On 05/15/2018 12:35 PM, Markus Armbruster wrote:
> Daniel Henrique Barboza <danielhb@linux.ibm.com> writes:
>
>> This patch updates the descriptions of 'guest-suspend-ram' and
>> 'guest-suspend-hybrid' to mention that both commands relies now
>> on the existence of 'system_wakeup' and also on the proper support
>> for wake up from suspend, retrieved by the 'wakeup-suspend-support'
>> attribute of the 'query-target' QMP command.
>>
>> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.ibm.com>
>> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>> ---
>>   qga/qapi-schema.json | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>> index 17884c7c70..e3fb8adfce 100644
>> --- a/qga/qapi-schema.json
>> +++ b/qga/qapi-schema.json
>> @@ -566,8 +566,11 @@
>>   # package installed in the guest.
>>   #
>>   # IMPORTANT: guest-suspend-ram requires QEMU to support the 'system_wakeup'
>> -# command.  Thus, it's *required* to query QEMU for the presence of the
>> -# 'system_wakeup' command before issuing guest-suspend-ram.
>> +# command and the guest to support wake up from suspend. Thus, it's
>> +# *required* to query QEMU for the presence of the 'system_wakeup' command
>> +# and to verify that wake up from suspend is enabled by checking the
>> +# 'wakeup-suspend-support' flag of 'query-target' QMP command, before issuing
>> +# guest-suspend-ram.
> Isn't checking for presence of system_wakeup redundant?
>
> When query-target tells us "system_wakeup works" by returning
> wakeup-suspend-support: true, we surely have system_wakeup (or else
> query-target would be lying to us).
>
> When it returns wakeup-suspend-support: false, it doesn't matter whether
> we have system_wakeup.
>
> Unless I'm wrong, we can simplify this to something like
>
>     # IMPORTANT: guest-suspend-ram requires working wakeup support in
>     # QEMU.  You *must* check QMP command query-target returns
>     # wakeup-suspend-support: true before issuing this command.

It is worth noticing that this API isn't checking for the existence of
system_wakeup. It is checking whether there are notifiers added in
the wakeup_notifiers QLIST.

However, I think we can simplify the text as you suggested because that
part seems outdated anyway. Is there any relevant scenario where
system_wakeup will not be present?



>>   #
>>   # This command does NOT return a response on success. There are two options
>>   # to check for success:
>> @@ -593,8 +596,11 @@
>>   # This command requires the pm-utils package to be installed in the guest.
>>   #
>>   # IMPORTANT: guest-suspend-hybrid requires QEMU to support the 'system_wakeup'
>> -# command.  Thus, it's *required* to query QEMU for the presence of the
>> -# 'system_wakeup' command before issuing guest-suspend-hybrid.
>> +# command and the guest to support wake up from suspend. Thus, it's
>> +# *required* to query QEMU for the presence of the 'system_wakeup' command
>> +# and to verify that wake up from suspend is enabled by checking the
>> +# 'wakeup-suspend-support' flag of 'query-target' QMP command, before issuing
>> +# guest-suspend-hybrid.
>>   #
>>   # This command does NOT return a response on success. There are two options
>>   # to check for success:
> Likewise.
>
