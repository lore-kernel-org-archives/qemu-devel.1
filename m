Received: from eggs.gnu.org ([2001:4830:134:3::10]:59098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKLh-0002v8-Be
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:23:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKLf-0005u8-Sv
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:23:37 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:30 +0100
Message-Id: <1487006583-24350-9-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 08/41] block: Request child permissions in
 filter drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

All callers will have to request permissions for all of their child
nodes. Block drivers that act as simply filters can use the default
implementation of .bdrv_child_perm().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/blkdebug.c    | 2 ++
 block/blkreplay.c   | 1 +
 block/blkverify.c   | 1 +
 block/quorum.c      | 2 ++
 block/raw-format.c  | 1 +
 block/replication.c | 1 +
 6 files changed, 8 insertions(+)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index acccf85..39301d8 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -741,6 +741,8 @@ static BlockDriver bdrv_blkdebug = {
     .bdrv_file_open         = blkdebug_open,
     .bdrv_close             = blkdebug_close,
     .bdrv_reopen_prepare    = blkdebug_reopen_prepare,
+    .bdrv_child_perm        = bdrv_filter_default_perms,
+
     .bdrv_getlength         = blkdebug_getlength,
     .bdrv_truncate          = blkdebug_truncate,
     .bdrv_refresh_filename  = blkdebug_refresh_filename,
diff --git a/block/blkreplay.c b/block/blkreplay.c
index a741654..c4e07f0 100755
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -137,6 +137,7 @@ static BlockDriver bdrv_blkreplay = {
 
     .bdrv_file_open         = blkreplay_open,
     .bdrv_close             = blkreplay_close,
+    .bdrv_child_perm        = bdrv_filter_default_perms,
     .bdrv_getlength         = blkreplay_getlength,
 
     .bdrv_co_preadv         = blkreplay_co_preadv,
diff --git a/block/blkverify.c b/block/blkverify.c
index 43a940c..9a1e21c 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -320,6 +320,7 @@ static BlockDriver bdrv_blkverify = {
     .bdrv_parse_filename              = blkverify_parse_filename,
     .bdrv_file_open                   = blkverify_open,
     .bdrv_close                       = blkverify_close,
+    .bdrv_child_perm                  = bdrv_filter_default_perms,
     .bdrv_getlength                   = blkverify_getlength,
     .bdrv_refresh_filename            = blkverify_refresh_filename,
 
diff --git a/block/quorum.c b/block/quorum.c
index 45bf010..b6d8215 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1132,6 +1132,8 @@ static BlockDriver bdrv_quorum = {
     .bdrv_add_child                     = quorum_add_child,
     .bdrv_del_child                     = quorum_del_child,
 
+    .bdrv_child_perm                    = bdrv_filter_default_perms,
+
     .is_filter                          = true,
     .bdrv_recurse_is_first_non_filter   = quorum_recurse_is_first_non_filter,
 };
diff --git a/block/raw-format.c b/block/raw-format.c
index 30caaa5..bbcfcbf 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -467,6 +467,7 @@ BlockDriver bdrv_raw = {
     .bdrv_reopen_abort    = &raw_reopen_abort,
     .bdrv_open            = &raw_open,
     .bdrv_close           = &raw_close,
+    .bdrv_child_perm      = bdrv_filter_default_perms,
     .bdrv_create          = &raw_create,
     .bdrv_co_preadv       = &raw_co_preadv,
     .bdrv_co_pwritev      = &raw_co_pwritev,
diff --git a/block/replication.c b/block/replication.c
index eff85c7..91465cb 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -660,6 +660,7 @@ BlockDriver bdrv_replication = {
 
     .bdrv_open                  = replication_open,
     .bdrv_close                 = replication_close,
+    .bdrv_child_perm            = bdrv_filter_default_perms,
 
     .bdrv_getlength             = replication_getlength,
     .bdrv_co_readv              = replication_co_readv,
-- 
1.8.3.1
