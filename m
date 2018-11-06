Received: from eggs.gnu.org ([2001:4830:134:3::10]:33501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKAQD-0002Cv-23
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:06:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKAQB-0005qu-NE
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:06:08 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:46502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKAQB-0002n3-2n
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:06:07 -0500
Received: by mail-oi1-x232.google.com with SMTP id k64-v6so12251808oia.13
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 15:05:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f5712b07-05a1-650c-332a-a24462fed977@redhat.com>
References: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
	<f5712b07-05a1-650c-332a-a24462fed977@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Nov 2018 23:05:12 +0000
Message-ID: <CAFEAcA-Wkk9wLOfSYs2_R_2WwSe59egU4dwRBpdALDaA7642mQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] List of files containing devices which have not
 been QOMified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 November 2018 at 19:46, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 06/11/2018 19:43, Peter Maydell wrote:
>> hw/core/ptimer.c
>
> Not a device.

Indeed not, but it could be a QOM object I guess (would
that gain us anything?)

>> hw/i2c/bitbang_i2c.c
>
> TYPE_GPIO_I2C?

That part is, but bitbang_i2c_init() creates an object
which isn't a QOM object and is used by some other i2c devices.

>> hw/ide/ahci.c
>
> Even though AHCIState is not a QOM object, all of its users are
> (TYPE_SYSBUS_AHCI is in this file, TYPE_ICH9_AHCI is in hw/ide/ich.c)

Mmm, this is one of those which I was unsure about so
put on the list anyway.

Overall something that occurs to me is that I'm not sure
what exactly (other than tidiness) we gain from converting
remaining non-QOM devices. In some of the other cases I've
looked at (like sysbus init methods or old_mmio users) we
get to complete an API transition and remove the old code.
For a non-QOM device, how much does it hurt us that they're
lying around in the codebase? We might do better to
specifically target APIs we'd like to deal with (like
direct uses of vmstate_register, maybe?).

Some bits I would definitely like to see cleaned up are
the things like the mmio version of the 16550 UART code
in hw/char/serial.c -- that not being QOMified has
knock-on effects in making other devices that would
like to basically just be 16550-wrappers harder to
write in a clean way.

thanks
-- PMM
