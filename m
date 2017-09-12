Received: from eggs.gnu.org ([2001:4830:134:3::10]:41602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drsst-00080W-3w
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drssn-0000QA-S7
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:38:19 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:54629)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drssn-0000OP-CA
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:38:13 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 13 Sep 2017 00:38:03 +0300
Message-Id: <150525228289.15988.9844115871305476442.stgit@frigg.lan>
In-Reply-To: <150525010239.15988.8172586618197849619.stgit@frigg.lan>
References: <150525010239.15988.8172586618197849619.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 09/22] instrument: Add basic control
 interface
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
 Makefile                        |    4 +++
 configure                       |    1 +
 include/qemu/compiler.h         |   19 ++++++++++++++++
 instrument/Makefile.objs        |    1 +
 instrument/control.c            |   28 ++++++++++++++++++++++++
 instrument/control.h            |   44 +++++++++++++++++++++++++++++++++=
++++
 instrument/control.inc.h        |   25 +++++++++++++++++++++
 instrument/error.h              |   28 ++++++++++++++++++++++++
 instrument/events.h             |   37 +++++++++++++++++++++++++++++++
 instrument/events.inc.h         |   11 +++++++++
 instrument/load.c               |   13 +++++++++++
 instrument/qemu-instr/control.h |   46 +++++++++++++++++++++++++++++++++=
++++++
 stubs/instrument.c              |    4 +++
 13 files changed, 261 insertions(+)
 create mode 100644 instrument/control.c
 create mode 100644 instrument/control.h
 create mode 100644 instrument/control.inc.h
 create mode 100644 instrument/error.h
 create mode 100644 instrument/events.h
 create mode 100644 instrument/events.inc.h
 create mode 100644 instrument/qemu-instr/control.h

diff --git a/Makefile b/Makefile
index 3861b3f49c..c3d9a4bcd9 100644
--- a/Makefile
+++ b/Makefile
@@ -599,6 +599,10 @@ ifdef CONFIG_VIRTFS
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DATA) fsdev/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man1"
 endif
+ifdef CONFIG_INSTRUMENT
+	$(INSTALL_DIR) "$(DESTDIR)$(includedir)/qemu-instr/"
+	$(INSTALL_DATA) $(SRC_PATH)/instrument/qemu-instr/control.h "$(DESTDIR)=
$(includedir)/qemu-instr/"
+endif
=20
 install-datadir:
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"
diff --git a/configure b/configure
index 5175151317..18810eae84 100755
--- a/configure
+++ b/configure
@@ -6030,6 +6030,7 @@ if test "$instrument" =3D "yes"; then
   LIBS=3D"-ldl $LIBS"
   echo "CONFIG_INSTRUMENT=3Dy" >> $config_host_mak
 fi
+QEMU_INCLUDES=3D"-I\$(SRC_PATH)/instrument $QEMU_INCLUDES"
=20
 if test "$rdma" =3D "yes" ; then
   echo "CONFIG_RDMA=3Dy" >> $config_host_mak
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 340e5fdc09..e86bd34e2c 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -111,4 +111,23 @@
 #define GCC_FMT_ATTR(n, m)
 #endif
=20
+/*
+ * Export symbol to dlopen()'ed libraries'.
+ *
+ * This code is taken from http://gcc.gnu.org/wiki/Visibility.
+ */
+#if defined _WIN32 || defined __CYGWIN__
+  #ifdef __GNUC__
+    #define SYM_PUBLIC __attribute__ ((dllimport))
+  #else
+    #define SYM_PUBLIC __declspec(dllimport)
+  #endif
+#else
+  #if __GNUC__ >=3D 4
+    #define SYM_PUBLIC __attribute__ ((visibility("default")))
+  #else
+    #define SYM_PUBLIC
+  #endif
+#endif
+
 #endif /* COMPILER_H */
diff --git a/instrument/Makefile.objs b/instrument/Makefile.objs
index 7bf4e27e3c..ec76b2080b 100644
--- a/instrument/Makefile.objs
+++ b/instrument/Makefile.objs
@@ -3,3 +3,4 @@
 target-obj-$(CONFIG_INSTRUMENT) +=3D cmdline.o
 target-obj-$(CONFIG_INSTRUMENT) +=3D load.o
 target-obj-$(CONFIG_INSTRUMENT) +=3D qmp.o
+target-obj-$(CONFIG_INSTRUMENT) +=3D control.o
diff --git a/instrument/control.c b/instrument/control.c
new file mode 100644
index 0000000000..3630d6b3be
--- /dev/null
+++ b/instrument/control.c
@@ -0,0 +1,28 @@
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
+#include "instrument/control.h"
+#include "instrument/error.h"
+#include "instrument/events.h"
+#include "instrument/load.h"
+#include "instrument/qemu-instr/control.h"
+#include "qemu/compiler.h"
+
+__thread InstrState instr_cur_state;
+
+
+qi_fini_fn instr_event__fini_fn;
+void *instr_event__fini_data;
+
+SYM_PUBLIC void qi_set_fini(qi_fini_fn fn, void *data)
+{
+    ERROR_IF(!instr_get_state(), "called outside instrumentation");
+    instr_set_event(fini_fn, fn);
+    instr_set_event(fini_data, data);
+}
diff --git a/instrument/control.h b/instrument/control.h
new file mode 100644
index 0000000000..f2b085f69b
--- /dev/null
+++ b/instrument/control.h
@@ -0,0 +1,44 @@
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
+#ifndef INSTRUMENT__CONTROL_H
+#define INSTRUMENT__CONTROL_H
+
+
+/**
+ * InstrState:
+ * @INSTR_STATE_DISABLE: Intrumentation API not available.
+ * @INSTR_STATE_ENABLE: Intrumentation API available.
+ *
+ * Instrumentation state of current host thread. Used to ensure instrume=
ntation
+ * clients use QEMU's API only in expected points.
+ */
+typedef enum {
+    INSTR_STATE_DISABLE,
+    INSTR_STATE_ENABLE,
+} InstrState;
+
+/**
+ * instr_set_state:
+ *
+ * Set the instrumentation state of the current host thread.
+ */
+static inline void instr_set_state(InstrState state);
+
+/**
+ * instr_get_state:
+ *
+ * Get the instrumentation state of the current host thread.
+ */
+static inline InstrState instr_get_state(void);
+
+
+#include "instrument/control.inc.h"
+
+#endif  /* INSTRUMENT__CONTROL_H */
diff --git a/instrument/control.inc.h b/instrument/control.inc.h
new file mode 100644
index 0000000000..0f649f4caa
--- /dev/null
+++ b/instrument/control.inc.h
@@ -0,0 +1,25 @@
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
+#include "qemu/atomic.h"
+#include "qemu/compiler.h"
+#include <stdbool.h>
+
+
+extern __thread InstrState instr_cur_state;
+
+static inline void instr_set_state(InstrState state)
+{
+    atomic_store_release(&instr_cur_state, state);
+}
+
+static inline InstrState instr_get_state(void)
+{
+    return atomic_load_acquire(&instr_cur_state);
+}
diff --git a/instrument/error.h b/instrument/error.h
new file mode 100644
index 0000000000..f8d1dd4b16
--- /dev/null
+++ b/instrument/error.h
@@ -0,0 +1,28 @@
+/*
+ * Helpers for controlling errors in instrumentation libraries.
+ *
+ * Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef INSTRUMENT_ERROR_H
+#define INSTRUMENT_ERROR_H
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+
+
+#define _ERROR(msg, args...)                            \
+    do {                                                \
+        error_report("%s:" msg, __func__, ##args);      \
+    } while (0)
+
+#define ERROR_IF(cond, msg, args...) \
+    if (unlikely(cond)) {            \
+        _ERROR(msg, ##args);         \
+        return;                      \
+    }
+
+#endif  /* INSTRUMENT_ERROR_H */
diff --git a/instrument/events.h b/instrument/events.h
new file mode 100644
index 0000000000..82ad0bd827
--- /dev/null
+++ b/instrument/events.h
@@ -0,0 +1,37 @@
+/*
+ * Internal API for triggering instrumentation events.
+ *
+ * Copyright (C) 2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef INSTRUMENT__EVENTS_H
+#define INSTRUMENT__EVENTS_H
+
+#include "instrument/qemu-instr/control.h"
+
+/**
+ * instr_get_event:
+ *
+ * Get value set by instrumentation library.
+ */
+#define instr_get_event(name)                   \
+    atomic_load_acquire(&instr_event__ ## name)
+
+/**
+ * instr_get_event:
+ *
+ * Set value from instrumentation library.
+ */
+#define instr_set_event(name, fn)               \
+    atomic_store_release(&instr_event__ ## name, fn)
+
+
+extern qi_fini_fn instr_event__fini_fn;
+extern void *instr_event__fini_data;
+
+#include "instrument/events.inc.h"
+
+#endif  /* INSTRUMENT__EVENTS_H */
diff --git a/instrument/events.inc.h b/instrument/events.inc.h
new file mode 100644
index 0000000000..8b1ce7fcb2
--- /dev/null
+++ b/instrument/events.inc.h
@@ -0,0 +1,11 @@
+/*
+ * Internal API for triggering instrumentation events.
+ *
+ * Copyright (C) 2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+
+
diff --git a/instrument/load.c b/instrument/load.c
index af98f4ce38..a01d66a4d4 100644
--- a/instrument/load.c
+++ b/instrument/load.c
@@ -11,6 +11,8 @@
 #include "qemu-common.h"
=20
 #include <dlfcn.h>
+#include "instrument/control.h"
+#include "instrument/events.h"
 #include "instrument/load.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
@@ -96,8 +98,11 @@ InstrLoadError instr_load(const char *path, int argc, =
const char **argv,
         res =3D INSTR_LOAD_DLERROR;
         goto err;
     }
+    instr_set_event(fini_fn, NULL);
=20
+    instr_set_state(INSTR_STATE_ENABLE);
     main_res =3D main_cb(argc, argv);
+    instr_set_state(INSTR_STATE_DISABLE);
=20
     if (main_res !=3D 0) {
         res =3D INSTR_LOAD_ERROR;
@@ -126,6 +131,14 @@ InstrUnloadError instr_unload(const char *id)
         goto out;
     }
=20
+    qi_fini_fn fini_fn =3D instr_get_event(fini_fn);
+    if (fini_fn) {
+        void *fini_data =3D instr_get_event(fini_data);
+        fini_fn(fini_data);
+    }
+
+    instr_set_event(fini_fn, NULL);
+
     /* this should never fail */
     if (dlclose(handle->dlhandle) < 0) {
         res =3D INSTR_UNLOAD_DLERROR;
diff --git a/instrument/qemu-instr/control.h b/instrument/qemu-instr/cont=
rol.h
new file mode 100644
index 0000000000..b841afaa31
--- /dev/null
+++ b/instrument/qemu-instr/control.h
@@ -0,0 +1,46 @@
+/*
+ * Main instrumentation interface for QEMU.
+ *
+ * Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QI__CONTROL_H
+#define QI__CONTROL_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <stdbool.h>
+#include <stddef.h>
+
+
+/**
+ * SECTION:control
+ * @section_id: qi-control
+ * @title: Event control API for QEMU event instrumentation
+ */
+
+typedef void (*qi_fini_fn)(void *arg);
+
+/**
+ * qi_set_fini:
+ * @fn: Finalization function.
+ * @data: Argument to pass to the finalization function.
+ *
+ * Set the function to call when finalizing (unloading) the instrumentat=
ion
+ * library.
+ *
+ * NOTE: Calls to printf() might not be shown if the library is unloaded=
 when
+ *       QEMU terminates.
+ */
+void qi_set_fini(qi_fini_fn fn, void *data);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif  /* QI__CONTROL_H */
diff --git a/stubs/instrument.c b/stubs/instrument.c
index 79cd0fd2d1..9498fcdfe5 100644
--- a/stubs/instrument.c
+++ b/stubs/instrument.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
=20
 #include "instrument/cmdline.h"
+#include "instrument/control.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
=20
@@ -42,3 +43,6 @@ void qmp_instr_unload(const char *id, Error **errp)
 {
     error_setg(errp, QERR_UNSUPPORTED);
 }
+
+
+__thread InstrState instr_cur_state;
