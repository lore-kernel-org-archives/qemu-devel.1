Received: from eggs.gnu.org ([2001:4830:134:3::10]:58480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZh4G-00089T-LN
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZh4B-0007Dn-Pf
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:22:52 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:41378 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZh4B-0007DH-4D
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:22:47 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 24 Jul 2017 20:22:36 +0300
Message-Id: <150091695652.30739.17868656744714699780.stgit@frigg.lan>
In-Reply-To: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/13] instrument: [dynamic] Add default public
 per-event functions
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

For each event, adds a set of public routines available to instrumentatio=
n
clients:

* qi_event_*_nop:
  Do nothing (to disable an instrumentation event).

* qi_event_*_trace
  Trace event using QEMU's tracing system. Default for execution-time eve=
nts.

* qi_event_*_gen_exec
  Generate TCG code to raise the event at execution time. Only available =
for
  translation-time events.

* qi_event_*_trace_and_gen_exec
  Combination of qi_event_*_trace and qi_event_*_gen_exec. Only available=
 for
  translation-time events. Default for translation-time events.

The functions are defined for all events, regardless of whether they are
instrumented or disabled (used later).

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 .gitignore                                  |    1=20
 Makefile                                    |   14 +++++
 configure                                   |    2 +
 instrument/Makefile.objs                    |   14 +++++
 instrument/qemu-instr/types.h               |   73 +++++++++++++++++++++=
++
 instrument/qemu-instr/visibility-internal.h |   58 +++++++++++++++++++
 scripts/tracetool/__init__.py               |    4 +
 scripts/tracetool/backend/instr_dynamic.py  |   84 +++++++++++++++++++++=
++++++
 scripts/tracetool/backend/instr_none.py     |   18 ++++++
 scripts/tracetool/format/instr_api_h.py     |   65 +++++++++++++++++++++
 scripts/tracetool/format/instr_c.py         |    7 +-
 scripts/tracetool/format/instr_tcg_c.py     |    7 +-
 scripts/tracetool/format/tcg_helper_c.py    |    2 -
 scripts/tracetool/transform.py              |   13 ++++
 14 files changed, 351 insertions(+), 11 deletions(-)
 create mode 100644 instrument/qemu-instr/types.h
 create mode 100644 instrument/qemu-instr/visibility-internal.h
 create mode 100644 scripts/tracetool/format/instr_api_h.py

diff --git a/.gitignore b/.gitignore
index ee2768cb05..d3aa8286b0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -9,6 +9,7 @@
 /instrument-root.c
 /instrument/generated-tcg-tracers.h
 /instrument/generated-tcg-tracers.c
+/instrument/qemu-instr/events.h
 /trace-events-all
 /trace/generated-events.h
 /trace/generated-events.c
diff --git a/Makefile b/Makefile
index fb226bf54b..c8be326790 100644
--- a/Makefile
+++ b/Makefile
@@ -193,6 +193,9 @@ trace-dtrace-root.o: trace-dtrace-root.dtrace
=20
 INSTRUMENT_HEADERS =3D instrument-root.h $(trace-events-subdirs:%=3D%/in=
strument.h)
 INSTRUMENT_HEADERS +=3D instrument/generated-tcg-tracers.h
+ifeq ($(TRACE_INSTRUMENT_BACKEND),instr-dynamic)
+INSTRUMENT_HEADERS +=3D instrument/qemu-instr/events.h
+endif
 INSTRUMENT_SOURCES =3D instrument-root.c $(trace-events-subdirs:%=3D%/in=
strument.c)
 INSTRUMENT_SOURCES +=3D instrument/generated-tcg-tracers.c
=20
@@ -644,8 +647,13 @@ ifneq (,$(findstring qemu-ga,$(TOOLS)))
 endif
 endif
=20
+install-includedir:
+	$(INSTALL_DIR) "$(DESTDIR)$(includedir)"
=20
 install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-loc=
alstatedir
+ifeq ($(TRACE_INSTRUMENT_BACKEND),instr-dynamic)
+install: install-includedir
+endif
 ifneq ($(TOOLS),)
 	$(call install-prog,$(subst qemu-ga,qemu-ga$(EXESUF),$(TOOLS)),$(DESTDI=
R)$(bindir))
 endif
@@ -676,6 +684,12 @@ endif
 	for d in $(TARGET_DIRS); do \
 	$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=3D$$d/ -C $$d $@ || exit 1 ; \
         done
+ifeq ($(TRACE_INSTRUMENT_BACKEND),instr-dynamic)
+	$(INSTALL_DIR) "$(DESTDIR)$(includedir)/qemu-instr"
+	$(INSTALL_DATA) $(SRC_PATH)/instrument/qemu-instr/types.h "$(DESTDIR)$(=
includedir)/qemu-instr/"
+	$(INSTALL_DATA) $(SRC_PATH)/instrument/qemu-instr/visibility-internal.h=
 "$(DESTDIR)$(includedir)/qemu-instr/"
+	$(INSTALL_DATA) $(BUILD_DIR)/instrument/qemu-instr/events.h "$(DESTDIR)=
$(includedir)/qemu-instr/"
+endif
=20
 # various test targets
 test speed: all
diff --git a/configure b/configure
index 8ab2a36130..ca61665874 100755
--- a/configure
+++ b/configure
@@ -489,6 +489,8 @@ QEMU_CFLAGS=3D"-Wall -Wundef -Wwrite-strings -Wmissin=
g-prototypes $QEMU_CFLAGS"
 QEMU_CFLAGS=3D"-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
 QEMU_CFLAGS=3D"-D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURC=
E $QEMU_CFLAGS"
 QEMU_INCLUDES=3D"-I. -I\$(SRC_PATH) -I\$(SRC_PATH)/accel/tcg -I\$(SRC_PA=
TH)/include"
+QEMU_INCLUDES=3D"$QEMU_INCLUDES -I\$(SRC_PATH)/instrument"
+QEMU_INCLUDES=3D"$QEMU_INCLUDES -I\$(BUILD_DIR)/instrument"
 if test "$debug_info" =3D "yes"; then
     CFLAGS=3D"-g $CFLAGS"
     LDFLAGS=3D"-g $LDFLAGS"
diff --git a/instrument/Makefile.objs b/instrument/Makefile.objs
index c548bbdd8a..c2289aba85 100644
--- a/instrument/Makefile.objs
+++ b/instrument/Makefile.objs
@@ -24,3 +24,17 @@ $(obj)/generated-tcg-tracers.c-timestamp: $(SRC_PATH)/=
trace-events $(BUILD_DIR)/
 		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
=20
 target-obj-$(CONFIG_INSTRUMENT) +=3D generated-tcg-tracers.o
+
+######################################################################
+# User interface
+
+$(obj)/qemu-instr/events.h: $(obj)/qemu-instr/events.h-timestamp
+	@cmp -s $< $@ || cp $< $@
+$(obj)/qemu-instr/events.h-timestamp: $(BUILD_DIR)/trace-events-all $(BU=
ILD_DIR)/config-host.mak $(tracetool-y)
+	@mkdir -p $(dir $@)
+	$(call quiet-command,$(TRACETOOL) \
+		--group=3Droot \
+		--format=3Dinstr-api-h \
+		--backend=3D$(TRACE_INSTRUMENT_BACKEND) \
+		$(TRACETOOL_INSTR_STATIC) \
+		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
diff --git a/instrument/qemu-instr/types.h b/instrument/qemu-instr/types.=
h
new file mode 100644
index 0000000000..d3d26bbf73
--- /dev/null
+++ b/instrument/qemu-instr/types.h
@@ -0,0 +1,73 @@
+/*
+ * QI-specific types for instrumentation clients.
+ *
+ * Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QI__TYPES_H
+#define QI__TYPES_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * SECTION: types
+ * @section_id: qi-types
+ * @title: Common types
+ *
+ * Data of architecture-specific length is always passed as an #int64_t =
to
+ * provide binary compatibility between the instrumentation library and =
QEMU,
+ * regardless of the guest architecture being instrumented.
+ */
+
+/**
+ * QICPU:
+ *
+ * Opaque guest CPU pointer.
+ */
+typedef struct QICPU QICPU;
+
+/**
+ * QITCGv_cpu:
+ *
+ * TCG register with QICPU.
+ */
+typedef struct QITCGv_cpu_d *QITCGv_cpu;
+
+/**
+ * QITCGv:
+ *
+ * TCG register with data of architecture-specific length.
+ */
+typedef struct QITCGv_d *QITCGv;
+
+/**
+ * QITCGv_i32:
+ *
+ * TCG register with 32-bit data.
+ */
+typedef struct QITCGv_i32_d *QITCGv_i32;
+
+/**
+ * QITCGv_i64:
+ *
+ * TCG register with 64-bit data.
+ */
+typedef struct QITCGv_i64_d *QITCGv_i64;
+
+/**
+ * QITCGv_ptr:
+ *
+ * TCG register with pointer of architecture-specific length.
+ */
+typedef struct QITCGv_ptr_d *QITCGv_ptr;
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif  /* QI__TYPES_H */
diff --git a/instrument/qemu-instr/visibility-internal.h b/instrument/qem=
u-instr/visibility-internal.h
new file mode 100644
index 0000000000..3bbbdc34cd
--- /dev/null
+++ b/instrument/qemu-instr/visibility-internal.h
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
+#ifndef QI__VISIBILITY_INTERNAL_H
+#define QI__VISIBILITY_INTERNAL_H
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
+#endif  /* QI__VISIBILITY_INTERNAL_H */
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.p=
y
index b9ddf8fbf9..7c19dc8c94 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -277,6 +277,10 @@ class Event(object):
=20
     QI_TRACE_INSTRUMENT      =3D "qi_event_%(name)s"
     QI_TRACE_INSTRUMENT_TCG  =3D QI_TRACE_INSTRUMENT + "_tcg"
+    QI_TRACE_NOP             =3D QI_TRACE_INSTRUMENT + "_nop"
+    QI_TRACE_TRACE           =3D QI_TRACE_INSTRUMENT + "_trace"
+    QI_TRACE_GEN             =3D QI_TRACE_INSTRUMENT + "_gen_exec"
+    QI_TRACE_TRACEGEN        =3D QI_TRACE_INSTRUMENT + "_trace_and_gen_e=
xec"
=20
     def api(self, fmt=3DNone):
         if fmt is None:
diff --git a/scripts/tracetool/backend/instr_dynamic.py b/scripts/traceto=
ol/backend/instr_dynamic.py
index f42d3afa8f..6f9f8e49fb 100644
--- a/scripts/tracetool/backend/instr_dynamic.py
+++ b/scripts/tracetool/backend/instr_dynamic.py
@@ -65,3 +65,87 @@ def generate_instr_tcg_h(event, group):
         args=3Devent.args,
         argnames=3D", ".join(event.args.names()),
         argtypes=3Dargtypes)
+
+
+##################################################
+# instr-tcg-c
+
+def generate_instr_tcg_c_begin(events, group):
+    out('#include "qemu-instr/events.h"',
+        '')
+
+def generate_instr_tcg_c(event, group):
+    if "tcg" in event.properties:
+        event =3D event.event_trans
+
+    iargs =3D tracetool.vcpu.transform_args("tcg_h", event.original)
+    api_args =3D iargs.transform(TCG_2_QI_TCG)
+
+    qtargs =3D ["(%s)%s" % (arg[0], arg[1])
+              for arg in event.args]
+    gargs =3D tracetool.vcpu.transform_args(
+        "tcg_helper_c", event.original, "wrapper")
+    qgargs =3D ["(%s)%s" % (arg[0], arg[1])
+              for arg in gargs]
+    qargs =3D ["(%s)%s" % (arg[0], arg[1])
+             for arg in iargs]
+
+    out('QI_VPUBLIC void %(nop)s(%(api_args)s)',
+        '{',
+        '}',
+        'QI_VPUBLIC void %(trace)s(%(api_args)s)',
+        '{',
+        '     %(b_trace)s(%(qtargs)s);',
+        '}',
+        'QI_VPUBLIC void %(gen)s(%(api_args)s)',
+        '{',
+        '     %(b_gen)s(%(qgargs)s);',
+        '}',
+        'QI_VPUBLIC void %(trace_gen)s(%(api_args)s)',
+        '{',
+        '     %(b_trace_gen)s(%(qargs)s);',
+        '}',
+        'void *%(qi_cb)s_cb =3D %(trace_gen)s;',
+        '',
+        api_args=3Dapi_args,
+        nop=3Devent.api(event.QI_TRACE_NOP),
+        trace=3Devent.api(event.QI_TRACE_TRACE),
+        b_trace=3Devent.api(event.QEMU_TRACE_BACKEND),
+        gen=3Devent.api(event.QI_TRACE_GEN),
+        b_gen=3D"gen_helper_" + event.original.event_exec.api(event.QEMU=
_TRACE_BACKEND),
+        trace_gen=3Devent.api(event.QI_TRACE_TRACEGEN),
+        b_trace_gen=3Devent.original.api(event.QEMU_TRACE_TCG_BACKEND),
+        iargs=3Diargs,
+        qargs=3D", ".join(qargs),
+        qtargs=3D", ".join(qtargs),
+        qgargs=3D", ".join(qgargs),
+        qi_cb=3Devent.original.api(event.QI_TRACE_INSTRUMENT_TCG))
+
+
+##################################################
+# instr-c
+
+def generate_instr_c_begin(events, group):
+    out('#include "qemu-instr/events.h"',
+        '')
+
+def generate_instr_c(event, group):
+    args =3D event.args.transform(TCG_2_QI_TCG)
+    qargs =3D ["(%s)%s" % (arg[0], arg[1])
+             for arg in event.args]
+    out('QI_VPUBLIC void %(nop)s(%(args)s)',
+        '{',
+        '}',
+        'QI_VPUBLIC void %(trace)s(%(args)s)',
+        '{',
+        '     %(backend)s(%(qargs)s);',
+        '}',
+        'void *%(qi_cb)s_cb =3D %(qi_trace)s;',
+        '',
+        args=3Dargs,
+        nop=3Devent.api(event.QI_TRACE_NOP),
+        trace=3Devent.api(event.QI_TRACE_TRACE),
+        backend=3Devent.api(event.QEMU_TRACE_BACKEND),
+        qargs=3D", ".join(qargs),
+        qi_cb=3Devent.api(event.QI_TRACE_INSTRUMENT),
+        qi_trace=3Devent.api(event.QI_TRACE_TRACE))
diff --git a/scripts/tracetool/backend/instr_none.py b/scripts/tracetool/=
backend/instr_none.py
index 56508cfcbe..95aed5e96f 100644
--- a/scripts/tracetool/backend/instr_none.py
+++ b/scripts/tracetool/backend/instr_none.py
@@ -32,3 +32,21 @@ def generate_instr_h(event, group):
     out('    %(backend)s(%(argnames)s);',
         backend=3Devent.api(event.QEMU_TRACE_BACKEND),
         argnames=3D", ".join(event.args.names()))
+
+
+##################################################
+# instr-tcg-c
+
+def generate_instr_tcg_c(event, group):
+    out('void *%(qi_cb)s_cb =3D %(qi_trace)s;',
+        qi_cb=3Devent.api(event.QI_TRACE_INSTRUMENT_TCG),
+        qi_trace=3Devent.api(event.QEMU_TRACE_TCG_BACKEND))
+
+
+##################################################
+# instr-c
+
+def generate_instr_c(event, group):
+    out('void *%(qi_cb)s_cb =3D %(qi_trace)s;',
+        qi_cb=3Devent.api(event.QI_TRACE_INSTRUMENT),
+        qi_trace=3Devent.api(event.QEMU_TRACE_BACKEND))
diff --git a/scripts/tracetool/format/instr_api_h.py b/scripts/tracetool/=
format/instr_api_h.py
new file mode 100644
index 0000000000..d85f64df45
--- /dev/null
+++ b/scripts/tracetool/format/instr_api_h.py
@@ -0,0 +1,65 @@
+#!/usr/bin/env python
+# -*- coding: utf-8 -*-
+
+"""
+instrument/qemu-instr/events.h
+
+"""
+
+__author__     =3D "Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>"
+__copyright__  =3D "Copyright 2012-2017, Llu=C3=ADs Vilanova <vilanova@a=
c.upc.edu>"
+__license__    =3D "GPL version 2 or (at your option) any later version"
+
+__maintainer__ =3D "Stefan Hajnoczi"
+__email__      =3D "stefanha@linux.vnet.ibm.com"
+
+
+from tracetool import out
+from tracetool.transform import *
+import tracetool.vcpu
+
+
+def generate(events, backend, group):
+    # We won't be using any backend, because this code is only compiled =
in when
+    # dynamic instrumentation mode is enabled
+
+    out('/* This file is autogenerated by tracetool, do not edit. */',
+        '',
+        '#ifndef QI__EVENTS_H',
+        '#define QI__EVENTS_H',
+        '',
+        '#ifdef __cplusplus',
+        'extern "C" {',
+        '#endif',
+        '',
+        '#include <stdbool.h>',
+        '#include <stdint.h>',
+        '#include <qemu-instr/types.h>',
+        '#include <qemu-instr/visibility-internal.h>',
+        '',
+        '')
+
+    for e in events:
+        if "tcg-trans" in e.properties:
+            args =3D tracetool.vcpu.transform_args("tcg_h", e.original)
+            args =3D args.transform(TCG_2_QI_TCG)
+        else:
+            args =3D e.args.transform(TCG_2_QI_TCG)
+        out('QI_VPUBLIC void %(nop)s(%(args)s);',
+            'QI_VPUBLIC void %(trace)s(%(args)s);',
+            args=3Dargs,
+            nop=3De.api(e.QI_TRACE_NOP),
+            trace=3De.api(e.QI_TRACE_TRACE))
+        if "tcg-trans" in e.properties:
+            out('QI_VPUBLIC void %(gen)s(%(args)s);',
+                'QI_VPUBLIC void %(trace_gen)s(%(args)s);',
+                args=3Dargs,
+                gen=3De.api(e.QI_TRACE_GEN),
+                trace_gen=3De.api(e.QI_TRACE_TRACEGEN))
+        out('')
+
+    out('#ifdef __cplusplus',
+        '}',
+        '#endif',
+        '',
+        '#endif  /* QI__EVENTS_H */')
diff --git a/scripts/tracetool/format/instr_c.py b/scripts/tracetool/form=
at/instr_c.py
index 987ecbf5c2..35b7955641 100644
--- a/scripts/tracetool/format/instr_c.py
+++ b/scripts/tracetool/format/instr_c.py
@@ -21,8 +21,7 @@ from tracetool.transform import *
=20
 def generate(events, backend, group):
     events =3D [e for e in events
-              if "tcg-trans" not in e.properties and
-              "instrument" in e.properties]
+              if "tcg-trans" not in e.properties]
=20
     if group =3D=3D "root":
         header =3D "trace-root.h"
@@ -37,8 +36,6 @@ def generate(events, backend, group):
     backend.generate_begin(events, group)
=20
     for e in events:
-        out('void *%(qi_cb)s_cb =3D %(qi_trace)s;',
-            qi_cb=3De.api(e.QI_TRACE_INSTRUMENT),
-            qi_trace=3De.api(e.QEMU_TRACE_BACKEND))
+        backend.generate(e, group)
=20
     backend.generate_end(events, group)
diff --git a/scripts/tracetool/format/instr_tcg_c.py b/scripts/tracetool/=
format/instr_tcg_c.py
index 382709d0bd..61407a68c0 100644
--- a/scripts/tracetool/format/instr_tcg_c.py
+++ b/scripts/tracetool/format/instr_tcg_c.py
@@ -20,8 +20,7 @@ from tracetool.transform import *
=20
 def generate(events, backend, group):
     events =3D [e.original for e in events
-              if "tcg-trans" in e.properties and
-              "instrument" in e.properties]
+              if "tcg-trans" in e.properties]
=20
     out('/* This file is autogenerated by tracetool, do not edit. */',
         '',
@@ -33,8 +32,6 @@ def generate(events, backend, group):
     backend.generate_begin(events, group)
=20
     for e in events:
-        out('void *%(qi_cb)s_cb =3D %(qi_trace)s;',
-            qi_cb=3De.api(e.QI_TRACE_INSTRUMENT_TCG),
-            qi_trace=3De.api(e.QEMU_TRACE_TCG_BACKEND))
+        backend.generate(e, group)
=20
     backend.generate_end(events, group)
diff --git a/scripts/tracetool/format/tcg_helper_c.py b/scripts/tracetool=
/format/tcg_helper_c.py
index e9ba62a136..db431797d9 100644
--- a/scripts/tracetool/format/tcg_helper_c.py
+++ b/scripts/tracetool/format/tcg_helper_c.py
@@ -75,7 +75,7 @@ def generate(events, backend, group):
             '    %(name)s(%(args_call)s);',
             '}',
             name_tcg=3D"helper_%s_proxy" % e.api(e.QEMU_TRACE_BACKEND),
-            name=3De.api(e.QEMU_TRACE_NOCHECK),
+            name=3De.api(e.QEMU_TRACE),
             args_api=3De_args_api,
             args_call=3D", ".join(e_args_call.casted()),
             )
diff --git a/scripts/tracetool/transform.py b/scripts/tracetool/transform=
.py
index e18b05315e..400d36a6ed 100644
--- a/scripts/tracetool/transform.py
+++ b/scripts/tracetool/transform.py
@@ -137,6 +137,19 @@ TCG_2_TCG_HELPER_DECL =3D {
=20
=20
 ##################################################
+# host/tcg -> instrumentation-client tcg type
+
+def TCG_2_QI_TCG(type_):
+    if type_ =3D=3D "TCGv_env":
+        return "QITCGv_cpu"
+    elif type_.startswith("TCGv"):
+        return "QI" + type_
+    elif type_.startswith("CPUState"):
+        return type_.replace("CPUState", "QICPU", 1)
+    else:
+        return type_
+
+##################################################
 # host/tcg -> tcg temporal constant allocation
=20
 def _host_2_tcg_tmp_new(type_):
