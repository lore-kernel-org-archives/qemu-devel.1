Received: from eggs.gnu.org ([209.51.188.92]:57974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hL86F-00037c-GG
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hL86E-0003MV-Ak
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:21:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hL86D-0003HC-63
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:21:45 -0400
References: <20190427165504.29846-1-philmd@redhat.com>
	<20190427165504.29846-2-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bca8bc52-50fc-575e-718f-8590b47fa1f8@redhat.com>
Date: Mon, 29 Apr 2019 17:21:30 +0200
MIME-Version: 1.0
In-Reply-To: <20190427165504.29846-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/acpi: Simplify the Makefile logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Samuel Ortiz <sameo@linux.intel.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Yang Zhong <yang.zhong@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Igor Mammedov <imammedo@redhat.com>

On 27/04/2019 18.55, Philippe Mathieu-Daud=C3=A9 wrote:
> Since we only require to link with acpi-stub.o when CONFIG_ACPI
> is disabled, we can simplify the Makefile logic.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/acpi/Makefile.objs | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
> index 2d46e3789ae..c86edfbed90 100644
> --- a/hw/acpi/Makefile.objs
> +++ b/hw/acpi/Makefile.objs
> @@ -1,4 +1,3 @@
> -ifeq ($(CONFIG_ACPI),y)
>  common-obj-$(CONFIG_ACPI_X86) +=3D core.o piix4.o pcihp.o
>  common-obj-$(CONFIG_ACPI_X86_ICH) +=3D ich9.o tco.o
>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu_hotplug.o
> @@ -6,16 +5,11 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) +=3D memory_=
hotplug.o
>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu.o
>  common-obj-$(CONFIG_ACPI_NVDIMM) +=3D nvdimm.o
>  common-obj-$(CONFIG_ACPI_VMGENID) +=3D vmgenid.o
> -common-obj-$(call lnot,$(CONFIG_ACPI_X86)) +=3D acpi-stub.o
> -
>  common-obj-y +=3D acpi_interface.o
>  common-obj-y +=3D bios-linker-loader.o
>  common-obj-y +=3D aml-build.o

What about these three object files? We don't want to build them if
CONFIG_ACPI is disabled, do we?

 Thomas


>  common-obj-$(CONFIG_TPM) +=3D tpm.o
> -
>  common-obj-$(CONFIG_IPMI) +=3D ipmi.o
> +
>  common-obj-$(call lnot,$(CONFIG_IPMI)) +=3D ipmi-stub.o
> -else
> -common-obj-y +=3D acpi-stub.o
> -endif
> -common-obj-$(CONFIG_ALL) +=3D acpi-stub.o ipmi-stub.o
> +common-obj-$(call lnot,$(CONFIG_ACPI)) +=3D acpi-stub.o
>=20
