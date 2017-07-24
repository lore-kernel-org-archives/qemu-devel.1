Received: from eggs.gnu.org ([2001:4830:134:3::10]:41417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZhVb-00051K-MW
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZhVW-00060x-R1
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:51:07 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:35840)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZhVW-00060i-Ec
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:51:02 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 24 Jul 2017 20:50:52 +0300
Message-Id: <150091865221.30739.8093437461715631283.stgit@frigg.lan>
In-Reply-To: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/13] instrument: [hmp] Add library loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 hmp-commands.hx |   28 ++++++++++++++++++++++++++++
 monitor.c       |   55 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 83 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 1941e19932..b1f3a75ab0 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1858,6 +1858,34 @@ ETEXI
         .sub_table  =3D info_cmds,
     },
=20
+    {
+        .name       =3D "instr-load",
+        .args_type  =3D "path:F,args:s?",
+        .params     =3D "path [args]",
+        .help       =3D "load an instrumentation library",
+        .cmd        =3D hmp_instr_load,
+    },
+
+STEXI
+@item instr-load @var{path} [args=3Dvalue[,...]]
+@findex instr-load
+Load an instrumentation library.
+ETEXI
+
+    {
+        .name       =3D "instr-unload",
+        .args_type  =3D "handle:i",
+        .params     =3D "",
+        .help       =3D "unload an instrumentation library",
+        .cmd        =3D hmp_instr_unload,
+    },
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
index 6d040e620f..4784356798 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2319,6 +2319,61 @@ int monitor_fd_param(Monitor *mon, const char *fdn=
ame, Error **errp)
     return fd;
 }
=20
+static void hmp_instr_load(Monitor *mon, const QDict *qdict)
+{
+    const char *path =3D qdict_get_str(qdict, "path");
+    String str;
+    str.str =3D (char *)qdict_get_try_str(qdict, "args");
+    StringList args;
+    args.value =3D str.str =3D=3D NULL ? NULL : &str;
+    args.next =3D NULL;
+    InstrLoadResult *res =3D qmp_instr_load(path, args.value !=3D NULL,
+                                          args.value !=3D NULL ? &args :=
 NULL,
+                                          NULL);
+    switch (res->code) {
+    case INSTR_LOAD_CODE_OK:
+        monitor_printf(mon, "Handle: %"PRId64"\n", res->handle);
+        monitor_printf(mon, "OK\n");
+        break;
+    case INSTR_LOAD_CODE_UNAVAILABLE:
+        monitor_printf(mon, "Not available\n");
+        break;
+    case INSTR_LOAD_CODE_ERROR:
+        monitor_printf(mon, "Error loading library: %s\n", res->msg);
+        break;
+    default:
+        fprintf(stderr, "Unknown instrumentation load code: %d", res->co=
de);
+        exit(1);
+        break;
+    }
+    qapi_free_InstrLoadResult(res);
+}
+
+static void hmp_instr_unload(Monitor *mon, const QDict *qdict)
+{
+    int64_t handle =3D qdict_get_int(qdict, "handle");
+    InstrUnloadResult *res =3D qmp_instr_unload(handle, NULL);
+    switch (res->code) {
+    case INSTR_UNLOAD_CODE_OK:
+        monitor_printf(mon, "OK\n");
+        break;
+    case INSTR_UNLOAD_CODE_UNAVAILABLE:
+        monitor_printf(mon, "Not available\n");
+        break;
+    case INSTR_UNLOAD_CODE_INVALID:
+        monitor_printf(mon, "Invalid handle\n");
+        break;
+    case INSTR_UNLOAD_CODE_ERROR:
+        monitor_printf(mon, "Error unloading library: %s\n", res->msg);
+        break;
+    default:
+        fprintf(stderr, "Unknown instrumentation unload code: %d", res->=
code);
+        exit(1);
+        break;
+    }
+    qapi_free_InstrUnloadResult(res);
+}
+
 /* Please update hmp-commands.hx when adding or changing commands */
 static mon_cmd_t info_cmds[] =3D {
 #include "hmp-commands-info.h"
