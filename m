Received: from eggs.gnu.org ([2001:4830:134:3::10]:52259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLj-0004jR-Ku
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLf-0001Nh-DY
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 15 Aug 2018 14:55:35 +0200
Message-Id: <20180815125537.10651-20-kwolf@redhat.com>
In-Reply-To: <20180815125537.10651-1-kwolf@redhat.com>
References: <20180815125537.10651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 19/21] block: Update bs->options if
 bdrv_reopen() succeeds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

If bdrv_reopen() succeeds then bs->explicit_options is updated with
the new values, but bs->options never changes.

Here's an example:

   { "execute": "blockdev-add",
     "arguments": {
       "driver": "qcow2",
       "node-name": "hd0",
       "overlap-check": "all",
       "file": {
         "driver": "file",
         "filename": "hd0.qcow2"
       }
     }
   }

After this, both bs->options and bs->explicit_options contain
"overlap-check": "all".

Now let's change that using qemu-io's reopen command:

   (qemu) qemu-io hd0 "reopen -o overlap-check=none"

After this, bs->explicit_options contains the new value but
bs->options still keeps the old one.

This patch updates bs->options after a BDS has been successfully
reopened.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index e82cfa6fe2..8c95f9893a 100644
--- a/block.c
+++ b/block.c
@@ -3055,8 +3055,8 @@ cleanup:
                 bdrv_reopen_abort(&bs_entry->state);
             }
             qobject_unref(bs_entry->state.explicit_options);
+            qobject_unref(bs_entry->state.options);
         }
-        qobject_unref(bs_entry->state.options);
         g_free(bs_entry);
     }
     g_free(bs_queue);
@@ -3156,6 +3156,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
     Error *local_err = NULL;
     BlockDriver *drv;
     QemuOpts *opts;
+    QDict *orig_reopen_opts;
     const char *value;
     bool read_only;
 
@@ -3163,6 +3164,11 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
     assert(reopen_state->bs->drv != NULL);
     drv = reopen_state->bs->drv;
 
+    /* This function and each driver's bdrv_reopen_prepare() remove
+     * entries from reopen_state->options as they are processed, so
+     * we need to make a copy of the original QDict. */
+    orig_reopen_opts = qdict_clone_shallow(reopen_state->options);
+
     /* Process generic block layer options */
     opts = qemu_opts_create(&bdrv_runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, reopen_state->options, &local_err);
@@ -3269,8 +3275,13 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
 
     ret = 0;
 
+    /* Restore the original reopen_state->options QDict */
+    qobject_unref(reopen_state->options);
+    reopen_state->options = qobject_ref(orig_reopen_opts);
+
 error:
     qemu_opts_del(opts);
+    qobject_unref(orig_reopen_opts);
     return ret;
 }
 
@@ -3300,8 +3311,10 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
 
     /* set BDS specific flags now */
     qobject_unref(bs->explicit_options);
+    qobject_unref(bs->options);
 
     bs->explicit_options   = reopen_state->explicit_options;
+    bs->options            = reopen_state->options;
     bs->open_flags         = reopen_state->flags;
     bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
 
-- 
2.13.6
