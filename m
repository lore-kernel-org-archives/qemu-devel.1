Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1713C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 09:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F0E206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 09:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F0E206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsNIM-0004tc-Mw
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 05:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lorenzo.pieralisi@arm.com>)
 id 1jsNEs-0003Pv-8p
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 05:16:38 -0400
Received: from foss.arm.com ([217.140.110.172]:42686)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lorenzo.pieralisi@arm.com>) id 1jsNEp-0005VE-G2
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 05:16:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C94D430E;
 Mon,  6 Jul 2020 02:16:32 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com
 [10.1.196.255])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE0B73F71E;
 Mon,  6 Jul 2020 02:16:31 -0700 (PDT)
Date: Mon, 6 Jul 2020 10:16:25 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH v3 2/2] PCI: vmd: Use Shadow MEMBAR registers for
 QEMU/KVM guests
Message-ID: <20200706091625.GA26377@e121166-lin.cambridge.arm.com>
References: <20200528030240.16024-1-jonathan.derrick@intel.com>
 <20200528030240.16024-4-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528030240.16024-4-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=217.140.110.172;
 envelope-from=lorenzo.pieralisi@arm.com; helo=foss.arm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 05:16:33
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alex Williamson <alex.williamson@redhat.com>, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 27, 2020 at 11:02:40PM -0400, Jon Derrick wrote:
> VMD device 28C0 natively assists guest passthrough of the VMD endpoint
> through the use of shadow registers that provide Host Physical Addresses
> to correctly assign bridge windows. These shadow registers are only
> available if VMD config space register 0x70, bit 1 is set.
> 
> In order to support this mode in existing VMD devices which don't
> natively support the shadow register, it was decided that the hypervisor
> could offer the shadow registers in a vendor-specific PCI capability.
> 
> QEMU has been modified to create this vendor-specific capability and
> supply the shadow membar registers for VMDs which don't natively support
> this feature. This patch adds this mode and updates the supported device
> list to allow this feature to be used on these VMDs.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 44 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)

Applied to pci/vmd, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index e386d4e..76d8acb 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -40,13 +40,19 @@ enum vmd_features {
>  	 * membars, in order to allow proper address translation during
>  	 * resource assignment to enable guest virtualization
>  	 */
> -	VMD_FEAT_HAS_MEMBAR_SHADOW	= (1 << 0),
> +	VMD_FEAT_HAS_MEMBAR_SHADOW		= (1 << 0),
>  
>  	/*
>  	 * Device may provide root port configuration information which limits
>  	 * bus numbering
>  	 */
> -	VMD_FEAT_HAS_BUS_RESTRICTIONS	= (1 << 1),
> +	VMD_FEAT_HAS_BUS_RESTRICTIONS		= (1 << 1),
> +
> +	/*
> +	 * Device contains physical location shadow registers in
> +	 * vendor-specific capability space
> +	 */
> +	VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP	= (1 << 2),
>  };
>  
>  /*
> @@ -454,6 +460,28 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  		}
>  	}
>  
> +	if (features & VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP) {
> +		int pos = pci_find_capability(vmd->dev, PCI_CAP_ID_VNDR);
> +		u32 reg, regu;
> +
> +		pci_read_config_dword(vmd->dev, pos + 4, &reg);
> +
> +		/* "SHDW" */
> +		if (pos && reg == 0x53484457) {
> +			pci_read_config_dword(vmd->dev, pos + 8, &reg);
> +			pci_read_config_dword(vmd->dev, pos + 12, &regu);
> +			offset[0] = vmd->dev->resource[VMD_MEMBAR1].start -
> +					(((u64) regu << 32 | reg) &
> +					 PCI_BASE_ADDRESS_MEM_MASK);
> +
> +			pci_read_config_dword(vmd->dev, pos + 16, &reg);
> +			pci_read_config_dword(vmd->dev, pos + 20, &regu);
> +			offset[1] = vmd->dev->resource[VMD_MEMBAR2].start -
> +					(((u64) regu << 32 | reg) &
> +					 PCI_BASE_ADDRESS_MEM_MASK);
> +		}
> +	}
> +
>  	/*
>  	 * Certain VMD devices may have a root port configuration option which
>  	 * limits the bus range to between 0-127, 128-255, or 224-255
> @@ -716,16 +744,20 @@ static int vmd_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
>  
>  static const struct pci_device_id vmd_ids[] = {
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
> +		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
> -		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
> +		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> +				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
> -		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
> +		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> +				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> -		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
> +		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> +				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
>  	{0,}
>  };
>  MODULE_DEVICE_TABLE(pci, vmd_ids);
> -- 
> 1.8.3.1
> 

