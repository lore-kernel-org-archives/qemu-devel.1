Received: from eggs.gnu.org ([2001:4830:134:3::10]:46366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5ih-0002Jn-EO
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5id-0000En-Gy
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:07 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:19 -0500
Message-Id: <20180619014319.28272-54-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 053/113] gluster: Fix blockdev-add with
 server.N.type=unix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>

From: Kevin Wolf <kwolf@redhat.com>

The legacy command line interface gets the socket path from an option
called 'socket'. QAPI in contract uses SocketAddress, where the
corresponding option is called 'path'.

Fix the gluster block driver to accept both 'socket' and 'path', with
'path' being the preferred syntax.

https://bugzilla.redhat.com/show_bug.cgi?id=1545155

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-id: 20180403110810.25624-1-kwolf@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
(cherry picked from commit 9dae635afa98f83688806861cefe77ff1b4d76a8)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/gluster.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 0f4265a3a4..d09f4f2283 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -164,7 +164,12 @@ static QemuOptsList runtime_unix_opts = {
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
@@ -612,10 +617,18 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
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
@@ -680,7 +693,7 @@ static struct glfs *qemu_gluster_init(BlockdevOptionsGluster *gconf,
                              "file.server.0.host=1.2.3.4,"
                              "file.server.0.port=24007,"
                              "file.server.1.transport=unix,"
-                             "file.server.1.socket=/var/run/glusterd.socket ..."
+                             "file.server.1.path=/var/run/glusterd.socket ..."
                              "\n");
             errno = -ret;
             return NULL;
-- 
2.11.0
