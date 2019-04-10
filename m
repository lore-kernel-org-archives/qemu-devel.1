Received: from eggs.gnu.org ([209.51.188.92]:39925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hE4ga-0004UE-VX
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 00:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hE4ga-0004CL-2v
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 00:18:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hE4gZ-0004Bg-Qo
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 00:18:08 -0400
From: Pankaj Gupta <pagupta@redhat.com>
Date: Wed, 10 Apr 2019 09:38:24 +0530
Message-Id: <20190410040826.24371-5-pagupta@redhat.com>
In-Reply-To: <20190410040826.24371-1-pagupta@redhat.com>
References: <20190410040826.24371-1-pagupta@redhat.com>
Subject: [Qemu-devel] [PATCH v5 4/6] dax: check synchronous mapping is
 supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org, qemu-devel@nongnu.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: dan.j.williams@intel.com, zwisler@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com, jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net, hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com, lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com, jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com, stefanha@redhat.com, aarcange@redhat.com, david@redhat.com, david@fromorbit.com, cohuck@redhat.com, xiaoguangrong.eric@gmail.com, pbonzini@redhat.com, kilobyte@angband.pl, yuval.shaia@oracle.com, pagupta@redhat.com

This patch introduces 'daxdev_mapping_supported' helper
which checks if 'MAP_SYNC' is supported with filesystem
mapping. It also checks if corresponding dax_device is
synchronous. Virtio pmem device is asynchronous and
does not not support VM_SYNC. 

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 include/linux/dax.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/dax.h b/include/linux/dax.h
index b896706a5ee9..4a2a60ffec86 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -38,6 +38,24 @@ void kill_dax(struct dax_device *dax_dev);
 void dax_write_cache(struct dax_device *dax_dev, bool wc);
 bool dax_write_cache_enabled(struct dax_device *dax_dev);
 bool dax_synchronous(struct dax_device *dax_dev);
+
+/*
+ * Callers check if synchronous mapping is enabled for DAX file
+ * and attached dax device is also synchronous.
+ *
+ * dax_synchronous function verifies if dax device is synchronous.
+ * Currently, only virtio pmem device supports asynchronous device
+ * flush.
+ */
+static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
+				struct dax_device *dax_dev)
+{
+	if (!(vma->vm_flags & VM_SYNC))
+		return true;
+	if (!IS_DAX(file_inode(vma->vm_file)))
+		return false;
+	return dax_synchronous(dax_dev);
+}
 #else
 static inline struct dax_device *dax_get_by_host(const char *host)
 {
@@ -69,6 +87,11 @@ static inline bool dax_synchronous(struct dax_device *dax_dev)
 {
 	return true;
 }
+static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
+				struct dax_device *dax_dev)
+{
+	return true;
+}
 #endif
 
 struct writeback_control;
-- 
2.20.1
