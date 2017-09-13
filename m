Received: from eggs.gnu.org ([2001:4830:134:3::10]:54393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4zq-0002zb-St
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4zl-00067W-Ss
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:34:18 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:53914)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4zl-00066s-Cd
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:34:13 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 13 Sep 2017 13:34:02 +0300
Message-Id: <150529884250.10902.820546188271554654.stgit@frigg.lan>
In-Reply-To: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 10/22] instrument: Add support for tracing
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 .gitignore                        |    1=20
 Makefile                          |    3 +
 instrument/Makefile.objs          |    1=20
 instrument/error.h                |    6 ++
 instrument/qemu-instr/types.h     |   51 +++++++++++++++
 instrument/qemu-instr/types.inc.h |   15 ++++
 instrument/trace.c                |  125 +++++++++++++++++++++++++++++++=
++++++
 trace/control.h                   |    1=20
 8 files changed, 203 insertions(+)
 create mode 100644 instrument/qemu-instr/types.h
 create mode 100644 instrument/qemu-instr/types.inc.h
 create mode 100644 instrument/trace.c

diff --git a/.gitignore b/.gitignore
index cf65316863..5ffcb9a091 100644
--- a/.gitignore
+++ b/.gitignore
@@ -134,3 +134,4 @@ trace-dtrace-root.h
 trace-dtrace-root.dtrace
 trace-ust-all.h
 trace-ust-all.c
+!/instrument/*
diff --git a/Makefile b/Makefile
index c3d9a4bcd9..646fe2f327 100644
--- a/Makefile
+++ b/Makefile
@@ -602,6 +602,9 @@ endif
 ifdef CONFIG_INSTRUMENT
 	$(INSTALL_DIR) "$(DESTDIR)$(includedir)/qemu-instr/"
 	$(INSTALL_DATA) $(SRC_PATH)/instrument/qemu-instr/control.h "$(DESTDIR)=
$(includedir)/qemu-instr/"
+	$(INSTALL_DATA) $(SRC_PATH)/instrument/qemu-instr/trace.h "$(DESTDIR)$(=
includedir)/qemu-instr/"
+	$(INSTALL_DATA) $(SRC_PATH)/instrument/qemu-instr/types.h "$(DESTDIR)$(=
includedir)/qemu-instr/"
+	$(INSTALL_DATA) $(SRC_PATH)/instrument/qemu-instr/types.inc.h "$(DESTDI=
R)$(includedir)/qemu-instr/"
 endif
=20
 install-datadir:
diff --git a/instrument/Makefile.objs b/instrument/Makefile.objs
index ec76b2080b..d7e6c760c3 100644
--- a/instrument/Makefile.objs
+++ b/instrument/Makefile.objs
@@ -4,3 +4,4 @@ target-obj-$(CONFIG_INSTRUMENT) +=3D cmdline.o
 target-obj-$(CONFIG_INSTRUMENT) +=3D load.o
 target-obj-$(CONFIG_INSTRUMENT) +=3D qmp.o
 target-obj-$(CONFIG_INSTRUMENT) +=3D control.o
+target-obj-$(CONFIG_INSTRUMENT) +=3D trace.o
diff --git a/instrument/error.h b/instrument/error.h
index f8d1dd4b16..7a51d62fdb 100644
--- a/instrument/error.h
+++ b/instrument/error.h
@@ -25,4 +25,10 @@
         return;                      \
     }
=20
+#define ERROR_IF_RET(cond, ret, msg, args...)   \
+    if (unlikely(cond)) {                       \
+        _ERROR(msg, ##args);                    \
+        return ret;                             \
+    }                                           \
+
 #endif  /* INSTRUMENT_ERROR_H */
diff --git a/instrument/qemu-instr/types.h b/instrument/qemu-instr/types.=
h
new file mode 100644
index 0000000000..ea3a032b4f
--- /dev/null
+++ b/instrument/qemu-instr/types.h
@@ -0,0 +1,51 @@
+/*
+ * QEMU-specific types for instrumentation clients.
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
+ */
+
+/**
+ * QITraceEvent:
+ *
+ * Opaque structure defining a tracing event.
+ */
+typedef struct QITraceEvent QITraceEvent;
+
+/**
+ * QITraceEventIter:
+ *
+ * Opaque structure defining a tracing event iterator.
+ */
+typedef struct QITraceEventIter QITraceEventIter;
+
+/**
+ * QICPU:
+ *
+ * Opaque guest CPU pointer.
+ */
+typedef struct QICPU_d *QICPU;
+
+
+#include <qemu-instr/types.inc.h>
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif  /* QI__TYPES_H */
diff --git a/instrument/qemu-instr/types.inc.h b/instrument/qemu-instr/ty=
pes.inc.h
new file mode 100644
index 0000000000..0d99ea59a2
--- /dev/null
+++ b/instrument/qemu-instr/types.inc.h
@@ -0,0 +1,15 @@
+/*
+ * QEMU-specific types for instrumentation clients.
+ *
+ * Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include <stdlib.h>
+
+
+struct QITraceEventIter {
+    char buffer[(sizeof(size_t) * 2) + sizeof(char *)];
+};
diff --git a/instrument/trace.c b/instrument/trace.c
new file mode 100644
index 0000000000..6a437039b4
--- /dev/null
+++ b/instrument/trace.c
@@ -0,0 +1,125 @@
+/*
+ * API for QEMU's tracing events.
+ *
+ * Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "instrument/error.h"
+#include "qemu/compiler.h"
+#include "qemu-instr/trace.h"
+#include "trace/control.h"
+
+
+SYM_PUBLIC
+QITraceEvent *qi_trace_event_name(const char *name)
+{
+    ERROR_IF_RET(!name, NULL, "must provide a name");
+    return (QITraceEvent *)trace_event_name(name);
+}
+
+SYM_PUBLIC
+void qi_trace_event_iter_init(QITraceEventIter *iter, const char *patter=
n)
+{
+    TraceEventIter *iter_ =3D (TraceEventIter *)iter;
+    ERROR_IF(!iter_, "must provide an iterator");
+    trace_event_iter_init(iter_, pattern);
+}
+
+SYM_PUBLIC
+QITraceEvent *qi_trace_event_iter_next(QITraceEventIter *iter)
+{
+    TraceEventIter *iter_ =3D (TraceEventIter *)iter;
+    ERROR_IF_RET(!iter_, NULL, "must provide an iterator");
+    return (QITraceEvent *)trace_event_iter_next(iter_);
+}
+
+
+SYM_PUBLIC
+bool qi_trace_event_is_vcpu(QITraceEvent *ev)
+{
+    TraceEvent *ev_ =3D (TraceEvent *)ev;
+    ERROR_IF_RET(!ev_, false, "must provide an event");
+    return trace_event_is_vcpu(ev_);
+}
+
+SYM_PUBLIC
+const char *qi_trace_event_get_name(QITraceEvent *ev)
+{
+    TraceEvent *ev_ =3D (TraceEvent *)ev;
+    ERROR_IF_RET(!ev_, false, "must provide an event");
+    return trace_event_get_name(ev_);
+}
+
+
+SYM_PUBLIC
+bool qi_trace_event_get_state(QITraceEvent *ev)
+{
+    TraceEvent *ev_ =3D (TraceEvent *)ev;
+    ERROR_IF_RET(!ev_, false, "must provide an event");
+    return trace_event_get_state_static(ev_) &&
+        trace_event_get_state_dynamic(ev_);
+}
+
+SYM_PUBLIC
+bool qi_trace_event_get_vcpu_state(QICPU *vcpu, QITraceEvent *ev)
+{
+    CPUState *vcpu_ =3D (CPUState *)vcpu;
+    TraceEvent *ev_ =3D (TraceEvent *)ev;
+    ERROR_IF_RET(!vcpu_, false, "must provide a vCPU");
+    ERROR_IF_RET(!ev_, false, "must provide an event");
+    return trace_event_get_state_static(ev_) &&
+        trace_event_get_vcpu_state_dynamic(vcpu_, ev_);
+}
+
+SYM_PUBLIC
+bool qi_trace_event_get_state_static(QITraceEvent *ev)
+{
+    TraceEvent *ev_ =3D (TraceEvent *)ev;
+    ERROR_IF_RET(!ev_, false, "must provide an event");
+    return trace_event_get_state_static(ev_);
+}
+
+SYM_PUBLIC
+bool qi_trace_event_get_state_dynamic(QITraceEvent *ev)
+{
+    TraceEvent *ev_ =3D (TraceEvent *)ev;
+    ERROR_IF_RET(!ev_, false, "must provide an event");
+    return trace_event_get_state_dynamic(ev_);
+}
+
+SYM_PUBLIC
+bool qi_trace_event_get_vcpu_state_dynamic(QICPU *vcpu, QITraceEvent *ev=
)
+{
+    CPUState *vcpu_ =3D (CPUState *)vcpu;
+    TraceEvent *ev_ =3D (TraceEvent *)ev;
+    ERROR_IF_RET(!vcpu_, false, "must provide a vCPU");
+    ERROR_IF_RET(!ev_, false, "must provide an event");
+    return trace_event_get_vcpu_state_dynamic(vcpu_, ev_);
+}
+
+SYM_PUBLIC
+void qi_trace_event_set_state_dynamic(QITraceEvent *ev, bool state)
+{
+    TraceEvent *ev_ =3D (TraceEvent *)ev;
+    ERROR_IF(!ev_, "must provide an event");
+    ERROR_IF(!trace_event_get_state_static(ev_),
+             "event must be statically enabled");
+    trace_event_set_state_dynamic(ev_, state);
+}
+
+SYM_PUBLIC
+void qi_trace_event_set_vcpu_state_dynamic(QICPU *vcpu,
+                                           QITraceEvent *ev, bool state)
+{
+    CPUState *vcpu_ =3D (CPUState *)vcpu;
+    TraceEvent *ev_ =3D (TraceEvent *)ev;
+    ERROR_IF(!vcpu_, "must provide a vCPU");
+    ERROR_IF(!ev_, "must provide an event");
+    ERROR_IF(!trace_event_get_state_static(ev_),
+             "event must be statically enabled");
+    trace_event_set_vcpu_state_dynamic(vcpu_, ev_, state);
+}
diff --git a/trace/control.h b/trace/control.h
index 1903e22975..3e6da24c98 100644
--- a/trace/control.h
+++ b/trace/control.h
@@ -13,6 +13,7 @@
 #include "qemu-common.h"
 #include "event-internal.h"
=20
+/* NOTE: Keep in sync with size of QITraceEventIter */
 typedef struct TraceEventIter {
     size_t event;
     size_t group;
