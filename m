Received: from eggs.gnu.org ([2001:4830:134:3::10]:42938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fn2pA-0000wp-RA
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fn2p9-0002Fy-Df
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:19:00 -0400
References: <20180725143413.9728-1-geert+renesas@glider.be>
	<20180725143413.9728-3-geert+renesas@glider.be>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <768b7a25-273d-69cb-5b98-8339313560c3@redhat.com>
Date: Tue, 7 Aug 2018 16:18:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180725143413.9728-3-geert+renesas@glider.be>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/4] hw/arm/sysbus-fdt: Allow device
 matching with DT compatible value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org

Hi Geert,

On 07/25/2018 04:34 PM, Geert Uytterhoeven wrote:
> From: Auger Eric <eric.auger@redhat.com>
> 
> Up to now we have relied on the device type to identify a device tree
> node creation function.  Since we would like the vfio-platform device to
> be instantiatable with different compatible strings we introduce the
> capability to specialize the node creation depending on actual
> compatible value.
> 
> NodeCreationPair is renamed into BindingEntry. The struct is enhanced
> with compat and match_fn() fields.  We introduce a new matching function
> adapted to the vfio-platform generic device.
> 
> From now on, the AMD XGBE can be instantiated with either manner, i.e.:
> 
>     -device vfio-amd-xgbe,host=e0900000.xgmac
> 
> or using the new option line:
> 
>     -device vfio-platform,host=e0900000.xgmac
strictly speaking I think you need patch 3 to do that?
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> [geert: Match using compatible values in sysfs instead of user-supplied
> 	manufacturer/model options, reword]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Not tested with amd-xgbe due to lack of hardware.
I tested it. Feel free to add:
Tested-by: Eric Auger <eric.auger@redhat.com>

Otherwise looks fine to me

Thanks

Eric
> 
> v3:
>   - Match using the compatible values from sysfs instead of using
>     user-supplied manufacturer and model options,
>   - Reword patch description,
>   - Drop RFC state,
> 
> v2:
>   - No changes,
> 
> v1:
>   - No changes,
> 
> v0:
>   - Original version from Eric.
> ---
>  hw/arm/sysbus-fdt.c | 61 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 47 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
> index 43d6a7bb48ddc351..0e24c803a1c2c734 100644
> --- a/hw/arm/sysbus-fdt.c
> +++ b/hw/arm/sysbus-fdt.c
> @@ -50,11 +50,13 @@ typedef struct PlatformBusFDTData {
>      PlatformBusDevice *pbus;
>  } PlatformBusFDTData;
>  
> -/* struct that associates a device type name and a node creation function */
> -typedef struct NodeCreationPair {
> +/* struct that allows to match a device and create its FDT node */
> +typedef struct BindingEntry {
>      const char *typename;
> -    int (*add_fdt_node_fn)(SysBusDevice *sbdev, void *opaque);
> -} NodeCreationPair;
> +    const char *compat;
> +    int  (*add_fn)(SysBusDevice *sbdev, void *opaque);
> +    bool (*match_fn)(SysBusDevice *sbdev, const struct BindingEntry *combo);
> +} BindingEntry;
>  
>  /* helpers */
>  
> @@ -413,6 +415,27 @@ static int add_amd_xgbe_fdt_node(SysBusDevice *sbdev, void *opaque)
>      return 0;
>  }
>  
> +/* DT compatible matching */
> +static bool vfio_platform_match(SysBusDevice *sbdev,
> +                                const BindingEntry *entry)
> +{
> +    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
> +    const char *compat;
> +    unsigned int n;
> +
> +    for (n = vdev->num_compat, compat = vdev->compat; n > 0;
> +         n--, compat += strlen(compat) + 1) {
> +        if (!strcmp(entry->compat, compat)) {
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +#define VFIO_PLATFORM_BINDING(compat, add_fn) \
> +    {TYPE_VFIO_PLATFORM, (compat), (add_fn), vfio_platform_match}
> +
>  #endif /* CONFIG_LINUX */
>  
>  static int no_fdt_node(SysBusDevice *sbdev, void *opaque)
> @@ -420,14 +443,23 @@ static int no_fdt_node(SysBusDevice *sbdev, void *opaque)
>      return 0;
>  }
>  
> -/* list of supported dynamic sysbus devices */
> -static const NodeCreationPair add_fdt_node_functions[] = {
> +/* Device type based matching */
> +static bool type_match(SysBusDevice *sbdev, const BindingEntry *entry)
> +{
> +    return !strcmp(object_get_typename(OBJECT(sbdev)), entry->typename);
> +}
> +
> +#define TYPE_BINDING(type, add_fn) {(type), NULL, (add_fn), type_match}
> +
> +/* list of supported dynamic sysbus bindings */
> +static const BindingEntry bindings[] = {
>  #ifdef CONFIG_LINUX
> -    {TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_node},
> -    {TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node},
> +    TYPE_BINDING(TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_node),
> +    TYPE_BINDING(TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node),
> +    VFIO_PLATFORM_BINDING("amd,xgbe-seattle-v1a", add_amd_xgbe_fdt_node),
>  #endif
> -    {TYPE_RAMFB_DEVICE, no_fdt_node},
> -    {"", NULL}, /* last element */
> +    TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
> +    TYPE_BINDING("", NULL), /* last element */
>  };
>  
>  /* Generic Code */
> @@ -446,10 +478,11 @@ static void add_fdt_node(SysBusDevice *sbdev, void *opaque)
>  {
>      int i, ret;
>  
> -    for (i = 0; i < ARRAY_SIZE(add_fdt_node_functions); i++) {
> -        if (!strcmp(object_get_typename(OBJECT(sbdev)),
> -                    add_fdt_node_functions[i].typename)) {
> -            ret = add_fdt_node_functions[i].add_fdt_node_fn(sbdev, opaque);
> +    for (i = 0; i < ARRAY_SIZE(bindings); i++) {
> +        const BindingEntry *iter = &bindings[i];
> +
> +        if (iter->match_fn(sbdev, iter)) {
> +            ret = iter->add_fn(sbdev, opaque);
>              assert(!ret);
>              return;
>          }
> 
