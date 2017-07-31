Received: from eggs.gnu.org ([2001:4830:134:3::10]:60532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dc58J-0004NQ-8W
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dc58I-0007qR-71
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:28:55 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-9-eblake@redhat.com>
	<87k22sjsu4.fsf@dusky.pond.sub.org>
	<176555af-931f-213e-c8f5-190d4e03bb13@redhat.com>
Date: Mon, 31 Jul 2017 09:28:41 +0200
In-Reply-To: <176555af-931f-213e-c8f5-190d4e03bb13@redhat.com> (Eric Blake's
	message of "Fri, 28 Jul 2017 14:08:12 -0500")
Message-ID: <87d18hawuu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 08/12] qtests: convert tests to use
 qmp_cmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: stefanha@redhat.com, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, "open list:IDE" <qemu-block@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 07/28/2017 01:53 PM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> Now that we have the qmp_cmd() helper, we can further simplify
>>> some of the tests by using it.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>
>>>      }
>>> -    resp = qmp("{'execute': 'qom-list-types',"
>>> -               " 'arguments': %p }", args);
>>> +    resp = qmp_cmd("qom-list-types", QOBJECT(args));
>> 
>> This one's a clear win.
>
> Well, it'd be even NICER if I could pass QDict instead of QObject around.
>
>
>>> +++ b/tests/ide-test.c
>>> @@ -651,7 +651,7 @@ static void test_retry_flush(const char *machine)
>>>      qmp_eventwait("STOP");
>>>
>>>      /* Complete the command */
>>> -    qmp_discard_response("{'execute':'cont' }");
>>> +    qmp_cmd_discard_response("cont", NULL);
>> 
>> This one isn't.
>
> Fair enough.
>
>>> @@ -86,7 +87,7 @@ void set_context(QOSState *s)
>>>
>>>  static QDict *qmp_execute(const char *command)
>>>  {
>>> -    return qmp("{ 'execute': %s }", command);
>>> +    return qmp_cmd(command, NULL);
>> 
>> Marginal.
>> 
>>>  }
>>>
>>>  void migrate(QOSState *from, QOSState *to, const char *uri)
>>> @@ -106,7 +107,7 @@ void migrate(QOSState *from, QOSState *to, const char *uri)
>>>      QDECREF(rsp);
>>>
>>>      /* Issue the migrate command. */
>>> -    rsp = qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", uri);
>>> +    rsp = qmp_cmd("migrate", qobject_from_jsonf("{ 'uri': %s }", uri));
>> 
>> Not a simplification.  The opposite, I'm afraid.
>> 
>> I could become one if qmp_cmd() worked like this:
>> 
>>        rsp = qmp_cmd("migrate", "{ 'uri': %s }", uri));
>
> Oh, nice. But it makes qmp_cmd become varargs, at which point...
>
>> 
>> Even better if qmp_cmd("cont", "") just works.  Hmm, unles gcc whines
>> about the empty format string.
>
> yeah, we'd have to figure out a way to shut up gcc when no arguments are
> wanted.  Here's a compromise that does the best for all three categories
> you pointed out above:
>
> qmp_cmd("cont");
> qmp_cmd_args("migrate", "{ 'uri': %s  }", uri);
> qmp_cmd_dict("qom-list-types", args);
>
> Sounds like I have a plan of attack!  Also, since I'm somewhat churning
> on the stuff you did in a previous patch, should we reorder any of this
> series (add the helper first, then a single fix the callers that benefit
> from the helpers; instead of fixing callers twice in three patches)?

If easier review and cleaner history can justify the effort to rework.
Your call.

>>>      g_assert(qdict_haskey(rsp, "return"));
>>>      QDECREF(rsp);
>>>
>> [More of the same snipped...]
>> 
>
> And, as I said in the cover letter, there's probably a lot more we could
> touch in the testsuite if we like the new pattern.

One step at a time.
