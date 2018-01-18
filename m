Received: from eggs.gnu.org ([2001:4830:134:3::10]:59743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ecEex-0001WD-K5
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:11:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ecEeu-0004Nu-TG
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:11:31 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 18 Jan 2018 21:11:19 +0300
Message-Id: <20180118181123.37056-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180118181123.37056-1-vsementsov@virtuozzo.com>
References: <20180118181123.37056-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 2/6] hmp: add name parameter to
 nbd_server_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Support name parameter for HMP too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 hmp.c           | 3 ++-
 hmp-commands.hx | 9 +++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/hmp.c b/hmp.c
index 37972f8322..964cff8aed 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2236,10 +2236,11 @@ exit:
 void hmp_nbd_server_add(Monitor *mon, const QDict *qdict)
 {
     const char *device = qdict_get_str(qdict, "device");
+    const char *name = qdict_get_try_str(qdict, "name");
     bool writable = qdict_get_try_bool(qdict, "writable", false);
     Error *local_err = NULL;
 
-    qmp_nbd_server_add(device, false, NULL, true, writable, &local_err);
+    qmp_nbd_server_add(device, name != NULL, name, true, writable, &local_err);
 
     if (local_err != NULL) {
         hmp_handle_error(mon, &local_err);
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 6d5ebdf6ab..cad9a9a238 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1553,8 +1553,8 @@ ETEXI
 
     {
         .name       = "nbd_server_add",
-        .args_type  = "writable:-w,device:B",
-        .params     = "nbd_server_add [-w] device",
+        .args_type  = "name:-n,writable:-w,device:B",
+        .params     = "nbd_server_add [-n] [-w] device",
         .help       = "export a block device via NBD",
         .cmd        = hmp_nbd_server_add,
     },
@@ -1562,8 +1562,9 @@ STEXI
 @item nbd_server_add @var{device}
 @findex nbd_server_add
 Export a block device through QEMU's NBD server, which must be started
-beforehand with @command{nbd_server_start}.  The @option{-w} option makes the
-exported device writable too.
+beforehand with @command{nbd_server_start}. The @option{-n} option sets export
+name. If @option{-n} option is unspecified, the @var{device} parameter is used.
+The @option{-w} option makes the exported device writable too.
 ETEXI
 
     {
-- 
2.11.1
