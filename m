Received: from eggs.gnu.org ([2001:4830:134:3::10]:55821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZYkq-0006BT-Hb
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZYkn-00076s-9j
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:30:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dZYkn-00076e-1I
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:30:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9CADC00E0DB
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 08:30:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-5-git-send-email-armbru@redhat.com>
	<295a3dcc-5165-cc23-26a2-ffb4d8ccb144@redhat.com>
	<87tw25ag8p.fsf@dusky.pond.sub.org>
	<500db1a0-e7f5-0413-950a-4c9bfbceba06@redhat.com>
Date: Mon, 24 Jul 2017 10:30:09 +0200
In-Reply-To: <500db1a0-e7f5-0413-950a-4c9bfbceba06@redhat.com> (Eric Blake's
	message of "Fri, 21 Jul 2017 15:08:09 -0500")
Message-ID: <87r2x6tey6.fsf@dusky.pond.sub.org>
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

> On 07/21/2017 11:48 AM, Markus Armbruster wrote:
>> I forgot that PRId64 expands into non-standard crap on some systems.
>> 
>> Options:
>> 
>> 1. Outlaw use of PRI macros, limit integer length modifiers for
>>    conversion specifiers "d" and "u" to "l" and "ll".  When PRI macros
>>    creep in, the build breaks on hosts where they expand to anything
>>    else (hopefully, our CI will catch that).  Interpolating int64_t
>>    values become a bit awkward.
>> 
>>    Required work: fix my patches not to use PRId64, drop support for
>>    length modifier "I64" from parse_escape().
>
> Yuck.  (But motivation for my earlier series to nuke qobject_from_jsonf())
>
>> 
>> 2. Support PRId64 and PRIu64, whatever their actual value may be.
>> 
>>    a. Support all possible values.  This is what we've tried before.

Clarification: all the values we expect on the hosts we support.
Currently "l", "ll", "I64" and "q".

>>       Nasty: fails only at run-time on hosts with sufficiently creative
>>       values.
>> 
>>       Required work: add support for length modifier "q", to unbreak
>>       MacOS.

We already support the other three.

>>       Optional work: try to turn the run-time failure into a compile-
>>       time failure, ideally in configure.
>
> Accepts garbage (although -Wformat detection will help avoid the worst
> of it).  You can't check string equality in the preprocessor, and you
> can't do things like "case PRId64[0]: case 'l':" to force compilation
> errors due to duplicate labels, but we CAN limit ourselves to the
> preprocessor and grep that output to see what PRId64 expands to.  I'll
> see if I can come up with a configure check.  Still, it may be easier to
> just fail configure and tell people to report the bug on their odd libc,
> at which point we update json-lexer.c and configure, than it is to try
> and reuse configure results in json-lexer.c (since the PRId64 string is
> not a constant width, it gets hard to code an exact value into our lexer
> state machine, but easier to code every reported value).

Auto-configuring our handwritten lexer to recognize PRId64 and PRIu64
would be awkward.  Certainly more awkward than substituting an
auto-configured string into the input of flex.  It's 2b anyway.

>>    b. Support exactly the host's PRId64 and PRIu64 values.
>> 
>>       Work required: replace support of "I64d" and "I64u" by support of
>>       PRId64 and PRIu64.  Easy enough in parse_escape(), but not in
>>       json-lexer.c.  We could perhaps have the lexer accept the shortest
>>       string that's followed by a conversion specifier as length
>>       modifier, then reject invalid length modifiers in a semantic
>>       action.
>
> Interesting idea. I'm playing with it...
>
>> 
>>    Optional work: try to simplify code that currently works around
>>    unavailability of PRId64 and PRIu64.
>> 
>> Preferences?
>> 
>> I like 2b, but I'm not sure I'll like the code implementing it.  One way
>> to find out...
>
> In the lexer, widen the state machine to accept up to three unknown
> characters between % and d.  Hmm, there's also the possibility of
> int64_t being mapped to %jd, in addition to our known culprits of %ld,
> %lld, %I64d, and %qd.

The lexer could accept any length modifier matching a suitable regular
expression, leaving rejection of invalid ones to semantic actions.

The only hard restriction on non-standard length modifiers is that the
resulting conversion specifications must be syntactically unambiguous,
and the ones the standard specifies still mean the same.

Example: length modifier "f" to conversion specifier "d" is impossible,
because "%fd" must be parsed as conversion specifier "%f" followed by
ordinary character "d".

Example: similarly, length modifiers starting with a flag character, a
digit, '.' or '*' are not possible because such a character must be
parsed as flag, minimum field width or precision, respectively.

In practice, length modifiers starting with characters used elsewhere in
conversion specifications, or containing conversion specifier characters
would be too confusing.

Example: length modifier "qp" to conversion specifier "d" could
technically be done as long as "q" isn't also made a length modifier to
"p".  But it would be nuts.

That leaves us with the regular expression
[^-+ #0-9*.diouxXfFeEgGaAcspn%][^diouxXfFeEgGaAcspn%]*

I think we can rule out control characters, too.

>>> Overall, I like the patch, but we need to fix the problems for the next
>>> round of this series.
>> 
>> Yes.  
>
> At this point, I think I'll spin the next round. But it's not longer a
> 2.10 priority, so it may be a few days.

No need to rush this work into 2.10.
