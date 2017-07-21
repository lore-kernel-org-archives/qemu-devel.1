Received: from eggs.gnu.org ([2001:4830:134:3::10]:43256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYb67-000656-VW
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYb63-0004IN-2F
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:48:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dYb62-0004GV-Q7
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:48:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F23377F772
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 16:48:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-5-git-send-email-armbru@redhat.com>
	<295a3dcc-5165-cc23-26a2-ffb4d8ccb144@redhat.com>
Date: Fri, 21 Jul 2017 18:48:06 +0200
In-Reply-To: <295a3dcc-5165-cc23-26a2-ffb4d8ccb144@redhat.com> (Eric Blake's
	message of "Fri, 21 Jul 2017 09:39:23 -0500")
Message-ID: <87tw25ag8p.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/9] tests: Clean up string interpolation
 into QMP input (simple cases)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 07/21/2017 08:53 AM, Markus Armbruster wrote:
>> When you build QMP input manually like this
>> 
>>     cmd = g_strdup_printf("{ 'execute': 'migrate',"
>>                           "'arguments': { 'uri': '%s' } }",
>>                           uri);
>>     rsp = qmp(cmd);
>>     g_free(cmd);
>> 
>> you're responsible for escaping the interpolated values for JSON.  Not
>> done here, and therefore works only for sufficiently nice @uri.  For
>> instance, if @uri contained a single "'", qobject_from_jsonv() would
>> fail, qmp_fd_sendv() would misinterpret the failure as empty input and
>> do nothing, and the test would hang waiting for a response that never
>> comes.
>> 
>> Leaving interpolation into JSON to qmp() is more robust:
>> 
>>     rsp = qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", uri);
>> 
>> It's also more concise.
>> 
>> Clean up the simple cases where we interpolate exactly a JSON value.
>> 
>> Bonus: gets rid of non-literal format strings.  A step towards
>> compile-time format string checking without triggering
>> -Wformat-nonliteral.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
>> ---
>> +    qmp_fd_send(fixture->fd,
>> +                "\xff{'execute': 'guest-sync-delimited',"
>> +                " 'arguments': {'id': %u } }",
>
> Ouch. Per 2/9:
>  * json-lexer.c (only understands '%((l|ll|I64)?d|[ipsf])').
>
> That will need to be %d now. Or, more likely, we need to update the
> comments in json-lexer.c and in 2/9 (/me goes to read json-lexer.c...)
>     /* escape */
>     [IN_ESCAPE_LL] = {
>         ['d'] = JSON_ESCAPE,
>         ['u'] = JSON_ESCAPE,
>     },
> ...
>     [IN_ESCAPE] = {
>         ['d'] = JSON_ESCAPE,
>         ['i'] = JSON_ESCAPE,
>         ['p'] = JSON_ESCAPE,
>         ['s'] = JSON_ESCAPE,
>         ['u'] = JSON_ESCAPE,
>         ['f'] = JSON_ESCAPE,
>         ['l'] = IN_ESCAPE_L,
>         ['I'] = IN_ESCAPE_I,
>
> Aha, that 'd' should be '[du]' in all of the comments.

Yes.  We really need %u, or else parse_escape() would call
qnum_from_int() instead of qnum_from_uint().

I think the doc fix for json-lexer.c can be squashed in.  Keeping it
separate could simplify commit message writing, though.  Your choice.

>> @@ -411,10 +408,10 @@ static void test_qga_file_ops(gconstpointer fix)
>>  
>>      enc = g_base64_encode(helloworld, sizeof(helloworld));
>>      /* write */
>> -    cmd = g_strdup_printf("{'execute': 'guest-file-write',"
>> -                          " 'arguments': { 'handle': %" PRId64 ","
>> -                          " 'buf-b64': '%s' } }", id, enc);
>> -    ret = qmp_fd(fixture->fd, cmd);
>> +    ret = qmp_fd(fixture->fd,
>> +                 "{'execute': 'guest-file-write',"
>> +                 " 'arguments': { 'handle': %" PRId64 ", 'buf-b64': %s } }",
>
> Ouch; you are reverting commit 1792d7d0. We tried hard to make
> json-lexer.c understand lots of different 64-bit format spellings, but
> we KNOW that we don't support MacOS (see commit 29a6731).  We either
> need to beef up json-lexer.c to understand %qd, or get rid of JSON
> psuedo-strings, if we expect this to work; otherwise, you should use
> %lld and long long instead of PRId64 and uint64_t.

I forgot that PRId64 expands into non-standard crap on some systems.

Options:

1. Outlaw use of PRI macros, limit integer length modifiers for
   conversion specifiers "d" and "u" to "l" and "ll".  When PRI macros
   creep in, the build breaks on hosts where they expand to anything
   else (hopefully, our CI will catch that).  Interpolating int64_t
   values become a bit awkward.

   Required work: fix my patches not to use PRId64, drop support for
   length modifier "I64" from parse_escape().

2. Support PRId64 and PRIu64, whatever their actual value may be.

   a. Support all possible values.  This is what we've tried before.
      Nasty: fails only at run-time on hosts with sufficiently creative
      values.

      Required work: add support for length modifier "q", to unbreak
      MacOS.

      Optional work: try to turn the run-time failure into a compile-
      time failure, ideally in configure.

   b. Support exactly the host's PRId64 and PRIu64 values.

      Work required: replace support of "I64d" and "I64u" by support of
      PRId64 and PRIu64.  Easy enough in parse_escape(), but not in
      json-lexer.c.  We could perhaps have the lexer accept the shortest
      string that's followed by a conversion specifier as length
      modifier, then reject invalid length modifiers in a semantic
      action.

   Optional work: try to simplify code that currently works around
   unavailability of PRId64 and PRIu64.

Preferences?

I like 2b, but I'm not sure I'll like the code implementing it.  One way
to find out...

> Overall, I like the patch, but we need to fix the problems for the next
> round of this series.

Yes.  
