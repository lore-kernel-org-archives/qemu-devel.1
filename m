Received: from eggs.gnu.org ([2001:4830:134:3::10]:55425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eSP4b-0004Ll-B3
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eSP4X-0000M3-9Y
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:17:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eSP4X-0000Jz-2L
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:17:17 -0500
Date: Fri, 22 Dec 2017 16:17:07 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171222161707.76edf0cb@igors-macbook-pro.local>
In-Reply-To: <20171222015120.31730-1-haozhong.zhang@intel.com>
References: <20171222015120.31730-1-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc: fail memory hot-plug/unplug with
 -no-acpi and Q35 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, 22 Dec 2017 09:51:20 +0800
Haozhong Zhang <haozhong.zhang@intel.com> wrote:

> When -no-acpi option is used with Q35 machine type, no guest ACPI is
> built, but the ACPI device is still created, so only checking the
> presence of ACPI device before memory plug/unplug is not enough in
> such cases. Check whether ACPI is disabled globally in addition and
> fail memory plug/unplug if it's disabled.
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
we do not expose dimms in E820, so there is no point in allowing them
being added (hot or cold-plug) without acpi enabled as guest
won't be able to know where they are located.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3fcf318a95..55686bf5d8 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1695,9 +1695,14 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
>          align = memory_region_get_alignment(mr);
>      }
>  
> -    if (!pcms->acpi_dev) {
> +    /*
> +     * When -no-acpi is used with Q35 machine type, no ACPI is built,
> +     * but pcms->acpi_dev is still created. Check !acpi_enabled in
> +     * addition to cover this case.
> +     */
> +    if (!pcms->acpi_dev || !acpi_enabled) {
>          error_setg(&local_err,
> -                   "memory hotplug is not enabled: missing acpi device");
> +                   "memory hotplug is not enabled: missing acpi device or acpi disabled");
>          goto out;
>      }
>  
> @@ -1729,9 +1734,14 @@ static void pc_dimm_unplug_request(HotplugHandler *hotplug_dev,
>      Error *local_err = NULL;
>      PCMachineState *pcms = PC_MACHINE(hotplug_dev);
>  
> -    if (!pcms->acpi_dev) {
> +    /*
> +     * When -no-acpi is used with Q35 machine type, no ACPI is built,
> +     * but pcms->acpi_dev is still created. Check !acpi_enabled in
> +     * addition to cover this case.
> +     */
> +    if (!pcms->acpi_dev || !acpi_enabled) {
>          error_setg(&local_err,
> -                   "memory hotplug is not enabled: missing acpi device");
> +                   "memory hotplug is not enabled: missing acpi device or acpi disabled");
>          goto out;
>      }
>  
