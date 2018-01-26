Received: from eggs.gnu.org ([2001:4830:134:3::10]:60017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef6US-0003Cd-E1
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:04:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef6UP-0002e4-Ei
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:04:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:26808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ef6UP-0002dl-7A
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:04:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F33B72663
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 16:04:28 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 26 Jan 2018 10:04:10 -0600
Message-Id: <20180126160411.4033-8-eblake@redhat.com>
In-Reply-To: <20180126160411.4033-1-eblake@redhat.com>
References: <20180126160411.4033-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 7/8] hmp: Add nbd_server_remove to mirror QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Since everything else about the nbd-server-* QMP commands is
accessible from HMP, we might as well make removing an export
available as well.  For now, I went with a bool flag rather
than a mode string for choosing between safe (default) and
hard modes.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180125144557.25502-1-eblake@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 hmp.h           |  1 +
 hmp.c           | 14 +++++++++++---
 hmp-commands.hx | 17 +++++++++++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/hmp.h b/hmp.h
index a6f56b1f29e..536cb91caa4 100644
--- a/hmp.h
+++ b/hmp.h
@@ -101,6 +101,7 @@ void hmp_sendkey(Monitor *mon, const QDict *qdict);
 void hmp_screendump(Monitor *mon, const QDict *qdict);
 void hmp_nbd_server_start(Monitor *mon, const QDict *qdict);
 void hmp_nbd_server_add(Monitor *mon, const QDict *qdict);
+void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict);
 void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict);
 void hmp_chardev_add(Monitor *mon, const QDict *qdict);
 void hmp_chardev_change(Monitor *mon, const QDict *qdict);
diff --git a/hmp.c b/hmp.c
index 7a64dd59c5c..b3de32d219b 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2226,10 +2226,18 @@ void hmp_nbd_server_add(Monitor *mon, const QDict *qdict)
     Error *local_err = NULL;

     qmp_nbd_server_add(device, !!name, name, true, writable, &local_err);
+    hmp_handle_error(mon, &local_err);
+}

-    if (local_err != NULL) {
-        hmp_handle_error(mon, &local_err);
-    }
+void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict)
+{
+    const char *name = qdict_get_str(qdict, "name");
+    bool force = qdict_get_try_bool(qdict, "force", false);
+    Error *err = NULL;
+
+    /* Rely on NBD_SERVER_REMOVE_MODE_SAFE being the default */
+    qmp_nbd_server_remove(name, force, NBD_SERVER_REMOVE_MODE_HARD, &err);
+    hmp_handle_error(mon, &err);
 }

 void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict)
diff --git a/hmp-commands.hx b/hmp-commands.hx
index b8b6fb91848..c36a9ec4657 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1565,6 +1565,23 @@ Export a block device through QEMU's NBD server, which must be started
 beforehand with @command{nbd_server_start}.  The @option{-w} option makes the
 exported device writable too.  The export name is controlled by @var{name},
 defaulting to @var{device}.
+ETEXI
+
+    {
+        .name       = "nbd_server_remove",
+        .args_type  = "force:-f,name:s",
+        .params     = "nbd_server_remove [-f] name",
+        .help       = "remove an export previously exposed via NBD",
+        .cmd        = hmp_nbd_server_remove,
+    },
+STEXI
+@item nbd_server_remove [-f] @var{name}
+@findex nbd_server_remove
+Stop exporting a block device through QEMU's NBD server, which was
+previously started with @command{nbd_server_add}.  The @option{-f}
+option forces the server to drop the export immediately even if
+clients are connected; otherwise the command fails unless there are no
+clients.
 ETEXI

     {
-- 
2.14.3
