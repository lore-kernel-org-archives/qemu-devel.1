Received: from eggs.gnu.org ([2001:4830:134:3::10]:47685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gO3Ag-0006dV-Ei
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 11:10:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gO3Af-0008Ac-OP
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 11:10:10 -0500
References: <1542482566-91660-1-git-send-email-peng.hao2@zte.com.cn>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <5fb48e39-d91b-6750-975b-ea58575ade92@redhat.com>
Date: Sat, 17 Nov 2018 17:10:00 +0100
MIME-Version: 1.0
In-Reply-To: <1542482566-91660-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/sysbus-fdt: fix assert in match
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

Hi Peng,

On 11/17/18 8:22 PM, Peng Hao wrote:
> In match function it should not call OBJECK_CHECK. When there is
> a mismatch, we should continue to match rather than assert().

Normally this issue should have been fixed by
e9ac8e84f0  "hw/arm/sysbus-fdt: Only call match_fn callback if the type
matches". Please can you confirm?

Thanks

Eric
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  hw/arm/sysbus-fdt.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
> index 0e24c80..41b962d 100644
> --- a/hw/arm/sysbus-fdt.c
> +++ b/hw/arm/sysbus-fdt.c
> @@ -419,10 +419,15 @@ static int add_amd_xgbe_fdt_node(SysBusDevice *sbdev, void *opaque)
>  static bool vfio_platform_match(SysBusDevice *sbdev,
>                                  const BindingEntry *entry)
>  {
> -    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
> +    VFIOPlatformDevice *vdev;
>      const char *compat;
>      unsigned int n;
>  
> +    vdev = (VFIOPlatformDevice *) object_dynamic_cast(OBJECT(sbdev),
> +                                                TYPE_VFIO_PLATFORM);
> +    if (!vdev)
> +        return false;
> +
>      for (n = vdev->num_compat, compat = vdev->compat; n > 0;
>           n--, compat += strlen(compat) + 1) {
>          if (!strcmp(entry->compat, compat)) {
> 
