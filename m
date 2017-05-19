Received: from eggs.gnu.org ([2001:4830:134:3::10]:46859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBhK0-0000Zz-95
	for qemu-devel@nongnu.org; Fri, 19 May 2017 08:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBhJz-0004JX-3b
	for qemu-devel@nongnu.org; Fri, 19 May 2017 08:47:56 -0400
Received: from mail-eopbgr00136.outbound.protection.outlook.com
	([40.107.0.136]:31167
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dBhJy-0004AG-OE
	for qemu-devel@nongnu.org; Fri, 19 May 2017 08:47:55 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 19 May 2017 15:47:17 +0300
Message-ID: <1495198042-124203-5-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495198042-124203-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1495198042-124203-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 4/9] hmp: add hmp analogue for
 qmp-chardev-change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 chardev/char.c        |  4 ++--
 hmp-commands.hx       | 16 ++++++++++++++++
 hmp.c                 | 34 ++++++++++++++++++++++++++++++++++
 hmp.h                 |  1 +
 include/sysemu/char.h | 12 ++++++++++++
 5 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index bac5e1c..0483f19 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -880,8 +880,8 @@ help_string_append(const char *name, void *opaque)
     g_string_append_printf(str, "\n%s", name);
 }
 
-static ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts,
-                                           Error **errp)
+ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts,
+                                    Error **errp)
 {
     Error *local_err = NULL;
     const ChardevClass *cc;
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 0aca984..0f2a059 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1727,6 +1727,22 @@ chardev_add accepts the same parameters as the -chardev command line switch.
 ETEXI
 
     {
+        .name       = "chardev-change",
+        .args_type  = "id:s,args:s",
+        .params     = "id args",
+        .help       = "change chardev",
+        .cmd        = hmp_chardev_change,
+    },
+
+STEXI
+@item chardev-change args
+@findex chardev-change
+chardev_change accepts existing chardev @var{id} and then the same arguments
+as the -chardev command line switch (except for "id").
+
+ETEXI
+
+    {
         .name       = "chardev-remove",
         .args_type  = "id:s",
         .params     = "id",
diff --git a/hmp.c b/hmp.c
index 3dceaf8..f7d0b38 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2209,6 +2209,40 @@ void hmp_chardev_add(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
 
+void hmp_chardev_change(Monitor *mon, const QDict *qdict)
+{
+    const char *args = qdict_get_str(qdict, "args");
+    const char *id;
+    Error *err = NULL;
+    ChardevBackend *backend = NULL;
+    ChardevReturn *ret = NULL;
+    QemuOpts *opts = qemu_opts_parse_noisily(qemu_find_opts("chardev"), args,
+                                             true);
+    if (!opts) {
+        error_setg(&err, "Parsing chardev args failed");
+        goto end;
+    }
+
+    id = qdict_get_str(qdict, "id");
+    if (qemu_opts_id(opts)) {
+        error_setg(&err, "Unexpected 'id' parameter");
+        goto end;
+    }
+
+    backend = qemu_chr_parse_opts(opts, &err);
+    if (!backend) {
+        goto end;
+    }
+
+    ret = qmp_chardev_change(id, backend, &err);
+
+end:
+    qapi_free_ChardevReturn(ret);
+    qapi_free_ChardevBackend(backend);
+    qemu_opts_del(opts);
+    hmp_handle_error(mon, &err);
+}
+
 void hmp_chardev_remove(Monitor *mon, const QDict *qdict)
 {
     Error *local_err = NULL;
diff --git a/hmp.h b/hmp.h
index d8b94ce..23e035c 100644
--- a/hmp.h
+++ b/hmp.h
@@ -102,6 +102,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict);
 void hmp_nbd_server_add(Monitor *mon, const QDict *qdict);
 void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict);
 void hmp_chardev_add(Monitor *mon, const QDict *qdict);
+void hmp_chardev_change(Monitor *mon, const QDict *qdict);
 void hmp_chardev_remove(Monitor *mon, const QDict *qdict);
 void hmp_qemu_io(Monitor *mon, const QDict *qdict);
 void hmp_cpu_add(Monitor *mon, const QDict *qdict);
diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 68c7876..92ae57e 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -132,6 +132,18 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
 void qemu_chr_parse_common(QemuOpts *opts, ChardevCommon *backend);
 
 /**
+ * @qemu_chr_parse_opts:
+ *
+ * Parse the options to the ChardevBackend struct.
+ *
+ * @opts
+ *
+ * Returns: a new backend
+ */
+ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts,
+                                    Error **errp);
+
+/**
  * @qemu_chr_new:
  *
  * Create a new character backend from a URI.
-- 
2.7.4
