Received: from eggs.gnu.org ([2001:4830:134:3::10]:52348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpZ9O-0008NC-Mc
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:14:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpZ9K-0004DE-Jk
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:14:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54130 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fpZ9K-0004Cx-D4
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:14:14 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-42-armbru@redhat.com>
	<eb69bba3-9226-87b7-ddf7-45c2d51b8446@redhat.com>
	<87in4d1hlk.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0f501cb5-b9b4-3b29-4b86-ae9dcf647cfb@redhat.com>
Date: Tue, 14 Aug 2018 08:14:12 -0500
MIME-Version: 1.0
In-Reply-To: <87in4d1hlk.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 41/56] json: Nicer recovery from invalid
 leading zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/14/2018 03:24 AM, Markus Armbruster wrote:
>> Should IN_BAD_ZERO also consume '.' and/or 'e' (after all, '01e2 is a
>> valid C constant, but not a valid JSON literal)?  But I think your
>> choice here is fine (again, add too much, and then the lexer has to
>> track a lot of state; whereas this minimal addition catches the most
>> obvious things with little effort).
> 
> My patch is of marginal value to begin with.  It improves error recovery
> only for the "integer with redundant leading zero" case.  I guess that's
> more common than "floating-point with redundant leading zero".

Yes, that was my thought.

> 
> An obvious way to extend it to "number with redundant leading zero"
> would be cloning the lexer states related to numbers.  Clean, but six
> more states.  Meh.
> 
> Another way is to dumb down the lexer not to care about leading zero,
> and catch it in parse_literal() instead.  Basically duplicates the lexer
> state machine up to where leading zero is recognized.  Not much code,
> but meh.
> 
> Yet another way is to have the lexer eat "digit salad" after redundant
> leading zero:
> 
>      [IN_BAD_ZERO] = {
>          ['0' ... '9'] = IN_BAD_ZERO,
>          ['.'] = IN_BAD_ZERO,
>          ['e'] = IN_BAD_ZERO,
>          ['-'] = IN_BAD_ZERO,
>          ['+'] = IN_BAD_ZERO,
>      },
> 
> Eats even crap like 01e...  But then the same crap without leading zero
> should also be eaten.  We'd have to add state transitions to IN_BAD_ZERO
> to the six states related to numbers.  Perhaps clever use of gcc's range
> initialization lets us do this compactly.  Otherwise, meh again.
> 
> Opinions?

Of the various options, the patch as written seems to be the most 
minimal. Maybe tweak the commit message to call out other cases that we 
discussed as not worth doing, because the likelihood of such input is 
dramatically less.

About the only other improvement that might be worth making is adding:

[IN_BAD_ZERO] = {
   ['x'] = IN_BAD_ZERO,
   ['X'] = IN_BAD_ZERO,
   ['a' ... 'f'] = IN_BAD_ZERO,
   ['A' ... 'F'] = IN_BAD_ZERO,
}

to catch people typing JSON by hand and thinking that a hex constant 
will work.  That way, '0x1a' gets parsed as a single JSON_ERROR token, 
rather than four separate tokens of JSON_INTEGER, JSON_KEYWORD, 
JSON_INTEGER, JSON_KEYWORD (where you get the semantic error due to 
JSON_KEYWORD unexpected).

> 
> I'd also be fine with dropping this patch.

No, I like it, especially if you also like my suggestion to make error 
reporting on hex numbers resemble error reporting on octal numbers.

> 
>> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Thanks!
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
