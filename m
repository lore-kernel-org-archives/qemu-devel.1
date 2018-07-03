Received: from eggs.gnu.org ([2001:4830:134:3::10]:50767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faF8k-0004EW-AP
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:50:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faF8f-0007Mg-E7
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:50:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faF8f-0007MS-7j
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:50:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6FB803082A46
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 06:50:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-31-armbru@redhat.com>
	<0de63ffd-0dba-7d02-8fea-18b2e04c02aa@redhat.com>
Date: Tue, 03 Jul 2018 08:50:00 +0200
In-Reply-To: <0de63ffd-0dba-7d02-8fea-18b2e04c02aa@redhat.com> (Eric Blake's
	message of "Mon, 2 Jul 2018 21:33:40 -0500")
Message-ID: <87in5w6cfb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 30/32] qmp: Clean up capability negotiation
 after commit 02130314d8c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, peterx@redhat.com, dgilbert@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 07/02/2018 11:22 AM, Markus Armbruster wrote:
>> qmp_greeting() offers capabilities to the client, and
>> qmp_qmp_capabilities() accepts or denies capabilities requested by the
>> client.  The two compute the set of available capabilities
>> independently.  Not nice.
>>
>> Clean this up as follows.  Compute available capabilities just once in
>> monitor_qmp_caps_reset(), and store them in Monitor member
>> qmp.capab_offered[].  Have qmp_greeting() and qmp_qmp_capabilities()
>> use that.  Both are now oblivious of capability details.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   monitor.c | 93 ++++++++++++++++++++++++-------------------------------
>>   1 file changed, 40 insertions(+), 53 deletions(-)
>>
>> diff --git a/monitor.c b/monitor.c
>> index 876a3a23a7..590e5b5b04 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -172,7 +172,8 @@ typedef struct {
>>        * mode.
>>        */
>>       QmpCommandList *commands;
>> -    bool qmp_caps[QMP_CAPABILITY__MAX];
>> +    bool capab_offered[QMP_CAPABILITY__MAX]; /* capabilities offered */
>> +    bool capab[QMP_CAPABILITY__MAX];         /* offered and accepted */
>
> Could also store as uint32_t, using '1U << bit' to compute various
> capabilities as a bitmask (up to 32 capabilities).  But it's not
> frequently executed, so this works.

Yes.  I chose to lessen the churn.  On a green field, I guess I'd go
with bits out of habit.  Might not even be a good habit :)

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
