Received: from eggs.gnu.org ([209.51.188.92]:39039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hM8b3-0004bW-4F
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hM8b2-0000Q4-7T
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:05:45 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hM8b2-0000OU-23
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:05:44 -0400
Received: by mail-oi1-x242.google.com with SMTP id j9so469605oie.10
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 03:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556515687.git.alistair@alistair23.me>
	<PSXP216MB02771957D4B9C5A15914D05FDD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
	<CAFEAcA86i3aZx-h2ys5kmc35AMqzd6k=JrfVXObdbcppnn-J8w@mail.gmail.com>
	<CAKmqyKMM0QHgdS3Z9Fd13XjeFsiG1UnZYz5brdjJgnbHXmxBrQ@mail.gmail.com>
In-Reply-To: <CAKmqyKMM0QHgdS3Z9Fd13XjeFsiG1UnZYz5brdjJgnbHXmxBrQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2019 11:05:31 +0100
Message-ID: <CAFEAcA-dZ5qdh58QCmX+t2RpJim8Fu9FY0UBY1tMpQOHkG06mA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 5/5] hw/arm: Add the Netduino Plus 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Tue, 30 Apr 2019 at 21:29, Alistair Francis <alistair23@gmail.com> wrote:
>
> On Tue, Apr 30, 2019 at 9:02 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> > Can you explain the purpose of the reset code? None of the other
> > v7m boards seem to need to do a manual qemu_register_reset().
>
> The reset code allows the machine to work with the -kernel option.
> Without the reset override using -kernel results in the guest starting
> at the wrong address. We can use the -device loader option without the
> reset code though.

That sounds in line with how -kernel works on the other armv7m
boards -- the expectation is that your image file includes a
full vector table and the CPU will read the PC and SP from it
when it resets. If you want "honour the entry point" you can
use -device loader, as you say.

Ignoring the entry point for -kernel ELF files is certainly
a bit confusing, but I think if we want to change this we should
do it globally, rather than having one board which behaves
differently to the rest. Changing it does have some awkwardness:
 * possibility of breaking previously working images
 * we can get the initial PC from the ELF entrypoint, but if
   we do this what do we do about the initial SP value ?

thanks
-- PMM
