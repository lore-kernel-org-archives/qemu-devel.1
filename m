Received: from eggs.gnu.org ([2001:4830:134:3::10]:45655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dq3OX-0007r5-G5
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dq3OS-0002y5-Rh
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:27:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dq3OS-0002wU-Kz
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:27:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F26FF6148C
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 20:27:18 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Thu, 07 Sep 2017 14:27:09 -0600
Message-ID: <20170907202637.23121.65136.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] vhost: Release memory references on cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com

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
---
 hw/virtio/vhost.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6eddb099b02f..b737ca915b06 100644
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
