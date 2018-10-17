Received: from eggs.gnu.org ([2001:4830:134:3::10]:52844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCmuJ-0000DA-6B
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCmuG-0006HU-QW
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:34:43 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 17 Oct 2018 17:33:50 +0300
Message-Id: <e0ba08677155b2cf3820b580fb5057458ed017d0.1539786605.git.berto@igalia.com>
In-Reply-To: <cover.1539786605.git.berto@igalia.com>
References: <cover.1539786605.git.berto@igalia.com>
In-Reply-To: <cover.1539786605.git.berto@igalia.com>
References: <cover.1539786605.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 2/3] quorum: Return an error if the blkverify
 mode has invalid settings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The blkverify mode of Quorum can only be enabled if the number of
children is exactly two and the value of vote-threshold is also two.

If the user tries to enable it but the other settings are incorrect
then QEMU simply prints an error message to stderr and carries on
disabling the blkverify setting.

This patch makes quorum_open() fail and return an error in this case.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reported-by: Markus Armbruster <armbru@redhat.com>
---
 block/quorum.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index b1b777baef..6188ff6666 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -912,13 +912,12 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
     s->read_pattern = ret;
 
     if (s->read_pattern == QUORUM_READ_PATTERN_QUORUM) {
-        /* is the driver in blkverify mode */
-        if (qemu_opt_get_bool(opts, QUORUM_OPT_BLKVERIFY, false) &&
-            s->num_children == 2 && s->threshold == 2) {
-            s->is_blkverify = true;
-        } else if (qemu_opt_get_bool(opts, QUORUM_OPT_BLKVERIFY, false)) {
-            fprintf(stderr, "blkverify mode is set by setting blkverify=on "
-                    "and using two files with vote_threshold=2\n");
+        s->is_blkverify = qemu_opt_get_bool(opts, QUORUM_OPT_BLKVERIFY, false);
+        if (s->is_blkverify && (s->num_children != 2 || s->threshold != 2)) {
+            error_setg(&local_err, "blkverify=on can only be set if there are "
+                       "exactly two files and vote-threshold is 2");
+            ret = -EINVAL;
+            goto exit;
         }
 
         s->rewrite_corrupted = qemu_opt_get_bool(opts, QUORUM_OPT_REWRITE,
-- 
2.11.0
