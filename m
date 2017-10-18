Received: from eggs.gnu.org ([2001:4830:134:3::10]:41219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4rER-0005wa-69
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4rEM-0005VC-Oi
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:30:11 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:55911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e4rEM-0005UD-Hx
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:30:06 -0400
Received: by mail-wm0-x22b.google.com with SMTP id u138so11326403wmu.4
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:30:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8ded3a0e-f7da-00cd-3abd-7d4bb22a5016@kaod.org>
References: <20171013142852.916-1-clg@kaod.org>
	<20171013142852.916-2-clg@kaod.org>
	<CAFEAcA-gYYbQu-Nuds3E0Aw7j0OdD5_ySm=EdMb1_FzxEoMTBQ@mail.gmail.com>
	<8ded3a0e-f7da-00cd-3abd-7d4bb22a5016@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Oct 2017 17:29:43 +0100
Message-ID: <CAFEAcA-7+XAXTVeemQvzEfRmCoMLTBDbM7VnCS6L6k0avXRcgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/6] aspeed: add support for the
 witherspoon-bmc board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 18 October 2017 at 17:10, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 10/17/2017 05:39 PM, Peter Maydell wrote:
>> A "reads like RAM but writes are ignored" lump of memory is easy...
>
> yes. It seems but I haven't found my way through :/

memory_region_init_rom_device() creates a memory region
which is backed by RAM for reads (and for debug writes,
like ELF file loading), but backed by the usual
device callback functions for writes. So I think you should
just be able to use one of those but with the write
functions doing nothing (or warning about unimp. behaviour,
assuming that your flash devices actually have some
kind of command behaviour for writes).

This is how we implement the flash device with actual
behaviour behind them.

hw/mips/boston.c actually has an example of doing a dummy
flash device like this (though it uses
memory_region_init_rom_device_nomigrate(), which is a bug
because your memory contents won't get migrated if you
do that. Use the plain function instead.)

thanks
-- PMM
