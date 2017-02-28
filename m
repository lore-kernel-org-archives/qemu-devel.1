Received: from eggs.gnu.org ([2001:4830:134:3::10]:43486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ciiz2-0007vU-OZ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ciiyz-0000dL-K7
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:42:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ciiyz-0000dE-BY
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:42:29 -0500
References: <1487910561-17825-1-git-send-email-peterx@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <e547f430-d078-27a5-7064-4fc5b9f738d1@redhat.com>
Date: Tue, 28 Feb 2017 16:42:25 +0200
MIME-Version: 1.0
In-Reply-To: <1487910561-17825-1-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] intel_iommu: check misordered init when
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: yi.l.liu@intel.com, Jintack Lim <jintack@cs.columbia.edu>, "\\ Michael S . Tsirkin \\ " <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

On 02/24/2017 06:29 AM, Peter Xu wrote:
> Intel vIOMMU devices are created with "-device" parameter, while here
> actually we need to make sure the dmar device be created before other
> PCI devices (like vfio-pci) so that we know iommu_fn will be setup
> correctly before realizations of those PCI devices (it is sensible that
> PCI device fetch these info during its realization). Now this ordering
> yet cannot be achieved elsewhere, and devices will be created in the
> order that user specified. That might be dangerous.
>
> Here we add one more function to detect this kind of misordering issue,
> then report to guest. Currently, the only known device that is affected
> by this VT-d defect is the vfio-pci typed devices. So for now we just
> check against it to make sure we are safe.
>

Hi,
I can't say that I like it but if we want it for 2.9 maybe we don't have a choice.

I mentioned in another thread other idea:
     Maybe we should follow the same "template" as disk/drive, nic/netdev ?
     I mean something like -device iommu,id=i1, -device vfio-pci,iommu=e1 .
You are able to change the order, I didn't look how it is done.

A nice side effect is that you can:
  1. Limit the iommu scope only to the devices you want to protect (tweaking APCI tables)
  2. In the future we can support multiple iommu devices.

Thanks,
Marcel

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 22d8226..b723ece 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2560,6 +2560,24 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>      return true;
>  }
>
> +/*
> + * TODO: we should have a better way to achieve the ordering rather
> + * than this misorder check explicitly against vfio-pci. After all, no
> + * one should be blamed for this, and vfio-pci did nothing wrong.
> + */
> +static bool vtd_detected_misorder_init(Error **errp)
> +{
> +    Object *dev = object_resolve_path_type("", "vfio-pci", NULL);
> +
> +    if (dev) {
> +        error_setg(errp, "Please specify \"intel-iommu\" before all the rest "
> +                   "of the devices.");
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>  static void vtd_realize(DeviceState *dev, Error **errp)
>  {
>      PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
> @@ -2567,6 +2585,10 @@ static void vtd_realize(DeviceState *dev, Error **errp)
>      IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
>      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
>
> +    if (vtd_detected_misorder_init(errp)) {
> +        return;
> +    }
> +
>      VTD_DPRINTF(GENERAL, "");
>      x86_iommu->type = TYPE_INTEL;
>
>
