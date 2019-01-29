Received: from eggs.gnu.org ([209.51.188.92]:52388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1goOP7-00006y-Ec
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1goOP6-0000Tb-La
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:05:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1goOP6-0000RL-Fu
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:05:56 -0500
Date: Tue, 29 Jan 2019 09:05:47 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190129090547.1ca97980@redhat.com>
In-Reply-To: <20190125210058.1092551-1-stefanb@linux.ibm.com>
References: <20190125210058.1092551-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] acpi: Make TPM 2.0 with TIS available as
 MSFT0101
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mst@redhat.com

On Fri, 25 Jan 2019 16:00:58 -0500
Stefan Berger <stefanb@linux.ibm.com> wrote:

> This patch makes the a TPM 2.0 with TIS interface available under the
> HID 'MSF0101'. This is supported by Linux and also Windows now
> recognizes the TPM 2.0 with TIS interface. Leave the TPM 1.2 as before.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/acpi-build.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2e21a31f82..f51225b4a7 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2141,8 +2141,16 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>              build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
>  
>              if (TPM_IS_TIS(tpm)) {
> -                dev = aml_device("ISA.TPM");
> -                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
> +                if (misc->tpm_version == TPM_VERSION_2_0) {
> +                    dev = aml_device("TPM");
> +                    aml_append(dev, aml_name_decl("_HID",
> +                                                  aml_string("MSFT0101")));
> +                } else {
> +                    dev = aml_device("ISA.TPM");
> +                    aml_append(dev, aml_name_decl("_HID",
> +                                                  aml_eisaid("PNP0C31")));
> +                }
> +
>                  aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
>                  crs = aml_resource_template();
>                  aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
