Received: from eggs.gnu.org ([2001:4830:134:3::10]:49172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eK7Rk-0001BW-Or
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eK7Rh-0001X8-O0
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:51:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eK7Rh-0001Wj-HX
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:50:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AB99C01B3F9
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 18:50:56 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 29 Nov 2017 18:50:25 +0000
Message-Id: <20171129185026.23632-7-dgilbert@redhat.com>
In-Reply-To: <20171129185026.23632-1-dgilbert@redhat.com>
References: <20171129185026.23632-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 6/7] vhost: Copy updated region data into device
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, imammedo@redhat.com
Cc: maxime.coquelin@redhat.com, mst@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Copy the temporary region data we calculated into the device state.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/vhost.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index ae3d57df1d..34011f9acb 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -787,7 +787,21 @@ static int vhost_update_mem(struct vhost_dev *dev)
     trace_vhost_update_mem_comparison(need_update,
                                       (uint64_t)change_start,
                                       (uint64_t)change_end);
-    /* TODO */
+    if (need_update) {
+        /* Update the main regions list from our tmp */
+        size_t mem_size = offsetof(struct vhost_memory, regions) +
+            (vtmp.nregions + 1) * sizeof dev->mem->regions[0];
+
+        dev->mem = g_realloc(dev->mem, mem_size);
+        dev->mem->nregions = vtmp.nregions;
+        memcpy(dev->mem->regions, vtmp.regions,
+               vtmp.nregions * sizeof dev->mem->regions[0]);
+        used_memslots = vtmp.nregions;
+
+        dev->mem_changed_start_addr = change_start;
+        dev->mem_changed_end_addr = change_end;
+    }
+
 out:
     g_free(vtmp.regions);
     return res;
-- 
2.14.3
