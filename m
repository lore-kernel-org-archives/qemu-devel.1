Received: from eggs.gnu.org ([2001:4830:134:3::10]:39153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOjy4-0001D0-Pg
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 07:47:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOjy4-0008Dw-0n
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 07:47:28 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:41200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eOjy3-0008DU-Qg
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 07:47:27 -0500
Received: by mail-ot0-x244.google.com with SMTP id b54so17636877otd.8
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 04:47:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <09e7b89f-27f2-1787-b371-7b0c0eff78b8@redhat.com>
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-4-git-send-email-peter.maydell@linaro.org>
	<5A2F6ED9.5030605@huawei.com>
	<ac182406-8011-9f19-38e7-37328434095b@redhat.com>
	<CAFEAcA_9pee99KpL4zwVS5jJuiv2MCGp79crufpU1kH1Okg-Hg@mail.gmail.com>
	<6b4b6351-eeb4-a4d3-8ddf-5401516671ae@redhat.com>
	<CAKv+Gu-Ugm1g8twoKwgXAPtDfETvXntk2h4WzMVuUTDF7GhMvA@mail.gmail.com>
	<5e3798f7-e280-b6c3-1504-828283617c52@redhat.com>
	<CAFEAcA_+NnpeP9Le7bp9yrYQDwtuP79pt8GpVzJ4RBDMx1iomA@mail.gmail.com>
	<09e7b89f-27f2-1787-b371-7b0c0eff78b8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2017 12:47:06 +0000
Message-ID: <CAFEAcA-357eVt3s_7ULWxssQttvAV0DkUv_tGkyk8umVgfH1QA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/arm/virt-acpi-build: Add second
 UART to ACPI tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Drew Jones <drjones@redhat.com>, Andrea Bolognani <abologna@redhat.com>

On 12 December 2017 at 12:41, Laszlo Ersek <lersek@redhat.com> wrote:
> I agree. There's one user-visible complication: while with one UART,
> it's not possible to mix things up, with two UARTs, users will
> inevitably want to assign inverse roles to them, relative to what QEMU /
> the firmware assigns originally.
>
> E.g. if one PL011 is redirected to a regular file (debug messages) and
> the other one to stdio (console), there will be complaints that "I
> wanted it the other way around". The redirection happens on the backend
> (chardev) level, but the firmware won't see the difference on the
> frontend (PL011) level.
>
> Is it possible to add a new property to the UART nodes in the DTB, like
> "purpose"?

This is what the "chosen" stdout-path node in the DTB is for,
but you said you didn't want to look at that :-) (it means
"device to be used for boot console output".)

> Or can we make a virt-arm policy that "first -serial is always ...,
> second -serial is always ..."?

Well, the first -serial will always be the 0x09000000 one
that we have today, and the second -serial will be the other
one (unless you have -machine secure=yes, in which case
second -serial is the secure-only UART and third -serial is
the second NS UART).

Is this any different to the x86 case, where there are two
UARTs at different IO port/IRQ locations?

I think the only thing users really expect is that if you're
using just the one serial port for anything then it's the
first one.

thanks
-- PMM
