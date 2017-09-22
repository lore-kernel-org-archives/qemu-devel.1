Received: from eggs.gnu.org ([2001:4830:134:3::10]:47904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1dvMk1-0000kY-5l
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1dvMjx-0007In-Ow
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:07:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:33111 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1dvMjx-0007I7-Im
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:07:29 -0400
From: Juergen Gross <jgross@suse.com>
Date: Fri, 22 Sep 2017 14:07:25 +0200
Message-Id: <20170922120725.10910-3-jgross@suse.com>
In-Reply-To: <20170922120725.10910-1-jgross@suse.com>
References: <20170922120725.10910-1-jgross@suse.com>
Subject: [Qemu-devel] [PATCH v2 2/2] xen: dont try setting max grants
 multiple times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: anthony.perard@citrix.com, kraxel@redhat.com, sstabellini@kernel.org, Juergen Gross <jgross@suse.com>

Trying to call xengnttab_set_max_grants() with the same file handle
might fail on some kernels, as this operation is allowed only once.

This is a problem for the qdisk backend as blk_connect() can be
called multiple times for a domain, e.g. in case grub-xen is being
used to boot it.

So instead of letting the generic backend code open the gnttab device
do it in blk_connect() and close it again in blk_disconnect.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- always call blk_disconnect() from blk_free() in order to have the
  gnttab device node closed (Anthony Perard)
---
 hw/block/xen_disk.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index 62506e3167..e431bd89e8 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -1220,6 +1220,12 @@ static int blk_connect(struct XenDevice *xendev)
     /* Add on the number needed for the ring pages */
     max_grants += blkdev->nr_ring_ref;
 
+    blkdev->xendev.gnttabdev = xengnttab_open(NULL, 0);
+    if (blkdev->xendev.gnttabdev == NULL) {
+        xen_pv_printf(xendev, 0, "xengnttab_open failed: %s\n",
+                      strerror(errno));
+        return -1;
+    }
     if (xengnttab_set_max_grants(blkdev->xendev.gnttabdev, max_grants)) {
         xen_pv_printf(xendev, 0, "xengnttab_set_max_grants failed: %s\n",
                       strerror(errno));
@@ -1327,6 +1333,11 @@ static void blk_disconnect(struct XenDevice *xendev)
         }
         blkdev->feature_persistent = false;
     }
+
+    if (blkdev->xendev.gnttabdev) {
+        xengnttab_close(blkdev->xendev.gnttabdev);
+        blkdev->xendev.gnttabdev = NULL;
+    }
 }
 
 static int blk_free(struct XenDevice *xendev)
@@ -1334,9 +1345,7 @@ static int blk_free(struct XenDevice *xendev)
     struct XenBlkDev *blkdev = container_of(xendev, struct XenBlkDev, xendev);
     struct ioreq *ioreq;
 
-    if (blkdev->blk || blkdev->sring) {
-        blk_disconnect(xendev);
-    }
+    blk_disconnect(xendev);
 
     while (!QLIST_EMPTY(&blkdev->freelist)) {
         ioreq = QLIST_FIRST(&blkdev->freelist);
@@ -1363,7 +1372,6 @@ static void blk_event(struct XenDevice *xendev)
 
 struct XenDevOps xen_blkdev_ops = {
     .size       = sizeof(struct XenBlkDev),
-    .flags      = DEVOPS_FLAG_NEED_GNTDEV,
     .alloc      = blk_alloc,
     .init       = blk_init,
     .initialise    = blk_connect,
-- 
2.12.3
