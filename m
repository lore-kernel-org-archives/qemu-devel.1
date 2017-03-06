Received: from eggs.gnu.org ([2001:4830:134:3::10]:45952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckxsR-00045w-Qk
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckxsQ-0004j3-Dm
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:00:59 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  6 Mar 2017 20:00:44 +0100
Message-Id: <1488826849-32384-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1488826849-32384-1-git-send-email-armbru@redhat.com>
References: <1488826849-32384-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/15] gluster: Drop assumptions on
 SocketTransport names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, ndevos@redhat.com, eblake@redhat.com, f4bug@amsat.org

qemu_gluster_glfs_init() passes the names of QAPI enumeration type
SocketTransport to glfs_set_volfile_server().  Works, because they
were chosen to match.  But the coupling is artificial.  Use the
appropriate literal strings instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Niels de Vos <ndevos@redhat.com>
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
2.7.4
