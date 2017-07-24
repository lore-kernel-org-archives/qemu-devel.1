Received: from eggs.gnu.org ([2001:4830:134:3::10]:35944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZhC4-0003D2-Bh
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZhBz-0004OF-Bo
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:30:56 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:34094 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZhBy-0004Nv-Rl
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:30:51 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 24 Jul 2017 20:30:41 +0300
Message-Id: <150091744146.30739.9284399356256394869.stgit@frigg.lan>
In-Reply-To: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/13] instrument: Add generic command line
 library loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 instrument/Makefile.objs |    1=20
 instrument/cmdline.c     |  117 ++++++++++++++++++++++++++++++++++++++++=
++++++
 instrument/cmdline.h     |   58 +++++++++++++++++++++++
 3 files changed, 176 insertions(+)
 create mode 100644 instrument/cmdline.c
 create mode 100644 instrument/cmdline.h

diff --git a/instrument/Makefile.objs b/instrument/Makefile.objs
index 244936aa8c..aa6db29ff4 100644
--- a/instrument/Makefile.objs
+++ b/instrument/Makefile.objs
@@ -43,3 +43,4 @@ $(obj)/qemu-instr/events.h-timestamp: $(BUILD_DIR)/trac=
e-events-all $(BUILD_DIR)
 # Control code
=20
 target-obj-y +=3D control.o
+target-obj-y +=3D cmdline.o
diff --git a/instrument/cmdline.c b/instrument/cmdline.c
new file mode 100644
index 0000000000..e0c0e9ce1b
--- /dev/null
+++ b/instrument/cmdline.c
@@ -0,0 +1,117 @@
+/*
+ * Control dynamic trace instrumentation during program (de)initializati=
on.
+ *
+ * Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <dlfcn.h>
+#include "instrument/cmdline.h"
+#include "instrument/control.h"
+#include "qemu/config-file.h"
+#include "qemu/error-report.h"
+
+
+QemuOptsList qemu_instr_opts =3D {
+    .name =3D "instrument",
+    .implied_opt_name =3D "file",
+    .merge_lists =3D true,
+    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_instr_opts.head),
+    .desc =3D {
+        {
+            .name =3D "file",
+            .type =3D QEMU_OPT_STRING,
+        },{
+            .name =3D "arg",
+            .type =3D QEMU_OPT_STRING,
+        },
+        { /* end of list */ }
+    },
+};
+
+void instr_opt_parse(const char *optarg, char **path,
+                     int *argc, const char ***argv)
+{
+    const char *arg;
+    QemuOptsIter iter;
+    QemuOpts *opts =3D qemu_opts_parse_noisily(qemu_find_opts("instrumen=
t"),
+                                             optarg, true);
+    if (!opts) {
+        exit(1);
+    } else {
+#if !defined(CONFIG_INSTRUMENT)
+        error_report("instrumentation not enabled on this build");
+        exit(1);
+#endif
+    }
+
+
+    arg =3D qemu_opt_get(opts, "file");
+    if (arg !=3D NULL) {
+        g_free(*path);
+        *path =3D g_strdup(arg);
+    }
+
+    qemu_opt_iter_init(&iter, opts, "arg");
+    while ((arg =3D qemu_opt_iter_next(&iter)) !=3D NULL) {
+        *argv =3D realloc(*argv, sizeof(**argv) * (*argc + 1));
+        (*argv)[*argc] =3D g_strdup(arg);
+        (*argc)++;
+    }
+
+    qemu_opts_del(opts);
+}
+
+
+void instr_init(const char *path, int argc, const char **argv)
+{
+    InstrLoadError err;
+    int64_t handle;
+
+    if (path =3D=3D NULL) {
+        return;
+    }
+
+    if (atexit(instr_fini) !=3D 0) {
+        fprintf(stderr, "error: atexit: %s\n", strerror(errno));
+        abort();
+    }
+
+    err =3D instr_load(path, argc, argv, &handle);
+    switch (err) {
+    case INSTR_LOAD_OK:
+        return;
+    case INSTR_LOAD_UNAVAILABLE:
+        error_report("instrument: not available");
+        break;
+    case INSTR_LOAD_ERROR:
+        error_report("instrument: error loading library: %s", dlerror())=
;
+        break;
+    }
+
+    exit(1);
+}
+
+void instr_fini(void)
+{
+    InstrUnloadError err =3D instr_unload_all();
+
+    switch (err) {
+    case INSTR_UNLOAD_OK:
+        return;
+    case INSTR_UNLOAD_UNAVAILABLE:
+        error_report("instrument: not available");
+        break;
+    case INSTR_UNLOAD_INVALID:
+        /* the user might have already unloaded it */
+        return;
+    case INSTR_UNLOAD_ERROR:
+        error_report("instrument: error unloading library: %s", dlerror(=
));
+        break;
+    }
+
+    exit(1);
+}
diff --git a/instrument/cmdline.h b/instrument/cmdline.h
new file mode 100644
index 0000000000..c5eebf8b58
--- /dev/null
+++ b/instrument/cmdline.h
@@ -0,0 +1,58 @@
+/*
+ * Control dynamic trace instrumentation during program (de)initializati=
on.
+ *
+ * Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef INSTRUMENT__CMDLINE_H
+#define INSTRUMENT__CMDLINE_H
+
+
+/**
+ * Definition of QEMU options describing instrumentation subsystem
+ * configuration.
+ */
+extern QemuOptsList qemu_instr_opts;
+
+/**
+ * instr_opt_parse:
+ * @optarg: A string argument of --instrument command line argument
+ *
+ * Initialize instrument subsystem.
+ */
+void instr_opt_parse(const char *optarg, char **path,
+                     int *argc, const char ***argv);
+
+/**
+ * instr_init:
+ * @path: Path to dynamic trace instrumentation library.
+ * @argc: Number of arguments to the library's #qi_init routine.
+ * @argv: Arguments to the library's #qi_init routine.
+ *
+ * Load and initialize the given instrumentation library.
+ *
+ * Automatically installs #instr_fini as an atexit callback.
+ *
+ * If path is %NULL and we're running with static instrumentation, the l=
ibrary
+ * is not loaded but just initialized.
+ *
+ * Pre-condition: There is no library already loaded.
+ */
+void instr_init(const char *path, int argc, const char **argv);
+
+/**
+ * instr_fini:
+ *
+ * Deinitialize and unload the current instrumentation library.
+ *
+ * If we're running with static instrumentation, the library is not unlo=
aded but
+ * just deinitialized.
+ *
+ * Pre-condition: There is an already loaded library.
+ */
+void instr_fini(void);
+
+#endif  /* INSTRUMENT__CMDLINE_H */
