Received: from eggs.gnu.org ([2001:4830:134:3::10]:42506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBs-0002sI-EH
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBp-0001IG-MN
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBp-0001H0-C1
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:29 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hhKL130951
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:28 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdkvs6th-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:28 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:27 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:21 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-28-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 27/67] block-backend: remove blk_flush_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: John Snow <jsnow@redhat.com>

We can teach Xen to drain and flush each device as it needs to, instead
of trying to flush ALL devices. This removes the last user of
blk_flush_all.

The function is therefore removed under the premise that any new uses
of blk_flush_all would be the wrong paradigm: either flush the single
device that requires flushing, or use an appropriate flush_all mechanism
from outside of the BlkBackend layer.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Acked-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 49137bf6845eaecad51a047fc06dd11c56118460)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/block-backend.c          | 22 ----------------------
 hw/i386/xen/xen_platform.c     |  2 --
 hw/ide/piix.c                  |  4 ++++
 include/sysemu/block-backend.h |  1 -
 4 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index effa038..a67a463 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1624,28 +1624,6 @@ int blk_commit_all(void)
     return 0;
 }
 
-int blk_flush_all(void)
-{
-    BlockBackend *blk = NULL;
-    int result = 0;
-
-    while ((blk = blk_all_next(blk)) != NULL) {
-        AioContext *aio_context = blk_get_aio_context(blk);
-        int ret;
-
-        aio_context_acquire(aio_context);
-        if (blk_is_inserted(blk)) {
-            ret = blk_flush(blk);
-            if (ret < 0 && !result) {
-                result = ret;
-            }
-        }
-        aio_context_release(aio_context);
-    }
-
-    return result;
-}
-
 
 /* throttling disk I/O limits */
 void blk_set_io_limits(BlockBackend *blk, ThrottleConfig *cfg)
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index aa78393..f85635c 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -134,8 +134,6 @@ static void platform_fixed_ioport_writew(void *opaque, uint32_t addr, uint32_t v
            devices, and bit 2 the non-primary-master IDE devices. */
         if (val & UNPLUG_ALL_IDE_DISKS) {
             DPRINTF("unplug disks\n");
-            blk_drain_all();
-            blk_flush_all();
             pci_unplug_disks(pci_dev->bus);
         }
         if (val & UNPLUG_ALL_NICS) {
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index c190fca..d5777fd 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -179,6 +179,10 @@ int pci_piix3_xen_ide_unplug(DeviceState *dev)
         if (di != NULL && !di->media_cd) {
             BlockBackend *blk = blk_by_legacy_dinfo(di);
             DeviceState *ds = blk_get_attached_dev(blk);
+
+            blk_drain(blk);
+            blk_flush(blk);
+
             if (ds) {
                 blk_detach_dev(blk, ds);
             }
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 2da4905..b1ba74f 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -149,7 +149,6 @@ BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void *buf,
 int blk_co_pdiscard(BlockBackend *blk, int64_t offset, int count);
 int blk_co_flush(BlockBackend *blk);
 int blk_flush(BlockBackend *blk);
-int blk_flush_all(void);
 int blk_commit_all(void);
 void blk_drain(BlockBackend *blk);
 void blk_drain_all(void);
-- 
1.9.1
