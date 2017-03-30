Received: from eggs.gnu.org ([2001:4830:134:3::10]:58678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctZv4-0002ZF-My
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctZv3-0002QS-Oo
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:15:18 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 30 Mar 2017 15:15:06 +0200
Message-Id: <1490879707-6060-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1490879707-6060-1-git-send-email-armbru@redhat.com>
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC v2 for-2.9 09/10] squash! nbd: Tidy up
 blockdev-add interface
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

Drop backward -drive server.data.* compatibility gunk.  On squash,
replace commit message's last paragraph "Unfortunately, SocketAddress
is also visible..." by:

Unfortunately, SocketAddress is also visible in -drive since 2.8:

    -drive if=none,driver=nbd,server.type=inet,server.data.host=127.0.0.1,server.data.port=12345

Nobody should be using it, as it's fairly new and has never been
documented, so adding still more compatibility gunk to keep it working
isn't worth the trouble.  You now have to use

    -drive if=none,driver=nbd,server.type=inet,server.host=127.0.0.1,server.port=12345

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/nbd.c | 41 +----------------------------------------
 1 file changed, 1 insertion(+), 40 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index ea9d8dc..8bb29a9 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -223,51 +223,12 @@ static bool nbd_process_legacy_socket_options(QDict *output_options,
     const char *path = qemu_opt_get(legacy_opts, "path");
     const char *host = qemu_opt_get(legacy_opts, "host");
     const char *port = qemu_opt_get(legacy_opts, "port");
-    const char *sd_path = qdict_get_try_str(output_options,
-                                            "server.data.path");
-    const char *sd_host = qdict_get_try_str(output_options,
-                                            "server.data.host");
-    const char *sd_port = qdict_get_try_str(output_options,
-                                            "server.data.port");
-    bool bare = path || host || port;
-    bool server_data = sd_path || sd_host || sd_port;
-    QObject *val;
     const QDictEntry *e;
 
-    if (!bare && !server_data) {
+    if (!path && !host && !port) {
         return true;
     }
 
-    if (bare && server_data) {
-        error_setg(errp, "Cannot use 'server' and path/host/port at the "
-                   "same time");
-        return false;
-    }
-
-    if (server_data) {
-        if (sd_host) {
-            val = qdict_get(output_options, "server.data.host");
-            qobject_incref(val);
-            qdict_put_obj(output_options, "server.host", val);
-            qdict_del(output_options, "server.data.host");
-        }
-        if (sd_port) {
-            val = qdict_get(output_options, "server.data.port");
-            qobject_incref(val);
-            qdict_put_obj(output_options, "server.port", val);
-            qdict_del(output_options, "server.data.port");
-        }
-        if (sd_path) {
-            val = qdict_get(output_options, "server.data.path");
-            qobject_incref(val);
-            qdict_put_obj(output_options, "server.path", val);
-            qdict_del(output_options, "server.data.path");
-        }
-        return true;
-    }
-
-    assert(bare);
-
     for (e = qdict_first(output_options); e; e = qdict_next(output_options, e))
     {
         if (strstart(e->key, "server.", NULL)) {
-- 
2.7.4
