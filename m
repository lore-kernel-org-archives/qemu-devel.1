Received: from eggs.gnu.org ([2001:4830:134:3::10]:56935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fvjaa-0005g5-Pk
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fvjVs-00069Q-U7
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:31:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34398 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fvjVs-00069H-P1
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:31:00 -0400
From: Pankaj Gupta <pagupta@redhat.com>
Date: Fri, 31 Aug 2018 19:00:17 +0530
Message-Id: <20180831133019.27579-3-pagupta@redhat.com>
In-Reply-To: <20180831133019.27579-1-pagupta@redhat.com>
References: <20180831133019.27579-1-pagupta@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] libnvdimm: nd_region flush callback support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org
Cc: jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com, riel@surriel.com, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, ross.zwisler@intel.com, david@redhat.com, xiaoguangrong.eric@gmail.com, hch@infradead.org, mst@redhat.com, niteshnarayanlal@hotmail.com, lcapitulino@redhat.com, imammedo@redhat.com, eblake@redhat.com, pagupta@redhat.com

This patch adds functionality to perform flush from guest
to host over VIRTIO. We are registering a callback based
on 'nd_region' type. virtio_pmem driver requires this special 
flush function. For rest of the region types we are registering 
existing flush function. Report error returned by host fsync 
failure to userspace.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 drivers/acpi/nfit/core.c     |  7 +++++--
 drivers/nvdimm/claim.c       |  3 ++-
 drivers/nvdimm/pmem.c        | 12 ++++++++----
 drivers/nvdimm/region_devs.c | 12 ++++++++++--
 include/linux/libnvdimm.h    |  4 +++-
 5 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index b072cfc..cd63b69 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2216,6 +2216,7 @@ static void write_blk_ctl(struct nfit_blk *nfit_blk, unsigned int bw,
 {
 	u64 cmd, offset;
 	struct nfit_blk_mmio *mmio = &nfit_blk->mmio[DCR];
+	struct nd_region *nd_region = nfit_blk->nd_region;
 
 	enum {
 		BCW_OFFSET_MASK = (1ULL << 48)-1,
@@ -2234,7 +2235,7 @@ static void write_blk_ctl(struct nfit_blk *nfit_blk, unsigned int bw,
 		offset = to_interleave_offset(offset, mmio);
 
 	writeq(cmd, mmio->addr.base + offset);
-	nvdimm_flush(nfit_blk->nd_region);
+	nd_region->flush(nd_region);
 
 	if (nfit_blk->dimm_flags & NFIT_BLK_DCR_LATCH)
 		readq(mmio->addr.base + offset);
@@ -2245,6 +2246,7 @@ static int acpi_nfit_blk_single_io(struct nfit_blk *nfit_blk,
 		unsigned int lane)
 {
 	struct nfit_blk_mmio *mmio = &nfit_blk->mmio[BDW];
+	struct nd_region *nd_region = nfit_blk->nd_region;
 	unsigned int copied = 0;
 	u64 base_offset;
 	int rc;
@@ -2283,7 +2285,8 @@ static int acpi_nfit_blk_single_io(struct nfit_blk *nfit_blk,
 	}
 
 	if (rw)
-		nvdimm_flush(nfit_blk->nd_region);
+		nd_region->flush(nd_region);
+
 
 	rc = read_blk_stat(nfit_blk, lane) ? -EIO : 0;
 	return rc;
diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index fb667bf..49dce9c 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -262,6 +262,7 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
 {
 	struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
 	unsigned int sz_align = ALIGN(size + (offset & (512 - 1)), 512);
+	struct nd_region *nd_region = to_nd_region(ndns->dev.parent);
 	sector_t sector = offset >> 9;
 	int rc = 0;
 
@@ -301,7 +302,7 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
 	}
 
 	memcpy_flushcache(nsio->addr + offset, buf, size);
-	nvdimm_flush(to_nd_region(ndns->dev.parent));
+	nd_region->flush(nd_region);
 
 	return rc;
 }
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 6071e29..ba57cfa 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -201,7 +201,8 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
 	struct nd_region *nd_region = to_region(pmem);
 
 	if (bio->bi_opf & REQ_PREFLUSH)
-		nvdimm_flush(nd_region);
+		bio->bi_status = nd_region->flush(nd_region);
+
 
 	do_acct = nd_iostat_start(bio, &start);
 	bio_for_each_segment(bvec, bio, iter) {
@@ -216,7 +217,7 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
 		nd_iostat_end(bio, start);
 
 	if (bio->bi_opf & REQ_FUA)
-		nvdimm_flush(nd_region);
+		bio->bi_status = nd_region->flush(nd_region);
 
 	bio_endio(bio);
 	return BLK_QC_T_NONE;
@@ -517,6 +518,7 @@ static int nd_pmem_probe(struct device *dev)
 static int nd_pmem_remove(struct device *dev)
 {
 	struct pmem_device *pmem = dev_get_drvdata(dev);
+	struct nd_region *nd_region = to_region(pmem);
 
 	if (is_nd_btt(dev))
 		nvdimm_namespace_detach_btt(to_nd_btt(dev));
@@ -528,14 +530,16 @@ static int nd_pmem_remove(struct device *dev)
 		sysfs_put(pmem->bb_state);
 		pmem->bb_state = NULL;
 	}
-	nvdimm_flush(to_nd_region(dev->parent));
+	nd_region->flush(nd_region);
 
 	return 0;
 }
 
 static void nd_pmem_shutdown(struct device *dev)
 {
-	nvdimm_flush(to_nd_region(dev->parent));
+	struct nd_region *nd_region = to_nd_region(dev->parent);
+
+	nd_region->flush(nd_region);
 }
 
 static void nd_pmem_notify(struct device *dev, enum nvdimm_event event)
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index fa37afc..a170a6b 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -290,7 +290,7 @@ static ssize_t deep_flush_store(struct device *dev, struct device_attribute *att
 		return rc;
 	if (!flush)
 		return -EINVAL;
-	nvdimm_flush(nd_region);
+	nd_region->flush(nd_region);
 
 	return len;
 }
@@ -1065,6 +1065,11 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 	dev->of_node = ndr_desc->of_node;
 	nd_region->ndr_size = resource_size(ndr_desc->res);
 	nd_region->ndr_start = ndr_desc->res->start;
+	if (ndr_desc->flush)
+		nd_region->flush = ndr_desc->flush;
+	else
+		nd_region->flush = nvdimm_flush;
+
 	nd_device_register(dev);
 
 	return nd_region;
@@ -1109,7 +1114,7 @@ EXPORT_SYMBOL_GPL(nvdimm_volatile_region_create);
  * nvdimm_flush - flush any posted write queues between the cpu and pmem media
  * @nd_region: blk or interleaved pmem region
  */
-void nvdimm_flush(struct nd_region *nd_region)
+int nvdimm_flush(struct nd_region *nd_region)
 {
 	struct nd_region_data *ndrd = dev_get_drvdata(&nd_region->dev);
 	int i, idx;
@@ -1133,7 +1138,10 @@ void nvdimm_flush(struct nd_region *nd_region)
 		if (ndrd_get_flush_wpq(ndrd, i, 0))
 			writeq(1, ndrd_get_flush_wpq(ndrd, i, idx));
 	wmb();
+
+	return 0;
 }
+
 EXPORT_SYMBOL_GPL(nvdimm_flush);
 
 /**
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index 097072c..3af7177 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -115,6 +115,7 @@ struct nd_mapping_desc {
 	int position;
 };
 
+struct nd_region;
 struct nd_region_desc {
 	struct resource *res;
 	struct nd_mapping_desc *mapping;
@@ -126,6 +127,7 @@ struct nd_region_desc {
 	int numa_node;
 	unsigned long flags;
 	struct device_node *of_node;
+	int (*flush)(struct nd_region *nd_region);
 };
 
 struct device;
@@ -201,7 +203,7 @@ unsigned long nd_blk_memremap_flags(struct nd_blk_region *ndbr);
 unsigned int nd_region_acquire_lane(struct nd_region *nd_region);
 void nd_region_release_lane(struct nd_region *nd_region, unsigned int lane);
 u64 nd_fletcher64(void *addr, size_t len, bool le);
-void nvdimm_flush(struct nd_region *nd_region);
+int nvdimm_flush(struct nd_region *nd_region);
 int nvdimm_has_flush(struct nd_region *nd_region);
 int nvdimm_has_cache(struct nd_region *nd_region);
 
-- 
2.9.3
