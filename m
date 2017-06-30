Received: from eggs.gnu.org ([2001:4830:134:3::10]:36569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQrsf-0002DM-6x
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 05:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQrse-0002tw-5l
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 05:06:25 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:36152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQrsd-0002t4-U4
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 05:06:24 -0400
Received: by mail-wm0-x22d.google.com with SMTP id 62so104185247wmw.1
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 02:06:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f7ff9307-f341-f7df-3c80-374626f7631a@adacore.com>
References: <1498728533-23160-1-git-send-email-frederic.konrad@adacore.com>
	<1498728533-23160-3-git-send-email-frederic.konrad@adacore.com>
	<CAFEAcA-tuehYiJkYo148N0VPJ3hwhcxYDDersmbs4TOqxQCEKw@mail.gmail.com>
	<7e7d94ce-a33c-6253-8dcf-475e93fe388f@adacore.com>
	<CAFEAcA_EcMOQ6afbmZK1jYUuWGzAUzj8AKRLvoDEsezsQkPYzA@mail.gmail.com>
	<f7ff9307-f341-f7df-3c80-374626f7631a@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Jun 2017 10:06:02 +0100
Message-ID: <CAFEAcA89iy-r0OQ1T_znZ7EHZxGMZS0p=F_O5nygOVYzC_Dwgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 2/3] arm: fix the armv7m reset state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, alistair@alistair23.me

On 30 June 2017 at 09:24, KONRAD Frederic <frederic.konrad@adacore.com> wrote:
> On 06/29/2017 06:45 PM, Peter Maydell wrote:
>> It's the same thing, though, right? If the user's ELF file
>> says "vector table is at 0x8000000" then we should either
>> (a) say that's a user error, or
>> (b) handle it right, whether we implemented the QEMU model with
>> the flash at 0 and the alias at 0x8000000, or with the flash
>> at 0x8000000 and the alias at 0.

> Fondamentaly yes, it is the same.. but it seems really strange to
> me to load the elf in the alias.

The user creating the ELF file has no idea whether we
modelled the flash at 0 and the alias at highmem or
the other way around -- that is an implementation detail
that should be completely invisible to the user.
My two suggestions are based on that point -- either we
should treat "ELF loaded at highmem" as always wrong, or
we should always support it.

> If I choose (a) I'll need to objcpy all the elf to 0 or modify
> the build script which should work on the real board.. This seems
> not really a good option to me.

I agree that I don't like this.

> If I choose (b) I won't be able to load it to SRAM and it is
> basically the same result I'll need to move or modify the config.

I don't understand this, though. Option (b) is probably painful
to implement (I don't have a good idea of how to do it) but
it ought to mean that the ELF files that work on the board
also work for QEMU (regardless of how the board model
implemented the aliased flash).

thanks
-- PMM
