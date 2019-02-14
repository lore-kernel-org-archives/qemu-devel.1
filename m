Received: from eggs.gnu.org ([209.51.188.92]:47263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guK9w-0000YQ-3d
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guJxe-0006nM-Mv
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:34:07 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:35340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guJxe-0006mf-E1
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:34:06 -0500
Received: by mail-ot1-x334.google.com with SMTP id z19so11554890otm.2
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 08:34:06 -0800 (PST)
MIME-Version: 1.0
References: <87wom249zf.fsf@dusky.pond.sub.org>
In-Reply-To: <87wom249zf.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 16:33:52 +0000
Message-ID: <CAFEAcA-9rhR3qiTZQx=oYtodfpo81wMWKFafboHR7uN0wRNccw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Object instantiation vs. device realization: what
 to do when?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

On Thu, 14 Feb 2019 at 16:21, Markus Armbruster <armbru@redhat.com> wrote:
>
> One of qdev's perennial sources of confusion is what to do at object
> instantiation time, i.e. in TypeInfo::instance_init(), and what to do at
> device realization time, i.e. in DeviceClass::realize().

Thanks for opening this topic. It's been on my todo list for a
long time to try to figure out what the answer is...

>  qdev-core.h's
> comment falls short:
>
>  * # Realization #
>  * Devices are constructed in two stages,
>  * 1) object instantiation via object_initialize() and
>  * 2) device realization via #DeviceState:realized property.
>  * The former may not fail (and must not abort or exit, since it is called
>  * during device introspection already), and the latter may return error
>  * information to the caller and must be re-entrant.
>  * Trivial field initializations should go into #TypeInfo.instance_init.
>
> As usual, "trivial" was too trivial to explain; the reader is trusted to
> figure it out himself.  Well, I'm afraid I'm not to be trusted.
>
> The easy part is "can fail means it's not trivial", because
> ::instance_init() must not fail.
>
> What about side effects?  If you already understand how introspection
> works, or perhaps even if you read carefully and paranoidly, then "since
> it is called during device introspection already" implies "guest-visible
> side-effects would be disastrous".  So guest-visible side-effect also
> means it's not trivial.

I think the other question here is "what about stuff that has
to be undone/freed/etc". Can I, for instance, allocate memory
in the initialize function? If so, where do I need to put the
corresponding memory-free? Similar but harder to figure out:
what about things which are ref-counted like memory_region_init()?
Can I pass a pointer to 'obj' as the "owner" to memory_region_init()
from its initialize function and trust that the refcounting will
result in the MR being suitably destroyed when whatever the
reverse of initialize happens? Or does this only work for really
initialized objects and so has to be postponed to realize time?

A lot of our devices get away with shortcuts because (apart from
the introspection special case) they're created once at startup
and never destroyed, but perhaps we should be stricter about requiring
everything to support the full create-and-destroy lifecycle (and
testing it)? At least, we should ensure our documentation describes
the 'destroy' part of things so that if you are writing a properly
destroyable device you can get it right.

>  * Operations depending on @props static properties should go into @realize.
>
> Actually, these *have* to go into realize(), because properties get set
> between ::instance_init() and ::realize().

Yes; this is using 'should' in the sense "is required to",
not in the RFC2119 sense. We could reasonably tighten the wording
to be clearer though.

> Even if I had a precise definition of "trivial field initializations",
> I'd still wonder where operations should go that are neither such
> trivial field initializations, nor depend on @props.

Yes. We should have some kind of design rule-of-thumb, either
"put things in initialize unless they must go in realize", or
"put things in realize unless they must go in initialize".

>  * After successful realization, setting static properties will fail.
>  *
>  * As an interim step, the #DeviceState:realized property can also be
>  * set with qdev_init_nofail().
>  * In the future, devices will propagate this state change to their children
>  * and along busses they expose.
>
> This sentence is five years old.  Any progress?  If not, any intentions
> to make progress?
>
>  * The point in time will be deferred to machine creation, so that values
>  * set in @realize will not be introspectable beforehand. Therefore devices
>  * must not create children during @realize; they should initialize them via
>  * object_initialize() in their own #TypeInfo.instance_init and forward the
>  * realization events appropriately.
>
> This is mostly greek to me.  Pity the developer who knows less about
> qdev than I do.

Also, if you need to create a child based on the value of a
static property then you're a bit stuck because you have a
rule saying it must be done in realize and also one that says
it must not be done in realize. (Not a hypothetical -- see
for instance the TYPE_ARMV7M object, which creates the CPU with
a type dependent on a QOM property.)


>  *
>  * Any type may override the @realize and/or @unrealize callbacks but needs
>  * to call the parent type's implementation if keeping their functionality
>  * is desired. Refer to QOM documentation for further discussion and examples.
>
> "Refer to QOM documentation"... okay, but this comment needs to make
> sense without having to read the 3000+ lines under include/qom/ (which
> by the way requires finding it first; I'd expect the naive reader to
> look under docs/ and draw a blank).

The parent_realize mechanism is also very clunky...

thanks
-- PMM
