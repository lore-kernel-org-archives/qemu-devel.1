Received: from eggs.gnu.org ([2001:4830:134:3::10]:52020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1d3KBU-00070r-US
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1d3KBP-0004Oe-Ui
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:28:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:33549)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1d3KBP-0004JF-I8
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:28:27 -0400
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Wed, 26 Apr 2017 18:11:59 +0800
Message-Id: <1493201525-14418-3-git-send-email-yi.l.liu@intel.com>
In-Reply-To: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
Subject: [Qemu-devel] [RFC PATCH 2/8] iommu/vt-d: add bind_pasid_table
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com, Jacob Pan <jacob.jun.pan@linux.intel.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

Add Intel VT-d ops to the generic iommu_bind_pasid_table API
functions.

The primary use case is for direct assignment of SVM capable
device. Originated from emulated IOMMU in the guest, the request goes
through many layers (e.g. VFIO). Upon calling host IOMMU driver, caller
passes guest PASID table pointer (GPA) and size.

Device context table entry is modified by Intel IOMMU specific
bind_pasid_table function. This will turn on nesting mode and matching
translation type.

The unbind operation restores default context mapping.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c   | 103 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/dma_remapping.h |   1 +
 2 files changed, 104 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 646756c..6d5b939 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5306,6 +5306,105 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
 
 	return iommu;
 }
+
+static int intel_iommu_bind_pasid_table(struct iommu_domain *domain,
+		struct device *dev, struct pasid_table_info *pasidt_binfo)
+{
+	struct intel_iommu *iommu;
+	struct context_entry *context;
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct device_domain_info *info;
+	u8 bus, devfn;
+	u16 did, *sid;
+	int ret = 0;
+	unsigned long flags;
+	u64 ctx_lo;
+
+	if (pasidt_binfo == NULL || pasidt_binfo->model != INTEL_IOMMU) {
+		pr_warn("%s: Invalid bind request!\n", __func__);
+		return -EINVAL;
+	}
+
+	iommu = device_to_iommu(dev, &bus, &devfn);
+	if (!iommu)
+		return -ENODEV;
+
+	sid = (u16 *)&pasidt_binfo->opaque;
+	/* check SID, if it is not correct, return */
+	if (PCI_DEVID(bus, devfn) != *sid)
+		return 0;
+
+	info = dev->archdata.iommu;
+	if (!info || !info->pasid_supported) {
+		pr_err("Device %d:%d.%d has no pasid support\n", bus,
+			PCI_SLOT(devfn), PCI_FUNC(devfn));
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (pasidt_binfo->size >= intel_iommu_get_pts(iommu)) {
+		pr_err("Invalid gPASID table size %llu, host size %lu\n",
+			pasidt_binfo->size,
+			intel_iommu_get_pts(iommu));
+		ret = -EINVAL;
+		goto out;
+	}
+	spin_lock_irqsave(&iommu->lock, flags);
+	context = iommu_context_addr(iommu, bus, devfn, 0);
+	if (!context || !context_present(context)) {
+		pr_warn("%s: ctx not present for bus devfn %x:%x\n",
+			__func__, bus, devfn);
+		spin_unlock_irqrestore(&iommu->lock, flags);
+		goto out;
+	}
+	/* Anticipate guest to use SVM and owns the first level */
+	ctx_lo = context[0].lo;
+	ctx_lo |= CONTEXT_NESTE;
+	ctx_lo |= CONTEXT_PRS;
+	ctx_lo |= CONTEXT_PASIDE;
+	ctx_lo &= ~CONTEXT_TT_MASK;
+	ctx_lo |= CONTEXT_TT_DEV_IOTLB << 2;
+	context[0].lo = ctx_lo;
+
+	/* Assign guest PASID table pointer and size */
+	ctx_lo = (pasidt_binfo->ptr & VTD_PAGE_MASK) | pasidt_binfo->size;
+	context[1].lo = ctx_lo;
+	/* make sure context entry is updated before flushing */
+	wmb();
+	did = dmar_domain->iommu_did[iommu->seq_id];
+	iommu->flush.flush_context(iommu, did,
+				(((u16)bus) << 8) | devfn,
+				DMA_CCMD_MASK_NOBIT,
+				DMA_CCMD_DEVICE_INVL);
+	iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
+	spin_unlock_irqrestore(&iommu->lock, flags);
+
+
+out:
+	return ret;
+}
+
+static int intel_iommu_unbind_pasid_table(struct iommu_domain *domain,
+					struct device *dev)
+{
+	struct intel_iommu *iommu;
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	u8 bus, devfn;
+
+	iommu = device_to_iommu(dev, &bus, &devfn);
+	if (!iommu)
+		return -ENODEV;
+	/*
+	 * REVISIT: we might want to clear the PASID table pointer
+	 * as part of context clear operation. Currently, it leaves
+	 * stale data but should be ignored by hardware since PASIDE
+	 * is clear.
+	 */
+	/* ATS will be reenabled when remapping is restored */
+	pci_disable_ats(to_pci_dev(dev));
+	domain_context_clear(iommu, dev);
+	return domain_context_mapping_one(dmar_domain, iommu, bus, devfn);
+}
 #endif /* CONFIG_INTEL_IOMMU_SVM */
 
 static const struct iommu_ops intel_iommu_ops = {
@@ -5314,6 +5413,10 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
 	.domain_free	= intel_iommu_domain_free,
 	.attach_dev	= intel_iommu_attach_device,
 	.detach_dev	= intel_iommu_detach_device,
+#ifdef CONFIG_INTEL_IOMMU_SVM
+	.bind_pasid_table	= intel_iommu_bind_pasid_table,
+	.unbind_pasid_table	= intel_iommu_unbind_pasid_table,
+#endif
 	.map		= intel_iommu_map,
 	.unmap		= intel_iommu_unmap,
 	.map_sg		= default_iommu_map_sg,
diff --git a/include/linux/dma_remapping.h b/include/linux/dma_remapping.h
index 187c102..c03b62a 100644
--- a/include/linux/dma_remapping.h
+++ b/include/linux/dma_remapping.h
@@ -27,6 +27,7 @@
 
 #define CONTEXT_DINVE		(1ULL << 8)
 #define CONTEXT_PRS		(1ULL << 9)
+#define CONTEXT_NESTE		(1ULL << 10)
 #define CONTEXT_PASIDE		(1ULL << 11)
 
 struct intel_iommu;
-- 
1.9.1
