Received: from eggs.gnu.org ([2001:4830:134:3::10]:56598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1ch86V-0003uV-QB
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:07:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1ch86S-0002ke-LS
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:07:39 -0500
Received: from mx6-phx2.redhat.com ([209.132.183.39]:48249)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1ch86S-0002kC-CW
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:07:36 -0500
Date: Fri, 24 Feb 2017 00:07:33 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <153715427.26269614.1487912853628.JavaMail.zimbra@redhat.com>
In-Reply-To: <1487910561-17825-1-git-send-email-peterx@redhat.com>
References: <1487910561-17825-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, yi l liu <yi.l.liu@intel.com>, "\\ Michael S . Tsirkin \";
	\"Alex Williamson\" <alex.williamson@redhat.com>;
	\"Marcel Apfelbaum\" <marcel@redhat.com>; \"Jintack Lim" <mst@redhat.com>

Hello Peter,

This solution looks to check dependency of 'vfio-pci' over 'intel-iommu'
before 'intel-iommu' is not initialized.

Overall it looks good to me, just a small nit below.
 
> 
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
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 22d8226..b723ece 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2560,6 +2560,24 @@ static bool vtd_decide_config(IntelIOMMUState *s,
> Error **errp)
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
> +        error_setg(errp, "Please specify \"intel-iommu\" before all the rest

            "before all the rest" does not give much clue to user. Do you think better
            error message would help? just a thought.
> "
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
> @@ -2567,6 +2585,10 @@ static void vtd_realize(DeviceState *dev, Error
> **errp)
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
> --
> 2.7.4
> 
> 
> 
