Received: from eggs.gnu.org ([2001:4830:134:3::10]:56935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fvjad-0005g5-2h
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fvjVf-0005wS-O4
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:30:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48468 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fvjVf-0005wK-JU
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:30:47 -0400
From: Pankaj Gupta <pagupta@redhat.com>
Date: Fri, 31 Aug 2018 19:00:16 +0530
Message-Id: <20180831133019.27579-2-pagupta@redhat.com>
In-Reply-To: <20180831133019.27579-1-pagupta@redhat.com>
References: <20180831133019.27579-1-pagupta@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] nd: move nd_region to common header
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

This patch moves nd_region definition to common header
include/linux/nd.h file. This is required for flush callback 
support for both virtio-pmem & pmem driver.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 drivers/nvdimm/nd.h | 39 ---------------------------------------
 include/linux/nd.h  | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 98317e7..d079a2b 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -123,45 +123,6 @@ enum nd_mapping_lock_class {
 	ND_MAPPING_UUID_SCAN,
 };
 
-struct nd_mapping {
-	struct nvdimm *nvdimm;
-	u64 start;
-	u64 size;
-	int position;
-	struct list_head labels;
-	struct mutex lock;
-	/*
-	 * @ndd is for private use at region enable / disable time for
-	 * get_ndd() + put_ndd(), all other nd_mapping to ndd
-	 * conversions use to_ndd() which respects enabled state of the
-	 * nvdimm.
-	 */
-	struct nvdimm_drvdata *ndd;
-};
-
-struct nd_region {
-	struct device dev;
-	struct ida ns_ida;
-	struct ida btt_ida;
-	struct ida pfn_ida;
-	struct ida dax_ida;
-	unsigned long flags;
-	struct device *ns_seed;
-	struct device *btt_seed;
-	struct device *pfn_seed;
-	struct device *dax_seed;
-	u16 ndr_mappings;
-	u64 ndr_size;
-	u64 ndr_start;
-	int id, num_lanes, ro, numa_node;
-	void *provider_data;
-	struct kernfs_node *bb_state;
-	struct badblocks bb;
-	struct nd_interleave_set *nd_set;
-	struct nd_percpu_lane __percpu *lane;
-	struct nd_mapping mapping[0];
-};
-
 struct nd_blk_region {
 	int (*enable)(struct nvdimm_bus *nvdimm_bus, struct device *dev);
 	int (*do_io)(struct nd_blk_region *ndbr, resource_size_t dpa,
diff --git a/include/linux/nd.h b/include/linux/nd.h
index 43c181a..b9da9f7 100644
--- a/include/linux/nd.h
+++ b/include/linux/nd.h
@@ -120,6 +120,46 @@ struct nd_namespace_blk {
 	struct resource **res;
 };
 
+struct nd_mapping {
+	struct nvdimm *nvdimm;
+	u64 start;
+	u64 size;
+	int position;
+	struct list_head labels;
+	struct mutex lock;
+	/*
+	 * @ndd is for private use at region enable / disable time for
+	 * get_ndd() + put_ndd(), all other nd_mapping to ndd
+	 * conversions use to_ndd() which respects enabled state of the
+	 * nvdimm.
+	 */
+	struct nvdimm_drvdata *ndd;
+};
+
+struct nd_region {
+	struct device dev;
+	struct ida ns_ida;
+	struct ida btt_ida;
+	struct ida pfn_ida;
+	struct ida dax_ida;
+	unsigned long flags;
+	struct device *ns_seed;
+	struct device *btt_seed;
+	struct device *pfn_seed;
+	struct device *dax_seed;
+	u16 ndr_mappings;
+	u64 ndr_size;
+	u64 ndr_start;
+	int id, num_lanes, ro, numa_node;
+	void *provider_data;
+	struct kernfs_node *bb_state;
+	struct badblocks bb;
+	struct nd_interleave_set *nd_set;
+	struct nd_percpu_lane __percpu *lane;
+	int (*flush)(struct nd_region *nd_region);
+	struct nd_mapping mapping[0];
+};
+
 static inline struct nd_namespace_io *to_nd_namespace_io(const struct device *dev)
 {
 	return container_of(dev, struct nd_namespace_io, common.dev);
-- 
2.9.3
