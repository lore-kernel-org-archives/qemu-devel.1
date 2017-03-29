Received: from eggs.gnu.org ([2001:4830:134:3::10]:47912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctGiw-0004Kt-CY
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctGiv-0006AL-FA
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:45:30 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 29 Mar 2017 18:45:20 +0200
Message-Id: <1490805920-17029-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1490805920-17029-1-git-send-email-armbru@redhat.com>
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [for-2.9 8/8] sheepdog: Fix blockdev-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pbonzini@redhat.com

Commit 831acdc "sheepdog: Implement bdrv_parse_filename()" and commit
d282f34 "sheepdog: Support blockdev-add" have different ideas on how
the QemuOpts parameters for the server address are named.  Fix that.
While there, rename BlockdevOptionsSheepdog member addr to server, for
consistency with BlockdevOptionsSsh, BlockdevOptionsGluster,
BlockdevOptionsNbd.

Commit 831acdc's example becomes

    --drive driver=sheepdog,server.host=fido,vdi=dolly

instead of

    --drive driver=sheepdog,host=fido,vdi=dolly

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/sheepdog.c     | 18 +++++++++---------
 qapi/block-core.json |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 89e98ed..60b9651 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1175,14 +1175,14 @@ static void sd_parse_filename(const char *filename, QDict *options,
     }
 
     if (cfg.host) {
-        qdict_set_default_str(options, "host", cfg.host);
+        qdict_set_default_str(options, "server.host", cfg.host);
     }
     if (cfg.port) {
         snprintf(buf, sizeof(buf), "%d", cfg.port);
-        qdict_set_default_str(options, "port", buf);
+        qdict_set_default_str(options, "server.port", buf);
     }
     if (cfg.path) {
-        qdict_set_default_str(options, "path", cfg.path);
+        qdict_set_default_str(options, "server.path", cfg.path);
     }
     qdict_set_default_str(options, "vdi", cfg.vdi);
     qdict_set_default_str(options, "tag", cfg.tag);
@@ -1510,15 +1510,15 @@ static QemuOptsList runtime_opts = {
     .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
     .desc = {
         {
-            .name = "host",
+            .name = "server.host",
             .type = QEMU_OPT_STRING,
         },
         {
-            .name = "port",
+            .name = "server.port",
             .type = QEMU_OPT_STRING,
         },
         {
-            .name = "path",
+            .name = "server.path",
             .type = QEMU_OPT_STRING,
         },
         {
@@ -1560,9 +1560,9 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
         goto err_no_fd;
     }
 
-    host = qemu_opt_get(opts, "host");
-    port = qemu_opt_get(opts, "port");
-    path = qemu_opt_get(opts, "path");
+    host = qemu_opt_get(opts, "server.host");
+    port = qemu_opt_get(opts, "server.port");
+    path = qemu_opt_get(opts, "server.path");
     vdi = qemu_opt_get(opts, "vdi");
     snap_id_str = qemu_opt_get(opts, "snap-id");
     snap_id = qemu_opt_get_number(opts, "snap-id", CURRENT_VDI_ID);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 8d87962..b5f0e99 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2623,7 +2623,7 @@
 # Driver specific block device options for sheepdog
 #
 # @vdi:         Virtual disk image name
-# @addr:        The Sheepdog server to connect to
+# @server:      The Sheepdog server to connect to
 # @snap-id:     Snapshot ID
 # @tag:         Snapshot tag name
 #
@@ -2632,7 +2632,7 @@
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsSheepdog',
-  'data': { 'addr': 'SocketAddressFlat',
+  'data': { 'server': 'SocketAddressFlat',
             'vdi': 'str',
             '*snap-id': 'uint32',
             '*tag': 'str' } }
-- 
2.7.4
