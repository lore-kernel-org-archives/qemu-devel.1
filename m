Received: from eggs.gnu.org ([2001:4830:134:3::10]:33245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9nq-0004z9-2N
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9np-00067U-Ap
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:38:54 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  6 Jul 2017 18:38:25 +0200
Message-Id: <20170706163828.24082-9-pbonzini@redhat.com>
In-Reply-To: <20170706163828.24082-1-pbonzini@redhat.com>
References: <20170706163828.24082-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 08/11] block: drain I/O around key management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

The resulting drained section is a replacement for the AioContext.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 blockdev.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index f92dcf24bf..b2c305402d 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2253,7 +2253,6 @@ void qmp_block_passwd(bool has_device, const char *device,
 {
     Error *local_err = NULL;
     BlockDriverState *bs;
-    AioContext *aio_context;
 
     bs = bdrv_lookup_bs(has_device ? device : NULL,
                         has_node_name ? node_name : NULL,
@@ -2263,12 +2262,9 @@ void qmp_block_passwd(bool has_device, const char *device,
         return;
     }
 
-    aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
-
+    bdrv_drained_begin(bs);
     bdrv_add_key(bs, password, errp);
-
-    aio_context_release(aio_context);
+    bdrv_drained_end(bs);
 }
 
 /*
-- 
2.13.0
