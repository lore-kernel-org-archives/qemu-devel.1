Received: from eggs.gnu.org ([2001:4830:134:3::10]:43755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cQZ0e-000410-Qz
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:25:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cQZ0a-0007Vm-B0
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:25:08 -0500
References: <1483802623-5507-1-git-send-email-hpoussin@reactos.org>
	<1483802623-5507-5-git-send-email-hpoussin@reactos.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3ae2a0f5-6bf0-c6f6-5852-6aff7bf8791a@redhat.com>
Date: Mon, 9 Jan 2017 13:25:01 +0100
MIME-Version: 1.0
In-Reply-To: <1483802623-5507-5-git-send-email-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 4/4] prep: add IBM RS/6000
 7020 (40p) machine emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org
Cc: Giancarlo Teodori <gteodori@gmail.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

 Hi,

On 07.01.2017 16:23, Herv=C3=A9 Poussineau wrote:
> Machine supports both Open Hack'Ware and OpenBIOS.
> Open Hack'Ware is the default because OpenBIOS is currently unable to b=
oot
> PReP boot partitions or PReP kernels.
>=20
> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> ---
>  default-configs/ppc-softmmu.mak |   1 +
>  hw/ppc/prep.c                   | 229 ++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 230 insertions(+)
>=20
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-soft=
mmu.mak
> index e567658..7dd004e 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -18,6 +18,7 @@ CONFIG_I82378=3Dy
>  CONFIG_PC87312=3Dy
>  CONFIG_MACIO=3Dy
>  CONFIG_PCSPK=3Dy
> +CONFIG_CS4231A=3Dy
>  CONFIG_CUDA=3Dy
>  CONFIG_ADB=3Dy
>  CONFIG_MAC_NVRAM=3Dy
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 9fb89d3..9bdf573 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -2,6 +2,7 @@
>   * QEMU PPC PREP hardware System Emulator
>   *
>   * Copyright (c) 2003-2007 Jocelyn Mayer
> + * Copyright (c) 2017 Herv=C3=A9 Poussineau
>   *
>   * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
>   * of this software and associated documentation files (the "Software"=
), to deal
> @@ -43,6 +44,7 @@
>  #include "hw/isa/pc87312.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/arch_init.h"
> +#include "sysemu/kvm.h"
>  #include "sysemu/qtest.h"
>  #include "exec/address-spaces.h"
>  #include "trace.h"
> @@ -54,6 +56,8 @@
> =20
>  #define MAX_IDE_BUS 2
> =20
> +#define CFG_ADDR 0xf0000510
> +
>  #define BIOS_SIZE (1024 * 1024)
>  #define BIOS_FILENAME "ppc_rom.bin"
>  #define KERNEL_LOAD_ADDR 0x01000000
> @@ -316,6 +320,12 @@ static uint32_t PREP_io_800_readb (void *opaque, u=
int32_t addr)
> =20
>  #define NVRAM_SIZE        0x2000
> =20
> +static void fw_cfg_boot_set(void *opaque, const char *boot_device,
> +                            Error **errp)
> +{
> +    fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
> +}
> +
>  static void ppc_prep_reset(void *opaque)
>  {
>      PowerPCCPU *cpu =3D opaque;
> @@ -677,4 +687,223 @@ static void prep_machine_init(MachineClass *mc)
[...]
> +
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_IS_KVM, kvm_enabled());
> +    if (kvm_enabled()) {
> +#ifdef CONFIG_KVM
> +        uint8_t *hypercall;
> +
> +        fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_TBFREQ, kvmppc_get_tbfreq())=
;
> +        hypercall =3D g_malloc(16);
> +        kvmppc_get_hypercall(env, hypercall, 16);
> +        fw_cfg_add_bytes(fw_cfg, FW_CFG_PPC_KVM_HC, hypercall, 16);
> +        fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_KVM_PID, getpid());
> +#endif

This currently does not compile on a ppc64 host where CONFIG_KVM is set:

hw/ppc/prep.c: In function =E2=80=98ibm_40p_init=E2=80=99:
hw/ppc/prep.c:872:9: error: implicit declaration of function =E2=80=98kvm=
ppc_get_tbfreq=E2=80=99 [-Werror=3Dimplicit-function-declaration]
         fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_TBFREQ, kvmppc_get_tbfreq());
         ^
hw/ppc/prep.c:872:9: error: nested extern declaration of =E2=80=98kvmppc_=
get_tbfreq=E2=80=99 [-Werror=3Dnested-externs]
hw/ppc/prep.c:874:9: error: implicit declaration of function =E2=80=98kvm=
ppc_get_hypercall=E2=80=99 [-Werror=3Dimplicit-function-declaration]
         kvmppc_get_hypercall(env, hypercall, 16);
         ^
hw/ppc/prep.c:874:9: error: nested extern declaration of =E2=80=98kvmppc_=
get_hypercall=E2=80=99 [-Werror=3Dnested-externs]

You need to #include "kvm_ppc.h" to get the prototype of the
kvmppc_get_tbfreq() function.

 Thomas
