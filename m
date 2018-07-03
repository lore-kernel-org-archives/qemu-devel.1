Received: from eggs.gnu.org ([2001:4830:134:3::10]:48928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faEx4-0000DO-42
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faEx1-00076q-0D
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:38:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47750 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faEx0-00074M-Kc
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:38:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B1B240255CB
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 06:38:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-15-armbru@redhat.com>
	<8055d3f1-b9e3-553c-7941-94af1233f5f6@redhat.com>
Date: Tue, 03 Jul 2018 08:38:08 +0200
In-Reply-To: <8055d3f1-b9e3-553c-7941-94af1233f5f6@redhat.com> (Eric Blake's
	message of "Mon, 2 Jul 2018 21:01:28 -0500")
Message-ID: <87r2kk6cz3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 14/32] qmp: Always free QMPRequest with
 qmp_request_free()
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
>> monitor_qmp_dispatch_one() frees a QMPRequest manually, because it
>> needs to keep a reference to ->id.  Premature optimization.  Take an
>> additional reference so we can use qmp_request_free().
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   monitor.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
>> diff --git a/monitor.c b/monitor.c
>> index 10991757f6..94f5660c3c 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -4181,8 +4181,6 @@ static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
>>       id = req_obj->id;
>>       need_resume = req_obj->need_resume;
>>   -    g_free(req_obj);
>> -
>>       old_mon = cur_mon;
>>       cur_mon = mon;
>>   @@ -4191,14 +4189,14 @@ static void
>> monitor_qmp_dispatch_one(QMPRequest *req_obj)
>>       cur_mon = old_mon;
>>         /* Respond if necessary */
>> -    monitor_qmp_respond(mon, rsp, NULL, id);
>> +    monitor_qmp_respond(mon, rsp, NULL, qobject_ref(id));
>
> This requires qobject_ref(NULL) to work (I thought at one point we
> were considering requiring it to be a non-NULL argument, but right now
> it looks like we are safe).

[PATCH v6 5/5] qobject: modify qobject_ref() to assert on NULL
Message-Id: <20180419150145.24795-6-marcandre.lureau@redhat.com>

I didn't merge it back then because I lacked the time to convince myself
all users of qobject_ref() the patch doesn't guard cannot pass null, and
also because I wasn't sure requiring qobject_ref()'s argument to be
non-null improves legibility of the code.  Right now we got bigger fish
to fry.
