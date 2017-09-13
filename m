Received: from eggs.gnu.org ([2001:4830:134:3::10]:38220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4YW-0004Ft-4R
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4YS-0006K4-1j
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:06:04 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:58599)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4YR-0006HV-F9
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:05:59 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 13 Sep 2017 13:05:49 +0300
Message-Id: <150529714885.10902.868327643224070834.stgit@frigg.lan>
In-Reply-To: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 03/22] instrument: Add generic library loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 MAINTAINERS              |    1=20
 Makefile.objs            |    4 +
 configure                |    3 +
 instrument/Makefile.objs |    4 +
 instrument/cmdline.c     |  128 +++++++++++++++++++++++++++++++++++
 instrument/cmdline.h     |   51 ++++++++++++++
 instrument/load.c        |  166 ++++++++++++++++++++++++++++++++++++++++=
++++++
 instrument/load.h        |   88 ++++++++++++++++++++++++
 stubs/Makefile.objs      |    1=20
 stubs/instrument.c       |   18 +++++
 10 files changed, 464 insertions(+)
 create mode 100644 instrument/Makefile.objs
 create mode 100644 instrument/cmdline.c
 create mode 100644 instrument/cmdline.h
 create mode 100644 instrument/load.c
 create mode 100644 instrument/load.h
 create mode 100644 stubs/instrument.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fb0eaee06a..6c0b12a69a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1491,6 +1491,7 @@ M: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
 M: Stefan Hajnoczi <stefanha@redhat.com>
 S: Maintained
 F: docs/instrument.txt
+F: instrument/
=20
 TPM
 S: Orphan
diff --git a/Makefile.objs b/Makefile.objs
index 24a4ea08b8..81a9218e14 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -97,6 +97,10 @@ version-obj-$(CONFIG_WIN32) +=3D $(BUILD_DIR)/version.=
o
 util-obj-y +=3D  trace/
 target-obj-y +=3D trace/
=20
+######################################################################
+# instrument
+target-obj-y +=3D instrument/
+
 ######################################################################
 # guest agent
=20
diff --git a/configure b/configure
index a21d1bceb9..5175151317 100755
--- a/configure
+++ b/configure
@@ -6025,6 +6025,9 @@ fi
 echo "CONFIG_TRACE_FILE=3D$trace_file" >> $config_host_mak
=20
 if test "$instrument" =3D "yes"; then
+  LDFLAGS=3D"-rdynamic $LDFLAGS"          # limit symbols available to c=
lients
+  QEMU_CFLAGS=3D"-fvisibility=3Dhidden $QEMU_CFLAGS"
+  LIBS=3D"-ldl $LIBS"
   echo "CONFIG_INSTRUMENT=3Dy" >> $config_host_mak
 fi
=20
diff --git a/instrument/Makefile.objs b/instrument/Makefile.objs
new file mode 100644
index 0000000000..71994a4c85
--- /dev/null
+++ b/instrument/Makefile.objs
@@ -0,0 +1,4 @@
+# -*- mode: makefile -*-
+
+target-obj-$(CONFIG_INSTRUMENT) +=3D cmdline.o
+target-obj-$(CONFIG_INSTRUMENT) +=3D load.o
diff --git a/instrument/cmdline.c b/instrument/cmdline.c
new file mode 100644
index 0000000000..da7a7cbceb
--- /dev/null
+++ b/instrument/cmdline.c
@@ -0,0 +1,128 @@
+/*
+ * Control instrumentation during program (de)initialization.
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
+#include "instrument/load.h"
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
+void instr_init(const char *path, int argc, const char **argv)
+{
+#if defined(CONFIG_INSTRUMENT)
+    InstrLoadError err;
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
+    const char *id =3D "cmdline";
+    err =3D instr_load(path, argc, argv, &id);
+    switch (err) {
+    case INSTR_LOAD_OK:
+        error_report("instrument: loaded library with ID '%s'", id);
+        return;
+    case INSTR_LOAD_TOO_MANY:
+        error_report("instrument: tried to load too many libraries");
+        break;
+    case INSTR_LOAD_ID_EXISTS:
+        g_assert_not_reached();
+        break;
+    case INSTR_LOAD_ERROR:
+        error_report("instrument: library initialization returned non-ze=
ro");
+        break;
+    case INSTR_LOAD_DLERROR:
+        error_report("instrument: error loading library: %s", dlerror())=
;
+        break;
+    }
+#else
+    error_report("instrument: not available");
+#endif
+
+    exit(1);
+}
+
+void instr_fini(void)
+{
+#if defined(CONFIG_INSTRUMENT)
+    InstrUnloadError err =3D instr_unload_all();
+
+    switch (err) {
+    case INSTR_UNLOAD_OK:
+        return;
+    case INSTR_UNLOAD_INVALID:
+        /* the user might have already unloaded it */
+        return;
+    case INSTR_UNLOAD_DLERROR:
+        error_report("instrument: error unloading library: %s", dlerror(=
));
+        break;
+    }
+#else
+    error_report("instrument: not available");
+#endif
+
+    exit(1);
+}
diff --git a/instrument/cmdline.h b/instrument/cmdline.h
new file mode 100644
index 0000000000..3734f5f438
--- /dev/null
+++ b/instrument/cmdline.h
@@ -0,0 +1,51 @@
+/*
+ * Control instrumentation during program (de)initialization.
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
+#include "qemu/typedefs.h"
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
+ * Load and initialize the given instrumentation library. Calls exit() i=
f the
+ * library's initialization function returns a non-zero value.
+ *
+ * Installs instr_fini() as an atexit() callback.
+ */
+void instr_init(const char *path, int argc, const char **argv);
+
+/**
+ * instr_fini:
+ *
+ * Deinitialize and unload all instrumentation libraries.
+ */
+void instr_fini(void);
+
+#endif  /* INSTRUMENT__CMDLINE_H */
diff --git a/instrument/load.c b/instrument/load.c
new file mode 100644
index 0000000000..af98f4ce38
--- /dev/null
+++ b/instrument/load.c
@@ -0,0 +1,166 @@
+/*
+ * Interface for (un)loading instrumentation libraries.
+ *
+ * Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include <dlfcn.h>
+#include "instrument/load.h"
+#include "qemu/config-file.h"
+#include "qemu/error-report.h"
+
+
+typedef struct InstrHandle {
+    char *id;
+    void *dlhandle;
+    QLIST_ENTRY(InstrHandle) list;
+} InstrHandle;
+
+
+static unsigned int handle_auto_id;
+static QLIST_HEAD(, InstrHandle) handles =3D QLIST_HEAD_INITIALIZER(hand=
les);
+static QemuMutex instr_lock;
+
+
+static InstrHandle *handle_new(const char **id)
+{
+    /* instr_lock is locked */
+    InstrHandle *res =3D g_malloc0(sizeof(InstrHandle));
+    if (!*id) {
+        *id =3D g_strdup_printf("lib%d", handle_auto_id);
+        handle_auto_id++;
+    }
+    res->id =3D g_strdup(*id);
+    QLIST_INSERT_HEAD(&handles, res, list);
+    return res;
+}
+
+static void handle_destroy(InstrHandle *handle)
+{
+    /* instr_lock is locked */
+    QLIST_REMOVE(handle, list);
+    g_free(handle->id);
+    g_free(handle);
+}
+
+static InstrHandle *handle_find(const char *id)
+{
+    /* instr_lock is locked */
+    InstrHandle *handle;
+    QLIST_FOREACH(handle, &handles, list) {
+        if (strcmp(handle->id, id) =3D=3D 0) {
+            return handle;
+        }
+    }
+    return NULL;
+}
+
+InstrLoadError instr_load(const char *path, int argc, const char **argv,
+                          const char **id)
+{
+    InstrLoadError res;
+    InstrHandle *handle;
+    int (*main_cb)(int, const char **);
+    int main_res;
+
+    qemu_rec_mutex_lock(&instr_lock);
+
+    if (*id && handle_find(*id)) {
+        res =3D INSTR_LOAD_ID_EXISTS;
+        goto out;
+    }
+
+    if (!QLIST_EMPTY(&handles) > 0) {
+        /* XXX: This is in fact a hard-coded limit, but there's no reaso=
n why a
+         *      real multi-library implementation should fail.
+         */
+        res =3D INSTR_LOAD_TOO_MANY;
+        goto out;
+    }
+
+    handle =3D handle_new(id);
+    handle->dlhandle =3D dlopen(path, RTLD_NOW);
+    if (handle->dlhandle =3D=3D NULL) {
+        res =3D INSTR_LOAD_DLERROR;
+        goto err;
+    }
+
+    main_cb =3D dlsym(handle->dlhandle, "main");
+    if (main_cb =3D=3D NULL) {
+        res =3D INSTR_LOAD_DLERROR;
+        goto err;
+    }
+
+    main_res =3D main_cb(argc, argv);
+
+    if (main_res !=3D 0) {
+        res =3D INSTR_LOAD_ERROR;
+        goto err;
+    }
+
+    res =3D INSTR_LOAD_OK;
+    goto out;
+
+err:
+    handle_destroy(handle);
+out:
+    qemu_rec_mutex_unlock(&instr_lock);
+    return res;
+}
+
+InstrUnloadError instr_unload(const char *id)
+{
+    InstrUnloadError res;
+
+    qemu_rec_mutex_lock(&instr_lock);
+
+    InstrHandle *handle =3D handle_find(id);
+    if (handle =3D=3D NULL) {
+        res =3D INSTR_UNLOAD_INVALID;
+        goto out;
+    }
+
+    /* this should never fail */
+    if (dlclose(handle->dlhandle) < 0) {
+        res =3D INSTR_UNLOAD_DLERROR;
+    } else {
+        res =3D INSTR_UNLOAD_OK;
+    }
+    handle_destroy(handle);
+
+out:
+    qemu_rec_mutex_unlock(&instr_lock);
+    return res;
+}
+
+InstrUnloadError instr_unload_all(void)
+{
+    InstrUnloadError res =3D INSTR_UNLOAD_OK;
+
+    qemu_rec_mutex_lock(&instr_lock);
+    while (true) {
+        InstrHandle *handle =3D QLIST_FIRST(&handles);
+        if (handle =3D=3D NULL) {
+            break;
+        } else {
+            res =3D instr_unload(handle->id);
+            if (res !=3D INSTR_UNLOAD_OK) {
+                break;
+            }
+        }
+    }
+    qemu_rec_mutex_unlock(&instr_lock);
+
+    return res;
+}
+
+static void __attribute__((constructor)) instr_lock_init(void)
+{
+    qemu_rec_mutex_init(&instr_lock);
+}
diff --git a/instrument/load.h b/instrument/load.h
new file mode 100644
index 0000000000..162e09f9c9
--- /dev/null
+++ b/instrument/load.h
@@ -0,0 +1,88 @@
+/*
+ * Interface for (un)loading instrumentation libraries.
+ *
+ * Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+
+#ifndef INSTRUMENT_LOAD_H
+#define INSTRUMENT_LOAD_H
+
+#include "qemu/osdep.h"
+
+#include "qapi-types.h"
+#include "qemu/queue.h"
+#include "qemu/thread.h"
+
+
+/**
+ * InstrLoadError:
+ * @INSTR_LOAD_OK: Correctly loaded.
+ * @INSTR_LOAD_ID_EXISTS: Tried to load an instrumentation libraries wit=
h an
+ *     existing ID.
+ * @INSTR_LOAD_TOO_MANY: Tried to load too many instrumentation librarie=
s.
+ * @INSTR_LOAD_ERROR: The library's main() function returned a non-zero =
value.
+ * @INSTR_LOAD_DLERROR: Error with libdl (see dlerror).
+ *
+ * Error codes for instr_load().
+ */
+typedef enum {
+    INSTR_LOAD_OK,
+    INSTR_LOAD_ID_EXISTS,
+    INSTR_LOAD_TOO_MANY,
+    INSTR_LOAD_ERROR,
+    INSTR_LOAD_DLERROR,
+} InstrLoadError;
+
+/**
+ * InstrUnloadError:
+ * @INSTR_UNLOAD_OK: Correctly unloaded.
+ * @INSTR_UNLOAD_INVALID: Invalid handle.
+ * @INSTR_UNLOAD_DLERROR: Error with libdl (see dlerror).
+ *
+ * Error codes for instr_unload().
+ */
+typedef enum {
+    INSTR_UNLOAD_OK,
+    INSTR_UNLOAD_INVALID,
+    INSTR_UNLOAD_DLERROR,
+} InstrUnloadError;
+
+/**
+ * instr_load:
+ * @path: Path to the shared library to load.
+ * @argc: Number of arguments passed to the initialization function of t=
he
+ *     library.
+ * @argv: Arguments passed to the initialization function of the library.
+ * @id: Instrumentation library id.
+ *
+ * Load a dynamic trace instrumentation library.
+ *
+ * Returns: Whether the library could be loaded.
+ */
+InstrLoadError instr_load(const char *path, int argc, const char **argv,
+                          const char **id);
+
+/**
+ * instr_unload:
+ * @id: Instrumentation library id passed to instr_load().
+ *
+ * Unload the given instrumentation library.
+ *
+ * Returns: Whether the library could be unloaded.
+ */
+InstrUnloadError instr_unload(const char *id);
+
+/**
+ * instr_unload_all:
+ *
+ * Unload all instrumentation libraries.
+ *
+ * Returns: Whether any library could not be unloaded.
+ */
+InstrUnloadError instr_unload_all(void);
+
+#endif  /* INSTRUMENT_LOAD_H */
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 4a33495911..4bf342cb96 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -13,6 +13,7 @@ stub-obj-y +=3D error-printf.o
 stub-obj-y +=3D fdset.o
 stub-obj-y +=3D gdbstub.o
 stub-obj-y +=3D get-vm-name.o
+stub-obj-y +=3D instrument.o
 stub-obj-y +=3D iothread.o
 stub-obj-y +=3D iothread-lock.o
 stub-obj-y +=3D is-daemonized.o
diff --git a/stubs/instrument.c b/stubs/instrument.c
new file mode 100644
index 0000000000..7d66f75454
--- /dev/null
+++ b/stubs/instrument.c
@@ -0,0 +1,18 @@
+/*
+ * Instrumentation placeholders.
+ *
+ * Copyright (C) 2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "instrument/cmdline.h"
+
+
+void instr_init(const char *path, int argc, const char **argv)
+{
+}
+void instr_fini(void)
+{
+}
