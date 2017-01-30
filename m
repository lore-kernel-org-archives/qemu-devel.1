Received: from eggs.gnu.org ([2001:4830:134:3::10]:55173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYBVA-000362-O0
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:56:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYBV9-0002eL-TE
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:56:08 -0500
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:35836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYBV9-0002eA-On
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:56:07 -0500
Received: by mail-ua0-x22a.google.com with SMTP id y9so250422713uae.2
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 04:56:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1483979087-32663-11-git-send-email-clg@kaod.org>
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
	<1483979087-32663-11-git-send-email-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jan 2017 12:55:46 +0000
Message-ID: <CAFEAcA-6vi3UbSa5naSqbk-JG+UysiwM6TyvqE29VUbswD7MFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/11] aspeed: use first FMC flash as a
 boot ROM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Marcin Krzeminski <marcin.krzeminski@nokia.com>

On 9 January 2017 at 16:24, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Create a ROM region, using the default size of the mapping window for
> the CE0 FMC flash module, and fill it with the flash content.
>
> This is a little hacky but until we can boot from a MMIO region, it
> seems difficult to do anything else.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  hw/arm/aspeed.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 40c13838fb2d..a92c2f1c362b 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -20,6 +20,8 @@
>  #include "qemu/log.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/blockdev.h"
> +#include "hw/loader.h"
> +#include "qemu/error-report.h"
>
>  static struct arm_boot_info aspeed_board_binfo =3D {
>      .board_id =3D -1, /* device-tree-only board */
> @@ -104,6 +106,28 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
>      },
>  };
>
> +#define FIRMWARE_ADDR 0x0
> +
> +static void write_boot_rom(DriveInfo *dinfo, hwaddr addr, size_t rom_siz=
e,
> +                           Error **errp)
> +{
> +    BlockBackend *blk =3D blk_by_legacy_dinfo(dinfo);
> +    uint8_t *storage;
> +
> +    if (rom_size > blk_getlength(blk)) {
> +        rom_size =3D blk_getlength(blk);
> +    }
> +
> +    storage =3D g_new0(uint8_t, rom_size);

Hi -- coverity points out that you're not checking for the
case where blk_getlength() returns negative. (This can happen
for the case where the BlockBackend represents an insertable
device like a floppy or cdrom with no medium present.)

Since for aspeed this dinfo always represents a flash device,
we know this shouldn't happen, so you can just make it a fatal
error if blk_getlength() doesn't return what you're expecting.

> +    if (blk_pread(blk, 0, storage, rom_size) < 0) {
> +        error_setg(errp, "failed to read the initial flash content");
> +        return;
> +    }
> +
> +    rom_add_blob_fixed("aspeed.boot_rom", storage, rom_size, addr);
> +    g_free(storage);
> +}

thanks
-- PMM
