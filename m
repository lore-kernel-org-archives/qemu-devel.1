Received: from eggs.gnu.org ([2001:4830:134:3::10]:55253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Osy-0006mI-Sw
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Osx-0006Y7-Qj
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:34:16 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  3 Apr 2018 18:33:52 +0200
Message-Id: <20180403163400.6307-2-kwolf@redhat.com>
In-Reply-To: <20180403163400.6307-1-kwolf@redhat.com>
References: <20180403163400.6307-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 1/9] gluster: Fix blockdev-add with
 server.N.type=unix
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

The legacy command line interface gets the socket path from an option
called 'socket'. QAPI in contract uses SocketAddress, where the
corresponding option is called 'path'.

Fix the gluster block driver to accept both 'socket' and 'path', with
'path' being the preferred syntax.

https://bugzilla.redhat.com/show_bug.cgi?id=1545155

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/gluster.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 296e036b3d..4adc1a875b 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -167,7 +167,12 @@ static QemuOptsList runtime_unix_opts = {
         {
             .name = GLUSTER_OPT_SOCKET,
             .type = QEMU_OPT_STRING,
-            .help = "socket file path)",
+            .help = "socket file path (legacy)",
+        },
+        {
+            .name = GLUSTER_OPT_PATH,
+            .type = QEMU_OPT_STRING,
+            .help = "socket file path (QAPI)",
         },
         { /* end of list */ }
     },
@@ -615,10 +620,18 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
                 goto out;
             }
 
-            ptr = qemu_opt_get(opts, GLUSTER_OPT_SOCKET);
+            ptr = qemu_opt_get(opts, GLUSTER_OPT_PATH);
+            if (!ptr) {
+                ptr = qemu_opt_get(opts, GLUSTER_OPT_SOCKET);
+            } else if (qemu_opt_get(opts, GLUSTER_OPT_SOCKET)) {
+                error_setg(&local_err,
+                           "Conflicting parameters 'path' and 'socket'");
+                error_append_hint(&local_err, GERR_INDEX_HINT, i);
+                goto out;
+            }
             if (!ptr) {
                 error_setg(&local_err, QERR_MISSING_PARAMETER,
-                           GLUSTER_OPT_SOCKET);
+                           GLUSTER_OPT_PATH);
                 error_append_hint(&local_err, GERR_INDEX_HINT, i);
                 goto out;
             }
@@ -684,7 +697,7 @@ static int qemu_gluster_parse(BlockdevOptionsGluster *gconf,
                              "file.server.0.host=1.2.3.4,"
                              "file.server.0.port=24007,"
                              "file.server.1.transport=unix,"
-                             "file.server.1.socket=/var/run/glusterd.socket ..."
+                             "file.server.1.path=/var/run/glusterd.socket ..."
                              "\n");
             return ret;
         }
-- 
2.13.6
