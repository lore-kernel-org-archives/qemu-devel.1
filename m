Received: from eggs.gnu.org ([2001:4830:134:3::10]:55248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkmvM-0008EI-0X
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkmvI-0001Tn-4C
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:51:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkmvH-0001Td-Tr
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:51:28 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170818222313.13391-1-eblake@redhat.com>
	<1c41ef09-3e34-63ba-fc85-5aac46a5c355@linux.vnet.ibm.com>
	<ebea7edf-6f5b-9096-552c-079bfcad71a4@redhat.com>
Date: Thu, 24 Aug 2017 09:51:22 +0200
In-Reply-To: <ebea7edf-6f5b-9096-552c-079bfcad71a4@redhat.com> (Eric Blake's
	message of "Wed, 23 Aug 2017 14:21:57 -0500")
Message-ID: <87d17lqu85.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH] osdep.h: Prohibit disabling assert()
 in supported builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, f4bug@amsat.org, "Michael S. Tsirkin" <mst@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 08/22/2017 06:19 AM, Halil Pasic wrote:
>
>> OTOH I do think this is to some degree institutionalizing a bad practice
>> (you say we do not want to do that, but IMHO refusing to build with
>> NDEBUG makes only sense if we want to alter the semantic of assert so
>> that once bad becomes acceptable). I can live with that, but I'm not
>> happy about it. Have we considered rolling our own construct which is
>> designed to exhibit the properties we desire?
>
> I've thought about it, and it may have even been discussed on the list
> perhaps (although I didn't go searching to verify).
>
>> 
>> I mean, if it's about the side effects we could create something like
>> q_assert(cond) and state that cond is evaluate exactly once (and
>> depending on what we want to have, make the actions on !cond (calling
>> abort(), producing a diagnostic message) compile time tweak-able or
>> not). I assume we could then convert each usage of assert to the safe
>> q_assert programmatically.
>
> I'd prefer that if we are going to introduce our own construct that
> always evaluates side effects, and only has a compile-time switch on
> whether to abort() or (foolishly) plow on, that we name it something
> without 'assert' in the name, so that reviewers don't have to be
> confused about remembering which variant evaluates side effects.  Maybe:
>
> q_verify(cond)
>
> is a good name, which performs the side effects of 'cond' no matter
> what, but also allows us to abort() if cond fails vs. ignore the
> failure; perhaps where we make a compile-time decision between the two
> behaviors as a configure --enable-FOO flag.
>
> Converting all existing assert() and g_assert() to q_verify() should be
> fairly simple, if we like the idea.

About as simple as expanding tabs.

CODING_STYLE demands spaces rather than tabs since 2009.  455 out of
3542 C source files have tabs.  Only a minority of them is imported from
other projects and thus exempt from CODING_STYLE.

I vote for frying bigger fish.

I also vote for using standard C when standard C is servicable.
