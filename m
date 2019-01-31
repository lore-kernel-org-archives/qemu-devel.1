Received: from eggs.gnu.org ([209.51.188.92]:51682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gp85U-00047a-L9
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 03:52:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gp85T-0000ZU-Ki
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 03:52:44 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<871s4uobf0.fsf@dusky.pond.sub.org>
	<CAFEAcA_t2707yp5cz+rbMVE3nhLk288iFgK=vUgzFyCw79uX5g@mail.gmail.com>
	<75629302-84bb-ba19-cb2c-5edc34cffadb@redhat.com>
	<CAFEAcA-jp=k5-jHeY_ziMbgYBo5U7-ZKSRtU8nfPyAFh9jYUQg@mail.gmail.com>
Date: Thu, 31 Jan 2019 09:52:34 +0100
In-Reply-To: <CAFEAcA-jp=k5-jHeY_ziMbgYBo5U7-ZKSRtU8nfPyAFh9jYUQg@mail.gmail.com>
	(Peter Maydell's message of "Wed, 30 Jan 2019 17:24:32 +0000")
Message-ID: <877eeldx9p.fsf@dusky.pond.sub.org>
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
Cc: Laszlo Ersek <lersek@redhat.com>, Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 30 Jan 2019 at 16:44, Laszlo Ersek <lersek@redhat.com> wrote:
>>
>> On 01/30/19 16:24, Peter Maydell wrote:
>>
>> > Well, nobody who does anything with x86 has cared enough to
>> > make the pflash implementation actually correct.
>>
>> I feel sort of included under this umbrella, so:
>>
>> I haven't been aware of any particular pflash implementation errors. I
>> "didn't care" because it "worked fine" as much as I could tell.

Lesson for the future: when we correct something, but don't dare to
touch (some) existing uses (being not "reasonably sure it doesn't
actually break guests that used to work"), we should at least have
enough sense to make "incorrect" opt-in rather than opt-out!  People
adding new uses will be blissfully unaware of the need to opt-out, and
the problem will multiply, just like it did here.

> It depends entirely on what the guest code that's accessing
> the flash devices does. If you stick to what Linux and
> presumably UEFI have always done then you don't notice
> anything wrong. Some things that are in spec for hardware
> don't work right, though.
>
> Commits 4b6fedcac0f51157e through a0289b8af3b05fe4 are
> where we fixed these bugs.
>
> Updating other platforms should mostly be a matter of
> (a) figuring out what the actual hardware config is
> and setting the device properties accordingly
> (b) testing that guest software still works
> (c) checking that migration compat remains working

Unavoidable pain for uses that predate the bug fixes.  Self-inflicted
pain for all later uses.

Can you fix the code so incorrect behavior becomes opt-in rather than
opt-out?  Pretty-please?
