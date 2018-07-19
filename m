Received: from eggs.gnu.org ([2001:4830:134:3::10]:36879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fg7wf-0006pM-Bx
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fg7wc-0000QZ-5z
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:22:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42764 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fg7wc-0000QR-1F
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:22:06 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180703213556.20619-1-armbru@redhat.com>
	<20180703213556.20619-14-armbru@redhat.com>
	<CAFEAcA97fm3+17jjvktAXPQOj0VrVCGXPSFi8mQvU1bnnzgWZg@mail.gmail.com>
Date: Thu, 19 Jul 2018 14:22:04 +0200
In-Reply-To: <CAFEAcA97fm3+17jjvktAXPQOj0VrVCGXPSFi8mQvU1bnnzgWZg@mail.gmail.com>
	(Peter Maydell's message of "Thu, 19 Jul 2018 12:07:48 +0100")
Message-ID: <87tvove7pv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL v2 13/32] qmp: Revert change to
 handle_qmp_command tracepoint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 3 July 2018 at 22:35, Markus Armbruster <armbru@redhat.com> wrote:
>> Commit 71da4667db6 "monitor: separate QMP parser and dispatcher" moved
>> the handle_qmp_command tracepoint from handle_qmp_command() to
>> monitor_qmp_dispatch_one().  This delays tracing from enqueue time to
>> dequeue time.  Revert that.  Dequeue remains adequately visible via
>> tracepoint monitor_qmp_cmd_in_band.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Message-Id: <20180703085358.13941-14-armbru@redhat.com>
>
> Hi; it looks like this revert has reintroduced(?) a coverity
> warning:
>
>> ---
>>  monitor.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/monitor.c b/monitor.c
>> index 3bf3e68bdc..3cc4b07788 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -4184,12 +4184,6 @@ static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
>>
>>      g_free(req_obj);
>>
>> -    if (trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND)) {
>> -        QString *req_json = qobject_to_json(req);
>> -        trace_handle_qmp_command(mon, qstring_get_str(req_json));
>> -        qobject_unref(req_json);
>> -    }
>> -
>>      old_mon = cur_mon;
>>      cur_mon = mon;
>>
>> @@ -4283,6 +4277,12 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
>>          qdict_del(qdict, "id");
>>      } /* else will fail qmp_dispatch() */
>>
>> +    if (trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND)) {
>> +        QString *req_json = qobject_to_json(req);
>> +        trace_handle_qmp_command(mon, qstring_get_str(req_json));
>> +        qobject_unref(req_json);
>> +    }
>
> Coverity CID 1394216 points out that in this function a
> little earlier we did a check on "if (!req && !err)", which
> implies that we can get here with a NULL req pointer,
> which will crash in qobject_to_json().

Since fixed in
commit 8720e63e monitor: Fix tracepoint crash on JSON syntax error

>> +
>>      /* Check against the request in general layout */
>>      qdict = qmp_dispatch_check_obj(req, qmp_oob_enabled(mon), &err);
>>      if (!qdict) {
>> --

Thanks anyway!
