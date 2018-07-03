Received: from eggs.gnu.org ([2001:4830:134:3::10]:41139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1faI8v-00027O-P1
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1faI8p-00039o-On
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:02:41 -0400
Received: from mail-sn1nam01on0108.outbound.protection.outlook.com
	([104.47.32.108]:49118
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1faI8p-000378-6u
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:02:35 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 3 Jul 2018 10:02:31 +0000
Message-ID: <BN7PR08MB4868207D07868BDDB87E7C74C6420@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180217192215.28581-1-paul.burton@mips.com>
	<20180217192215.28581-2-paul.burton@mips.com>
	<a67d6a92-7a00-e1e2-541e-843e676c9c19@amsat.org>
	<BN7PR08MB4868110F66E113B4E1C8AE7CC6420@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/mips/boston: Enable pch_gbe
 ethernet controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Paul Burton <pburton@wavecomp.com>, Jason Wang <jasowang@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

> Enable CONFIG_PCH_GBE_PCI in mips64el-softmmu.mak (currently the only=0A=
> default config to enable Boston board support) and create the pch_gbe=0A=
> device when using the Boston board.=0A=
>=0A=
> This provides the board with an ethernet controller matching that found=
=0A=
> on real Boston boards as part of the Intel EG20T Platform Controller=0A=
> Hub, and allows standard Boston Linux kernels to have network access.=0A=
>=0A=
> This is most easily tested using the downstream linux-mti kernels at the=
=0A=
> moment, until MIPS support for the Linux pch_gbe driver is upstream. For=
=0A=
> example, presuming U-Boot's mkimage tool is present in your $PATH, this=
=0A=
> should be sufficient to boot Linux & see it obtain an IP address using=0A=
> the emulated pch_gbe device:=0A=
>=0A=
>   $ git clone git://git.linux-mips.org/pub/scm/linux-mti.git -b eng=0A=
>   $ cd linux-mti=0A=
>   $ make ARCH=3Dmips 64r6el_defconfig=0A=
>   $ make ARCH=3Dmips CROSS_COMPILE=3D/path/to/compiler/bin/mips-linux-gnu=
-=0A=
>   $ qemu-system-mips64el \=0A=
>       -M boston -cpu I6400 \=0A=
>       -kernel arch/mips/boot/vmlinux.gz.itb \=0A=
>       -serial stdio -append "ip=3Ddhcp"=0A=
>=0A=
> Signed-off-by: Paul Burton <address@hidden>=0A=
> Cc: Aurelien Jarno <address@hidden>=0A=
> Cc: Yongbok Kim <address@hidden>=0A=
>=0A=
=0A=
Reviewed-by: Aleksandar Markovic <AMarkovic@wavecomp.com>=0A=
=0A=
> ---=0A=
>=0A=
>  default-configs/mips64el-softmmu.mak | 1 +=0A=
>  hw/mips/boston.c                     | 8 +++++++-=0A=
>  2 files changed, 8 insertions(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/default-configs/mips64el-softmmu.mak=0A=
> b/default-configs/mips64el-softmmu.mak=0A=
> index c2ae313f47..85175ea223 100644=0A=
> --- a/default-configs/mips64el-softmmu.mak=0A=
> +++ b/default-configs/mips64el-softmmu.mak=0A=
> @@ -13,3 +13,4 @@ CONFIG_VT82C686=3Dy=0A=
>  CONFIG_MIPS_BOSTON=3Dy=0A=
>  CONFIG_FITLOADER=3Dy=0A=
>  CONFIG_PCI_XILINX=3Dy=0A=
> +CONFIG_PCH_GBE_PCI=3Dy=0A=
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c=0A=
> index fb23161b33..408977bca1 100644=0A=
> --- a/hw/mips/boston.c=0A=
> +++ b/hw/mips/boston.c=0A=
> @@ -31,6 +31,7 @@=0A=
>  #include "hw/mips/cps.h"=0A=
>  #include "hw/mips/cpudevs.h"=0A=
>  #include "hw/pci-host/xilinx-pcie.h"=0A=
> +#include "net/net.h"=0A=
>  #include "qapi/error.h"=0A=
>  #include "qemu/cutils.h"=0A=
>  #include "qemu/error-report.h"=0A=
> @@ -430,7 +431,7 @@ static void boston_mach_init(MachineState *machine)=
=0A=
>      MemoryRegion *flash, *ddr, *ddr_low_alias, *lcd, *platreg;=0A=
>      MemoryRegion *sys_mem =3D get_system_memory();=0A=
>      XilinxPCIEHost *pcie2;=0A=
> -    PCIDevice *ahci;=0A=
> +    PCIDevice *ahci, *eth;=0A=
>      DriveInfo *hd[6];=0A=
>      Chardev *chr;=0A=
>      int fw_size, fit_err;=0A=
> @@ -529,6 +530,11 @@ static void boston_mach_init(MachineState *machine)=
=0A=
>      ide_drive_get(hd, ahci_get_num_ports(ahci));=0A=
>      ahci_ide_create_devs(ahci, hd);=0A=
>  =0A=
> +    eth =3D pci_create(&PCI_BRIDGE(&pcie2->root)->sec_bus,=0A=
> +                     PCI_DEVFN(0, 1), "pch_gbe");=0A=
> +    qdev_set_nic_properties(&eth->qdev, &nd_table[0]);=0A=
> +    qdev_init_nofail(&eth->qdev);=0A=
> +=0A=
>      if (machine->firmware) {=0A=
>          fw_size =3D load_image_targphys(machine->firmware,=0A=
>                                        0x1fc00000, 4 * M_BYTE);=0A=
> --=0A=
> 2.16.1>=0A=
