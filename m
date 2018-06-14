Received: from eggs.gnu.org ([2001:4830:134:3::10]:53136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fTUVN-0000jE-0m
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fTUVH-0003mh-TH
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:49:44 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 14 Jun 2018 18:48:59 +0300
Message-Id: <0b4e9321b9f77e8a031a09ac3cd2fe6b7a19c6d5.1528991017.git.berto@igalia.com>
In-Reply-To: <cover.1528991017.git.berto@igalia.com>
References: <cover.1528991017.git.berto@igalia.com>
In-Reply-To: <cover.1528991017.git.berto@igalia.com>
References: <cover.1528991017.git.berto@igalia.com>
Subject: [Qemu-devel] [RFC PATCH 02/10] block: Allow changing 'discard' on
 reopen
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

'discard' is one of the basic BlockdevOptions available for all
drivers, but it's silently ignored by bdrv_reopen_prepare/commit(), so
the user cannot change it and doesn't get an error explaining that it
can't be changed.

Since there's no reason why we shouldn't allow changing it and the
implementation is trivial, let's just do it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block.c b/block.c
index 50887087f3..e470db7e5e 100644
--- a/block.c
+++ b/block.c
@@ -3139,6 +3139,15 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
 
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
