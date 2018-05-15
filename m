Received: from eggs.gnu.org ([2001:4830:134:3::10]:45827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fITxX-0001pZ-Ae
	for qemu-devel@nongnu.org; Tue, 15 May 2018 03:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fITxR-0004zB-0b
	for qemu-devel@nongnu.org; Tue, 15 May 2018 03:01:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37936 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fITxQ-0004yN-SJ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 03:01:12 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1526029534-35771-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1526029534-35771-2-git-send-email-anton.nefedov@virtuozzo.com>
	<877eo6nm99.fsf@dusky.pond.sub.org>
	<1839ed60-ffd9-42c1-bf52-6d6121abb224@redhat.com>
Date: Tue, 15 May 2018 09:01:09 +0200
In-Reply-To: <1839ed60-ffd9-42c1-bf52-6d6121abb224@redhat.com> (Eric Blake's
	message of "Mon, 14 May 2018 14:34:53 -0500")
Message-ID: <87h8n9l7wq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] qapi: allow flat unions with empty
 branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 05/14/2018 01:08 PM, Markus Armbruster wrote:
>> Anton Nefedov <anton.nefedov@virtuozzo.com> writes:
>>
>>> The patch makes possible to avoid introducing dummy empty types
>>> for the flat union branches that have no data.
>>>
>
>>
>> Some unions have no variant members for certain discriminator values.
>> We currently have to use an empty type there, and we've accumulated
>> several just for the purpose, which is annoying.
>>
>> QAPI language design alternatives:
>>
>> 1. Having unions cover all discriminator values explicitly is useful.
>> All we need is a more convenient way to denote empty types.  Eric
>> proposed {}, as in 'foo: {}.
>
> And even posted a patch for it once:
> https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg00311.html
>
> although it was late enough in that series with other churn in the
> meantime that it would need serious revisiting to apply today.
>
>>
>> 2. Having unions repeat all the discriminator values explicitly is not
>> useful.  All we need is replacing the code enforcing that by code
>> defaulting missing ones to the empty type.
>>
>> 3. We can't decide, so we do both (this patch).
>>
>> Preferences?
>
> Here's some tradeoffs to consider:
>
> Allowing 'foo':{} makes your intent explicit - "I know this branch of
> the union exists, but it specifically adds no further members".

Yes.

>                                                                  But
> it's a lot of redundant typing - "I already had to type all the branch
> names when declaring the enum type, why do it again here?"

Redundancy isn't bad per se, but it needs to serve a useful purpose.
What's the purpose of repeating the tag values?

You give one below: grep.

> Allowing an easy way to mark all non-listed members of an enum default
> to the empty type is compact - "I told you the enum, so you are
> permitted to fill in an empty type with every branch that does not
> actually need further members; and I had to opt in to that behavior,
> so that I purposefully get an error if I did not opt in but forgot an
> enum member".

Syntactic options aren't bad per se, but they need to serve a useful
purpose.  What's the purpose of having both unions that require all tag
values, and unions that default omitted tag values to "no variant
members"?

>                But if the enum is likely to change, it can lead to
> forgotten additions later on - "I'm adding member 'bar' to an enum
> that already has member 'foo'; therefore, grepping for 'foo' should
> tell me all places where I should add handling for 'bar', except that
> it doesn't work when handling for 'foo' was implicit but handling for
> 'bar' should not be".

If your code still compiles when you forget to add members to a struct
or union, you obviously don't need the members you forgot :)

For what it's worth, grepping for the enum type's name finds the union
just fine, and is less likely to find unrelated stuff.

> Having said that, my personal preference is that opting in to an
> explicit way to do less typing ("all branches of the enum listed here
> are valid, and add no further members") seems like a nice syntactic
> sugar trick; and the easiest way to actually implement it is to
> probably already have support for an explicit 'foo':{} branch
> notation.  That way, you can always change your mind later and undo
> the opt-in "data-partial" flag and rewrite the union with explicit
> empty branches when needed, to match how the sugar was expanded on
> your behalf.

Is that 1. combined with 3.?

I dislike 3. because I feel it adds more complexity than the other
options.  More apparent once you add the necessary test coverage
(another reason why requiring test coverage is such a good idea; having
to cover every bell & whistle tends to make people reconsider which ones
they actually need).

I'd prefer a more opinionated design here.

Either we opine making people repeat the tag values is an overall win.
Then make them repeat them always, don't give them the option to not
repeat them.  Drop this patch.  To reduce verbosity, we can add a
suitable way to denote a predefined empty type.

Or we opine it's not.  Then let them not repeat them, don't give them
the option to make themselves repeat them.  Evolve this patch into one
that makes flat union variants optional and default to empty.  If we
later find we still want a way to denote a predefined empty type, we can
add it then.

My personal opinion is it's not.
