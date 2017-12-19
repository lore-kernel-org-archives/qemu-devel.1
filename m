Received: from eggs.gnu.org ([2001:4830:134:3::10]:40477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eRMO5-0007kA-KV
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 13:13:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eRMO0-0005F9-SR
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 13:13:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1eRMO0-0005EV-Lw
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 13:13:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E59665D5EB
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 18:13:03 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 19 Dec 2017 19:11:29 +0100
Message-Id: <20171219181129.24189-4-maxime.coquelin@redhat.com>
In-Reply-To: <20171219181129.24189-1-maxime.coquelin@redhat.com>
References: <20171219181129.24189-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] vhost-user: no more leak QEMU virtual
 addresses to user backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com
Cc: mlureau@redhat.com, Maxime Coquelin <maxime.coquelin@redhat.com>

The user backends use user address from VHOST_USER_SET_MEM_TABLE
to be able to handle VHOST_USER_SET_VRING_ADDR and
VHOST_USER_IOTLB_MSG payloads.

Now that Vhost code supports the use of Guest physical addresses
instead of QEMU process virtual addresses, let's do the switch
to avoid leaking QEMU process VAs to the user backend.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 hw/virtio/vhost-user.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 5ebeb8401b..e783d88afe 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -317,7 +317,8 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
                                      &offset);
         fd = memory_region_get_fd(mr);
         if (fd > 0) {
-            msg.payload.memory.regions[fd_num].user_addr = reg->userspace_addr;
+            /* Use GPA as user address not to leak QEMU VAs to the backend */
+            msg.payload.memory.regions[fd_num].user_addr = reg->guest_phys_addr;
             msg.payload.memory.regions[fd_num].memory_size  = reg->memory_size;
             msg.payload.memory.regions[fd_num].guest_phys_addr = reg->guest_phys_addr;
             msg.payload.memory.regions[fd_num].mmap_offset = offset;
@@ -924,7 +925,7 @@ static void vhost_user_set_iotlb_callback(struct vhost_dev *dev, int enabled)
 
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
-        .uaddr_type = VHOST_UADDR_TYPE_HVA,
+        .uaddr_type = VHOST_UADDR_TYPE_GPA,
         .vhost_backend_init = vhost_user_init,
         .vhost_backend_cleanup = vhost_user_cleanup,
         .vhost_backend_memslots_limit = vhost_user_memslots_limit,
-- 
2.14.3
