Received: from eggs.gnu.org ([2001:4830:134:3::10]:42850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHF1-0002W8-FT
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHF0-0002uq-HY
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:35 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  7 Mar 2017 16:40:44 +0100
Message-Id: <1488901251-16214-21-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
References: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 20/27] gluster: Drop assumptions on
 SocketTransport names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Markus Armbruster <armbru@redhat.com>

qemu_gluster_glfs_init() passes the names of QAPI enumeration type
SocketTransport to glfs_set_volfile_server().  Works, because they
were chosen to match.  But the coupling is artificial.  Use the
appropriate literal strings instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Niels de Vos <ndevos@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/gluster.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 56b4abe..7236d59 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -412,8 +412,7 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
 
     for (server = gconf->server; server; server = server->next) {
         if (server->value->type  == GLUSTER_TRANSPORT_UNIX) {
-            ret = glfs_set_volfile_server(glfs,
-                                   GlusterTransport_lookup[server->value->type],
+            ret = glfs_set_volfile_server(glfs, "unix",
                                    server->value->u.q_unix.path, 0);
         } else {
             if (parse_uint_full(server->value->u.tcp.port, &port, 10) < 0 ||
@@ -423,8 +422,7 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
                 errno = EINVAL;
                 goto out;
             }
-            ret = glfs_set_volfile_server(glfs,
-                                   GlusterTransport_lookup[server->value->type],
+            ret = glfs_set_volfile_server(glfs, "tcp",
                                    server->value->u.tcp.host,
                                    (int)port);
         }
-- 
1.8.3.1
