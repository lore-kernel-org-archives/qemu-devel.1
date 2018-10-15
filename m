Received: from eggs.gnu.org ([2001:4830:134:3::10]:39381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1R0-00045c-EU
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1Qu-0001uZ-Tl
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gC1Qu-0001u4-Jj
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:12 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 15 Oct 2018 13:52:37 +0200
Message-Id: <20181015115309.17089-4-armbru@redhat.com>
In-Reply-To: <20181015115309.17089-1-armbru@redhat.com>
References: <20181015115309.17089-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/35] block: Use warn_report() & friends to
 report warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>

Calling error_report() in a function that takes an Error ** argument
is suspicious.  Convert a few that are actually warnings to
warn_report().

While there, split warnings consisting of multiple sentences to
conform to conventions spelled out in warn_report()'s contract, and
improve a rather useless warning in sheepdog.c.

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Lieven <pl@kamp.de>
Cc: Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>
Cc: Liu Yuan <namei.unix@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/bochs.c    |  8 ++++----
 block/cloop.c    |  8 ++++----
 block/dmg.c      |  8 ++++----
 block/iscsi.c    |  2 +-
 block/rbd.c      | 12 ++++++------
 block/sheepdog.c |  2 +-
 block/vvfat.c    |  8 ++++----
 7 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/block/bochs.c b/block/bochs.c
index 50c630047b..36c1b45bd2 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -112,10 +112,10 @@ static int bochs_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     if (!bdrv_is_read_only(bs)) {
-        error_report("Opening bochs images without an explicit read-only=on "
-                     "option is deprecated. Future versions will refuse to "
-                     "open the image instead of automatically marking the "
-                     "image read-only.");
+        warn_report("Opening bochs images without an explicit read-only=on "
+                    "option is deprecated");
+        error_printf("Future versions may refuse to open the image "
+                     "instead of automatically marking it read-only.\n");
         ret = bdrv_set_read_only(bs, true, errp); /* no write support yet */
         if (ret < 0) {
             return ret;
diff --git a/block/cloop.c b/block/cloop.c
index 2be68987bd..a558e67cb0 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -74,10 +74,10 @@ static int cloop_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     if (!bdrv_is_read_only(bs)) {
-        error_report("Opening cloop images without an explicit read-only=on "
-                     "option is deprecated. Future versions will refuse to "
-                     "open the image instead of automatically marking the "
-                     "image read-only.");
+        warn_report("Opening cloop images without an explicit read-only=on "
+                    "option is deprecated");
+        error_printf("Future versions may refuse to open the image "
+                     "instead of automatically marking it read-only.\n");
         ret = bdrv_set_read_only(bs, true, errp);
         if (ret < 0) {
             return ret;
diff --git a/block/dmg.c b/block/dmg.c
index c9b3c519c4..9fb814460d 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -420,10 +420,10 @@ static int dmg_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     if (!bdrv_is_read_only(bs)) {
-        error_report("Opening dmg images without an explicit read-only=on "
-                     "option is deprecated. Future versions will refuse to "
-                     "open the image instead of automatically marking the "
-                     "image read-only.");
+        warn_report("Opening dmg images without an explicit read-only=on "
+                    "option is deprecated");
+        error_printf("Future versions may refuse to open the image "
+                     "instead of automatically marking it read-only.\n");
         ret = bdrv_set_read_only(bs, true, errp);
         if (ret < 0) {
             return ret;
diff --git a/block/iscsi.c b/block/iscsi.c
index bb69faf34a..73998c2860 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1844,7 +1844,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     iscsi_set_timeout(iscsi, timeout);
 #else
     if (timeout) {
-        error_report("iSCSI: ignoring timeout value for libiscsi <1.15.0");
+        warn_report("iSCSI: ignoring timeout value for libiscsi <1.15.0");
     }
 #endif
 
diff --git a/block/rbd.c b/block/rbd.c
index 014c68d629..6e26bac170 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -750,8 +750,8 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         /* Take care whenever deciding to actually deprecate; once this ability
          * is removed, we will not be able to open any images with legacy-styled
          * backing image strings. */
-        error_report("RBD options encoded in the filename as keyvalue pairs "
-                     "is deprecated");
+        warn_report("RBD options encoded in the filename as keyvalue pairs "
+                    "is deprecated");
     }
 
     /* Remove the processed options from the QDict (the visitor processes
@@ -781,10 +781,10 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
      * leave as-is */
     if (s->snap != NULL) {
         if (!bdrv_is_read_only(bs)) {
-            error_report("Opening rbd snapshots without an explicit "
-                         "read-only=on option is deprecated. Future versions "
-                         "will refuse to open the image instead of "
-                         "automatically marking the image read-only.");
+            warn_report("Opening rbd snapshots without an explicit "
+                        "read-only=on option is deprecated");
+            error_printf("Future versions may refuse to open the image "
+                         "instead of automatically marking it read-only.\n");
             r = bdrv_set_read_only(bs, true, &local_err);
             if (r < 0) {
                 error_propagate(errp, local_err);
diff --git a/block/sheepdog.c b/block/sheepdog.c
index b229a664d9..0125df9d49 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -572,7 +572,7 @@ static int connect_to_sdog(BDRVSheepdogState *s, Error **errp)
     if (s->addr->type == SOCKET_ADDRESS_TYPE_INET && fd >= 0) {
         int ret = socket_set_nodelay(fd);
         if (ret < 0) {
-            error_report("%s", strerror(errno));
+            warn_report("can't set TCP_NODELAY: %s", strerror(errno));
         }
     }
 
diff --git a/block/vvfat.c b/block/vvfat.c
index fc41841a5c..8f3f9e9a93 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1263,10 +1263,10 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
             goto fail;
         }
     } else  if (!bdrv_is_read_only(bs)) {
-        error_report("Opening non-rw vvfat images without an explicit "
-                     "read-only=on option is deprecated. Future versions "
-                     "will refuse to open the image instead of "
-                     "automatically marking the image read-only.");
+        warn_report("Opening non-rw vvfat images without an explicit "
+                    "read-only=on option is deprecated");
+        error_printf("Future versions may refuse to open the image "
+                     "instead of automatically marking it read-only.\n");
         /* read only is the default for safety */
         ret = bdrv_set_read_only(bs, true, &local_err);
         if (ret < 0) {
-- 
2.17.1
