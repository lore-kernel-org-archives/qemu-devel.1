Received: from eggs.gnu.org ([2001:4830:134:3::10]:35009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTB2f-0007ql-Ld
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:26:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTB2e-0008Dk-Rn
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:26:01 -0500
Received: from mail-ua0-x22d.google.com ([2607:f8b0:400c:c08::22d]:34054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTB2e-0008Df-No
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:26:00 -0500
Received: by mail-ua0-x22d.google.com with SMTP id 35so85876059uak.1
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 09:26:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484328738-21149-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1484328738-21149-1-git-send-email-ard.biesheuvel@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jan 2017 17:25:39 +0000
Message-ID: <CAFEAcA-s4To6BCgFzUG6Bs_rpeVupatXpHm45b=26QmLJAwy8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] hw/arm/virt-acpi - reserve ECAM space
 as PNP0C02 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>

On 13 January 2017 at 17:32, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Linux for arm64 v4.10 and later will complain if the ECAM config space is
> not reserved in the ACPI namespace:
>
>   acpi PNP0A08:00: [Firmware Bug]: ECAM area [mem 0x3f000000-0x3fffffff] not reserved in ACPI namespace
>
> The rationale is that OSes that don't consume the MCFG table should still
> be able to infer that the PCI config space MMIO region is occupied.
>
> So update the ACPI table generation routine to add this reservation.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  hw/arm/virt-acpi-build.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 085a61117378..50d52f685f68 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -310,6 +310,13 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>      Aml *dev_rp0 = aml_device("%s", "RP0");
>      aml_append(dev_rp0, aml_name_decl("_ADR", aml_int(0)));
>      aml_append(dev, dev_rp0);
> +
> +    Aml *dev_res0 = aml_device("%s", "RES0");
> +    aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_memory32_fixed(base_ecam, size_ecam, AML_READ_WRITE));
> +    aml_append(dev_res0, aml_name_decl("_CRS", crs));
> +    aml_append(dev, dev_res0);
>      aml_append(scope, dev);
>  }

This needs to be controlled via the machine class back-compat
machinery in hw/arm/virt.c so that it only happens for virt-2.9
and later.

thanks
-- PMM
