Received: from eggs.gnu.org ([209.51.188.92]:42905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gp9Wi-0006Aa-Lw
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 05:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gp9Wh-0008HW-Q7
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 05:24:56 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<871s4uobf0.fsf@dusky.pond.sub.org>
	<CAFEAcA_t2707yp5cz+rbMVE3nhLk288iFgK=vUgzFyCw79uX5g@mail.gmail.com>
	<75629302-84bb-ba19-cb2c-5edc34cffadb@redhat.com>
	<CAFEAcA-jp=k5-jHeY_ziMbgYBo5U7-ZKSRtU8nfPyAFh9jYUQg@mail.gmail.com>
	<877eeldx9p.fsf@dusky.pond.sub.org>
	<CAFEAcA-AYVgigihO5LF3EgfOo5=uaB5Gx3b8Eh3it2QvZkomYg@mail.gmail.com>
Date: Thu, 31 Jan 2019 11:24:48 +0100
In-Reply-To: <CAFEAcA-AYVgigihO5LF3EgfOo5=uaB5Gx3b8Eh3it2QvZkomYg@mail.gmail.com>
	(Peter Maydell's message of "Thu, 31 Jan 2019 10:01:53 +0000")
Message-ID: <87bm3xazv3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 31 Jan 2019 at 08:52, Markus Armbruster <armbru@redhat.com> wrote:
>> Lesson for the future: when we correct something, but don't dare to
>> touch (some) existing uses (being not "reasonably sure it doesn't
>> actually break guests that used to work"), we should at least have
>> enough sense to make "incorrect" opt-in rather than opt-out!  People
>> adding new uses will be blissfully unaware of the need to opt-out, and
>> the problem will multiply, just like it did here.
>
> The theory was that pflash_cfi01_register() is the legacy
> back-compat API, and new board models use new style
> "create the device and set its properties longhand", I think.
> (This is part of a wider issue that the preferred QOM APIs
> tend to be more longwinded than the old obsolete helper
> functions.) It's definitely unfortunate that we didn't
> at least comment that that function shouldn't be used in
> new boards.
>
> The problem hasn't multiplied very much -- almost all the
> users of pflash_cfi01_register() predate the change.
>
> I'm not sure what an API that defaulted to 'correct' would
> look like here, though.

What about this:

1. Make the device model default to some "correct" configuration, even
if that setting is kind of arbitrary.  That way, any code using new
style gets an "incorrect" configuration only if it actively selects one.

2. Won't help with pflash_cfi01_register(), which actively selects
whatever configuration it gets passed.  Not a serious problem as long as
it doesn't get used by new code, so rename it to
pflash_cfi01_create_legacy() and give it a fat comment.

3. Convert one or more of its users to the new style, so we have good
examples, not just bad ones.
