Received: from eggs.gnu.org ([2001:4830:134:3::10]:58737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctZv6-0002bC-DC
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctZv5-0002TF-66
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:15:20 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 30 Mar 2017 15:15:02 +0200
Message-Id: <1490879707-6060-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1490879707-6060-1-git-send-email-armbru@redhat.com>
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC v2 for-2.9 05/10] gluster: Prepare for
 SocketAddressFlat extension
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

qemu_gluster_glfs_init() and qemu_gluster_parse_json() rely on the
fact that SocketAddressFlatType has only two members
SOCKET_ADDRESS_FLAT_TYPE_INET and SOCKET_ADDRESS_FLAT_TYPE_UNIX.
Correct, but won't stay correct.  Make them more robust.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
---
 block/gluster.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index a577dae..fb0aafe 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -412,10 +412,12 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
     glfs_set_preopened(gconf->volume, glfs);
 
     for (server = gconf->server; server; server = server->next) {
-        if (server->value->type  == SOCKET_ADDRESS_FLAT_TYPE_UNIX) {
+        switch (server->value->type) {
+        case SOCKET_ADDRESS_FLAT_TYPE_UNIX:
             ret = glfs_set_volfile_server(glfs, "unix",
                                    server->value->u.q_unix.path, 0);
-        } else {
+            break;
+        case SOCKET_ADDRESS_FLAT_TYPE_INET:
             if (parse_uint_full(server->value->u.inet.port, &port, 10) < 0 ||
                 port > 65535) {
                 error_setg(errp, "'%s' is not a valid port number",
@@ -426,6 +428,9 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
             ret = glfs_set_volfile_server(glfs, "tcp",
                                    server->value->u.inet.host,
                                    (int)port);
+            break;
+        default:
+            abort();
         }
 
         if (ret < 0) {
@@ -487,7 +492,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
     char *str = NULL;
     const char *ptr;
     size_t num_servers;
-    int i;
+    int i, type;
 
     /* create opts info from runtime_json_opts list */
     opts = qemu_opts_create(&runtime_json_opts, NULL, 0, &error_abort);
@@ -539,16 +544,17 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
         if (!strcmp(ptr, "tcp")) {
             ptr = "inet";       /* accept legacy "tcp" */
         }
-        gsconf->type = qapi_enum_parse(SocketAddressFlatType_lookup, ptr,
-                                       SOCKET_ADDRESS_FLAT_TYPE__MAX, -1,
-                                       &local_err);
-        if (local_err) {
-            error_append_hint(&local_err,
-                              "Parameter '%s' may be 'inet' or 'unix'\n",
-                              GLUSTER_OPT_TYPE);
+        type = qapi_enum_parse(SocketAddressFlatType_lookup, ptr,
+                               SOCKET_ADDRESS_FLAT_TYPE__MAX, -1, NULL);
+        if (type != SOCKET_ADDRESS_FLAT_TYPE_INET
+            && type != SOCKET_ADDRESS_FLAT_TYPE_UNIX) {
+            error_setg(&local_err,
+                       "Parameter '%s' may be 'inet' or 'unix'",
+                       GLUSTER_OPT_TYPE);
             error_append_hint(&local_err, GERR_INDEX_HINT, i);
             goto out;
         }
+        gsconf->type = type;
         qemu_opts_del(opts);
 
         if (gsconf->type == SOCKET_ADDRESS_FLAT_TYPE_INET) {
-- 
2.7.4
