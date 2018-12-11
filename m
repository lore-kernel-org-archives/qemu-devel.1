Received: from eggs.gnu.org ([2001:4830:134:3::10]:58348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWcXQ-0002GM-9X
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 02:33:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWcXN-0001pj-4L
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 02:33:04 -0500
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:39556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWcXM-0001np-S4
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 02:33:01 -0500
Received: from player688.ha.ovh.net (unknown [10.109.146.163])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 2659310DA23
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 08:32:58 +0100 (CET)
References: <20181211031044.27628-1-joel@jms.id.au>
	<20181211031044.27628-2-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6b36b24b-9cef-c741-9cfa-cda118d187f5@kaod.org>
Date: Tue, 11 Dec 2018 08:32:53 +0100
MIME-Version: 1.0
In-Reply-To: <20181211031044.27628-2-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] aspeed: Add syscon-poweroff to guest
 device tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 12/11/18 4:10 AM, Joel Stanley wrote:
> This adds a node to the guest's device tree that allows it to cause Qem=
u
> to exit when the guest shuts down.

Do you think we could find a way to add the same node under U-Boot for=20
tests using flash images ? or could we just add the node in DT ? Would
that be a problem on real system ?     =20


Nevertheless, this is fine.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.


> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  hw/arm/aspeed.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 515898548284..00060d44ad51 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -21,8 +21,10 @@
>  #include "hw/i2c/smbus.h"
>  #include "qemu/log.h"
>  #include "sysemu/block-backend.h"
> +#include "sysemu/device_tree.h"
>  #include "hw/loader.h"
>  #include "qemu/error-report.h"
> +#include <libfdt.h>
> =20
>  static struct arm_boot_info aspeed_board_binfo =3D {
>      .board_id =3D -1, /* device-tree-only board */
> @@ -126,6 +128,36 @@ static void write_boot_rom(DriveInfo *dinfo, hwadd=
r addr, size_t rom_size,
>      g_free(storage);
>  }
> =20
> +static void fdt_add_shutdown_node(void *fdt)
> +{
> +    const char *nodename =3D "/syscon-poweroff";
> +    uint32_t phandle;
> +    int offset;
> +
> +    /* Find the scu phandle */
> +    offset =3D fdt_path_offset(fdt, "/ahb/apb/syscon@1e6e2000");
> +    if (offset < 0) {
> +        error_report("%s couldn't find syscon, guest shutdown unavaila=
ble: %s",
> +                     __func__, fdt_strerror(offset));
> +        return;
> +    }
> +    phandle =3D fdt_get_phandle(fdt, offset);
> +
> +    /* Add syscon-poweroff node and use 0x1A0, an un-used SCU register=
 */
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon-power=
off");
> +    qemu_fdt_setprop_cells(fdt, nodename, "regmap", phandle);
> +    qemu_fdt_setprop_cells(fdt, nodename, "offset", 0x1A0);
> +    qemu_fdt_setprop_cells(fdt, nodename, "value", 1);
> +}
> +
> +static void aspeed_board_modify_dtb(const struct arm_boot_info *binfo,
> +                                    void *fdt)
> +{
> +    fdt_add_shutdown_node(fdt);
> +}
> +
> +
>  static void aspeed_board_init_flashes(AspeedSMCState *s, const char *f=
lashtype,
>                                        Error **errp)
>  {
> @@ -228,6 +260,7 @@ static void aspeed_board_init(MachineState *machine=
,
>      aspeed_board_binfo.kernel_cmdline =3D machine->kernel_cmdline;
>      aspeed_board_binfo.ram_size =3D ram_size;
>      aspeed_board_binfo.loader_start =3D sc->info->sdram_base;
> +    aspeed_board_binfo.modify_dtb =3D aspeed_board_modify_dtb;
> =20
>      if (cfg->i2c_init) {
>          cfg->i2c_init(bmc);
>=20
