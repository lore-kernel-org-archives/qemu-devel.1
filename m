Received: from eggs.gnu.org ([209.51.188.92]:40511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hIqgz-0004tA-CI
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hIqTf-0005xB-G8
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:08:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18409)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hIqTf-0005wW-Ak
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:08:31 -0400
From: Pankaj Gupta <pagupta@redhat.com>
Date: Tue, 23 Apr 2019 13:36:12 +0530
Message-Id: <20190423080612.15361-7-pagupta@redhat.com>
In-Reply-To: <20190423080612.15361-1-pagupta@redhat.com>
References: <20190423080612.15361-1-pagupta@redhat.com>
Subject: [Qemu-devel] [PATCH v6 6/6] xfs: disable map_sync for async flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org, qemu-devel@nongnu.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: dan.j.williams@intel.com, zwisler@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com, jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net, hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com, lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com, jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com, stefanha@redhat.com, aarcange@redhat.com, david@redhat.com, david@fromorbit.com, cohuck@redhat.com, xiaoguangrong.eric@gmail.com, pagupta@redhat.com, pbonzini@redhat.com, yuval.shaia@oracle.com, kilobyte@angband.pl

Dont support 'MAP_SYNC' with non-DAX files and DAX files
with asynchronous dax_device. Virtio pmem provides
asynchronous host page cache flush mechanism. We don't
support 'MAP_SYNC' with virtio pmem and xfs.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 fs/xfs/xfs_file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 1f2e2845eb76..0e59be018511 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1196,11 +1196,13 @@ xfs_file_mmap(
 	struct file	*filp,
 	struct vm_area_struct *vma)
 {
-	/*
-	 * We don't support synchronous mappings for non-DAX files. At least
-	 * until someone comes with a sensible use case.
+	struct dax_device *dax_dev = xfs_find_daxdev_for_inode
+						(file_inode(filp));
+
+	/* We don't support synchronous mappings for non-DAX files and
+	 * for DAX files if underneath dax_device is not synchronous.
 	 */
-	if (!IS_DAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
+	if (!daxdev_mapping_supported(vma, dax_dev))
 		return -EOPNOTSUPP;
 
 	file_accessed(filp);
-- 
2.20.1
