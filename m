Received: from eggs.gnu.org ([2001:4830:134:3::10]:60112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ftvl9-00082p-HB
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 10:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ftvl6-0006zQ-Dd
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 10:11:19 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Sun, 26 Aug 2018 17:09:38 +0300
Message-Id: <e4b359c3971bb95e1e3cc55e0f69e68404f33f17.1535291602.git.berto@igalia.com>
In-Reply-To: <cover.1535291602.git.berto@igalia.com>
References: <cover.1535291602.git.berto@igalia.com>
In-Reply-To: <cover.1535291602.git.berto@igalia.com>
References: <cover.1535291602.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 7/9] block: Allow changing 'discard' on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

'discard' is one of the basic BlockdevOptions available for all
drivers, but it's silently ignored by bdrv_reopen_prepare/commit(), so
the user cannot change it and doesn't get an error explaining that it
can't be changed.

This should update the discard setting, but does nothing:

   (qemu) qemu-io virtio0 "reopen -o discard=on"

Since there's no reason why we shouldn't allow changing it and the
implementation is simple let's just do it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block.c b/block.c
index 804d557608..21f1eb9cd1 100644
--- a/block.c
+++ b/block.c
@@ -3178,6 +3178,15 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
 
     update_flags_from_options(&reopen_state->flags, opts);
 
+    value = qemu_opt_get(opts, "discard");
+    if (value != NULL) {
+        if (bdrv_parse_discard_flags(value, &reopen_state->flags) != 0) {
+            error_setg(errp, "Invalid discard option");
+            ret = -EINVAL;
+            goto error;
+        }
+    }
+
     /* node-name and driver must be unchanged. Put them back into the QDict, so
      * that they are checked at the end of this function. */
     value = qemu_opt_get(opts, "node-name");
-- 
2.11.0
