Received: from eggs.gnu.org ([209.51.188.92]:54535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvoI1-0005Cy-8c
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 14:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvoHz-0004PU-Ol
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 14:09:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gvoHu-00047A-2E
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 14:09:12 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87wom249zf.fsf@dusky.pond.sub.org>
	<CAFEAcA-9rhR3qiTZQx=oYtodfpo81wMWKFafboHR7uN0wRNccw@mail.gmail.com>
Date: Mon, 18 Feb 2019 20:08:48 +0100
In-Reply-To: <CAFEAcA-9rhR3qiTZQx=oYtodfpo81wMWKFafboHR7uN0wRNccw@mail.gmail.com>
	(Peter Maydell's message of "Thu, 14 Feb 2019 16:33:52 +0000")
Message-ID: <87r2c429tr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 14 Feb 2019 at 16:21, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> One of qdev's perennial sources of confusion is what to do at object
>> instantiation time, i.e. in TypeInfo::instance_init(), and what to do at
>> device realization time, i.e. in DeviceClass::realize().
>
> Thanks for opening this topic. It's been on my todo list for a
> long time to try to figure out what the answer is...
>
>>  qdev-core.h's
>> comment falls short:
>>
>>  * # Realization #
>>  * Devices are constructed in two stages,
>>  * 1) object instantiation via object_initialize() and
>>  * 2) device realization via #DeviceState:realized property.
>>  * The former may not fail (and must not abort or exit, since it is called
>>  * during device introspection already), and the latter may return error
>>  * information to the caller and must be re-entrant.
>>  * Trivial field initializations should go into #TypeInfo.instance_init.
>>
>> As usual, "trivial" was too trivial to explain; the reader is trusted to
>> figure it out himself.  Well, I'm afraid I'm not to be trusted.
>>
>> The easy part is "can fail means it's not trivial", because
>> ::instance_init() must not fail.
>>
>> What about side effects?  If you already understand how introspection
>> works, or perhaps even if you read carefully and paranoidly, then "since
>> it is called during device introspection already" implies "guest-visible
>> side-effects would be disastrous".  So guest-visible side-effect also
>> means it's not trivial.
>
> I think the other question here is "what about stuff that has
> to be undone/freed/etc". Can I, for instance, allocate memory
> in the initialize function?

Yes, but since .instance_init() can't fail, you have to treat OOM as
fatal.

>                             If so, where do I need to put the
> corresponding memory-free?

.instance_finalize().

>                            Similar but harder to figure out:
> what about things which are ref-counted like memory_region_init()?
> Can I pass a pointer to 'obj' as the "owner" to memory_region_init()
> from its initialize function and trust that the refcounting will
> result in the MR being suitably destroyed when whatever the
> reverse of initialize happens? Or does this only work for really
> initialized objects and so has to be postponed to realize time?

Hmm.

I'm not really familiar with this stuff, but I can try to reason anyway.

Passing @dev memory_region_init() as owner along with a non-null name
makes the memory region a child of @dev.  When object_finalize()
destroys @dev, it deletes all properties, which runs their release()
method.  I figure this is the automatic destruction you mean.

Since object_initialize() cannot fail, destruction must run
object_finalize().  

I guess the answer to your question is "can do in instance_init()".

Perhaps we should ask another question first: is it useful to do these
things in .instance_init()?

> A lot of our devices get away with shortcuts because (apart from
> the introspection special case) they're created once at startup
> and never destroyed, but perhaps we should be stricter about requiring
> everything to support the full create-and-destroy lifecycle (and
> testing it)?

I'm afraid the shortcuts sow confusion and breed bugs.  They get
imitated in places where they're invalid.  They also bite us in the
posterior when we make devices unpluggable.

However, we might have dug ourselves into a pretty deep hole there.

>              At least, we should ensure our documentation describes
> the 'destroy' part of things so that if you are writing a properly
> destroyable device you can get it right.

Documentation and good examples will certainly help.

Sadly, bad examples will continue to hurt anyway.

>>  * Operations depending on @props static properties should go into @realize.
>>
>> Actually, these *have* to go into realize(), because properties get set
>> between ::instance_init() and ::realize().
>
> Yes; this is using 'should' in the sense "is required to",
> not in the RFC2119 sense. We could reasonably tighten the wording
> to be clearer though.
>
>> Even if I had a precise definition of "trivial field initializations",
>> I'd still wonder where operations should go that are neither such
>> trivial field initializations, nor depend on @props.
>
> Yes. We should have some kind of design rule-of-thumb, either
> "put things in initialize unless they must go in realize", or
> "put things in realize unless they must go in initialize".

Ideally with an exhaustive list of the "must go" things.

Let's try to start with an easy question: what must go into
.instance_init()?

Here's my guess:

* Property default values

* Children with properties

Please add to this list.

>>  * After successful realization, setting static properties will fail.
>>  *
>>  * As an interim step, the #DeviceState:realized property can also be
>>  * set with qdev_init_nofail().
>>  * In the future, devices will propagate this state change to their children
>>  * and along busses they expose.
>>
>> This sentence is five years old.  Any progress?  If not, any intentions
>> to make progress?
>>
>>  * The point in time will be deferred to machine creation, so that values
>>  * set in @realize will not be introspectable beforehand. Therefore devices
>>  * must not create children during @realize; they should initialize them via
>>  * object_initialize() in their own #TypeInfo.instance_init and forward the
>>  * realization events appropriately.
>>
>> This is mostly greek to me.  Pity the developer who knows less about
>> qdev than I do.
>
> Also, if you need to create a child based on the value of a
> static property then you're a bit stuck because you have a
> rule saying it must be done in realize and also one that says
> it must not be done in realize. (Not a hypothetical -- see
> for instance the TYPE_ARMV7M object, which creates the CPU with
> a type dependent on a QOM property.)

Sucks.  Creating the child in .instance_init() is impossible, because
the required configuration bits aren't there, yet.  But creating the
child in .realize() makes the child's properties impossible to
configure.  Catch 22.

Similar for dynamic properties that aren't children.  As far as I can
see (and I'm half-blind in QOM-land), the only reason for having dynamic
properties rather than just static ones is to create them based on some
configuration, i.e. other properties.  The obvious place to act on
configuration in properties is .realize().  But any properties created
there cannot be used for configuration.  What's the use case again?

You could of course create the dynamic property earlier, in the property
setters of all the properties it depends on.  If there's more than one,
you'll create and destroy it several times.  If intermediate
configuration state is invalid, it gets even funnier.  Feels like
madness to me.

>>  *
>>  * Any type may override the @realize and/or @unrealize callbacks but needs
>>  * to call the parent type's implementation if keeping their functionality
>>  * is desired. Refer to QOM documentation for further discussion and examples.
>>
>> "Refer to QOM documentation"... okay, but this comment needs to make
>> sense without having to read the 3000+ lines under include/qom/ (which
>> by the way requires finding it first; I'd expect the naive reader to
>> look under docs/ and draw a blank).
>
> The parent_realize mechanism is also very clunky...
>
> thanks
> -- PMM
