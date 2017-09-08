Received: from eggs.gnu.org ([2001:4830:134:3::10]:50058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqKAa-0000kO-Hr
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqKAW-0006ye-9S
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:22:08 -0400
Date: Fri, 8 Sep 2017 17:21:59 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1504880304-12069-2-git-send-email-mst@redhat.com>
References: <1504880304-12069-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504880304-12069-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 01/17] vhost: Release memory references on
 cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org

From: Alex Williamson <alex.williamson@redhat.com>

vhost registers a MemoryListener where it adds and removes references
to MemoryRegions as the MemoryRegionSections pass through.  The
region_add callback is invoked for each existing section when the
MemoryListener is registered, but unregistering the MemoryListener
performs no reciprocal region_del callback.  It's therefore the
owner of the MemoryListener's responsibility to cleanup any persistent
changes, such as these memory references, after unregistering.

The consequence of this bug is that if we have both a vhost device
and a vfio device, the vhost device will reference any mmap'd MMIO of
the vfio device via this MemoryListener.  If the vhost device is then
removed, those references remain outstanding.  If we then attempt to
remove the vfio device, it never gets finalized and the only way to
release the kernel file descriptors is to terminate the QEMU process.

Fixes: dfde4e6e1a86 ("memory: add ref/unref calls")
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-stable@nongnu.org # v1.6.0+
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 0049a2c..5fd69f0 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1356,6 +1356,10 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     if (hdev->mem) {
         /* those are only safe after successful init */
         memory_listener_unregister(&hdev->memory_listener);
+        for (i = 0; i < hdev->n_mem_sections; ++i) {
+            MemoryRegionSection *section = &hdev->mem_sections[i];
+            memory_region_unref(section->mr);
+        }
         QLIST_REMOVE(hdev, entry);
     }
     if (hdev->migration_blocker) {
-- 
MST
