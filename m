Received: from eggs.gnu.org ([2001:4830:134:3::10]:39819)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cUVmD-0003vh-5i
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cUVm9-0003CZ-DH
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:46:33 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:59823 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cUVm9-0003An-57
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:46:29 -0500
From: Peter Lieven <pl@kamp.de>
Date: Fri, 20 Jan 2017 10:46:10 +0100
Message-Id: <1484905570-10520-3-git-send-email-pl@kamp.de>
In-Reply-To: <1484905570-10520-1-git-send-email-pl@kamp.de>
References: <1484905570-10520-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH 2/2] block/nfs: fix naming of runtime opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, ashijeetacharya@gmail.com, jcody@redhat.com, mreitz@redhat.com, armbru@redhat.com, Peter Lieven <pl@kamp.de>, qemu-stable@nongnu.org

commit 94d6a7a accidently left the naming of runtime opts and QAPI
scheme inconsistent. As one consequence passing of parameters in the
URI is broken. Sync the naming of the runtime opts to the QAPI
scheme.

Fixes: 94d6a7a76e9df9919629428f6c598e2b97d9426c
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
---
 block/nfs.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index baaecff..464d547 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -359,27 +359,27 @@ static QemuOptsList runtime_opts = {
             .help = "Path of the image on the host",
         },
         {
-            .name = "uid",
+            .name = "user",
             .type = QEMU_OPT_NUMBER,
             .help = "UID value to use when talking to the server",
         },
         {
-            .name = "gid",
+            .name = "group",
             .type = QEMU_OPT_NUMBER,
             .help = "GID value to use when talking to the server",
         },
         {
-            .name = "tcp-syncnt",
+            .name = "tcp-syn-count",
             .type = QEMU_OPT_NUMBER,
             .help = "Number of SYNs to send during the session establish",
         },
         {
-            .name = "readahead",
+            .name = "readahead-size",
             .type = QEMU_OPT_NUMBER,
             .help = "Set the readahead size in bytes",
         },
         {
-            .name = "pagecache",
+            .name = "page-cache-size",
             .type = QEMU_OPT_NUMBER,
             .help = "Set the pagecache size in bytes",
         },
@@ -508,29 +508,29 @@ static int64_t nfs_client_open(NFSClient *client, QDict *options,
         goto fail;
     }
 
-    if (qemu_opt_get(opts, "uid")) {
-        client->uid = qemu_opt_get_number(opts, "uid", 0);
+    if (qemu_opt_get(opts, "user")) {
+        client->uid = qemu_opt_get_number(opts, "user", 0);
         nfs_set_uid(client->context, client->uid);
     }
 
-    if (qemu_opt_get(opts, "gid")) {
-        client->gid = qemu_opt_get_number(opts, "gid", 0);
+    if (qemu_opt_get(opts, "group")) {
+        client->gid = qemu_opt_get_number(opts, "group", 0);
         nfs_set_gid(client->context, client->gid);
     }
 
-    if (qemu_opt_get(opts, "tcp-syncnt")) {
-        client->tcp_syncnt = qemu_opt_get_number(opts, "tcp-syncnt", 0);
+    if (qemu_opt_get(opts, "tcp-syn-count")) {
+        client->tcp_syncnt = qemu_opt_get_number(opts, "tcp-syn-count", 0);
         nfs_set_tcp_syncnt(client->context, client->tcp_syncnt);
     }
 
 #ifdef LIBNFS_FEATURE_READAHEAD
-    if (qemu_opt_get(opts, "readahead")) {
+    if (qemu_opt_get(opts, "readahead-size")) {
         if (open_flags & BDRV_O_NOCACHE) {
             error_setg(errp, "Cannot enable NFS readahead "
                              "if cache.direct = on");
             goto fail;
         }
-        client->readahead = qemu_opt_get_number(opts, "readahead", 0);
+        client->readahead = qemu_opt_get_number(opts, "readahead-size", 0);
         if (client->readahead > QEMU_NFS_MAX_READAHEAD_SIZE) {
             error_report("NFS Warning: Truncating NFS readahead "
                          "size to %d", QEMU_NFS_MAX_READAHEAD_SIZE);
@@ -545,13 +545,13 @@ static int64_t nfs_client_open(NFSClient *client, QDict *options,
 #endif
 
 #ifdef LIBNFS_FEATURE_PAGECACHE
-    if (qemu_opt_get(opts, "pagecache")) {
+    if (qemu_opt_get(opts, "page-cache-size")) {
         if (open_flags & BDRV_O_NOCACHE) {
             error_setg(errp, "Cannot enable NFS pagecache "
                              "if cache.direct = on");
             goto fail;
         }
-        client->pagecache = qemu_opt_get_number(opts, "pagecache", 0);
+        client->pagecache = qemu_opt_get_number(opts, "page-cache-size", 0);
         if (client->pagecache > QEMU_NFS_MAX_PAGECACHE_SIZE) {
             error_report("NFS Warning: Truncating NFS pagecache "
                          "size to %d pages", QEMU_NFS_MAX_PAGECACHE_SIZE);
-- 
1.9.1
