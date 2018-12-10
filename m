Received: from eggs.gnu.org ([2001:4830:134:3::10]:36526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gWNCw-0007qy-Gu
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gWNCt-0000Fu-Pe
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:10:54 -0500
References: <20181207165103.3992-1-philmd@redhat.com>
	<20181207165103.3992-5-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <59daee09-d797-3340-3fd3-c6d521d2cf68@redhat.com>
Date: Mon, 10 Dec 2018 16:10:28 +0100
MIME-Version: 1.0
In-Reply-To: <20181207165103.3992-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/smbios: Move to the hw/firmware/
 namespace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On 12/07/18 17:51, Philippe Mathieu-Daud=C3=A9 wrote:
> SMBIOS is just another firmware used by some QEMU models.
> We will later introduce more firmwares in this namespace.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS                              | 2 +-
>  hw/arm/virt.c                            | 2 +-
>  hw/i386/pc.c                             | 2 +-
>  hw/i386/pc_piix.c                        | 2 +-
>  hw/i386/pc_q35.c                         | 2 +-
>  hw/smbios/smbios-stub.c                  | 2 +-
>  hw/smbios/smbios.c                       | 2 +-
>  hw/smbios/smbios_type_38.c               | 2 +-
>  include/hw/{smbios =3D> firmware}/smbios.h | 0
>  tests/bios-tables-test.c                 | 2 +-
>  vl.c                                     | 2 +-
>  11 files changed, 10 insertions(+), 10 deletions(-)
>  rename include/hw/{smbios =3D> firmware}/smbios.h (100%)

(1) Please replace the word "namespace" in the subject, and in the
commit message too, with "subdirectory".

(2) Please replace "firmware" -- both instances -- in the commit message
with "firmware interface", or perhaps "firmware specification".

With the updates:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks,
Laszlo


> diff --git a/MAINTAINERS b/MAINTAINERS
> index 63effdc473..f7ba25c146 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1238,7 +1238,7 @@ M: Michael S. Tsirkin <mst@redhat.com>
>  M: Igor Mammedov <imammedo@redhat.com>
>  S: Supported
>  F: include/hw/acpi/*
> -F: include/hw/smbios/*
> +F: include/hw/firmware/smbios.h
>  F: hw/mem/*
>  F: hw/acpi/*
>  F: hw/smbios/*
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index f69e7eb399..49813bca1b 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -55,7 +55,7 @@
>  #include "hw/intc/arm_gic.h"
>  #include "hw/intc/arm_gicv3_common.h"
>  #include "kvm_arm.h"
> -#include "hw/smbios/smbios.h"
> +#include "hw/firmware/smbios.h"
>  #include "qapi/visitor.h"
>  #include "standard-headers/linux/input.h"
>  #include "hw/arm/smmuv3.h"
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f095725dba..afa1098082 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -37,7 +37,7 @@
>  #include "hw/pci/pci_bus.h"
>  #include "hw/nvram/fw_cfg.h"
>  #include "hw/timer/hpet.h"
> -#include "hw/smbios/smbios.h"
> +#include "hw/firmware/smbios.h"
>  #include "hw/loader.h"
>  #include "elf.h"
>  #include "multiboot.h"
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 7092d6d13f..e3ee3091d2 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -30,7 +30,7 @@
>  #include "hw/i386/pc.h"
>  #include "hw/i386/apic.h"
>  #include "hw/display/ramfb.h"
> -#include "hw/smbios/smbios.h"
> +#include "hw/firmware/smbios.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_ids.h"
>  #include "hw/usb.h"
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 4702bb13c4..bc31cd5822 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -47,7 +47,7 @@
>  #include "hw/i386/amd_iommu.h"
>  #include "hw/i386/intel_iommu.h"
>  #include "hw/display/ramfb.h"
> -#include "hw/smbios/smbios.h"
> +#include "hw/firmware/smbios.h"
>  #include "hw/ide/pci.h"
>  #include "hw/ide/ahci.h"
>  #include "hw/usb.h"
> diff --git a/hw/smbios/smbios-stub.c b/hw/smbios/smbios-stub.c
> index d3a385441a..64e5ba93ec 100644
> --- a/hw/smbios/smbios-stub.c
> +++ b/hw/smbios/smbios-stub.c
> @@ -23,7 +23,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qerror.h"
> -#include "hw/smbios/smbios.h"
> +#include "hw/firmware/smbios.h"
> =20
>  void smbios_entry_add(QemuOpts *opts, Error **errp)
>  {
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 9d737642cb..2a61f38637 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -24,7 +24,7 @@
>  #include "sysemu/sysemu.h"
>  #include "qemu/uuid.h"
>  #include "sysemu/cpus.h"
> -#include "hw/smbios/smbios.h"
> +#include "hw/firmware/smbios.h"
>  #include "hw/loader.h"
>  #include "exec/cpu-common.h"
>  #include "smbios_build.h"
> diff --git a/hw/smbios/smbios_type_38.c b/hw/smbios/smbios_type_38.c
> index a1ad28d059..0c08f282de 100644
> --- a/hw/smbios/smbios_type_38.c
> +++ b/hw/smbios/smbios_type_38.c
> @@ -9,7 +9,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "hw/ipmi/ipmi.h"
> -#include "hw/smbios/smbios.h"
> +#include "hw/firmware/smbios.h"
>  #include "qemu/error-report.h"
>  #include "smbios_build.h"
> =20
> diff --git a/include/hw/smbios/smbios.h b/include/hw/firmware/smbios.h
> similarity index 100%
> rename from include/hw/smbios/smbios.h
> rename to include/hw/firmware/smbios.h
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index d661d9be62..dfa74a5bec 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -13,7 +13,7 @@
>  #include "qemu/osdep.h"
>  #include <glib/gstdio.h>
>  #include "qemu-common.h"
> -#include "hw/smbios/smbios.h"
> +#include "hw/firmware/smbios.h"
>  #include "qemu/bitmap.h"
>  #include "acpi-utils.h"
>  #include "boot-sector.h"
> diff --git a/vl.c b/vl.c
> index a5ae5f23d2..bfc3114dd4 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -61,7 +61,7 @@ int main(int argc, char **argv)
>  #include "hw/display/vga.h"
>  #include "hw/bt.h"
>  #include "sysemu/watchdog.h"
> -#include "hw/smbios/smbios.h"
> +#include "hw/firmware/smbios.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/xen/xen.h"
>  #include "hw/qdev.h"
>=20
