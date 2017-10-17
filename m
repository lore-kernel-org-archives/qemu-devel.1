Received: from eggs.gnu.org ([2001:4830:134:3::10]:55849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4Txx-0005dk-88
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4Txw-0007Hg-3U
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:39:37 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:48839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e4Txv-0007HW-SZ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:39:36 -0400
Received: by mail-wr0-x22c.google.com with SMTP id u5so2155446wrc.5
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 08:39:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171013142852.916-2-clg@kaod.org>
References: <20171013142852.916-1-clg@kaod.org>
	<20171013142852.916-2-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2017 16:39:14 +0100
Message-ID: <CAFEAcA-gYYbQu-Nuds3E0Aw7j0OdD5_ySm=EdMb1_FzxEoMTBQ@mail.gmail.com>
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

On 13 October 2017 at 15:28, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> The Witherspoon boards are OpenPOWER system hosting POWER9 Processors.
> Let's add support for their BMC including a couple of I2C devices as
> found on real HW.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>
>  Changes since v2:
>
>  - removed 'ignore_memory_transaction_failures' flag on the machine.
>    Will require a couple of fixes in the legacy U-Boot accessing wrongly
>    the bss before the DRAM is initialized.
>
>    The HW drops the write access surely because the SMC controller is
>    configured in autoread mode by default. I don't know how to model
>    this behavior in QEMU. I think we would need suppport to boot from
>    a MMIO region.

It is actually possible now -- see hw/ssi/xilinx_spips.c and the
request_mmio_ptr code. It's a bit experimental at the moment
though (in particular it breaks migration, a thing which we
seem to have forgotten to fix for this release cycle :-( )

The other similar thing we have is the flash devices, which
allow execution, but requires that the guest doesn't try to
execute at the same time as it's put the flash into
reads-like-a-device mode.

How are you modelling this bit of the address space at the moment?
A "reads like RAM but writes are ignored" lump of memory is easy...

In any case we can deal with this as a later patchset.

thanks
-- PMM
