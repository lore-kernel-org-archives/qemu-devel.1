Received: from eggs.gnu.org ([2001:4830:134:3::10]:44471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpebf-0003RH-96
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpebZ-0007p4-KB
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:59:19 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:38567)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpebZ-0007no-0L
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:59:13 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed,  6 Sep 2017 20:59:02 +0300
Message-Id: <150472074219.24907.5510718414753398145.stgit@frigg.lan>
In-Reply-To: <150471856141.24907.274176769201097378.stgit@frigg.lan>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 09/20] instrument: Add basic control
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
Cc: Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 Makefile                           |    5 +++
 configure                          |    1 +
 instrument/Makefile.objs           |    2 +
 instrument/control.c               |   28 +++++++++++++++++
 instrument/control.h               |   44 +++++++++++++++++++++++++++
 instrument/control.inc.h           |   25 ++++++++++++++++
 instrument/error.h                 |   28 +++++++++++++++++
 instrument/events.h                |   37 +++++++++++++++++++++++
 instrument/events.inc.h            |   11 +++++++
 instrument/load.c                  |   13 ++++++++
 instrument/qemu-instr/control.h    |   43 +++++++++++++++++++++++++++
 instrument/qemu-instr/visibility.h |   58 ++++++++++++++++++++++++++++++=
++++++
 stubs/Makefile.objs                |    1 +
 stubs/instrument.c                 |   13 ++++++++
 14 files changed, 309 insertions(+)
 create mode 100644 instrument/control.c
 create mode 100644 instrument/control.h
 create mode 100644 instrument/control.inc.h
 create mode 100644 instrument/error.h
 create mode 100644 instrument/events.h
 create mode 100644 instrument/events.inc.h
 create mode 100644 instrument/qemu-instr/control.h
 create mode 100644 instrument/qemu-instr/visibility.h
 create mode 100644 stubs/instrument.c

diff --git a/Makefile b/Makefile
index 81447b1f08..6171661458 100644
--- a/Makefile
+++ b/Makefile
@@ -589,6 +589,11 @@ ifdef CONFIG_VIRTFS
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DATA) fsdev/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man1"
 endif
+ifdef CONFIG_INSTRUMENT
+	$(INSTALL_DIR) "$(DESTDIR)$(includedir)/qemu-instr/"
+	$(INSTALL_DATA) $(SRC_PATH)/instrument/qemu-instr/control.h "$(DESTDIR)=
$(includedir)/qemu-instr/"
+	$(INSTALL_DATA) $(SRC_PATH)/instrument/qemu-instr/visibility.h "$(DESTD=
IR)$(includedir)/qemu-instr/"
+endif
=20
 install-datadir:
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"
diff --git a/configure b/configure
index 05bd7b1950..3673fc9058 100755
--- a/configure
+++ b/configure
@@ -6038,6 +6038,7 @@ if test "$instrument" =3D "yes"; then
   LIBS=3D"-ldl $LIBS"
   echo "CONFIG_INSTRUMENT=3Dy" >> $config_host_mak
 fi
+QEMU_INCLUDES=3D"-I\$(SRC_PATH)/instrument $QEMU_INCLUDES"
=20
 if test "$rdma" =3D "yes" ; then
   echo "CONFIG_RDMA=3Dy" >> $config_host_mak
diff --git a/instrument/Makefile.objs b/instrument/Makefile.objs
index 13a8f60431..9b7e1c03aa 100644
--- a/instrument/Makefile.objs
+++ b/instrument/Makefile.objs
@@ -3,3 +3,5 @@
 target-obj-y +=3D cmdline.o
 target-obj-$(CONFIG_INSTRUMENT) +=3D load.o
 target-obj-y +=3D qmp.o
+
+target-obj-$(CONFIG_INSTRUMENT) +=3D control.o
diff --git a/instrument/control.c b/instrument/control.c
new file mode 100644
index 0000000000..2c2781beeb
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
+#include "instrument/qemu-instr/visibility.h"
+
+__thread InstrState instr_cur_state;
+
+
+qi_fini_fn instr_event__fini_fn;
+void *instr_event__fini_data;
+
+QI_VPUBLIC void qi_set_fini(qi_fini_fn fn, void *data)
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
index a57401102a..e180f03429 100644
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
@@ -105,8 +107,11 @@ InstrLoadError instr_load(const char * path, int arg=
c, const char ** argv,
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
@@ -136,6 +141,14 @@ InstrUnloadError instr_unload(int64_t handle_id)
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
index 0000000000..f6e289daa0
--- /dev/null
+++ b/instrument/qemu-instr/control.h
@@ -0,0 +1,43 @@
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
+ */
+void qi_set_fini(qi_fini_fn fn, void *data);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif  /* QI__CONTROL_H */
diff --git a/instrument/qemu-instr/visibility.h b/instrument/qemu-instr/v=
isibility.h
new file mode 100644
index 0000000000..305dddf7d8
--- /dev/null
+++ b/instrument/qemu-instr/visibility.h
@@ -0,0 +1,58 @@
+/*
+ * Macros for symbol visibility.
+ *
+ * Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory of QEMU.
+ */
+
+#ifndef QI__VISIBILITY_H
+#define QI__VISIBILITY_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * SECTION:visibility
+ * @section_id: qi-visibility
+ * @title: Symbol visibility
+ *
+ * This code is taken from http://gcc.gnu.org/wiki/Visibility.
+ */
+
+/**
+ * QI_VPUBLIC:
+ *
+ * Make an element public to user's instrumentation code.
+ */
+
+/**
+ * QI_VLOCAL:
+ *
+ * Make an element not visible to user's instrumentation code.
+ */
+
+#if defined _WIN32 || defined __CYGWIN__
+  #ifdef __GNUC__
+    #define QI_VPUBLIC __attribute__ ((dllimport))
+  #else
+    #define QI_VPUBLIC __declspec(dllimport)
+  #endif
+  #define QI_VLOCAL
+#else
+  #if __GNUC__ >=3D 4
+    #define QI_VPUBLIC __attribute__ ((visibility ("default")))
+    #define QI_VLOCAL  __attribute__ ((visibility ("hidden")))
+  #else
+    #define QI_VPUBLIC
+    #define QI_VLOCAL
+  #endif
+#endif
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif  /* QI__VISIBILITY_H */
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index e69c217aff..3aaec2d9dd 100644
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
index 0000000000..6731710fd5
--- /dev/null
+++ b/stubs/instrument.c
@@ -0,0 +1,13 @@
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
+#include "instrument/control.h"
+
+
+__thread InstrState instr_cur_state;
