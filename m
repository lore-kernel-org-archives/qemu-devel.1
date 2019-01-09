Received: from eggs.gnu.org ([209.51.188.92]:58995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1ghELX-0006dB-Bg
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:56:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1ghELV-0005oP-Sb
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:56:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18831)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1ghELV-0005da-Ka
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:56:37 -0500
From: Pankaj Gupta <pagupta@redhat.com>
Date: Wed,  9 Jan 2019 19:26:06 +0530
Message-Id: <20190109135606.15401-2-pagupta@redhat.com>
In-Reply-To: <20190109135606.15401-1-pagupta@redhat.com>
References: <20190109135606.15401-1-pagupta@redhat.com>
Subject: [Qemu-devel] [PATCH v3 5/5] xfs: disable map_sync for virtio pmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com, riel@surriel.com, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, zwisler@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com, david@redhat.com, jmoyer@redhat.com, xiaoguangrong.eric@gmail.com, hch@infradead.org, mst@redhat.com, jasowang@redhat.com, lcapitulino@redhat.com, imammedo@redhat.com, eblake@redhat.com, willy@infradead.org, tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com, rjw@rjwysocki.net, pagupta@redhat.com

Virtio pmem provides asynchronous host page cache flush
mechanism. we don't support 'MAP_SYNC' with virtio pmem 
and xfs.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 fs/xfs/xfs_file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index e474250..eae4aa4 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1190,6 +1190,14 @@ xfs_file_mmap(
 	if (!IS_DAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
 		return -EOPNOTSUPP;
 
+	/* We don't support synchronous mappings with guest direct access
+	 * and virtio based host page cache mechanism.
+	 */
+	if (IS_DAX(file_inode(filp)) && virtio_pmem_host_cache_enabled(
+		xfs_find_daxdev_for_inode(file_inode(filp))) &&
+					(vma->vm_flags & VM_SYNC))
+		return -EOPNOTSUPP;
+
 	file_accessed(filp);
 	vma->vm_ops = &xfs_file_vm_ops;
 	if (IS_DAX(file_inode(filp)))
-- 
2.9.3
