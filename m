Received: from eggs.gnu.org ([2001:4830:134:3::10]:43221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dc5se-0006Q7-RT
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dc5sb-0003B8-M8
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:16:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dc5sb-0003AL-DT
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:16:45 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-8-eblake@redhat.com>
	<20170728125759.GO12364@stefanha-x1.localdomain>
	<eb01fea0-945e-d954-0737-dc3c748a7f94@redhat.com>
	<7e291686-0242-5bd3-8f83-00145be9d9ee@redhat.com>
Date: Mon, 31 Jul 2017 10:16:39 +0200
In-Reply-To: <7e291686-0242-5bd3-8f83-00145be9d9ee@redhat.com> (Eric Blake's
	message of "Fri, 28 Jul 2017 11:33:03 -0500")
Message-ID: <871soxaumw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 07/12] qtest: Add a new helper qmp_cmd()
 and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, stefanha@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 07/28/2017 08:06 AM, Eric Blake wrote:
>> On 07/28/2017 07:57 AM, Stefan Hajnoczi wrote:
>>> On Tue, Jul 25, 2017 at 04:15:18PM -0500, Eric Blake wrote:
>>>> +QDict *qtest_qmp_cmd(QTestState *s, const char *cmd, QObject *args)
>>>> +{
>>>> +    QDict *dict = qdict_new();
>>>> +
>>>> +    qdict_put_str(dict, "execute", cmd);
>>>> +    if (args) {
>>>> +        qdict_put_obj(dict, "arguments", args);
>>>> +    }
>>>> +    return qtest_qmp(s, "%p", QOBJECT(dict));
>>>> +}
>>>
>>> qtest_qmp(s, "%p", QOBJECT(dict)) takes ownership of dict?
>> 
>> Hmm, I documented that for qtest_qmp_cmd(), but you have a good
>> question.  I need to double-check that it is true for
>> qobject_from_jsonf("%p", obj), but my recollection is that yes, wrapping
>> one object inside the other means freeing the outer object also reclaims
>> the inner (that is, qobject_from_jsonf wasn't increasing refcount).  At
>> any rate, I'll probably have to submit a followup patch (either to fix
>> the leak if I'm wrong, or to improve the documentation about %p
>> reference management if I'm right).
>
> $ valgrind --leak-check=full ./tests/check-qjson
> ...
> ==10596== LEAK SUMMARY:
> ==10596==    definitely lost: 0 bytes in 0 blocks
> ...
> $ grep -C5 %p tests/check-qjson.c
>             {}}));
>
>     embedded_obj = qobject_from_json("[32, 42]", &error_abort);
>     g_assert(embedded_obj != NULL);
>
>     obj = qobject_from_jsonf("[%d, 2, %p]", 1, embedded_obj);
>     g_assert(compare_litqobj_to_qobj(&decoded, obj) == 1);
>
>     qobject_decref(obj);
> }
>
> So given the clean bill of health from valgrind, we definitely DO turn
> over responsibility for freeing on object to its new wrapper, once it is
> passed through %p.  Documentation could be improved to make that clear.
>
> Eww, what happens if qobject_from_jsonf() can fail halfway through? If
> you mix %p with other stuff, how do you know on failure whether the
> reference was taken or not yet reached?  Maybe the testsuite needs an
> enhancement.

What we actually need is qobject_from_jsonf() behaving sanely failure!
Either it takes over all references (just like on success) or none.

It delegates the part of its job that's relevant here to json-parser.c.
Looks like parse_escape() takes over the reference greedily.  If parsing
fails, it's released along with all the refernces to objects the parser
built.

One way to do "none": delay taking over the reference until parsing
succeeded.  Increment it in parse_escape(), decrement it in
json_parser_parse_err().  Either hold %p arguments in JSONParserContext,
so json_parser_parse_err() can find them easily, or iterate over @tokens
and @ap again.

One way to do "all": on error, have json_parser_parse_err() iterate over
remaining @tokens and @ap to consume references.
