Received: from eggs.gnu.org ([209.51.188.92]:44471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw69F-0002DF-7y
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:13:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw69E-0006kn-46
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:13:25 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gw69C-0006ip-BQ
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:13:23 -0500
Received: by mail-ot1-x341.google.com with SMTP id i20so34419123otl.0
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 06:13:21 -0800 (PST)
MIME-Version: 1.0
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-11-armbru@redhat.com>
In-Reply-To: <20190218125615.18970-11-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Feb 2019 14:13:09 +0000
Message-ID: <CAFEAcA9NLjpoB47vG-vhTpp1zKdrFb3FRXjNUbzjxVCb4soRyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 10/10] hw/arm hw/xtensa: De-duplicate
 pflash creation code some
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, Laszlo Ersek <lersek@redhat.com>

On Mon, 18 Feb 2019 at 13:08, Markus Armbruster <armbru@redhat.com> wrote:
>
> pflash_cfi01_register() creates a TYPE_CFI_PFLASH01 device, sets
> properties, realizes, and wires up.
>
> We have three modified copies of it, because their users need to set
> additional properties, or have the wiring done differently.
>
> Factor out their common part into pflash_cfi01_create().
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/arm/vexpress.c        | 22 +++++-----------------
>  hw/arm/virt.c            | 26 +++++++++-----------------
>  hw/block/pflash_cfi01.c  | 39 +++++++++++++++++++++++++++------------
>  hw/xtensa/xtfpga.c       | 18 +++++++-----------
>  include/hw/block/flash.h |  8 ++++++++
>  5 files changed, 56 insertions(+), 57 deletions(-)
>
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index 00913f2655..b23c63ed24 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -515,26 +515,14 @@ static void vexpress_modify_dtb(const struct arm_boot_info *info, void *fdt)
>  static PFlashCFI01 *ve_pflash_cfi01_register(hwaddr base, const char *name,
>                                               DriveInfo *di)
>  {
> -    DeviceState *dev = qdev_create(NULL, TYPE_CFI_PFLASH01);
> +    DeviceState *dev;
>
> -    if (di) {
> -        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(di),
> -                            &error_abort);
> -    }
> -
> -    qdev_prop_set_uint32(dev, "num-blocks",
> -                         VEXPRESS_FLASH_SIZE / VEXPRESS_FLASH_SECT_SIZE);
> -    qdev_prop_set_uint64(dev, "sector-length", VEXPRESS_FLASH_SECT_SIZE);
> -    qdev_prop_set_uint8(dev, "width", 4);
> +    dev = DEVICE(pflash_cfi01_create(name, VEXPRESS_FLASH_SIZE,
> +                                     di ? blk_by_legacy_dinfo(di) : NULL,
> +                                     VEXPRESS_FLASH_SECT_SIZE,
> +                                     4, 0x89, 0x18, 0x00, 0x00, false));
>      qdev_prop_set_uint8(dev, "device-width", 2);
> -    qdev_prop_set_bit(dev, "big-endian", false);
> -    qdev_prop_set_uint16(dev, "id0", 0x89);
> -    qdev_prop_set_uint16(dev, "id1", 0x18);
> -    qdev_prop_set_uint16(dev, "id2", 0x00);
> -    qdev_prop_set_uint16(dev, "id3", 0x00);
> -    qdev_prop_set_string(dev, "name", name);
>      qdev_init_nofail(dev);
> -
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>      return CFI_PFLASH01(dev);
>  }

I prefer this code the way it stands. In particular the
"call another function but then set the 'device-width'
property here" looks dubious. But broadly speaking the
"do all the property setting directly rather than calling
a helper function" is the style choice I think we should
be aiming for. (The prevalence of the other approach is
due to a mix of (1) older code we haven't updated and
(2) property-setting being annoyingly heavyweight
syntax.)

thanks
-- PMM
