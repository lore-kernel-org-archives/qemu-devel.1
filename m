Received: from eggs.gnu.org ([2001:4830:134:3::10]:49633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4s2-0004X9-6u
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4rw-000786-UQ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:26:14 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:39954)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4rw-00077S-Iu
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:26:08 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 13 Sep 2017 13:25:58 +0300
Message-Id: <150529835846.10902.5108194050713694092.stgit@frigg.lan>
In-Reply-To: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 08/22] instrument: [hmp] Add library loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 hmp-commands.hx |   32 ++++++++++++++++++++++++++++++++
 monitor.c       |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 1941e19932..2e8ebe8422 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1858,6 +1858,38 @@ ETEXI
         .sub_table  =3D info_cmds,
     },
=20
+#ifdef CONFIG_INSTRUMENT
+    {
+        .name       =3D "instr-load",
+        .args_type  =3D "path:F,id:s?,arg:s?",
+        .params     =3D "path [id] [arg]",
+        .help       =3D "load an instrumentation library",
+        .cmd        =3D hmp_instr_load,
+    },
+#endif
+
+STEXI
+@item instr-load @var{path} [@var{id}] [@var{arg}]
+@findex instr-load
+Load an instrumentation library.
+ETEXI
+
+#ifdef CONFIG_INSTRUMENT
+    {
+        .name       =3D "instr-unload",
+        .args_type  =3D "id:s",
+        .params     =3D "id",
+        .help       =3D "unload an instrumentation library",
+        .cmd        =3D hmp_instr_unload,
+    },
+#endif
+
+STEXI
+@item instr-unload
+@findex instr-unload
+Unload an instrumentation library.
+ETEXI
+
 STEXI
 @end table
 ETEXI
diff --git a/monitor.c b/monitor.c
index e031aa2687..7b80d5351f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2323,6 +2323,45 @@ int monitor_fd_param(Monitor *mon, const char *fdn=
ame, Error **errp)
     return fd;
 }
=20
+#ifdef CONFIG_INSTRUMENT
+static void hmp_instr_load(Monitor *mon, const QDict *qdict)
+{
+    Error *err =3D NULL;
+    const char *path =3D qdict_get_str(qdict, "path");
+    const char *id =3D qdict_get_try_str(qdict, "id");
+    const char *str =3D qdict_get_try_str(qdict, "arg");
+    strList args;
+
+    args.value =3D (char *)str;
+    args.next =3D NULL;
+
+    InstrLoadResult *res =3D qmp_instr_load(path,
+                                          id !=3D NULL, id,
+                                          args.value !=3D NULL, &args,
+                                          &err);
+    if (err) {
+        error_report_err(err);
+    } else {
+        monitor_printf(mon, "Handle: %s\n", res->id);
+        monitor_printf(mon, "OK\n");
+    }
+    qapi_free_InstrLoadResult(res);
+}
+
+static void hmp_instr_unload(Monitor *mon, const QDict *qdict)
+{
+    Error *err =3D NULL;
+    const char *id =3D qdict_get_str(qdict, "id");
+
+    qmp_instr_unload(id, &err);
+    if (err) {
+        error_report_err(err);
+    } else {
+        monitor_printf(mon, "OK\n");
+    }
+}
+#endif
+
 /* Please update hmp-commands.hx when adding or changing commands */
 static mon_cmd_t info_cmds[] =3D {
 #include "hmp-commands-info.h"
