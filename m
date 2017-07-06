Received: from eggs.gnu.org ([2001:4830:134:3::10]:36077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dT5cB-0005wZ-A7
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dT5c7-0004y5-76
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:10:35 -0400
Received: from mail-db5eur01on0101.outbound.protection.outlook.com
	([104.47.2.101]:5600
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dT5c6-0004v6-OE
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:10:31 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu,  6 Jul 2017 15:08:57 +0300
Message-Id: <1499342940-56739-11-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1499342940-56739-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1499342940-56739-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 10/13] hmp: add hmp analogue for
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
Cc: den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, amit@kernel.org, mst@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/chardev/char.h | 10 ++++++++++
 hmp.h                  |  1 +
 chardev/char.c         |  2 +-
 hmp-commands.hx        | 18 +++++++++++++++++-
 hmp.c                  | 34 ++++++++++++++++++++++++++++++++++
 tests/test-hmp.c       |  1 +
 6 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index 22fd734..1604ea9 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -81,6 +81,16 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
 void qemu_chr_parse_common(QemuOpts *opts, ChardevCommon *backend);
 
 /**
+ * @qemu_chr_parse_opts:
+ *
+ * Parse the options to the ChardevBackend struct.
+ *
+ * Returns: a new backend or NULL on error
+ */
+ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts,
+                                    Error **errp);
+
+/**
  * @qemu_chr_new:
  *
  * Create a new character backend from a URI.
diff --git a/hmp.h b/hmp.h
index 214b261..1ff4552 100644
--- a/hmp.h
+++ b/hmp.h
@@ -102,6 +102,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict);
 void hmp_nbd_server_add(Monitor *mon, const QDict *qdict);
 void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict);
 void hmp_chardev_add(Monitor *mon, const QDict *qdict);
+void hmp_chardev_change(Monitor *mon, const QDict *qdict);
 void hmp_chardev_remove(Monitor *mon, const QDict *qdict);
 void hmp_chardev_send_break(Monitor *mon, const QDict *qdict);
 void hmp_qemu_io(Monitor *mon, const QDict *qdict);
diff --git a/chardev/char.c b/chardev/char.c
index d6b9d89..c34b44a 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -567,7 +567,7 @@ static const char *chardev_alias_translate(const char *name)
     return name;
 }
 
-static ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
+ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
 {
     Error *local_err = NULL;
     const ChardevClass *cc;
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 275ccdf..c4c96db 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1724,7 +1724,23 @@ ETEXI
 STEXI
 @item chardev-add args
 @findex chardev-add
-chardev_add accepts the same parameters as the -chardev command line switch.
+chardev-add accepts the same parameters as the -chardev command line switch.
+
+ETEXI
+
+    {
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
+chardev-change accepts existing chardev @var{id} and then the same arguments
+as the -chardev command line switch (except for "id").
 
 ETEXI
 
diff --git a/hmp.c b/hmp.c
index dee4028..1b443e1 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2228,6 +2228,40 @@ void hmp_chardev_add(Monitor *mon, const QDict *qdict)
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
diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 6dfa0c3..d77b3c8 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -23,6 +23,7 @@ static const char *hmp_cmds[] = {
     "boot_set ndc",
     "chardev-add null,id=testchardev1",
     "chardev-send-break testchardev2",
+    "chardev-change testchardev1 ringbuf",
     "chardev-remove testchardev1",
     "commit all",
     "cpu-add 1",
-- 
2.7.4
