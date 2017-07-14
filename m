Received: from eggs.gnu.org ([2001:4830:134:3::10]:53541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dW1hb-0003zk-9d
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dW1hY-0003Q1-Ck
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:36:19 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:16577)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dW1hY-0003PI-1c
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:36:16 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 14 Jul 2017 17:35:47 +0300
Message-Id: <20170714143548.32559-2-el13635@mail.ntua.gr>
In-Reply-To: <20170714143548.32559-1-el13635@mail.ntua.gr>
References: <20170714143548.32559-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v3 1/2] block: fix dangling
 bs->explicit_options in block.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

In some error paths it is possible to QDECREF a freed dangling
explicit_options, resulting in a heap overflow crash.  For example
bdrv_open_inherit()'s fail unrefs it, then calls bdrv_unref which calls
bdrv_close which also unrefs it.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block.c b/block.c
index 98a9209371..96b912d229 100644
--- a/block.c
+++ b/block.c
@@ -2608,6 +2608,7 @@ fail:
     QDECREF(bs->options);
     QDECREF(options);
     bs->options = NULL;
+    bs->explicit_options = NULL;
     bdrv_unref(bs);
     error_propagate(errp, local_err);
     return NULL;
@@ -3087,6 +3088,7 @@ static void bdrv_close(BlockDriverState *bs)
         QDECREF(bs->options);
         QDECREF(bs->explicit_options);
         bs->options = NULL;
+        bs->explicit_options = NULL;
         QDECREF(bs->full_open_options);
         bs->full_open_options = NULL;
     }
-- 
2.11.0
