Received: from eggs.gnu.org ([2001:4830:134:3::10]:42261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTsGp-0004qZ-Fc
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:44:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTsGl-0001me-Lm
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:44:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49427)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gTsGk-0001k5-6W
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:44:30 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181129152552.14363-1-liq3ea@163.com>
	<87ftvj4shh.fsf@dusky.pond.sub.org>
	<CAFEAcA9LtBfxmaLnwX_ZFoGxZd6fFAkjdqJKiwy-Ztmcs5aM3w@mail.gmail.com>
	<87efb3nhbz.fsf@dusky.pond.sub.org>
	<CAFEAcA_z+4MRQVC0n3P1FsEe2oBUQ-yUj=NGEBwkd4X6wVhf1w@mail.gmail.com>
Date: Mon, 03 Dec 2018 18:44:24 +0100
In-Reply-To: <CAFEAcA_z+4MRQVC0n3P1FsEe2oBUQ-yUj=NGEBwkd4X6wVhf1w@mail.gmail.com>
	(Peter Maydell's message of "Fri, 30 Nov 2018 11:20:57 +0000")
Message-ID: <87efay4i9z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Hot-pluggable device without ->unrealize() is
 highly suspect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: fam@euphon.net, Juan Quintela <quintela@redhat.com>, Li Qiang <liq3ea@163.com>, Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 30 Nov 2018 at 07:40, Markus Armbruster <armbru@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > Add an assert somewhere and catch it with the usual
>> > "instantiate everything" qtest?
>
>> The troublemaker is (3), where we may end up with an overridden
>> realize-like method and an non-matching, un-overridden unrealize-like
>> method.  Got any smart ideas?
>
> Mmm, I see the difficulty. I suppose in theory we could have
> a custom linter like clang-tidy and check that anything that
> sets a realize pointer also sets an unrealize, but that's
> pie-in-the-sky territory at the moment.
>
> Asserting that there is an unrealize would catch at least
> some cases of "forgot to handle hotplug", though, right?

Yes.  I figure it's worth doing.

Another idea: track down all the instances of "parent class implements
::realize(), ::unrealize(), which in turn call methods its children may
implement", and rename the children's methods to be called realize(),
unrealize(), so that we can find offenders with a git-grep -E
'->(un)?realize *='.

>> > More generally, what is causing dc390 to be hotpluggable?
>> > I can't see anything obvious in the class init.
>>
>> It's a PCI device.  These are all hot-pluggable by default.
>
> Maybe we should change that? Most people writing a
> PCI device are probably not thinking about hotplug.

More on that below.

> Though in the dc390 case it would probably not help to have
> to set a dc->hotpluggable flag, because it would inherit that
> from am53c974 too.
>
> I wonder if the dc390 could be structured in a way that
> it doesn't subclass a complete non-abstract pci device like
> that...

Yes, a common abstract base class would be cleaner.

>> >                                                 If we
>> > have APIs where the default is "you get this weird thing
>> > you weren't thinking about but it's broken because
>> > you weren't thinking about it" then we will have a whole
>> > class of bugs that we then need to squash device by device[*].
>> > I think it would be better for devices to have to explicitly
>> > opt in to implementing things like hotplug -- that way the
>> > failure mode is just "this isn't hotpluggable", we can
>> > report that helpfully to the user, and if anybody cares
>> > they can add the support.
>>
>> I tend to agree, although for PCI devices, not being hot-pluggable is
>> kind of weird, except for the ones that only occur soldered onto
>> mainboards.
>
> Real hardware PCI devices are not hot-pluggable by default
> as far as I'm aware; PCIe may be hot-pluggable but I think
> need to be designed to support it.
> This is a random non-hotplug-safe PCIe card:
> https://i.stack.imgur.com/tXug5.jpg
> PRSNT2# (pin 17 side B) is connected to Ground on pin 18
> (these are the rightmost two connections visible); for
> hotplug it must be connected to PRSNT1# (which is pin 1 side A),
> AIUI.
>
> But the hardware situation is kind of a tangent from how
> we try to design our APIs.

It's best not to deviate from real hardware without a good reason.
Making it harder to create the same stupid bugs over and over again is a
good reason.
