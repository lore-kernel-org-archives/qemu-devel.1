Received: from eggs.gnu.org ([2001:4830:134:3::10]:59636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dKmQT-0001hA-2I
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dKmQQ-0005JK-Mf
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:09 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:6801 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dKmQQ-0005HA-Be
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:06 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 13 Jun 2017 17:03:40 +0300
Message-Id: <20170613140358.81651-13-vsementsov@virtuozzo.com>
In-Reply-To: <20170613140358.81651-1-vsementsov@virtuozzo.com>
References: <20170613140358.81651-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v21 12/30] block: refactor bdrv_reopen_commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

Add bs local variable to simplify code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index 50ba264143..04af7697dc 100644
--- a/block.c
+++ b/block.c
@@ -2945,9 +2945,11 @@ error:
 void bdrv_reopen_commit(BDRVReopenState *reopen_state)
 {
     BlockDriver *drv;
+    BlockDriverState *bs;
 
     assert(reopen_state != NULL);
-    drv = reopen_state->bs->drv;
+    bs = reopen_state->bs;
+    drv = bs->drv;
     assert(drv != NULL);
 
     /* If there are any driver level actions to take */
@@ -2956,13 +2958,13 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
     }
 
     /* set BDS specific flags now */
-    QDECREF(reopen_state->bs->explicit_options);
+    QDECREF(bs->explicit_options);
 
-    reopen_state->bs->explicit_options   = reopen_state->explicit_options;
-    reopen_state->bs->open_flags         = reopen_state->flags;
-    reopen_state->bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
+    bs->explicit_options   = reopen_state->explicit_options;
+    bs->open_flags         = reopen_state->flags;
+    bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
 
-    bdrv_refresh_limits(reopen_state->bs, NULL);
+    bdrv_refresh_limits(bs, NULL);
 }
 
 /*
-- 
2.11.1
