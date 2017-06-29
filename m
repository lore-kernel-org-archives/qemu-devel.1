Received: from eggs.gnu.org ([2001:4830:134:3::10]:33942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQb9K-000339-P1
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQb9J-0003vi-JO
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:14:30 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:36423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQb9J-0003vU-Bu
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:14:29 -0400
Received: by mail-wm0-x22f.google.com with SMTP id 62so85586684wmw.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 08:14:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1498728533-23160-3-git-send-email-frederic.konrad@adacore.com>
References: <1498728533-23160-1-git-send-email-frederic.konrad@adacore.com>
	<1498728533-23160-3-git-send-email-frederic.konrad@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jun 2017 16:14:07 +0100
Message-ID: <CAFEAcA-tuehYiJkYo148N0VPJ3hwhcxYDDersmbs4TOqxQCEKw@mail.gmail.com>
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

On 29 June 2017 at 10:28, KONRAD Frederic <frederic.konrad@adacore.com> wrote:
> This fixes an odd bug when a ROM is present somewhere and an alias @0x00000000
> is pointing to the ROM. The "if (rom)" test fails and we don't get a valid reset
> state. QEMU later crashes with an exception because the ARMv7-M starts with the
> ARM instruction set. (eg: PC & 0x01 is 0).
>
> This patch uses memory_region_get_offset_within_address_space introduced before
> to check if an alias doesn't point to a flash somewhere.
>
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>

This is awkward, because in the "we have a ROM but it's not been
copied into memory yet" case, the only thing we have is the
rom->addr, which is the address which the user's ROM blob said
it ought to be loaded in at. If the user didn't actually provide
a ROM blob that loads at 0 that seems a bit like a user error,
and I don't think this patch will catch all the cases of that
sort of mistake. For instance if address 0 is real flash and the
high address alias is modelled by having the high address be the
alias, then if the user passes us an ELF file saying "load to
the high address" then this change won't catch that I think
(because doing the memory_region_find/get_offset_within_address_space
will return 0, which has already been tried). You'd need to
somehow have a way to say "find all the addresses within this
AS where this MR is mapped" and try them all...

thanks
-- PMM
