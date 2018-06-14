Received: from eggs.gnu.org ([2001:4830:134:3::10]:53128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fTUVM-0000jB-Vl
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fTUVI-0003mx-0F
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:49:44 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 14 Jun 2018 18:49:01 +0300
Message-Id: <5800c9ccc0a6ce2e58d25b127e75cac282458a11.1528991017.git.berto@igalia.com>
In-Reply-To: <cover.1528991017.git.berto@igalia.com>
References: <cover.1528991017.git.berto@igalia.com>
In-Reply-To: <cover.1528991017.git.berto@igalia.com>
References: <cover.1528991017.git.berto@igalia.com>
Subject: [Qemu-devel] [RFC PATCH 04/10] block: Allow changing 'force-share'
 on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>

'force-share' is one of the basic BlockdevOptions available for all
drivers, but it's silently ignored by bdrv_reopen_prepare/commit(), so
the user cannot change it and doesn't get an error explaining that it
can't be changed.

Since there's no reason why we shouldn't allow changing it and the
implementation is trivial, let's just do it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c               | 11 +++++++++++
 include/block/block.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/block.c b/block.c
index 4c186e54b6..a741300fae 100644
--- a/block.c
+++ b/block.c
@@ -3169,6 +3169,16 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
         }
     }
 
+    reopen_state->force_share = qemu_opt_get_bool(opts, BDRV_OPT_FORCE_SHARE,
+                                                  false);
+    if (reopen_state->force_share && (reopen_state->flags & BDRV_O_RDWR)) {
+        error_setg(errp,
+                   BDRV_OPT_FORCE_SHARE
+                   "=on can only be used with read-only images");
+        ret = -EINVAL;
+        goto error;
+    }
+
     /* node-name and driver must be unchanged. Put them back into the QDict, so
      * that they are checked at the end of this function. */
     value = qemu_opt_get(opts, "node-name");
@@ -3300,6 +3310,7 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
     bs->open_flags         = reopen_state->flags;
     bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
     bs->detect_zeroes      = reopen_state->detect_zeroes;
+    bs->force_share        = reopen_state->force_share;
 
     bdrv_refresh_limits(bs, NULL);
 
diff --git a/include/block/block.h b/include/block/block.h
index 1e78587331..9306c986ef 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -160,6 +160,7 @@ typedef struct BDRVReopenState {
     BlockDriverState *bs;
     int flags;
     BlockdevDetectZeroesOptions detect_zeroes;
+    bool force_share;
     uint64_t perm, shared_perm;
     QDict *options;
     QDict *explicit_options;
-- 
2.11.0
