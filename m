Received: from eggs.gnu.org ([2001:4830:134:3::10]:59968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMD-0001U9-SY
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMC-0007nu-Of
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:53 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:34 +0200
Message-Id: <1498234919-27316-37-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 36/61] qed: Remove GenericCB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

The GenericCB infrastructure isn't used any more. Remove it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/Makefile.objs |  2 +-
 block/qed-gencb.c   | 33 ---------------------------------
 block/qed.h         | 11 -----------
 3 files changed, 1 insertion(+), 45 deletions(-)
 delete mode 100644 block/qed-gencb.c

diff --git a/block/Makefile.objs b/block/Makefile.objs
index ea95530..f9368b5 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -1,6 +1,6 @@
 block-obj-y += raw-format.o qcow.o vdi.o vmdk.o cloop.o bochs.o vpc.o vvfat.o dmg.o
 block-obj-y += qcow2.o qcow2-refcount.o qcow2-cluster.o qcow2-snapshot.o qcow2-cache.o
-block-obj-y += qed.o qed-gencb.o qed-l2-cache.o qed-table.o qed-cluster.o
+block-obj-y += qed.o qed-l2-cache.o qed-table.o qed-cluster.o
 block-obj-y += qed-check.o
 block-obj-y += vhdx.o vhdx-endian.o vhdx-log.o
 block-obj-y += quorum.o
diff --git a/block/qed-gencb.c b/block/qed-gencb.c
deleted file mode 100644
index faf8ecc..0000000
--- a/block/qed-gencb.c
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * QEMU Enhanced Disk Format
- *
- * Copyright IBM, Corp. 2010
- *
- * Authors:
- *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include "qed.h"
-
-void *gencb_alloc(size_t len, BlockCompletionFunc *cb, void *opaque)
-{
-    GenericCB *gencb = g_malloc(len);
-    gencb->cb = cb;
-    gencb->opaque = opaque;
-    return gencb;
-}
-
-void gencb_complete(void *opaque, int ret)
-{
-    GenericCB *gencb = opaque;
-    BlockCompletionFunc *cb = gencb->cb;
-    void *user_opaque = gencb->opaque;
-
-    g_free(gencb);
-    cb(user_opaque, ret);
-}
diff --git a/block/qed.h b/block/qed.h
index 6ab5702..46843c4 100644
--- a/block/qed.h
+++ b/block/qed.h
@@ -202,17 +202,6 @@ void qed_acquire(BDRVQEDState *s);
 void qed_release(BDRVQEDState *s);
 
 /**
- * Generic callback for chaining async callbacks
- */
-typedef struct {
-    BlockCompletionFunc *cb;
-    void *opaque;
-} GenericCB;
-
-void *gencb_alloc(size_t len, BlockCompletionFunc *cb, void *opaque);
-void gencb_complete(void *opaque, int ret);
-
-/**
  * Header functions
  */
 int qed_write_header_sync(BDRVQEDState *s);
-- 
1.8.3.1
