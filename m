Received: from eggs.gnu.org ([2001:4830:134:3::10]:46184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvNZu-0003sE-Vz
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvNZo-0006hf-RH
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:05:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48552 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fvNZm-0006e6-TF
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:05:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC0EE7A7E5
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 14:05:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180815133747.25032-1-peterx@redhat.com>
	<20180815133747.25032-4-peterx@redhat.com>
	<87tvngt3a6.fsf@dusky.pond.sub.org>
Date: Thu, 30 Aug 2018 16:05:25 +0200
In-Reply-To: <87tvngt3a6.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Mon, 27 Aug 2018 14:14:25 +0200")
Message-ID: <871sag2bmi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 03/13] qapi: remove error checks for
 event emission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan
	Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Markus Armbruster <armbru@redhat.com> writes:

> Peter Xu <peterx@redhat.com> writes:
>
>> In the whole QAPI event emission code we're passing in an Error* object
>> along the whole stack.  That's never useful since it never fails after
>> all.  Remove that.
>
> This is the interesting part.  We'll see below why it can't fail.
>
>> Then, remove that parameter from all the callers to send an event.
>
> This is the mechanical part.  The callers pass &error_abort, except for
> one that passes NULL.
>
> The patch moves the &error_abort argument from the qapi_event_send_FOO()
> calls to the places where the argument is used.  No effect except for
> the caller that passes NULL.  That one now asserts "no error".
>
>> Suggested-by: Eric Blake <eblake@redhat.com>
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>
> Patch quoted except for the parts that drop &error_abort from
> qapi_event_send_FOO() calls:
>
> [...]
>> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
>> index c2e11465f0..6d3cffd548 100644
>> --- a/docs/devel/qapi-code-gen.txt
>> +++ b/docs/devel/qapi-code-gen.txt

Missing:

   @@ -1340,7 +1340,7 @@ Example:
        #include "example-qapi-types.h"


   -    void qapi_event_send_my_event(Error **errp);
   +    void qapi_event_send_my_event(void);

        typedef enum example_QAPIEvent {
            EXAMPLE_QAPI_EVENT_MY_EVENT = 0,

>> @@ -1356,10 +1356,9 @@ Example:
>>      $ cat qapi-generated/example-qapi-events.c
>>  [Uninteresting stuff omitted...]
>>  
>> -    void qapi_event_send_my_event(Error **errp)
>> +    void qapi_event_send_my_event(void)
>>      {
>>          QDict *qmp;
>> -        Error *err = NULL;
>>          QMPEventFuncEmit emit;
>>  
>>          emit = qmp_event_get_func_emit();
>> @@ -1369,9 +1368,8 @@ Example:
>>  
>>          qmp = qmp_event_build_dict("MY_EVENT");
>>  
>> -        emit(EXAMPLE_QAPI_EVENT_MY_EVENT, qmp, &err);
>> +        emit(EXAMPLE_QAPI_EVENT_MY_EVENT, qmp);
>>  
>> -        error_propagate(errp, err);
>>          qobject_unref(qmp);
>>      }
>>  
[...]
