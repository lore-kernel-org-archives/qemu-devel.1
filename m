Received: from eggs.gnu.org ([2001:4830:134:3::10]:40230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqKOO-0003pk-Dz
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqKOK-0006wf-AD
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:40:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50134 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqKOK-0006uu-2R
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:40:52 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-48-armbru@redhat.com>
	<5803f1ba-9bb5-8baa-2423-40ac6ec0ab77@redhat.com>
Date: Thu, 16 Aug 2018 17:40:47 +0200
In-Reply-To: <5803f1ba-9bb5-8baa-2423-40ac6ec0ab77@redhat.com> (Eric Blake's
	message of "Thu, 16 Aug 2018 08:20:25 -0500")
Message-ID: <87mutm720w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 47/56] qjson: Have qobject_from_json() &
 friends reject empty and blank
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/08/2018 07:03 AM, Markus Armbruster wrote:
>> The last case where qobject_from_json() & friends return null without
>> setting an error is empty or blank input.  Callers:
>>
>> * block.c's parse_json_protocol() reports "Could not parse the JSON
>>    options".  It's marked as a work-around, because it also covered
>>    actual bugs, but they got fixed in the previous few commits.
>
> How would you trigger this?

$ qemu-system-x86_64 json:{}
qemu-system-x86_64: Must specify either driver or file
$ qemu-system-x86_64 json:
qemu-system-x86_64: Could not parse the JSON options

>                             I guess that would be by using the
> pseud-json block specification spelled "json:" rather than the usual
> "json:{...}".
>
>>
>> * qobject_input_visitor_new_str() reports "JSON parse error".  Also
>>    marked as work-around.  The recent fixes have made this unreachable,
>>    because it currently gets called only for input starting with '{'.
>
> Indeed, no triggers to this.
>
>>
>> * check-qjson.c's empty_input() and blank_input() demonstrate the
>>    behavior.
>>
>> * The other callers are not affected since they only pass input with
>>    exactly one JSON value or, in the case of negative tests, one error.
>
> As long as sending back-to-back newlines to QMP does not treat the
> empty line as an error, you should be okay. (If sending two newlines
> in a row now results in a {"error":...} response from the server for
> the blank line, then you've regressed).

QMP doesn't parse with qobject_from_json(), so it isn't affected.

Permit me a digression on newlines.

Newlines are like any other whitespace.  Whitespace can be necessary to
make the lexer emit a token.  For instance, sending "123" without a
newline to QMP does not produce a reply.  The lexer is in state
IN_DIGITS then.  You can make it go to JSON_INTEGER and emit the token
by sending a newline.  This produces a reply.

This doesn't match a (naive?) interactive users mental model of newline.
When such a user hits newline, he expects a reply.  If he doesn't get
one, say because he miscounted his curlies, confusion ensues.

A better designed protocol would avoid that trap.

>> Fail with "Expecting a JSON value" instead of returning null, and
>> simplify callers.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
> Yay for getting rid of the inconsistent error reporting!
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
