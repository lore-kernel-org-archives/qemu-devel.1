Received: from eggs.gnu.org ([2001:4830:134:3::10]:59032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZh8B-0000b9-Ru
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZh86-0000nV-Ry
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:26:55 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:55462 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZh86-0000nD-6F
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:26:50 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 24 Jul 2017 20:26:39 +0300
Message-Id: <150091719881.30739.10096572040779058122.stgit@frigg.lan>
In-Reply-To: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/13] instrument: Add event control interface
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

Adds public and internal APIs to control event instrumentation.

It also adds an event object (QI_EVENT_${NAME}) and define to know if it'=
s staically enabled (QI_EVENT_${NAME}_ENABLED).

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 Makefile                                   |    1=20
 configure                                  |    4=20
 instrument/Makefile.objs                   |    5=20
 instrument/control.c                       |  316 ++++++++++++++++++++++=
++++++
 instrument/control.h                       |   86 ++++++++
 instrument/qemu-instr/control.h            |  128 +++++++++++
 instrument/qemu-instr/types.h              |    8 +
 scripts/tracetool/backend/instr_dynamic.py |   14 +
 scripts/tracetool/format/c.py              |   37 +++
 scripts/tracetool/format/instr_api_h.py    |   13 +
 trace/event-internal.h                     |   10 +
 11 files changed, 615 insertions(+), 7 deletions(-)
 create mode 100644 instrument/control.c
 create mode 100644 instrument/control.h
 create mode 100644 instrument/qemu-instr/control.h

diff --git a/Makefile b/Makefile
index c8be326790..ee54b7e17a 100644
--- a/Makefile
+++ b/Makefile
@@ -688,6 +688,7 @@ ifeq ($(TRACE_INSTRUMENT_BACKEND),instr-dynamic)
 	$(INSTALL_DIR) "$(DESTDIR)$(includedir)/qemu-instr"
 	$(INSTALL_DATA) $(SRC_PATH)/instrument/qemu-instr/types.h "$(DESTDIR)$(=
includedir)/qemu-instr/"
 	$(INSTALL_DATA) $(SRC_PATH)/instrument/qemu-instr/visibility-internal.h=
 "$(DESTDIR)$(includedir)/qemu-instr/"
+	$(INSTALL_DATA) $(SRC_PATH)/instrument/qemu-instr/control.h "$(DESTDIR)=
$(includedir)/qemu-instr/"
 	$(INSTALL_DATA) $(BUILD_DIR)/instrument/qemu-instr/events.h "$(DESTDIR)=
$(includedir)/qemu-instr/"
 endif
=20
diff --git a/configure b/configure
index ca61665874..320309e0c0 100755
--- a/configure
+++ b/configure
@@ -6019,10 +6019,14 @@ QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg $QEMU_INCLUDE=
S"
 echo "TRACE_INSTRUMENT_BACKEND=3Dinstr-$trace_instrument_backend" >> $co=
nfig_host_mak
 if test "$trace_instrument" =3D "yes"; then
     echo "CONFIG_INSTRUMENT=3Dy" >> $config_host_mak
+    libs_qga=3D"-ldl $libs_qga"
+    LDFLAGS=3D"-rdynamic $LDFLAGS"
 fi
 if test -n "$instrument_events"; then
     echo "CONFIG_INSTRUMENT_EVENTS=3D$instrument_events" >> $config_host=
_mak
 fi
+# code requiring it is always compiled-in
+LIBS=3D"-ldl $LIBS"
 ##########################################
=20
 echo "TOOLS=3D$tools" >> $config_host_mak
diff --git a/instrument/Makefile.objs b/instrument/Makefile.objs
index c2289aba85..244936aa8c 100644
--- a/instrument/Makefile.objs
+++ b/instrument/Makefile.objs
@@ -38,3 +38,8 @@ $(obj)/qemu-instr/events.h-timestamp: $(BUILD_DIR)/trac=
e-events-all $(BUILD_DIR)
 		--backend=3D$(TRACE_INSTRUMENT_BACKEND) \
 		$(TRACETOOL_INSTR_STATIC) \
 		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
+
+######################################################################
+# Control code
+
+target-obj-y +=3D control.o
diff --git a/instrument/control.c b/instrument/control.c
new file mode 100644
index 0000000000..309228f15d
--- /dev/null
+++ b/instrument/control.c
@@ -0,0 +1,316 @@
+/*
+ * Interface for controlling dynamic trace instrumentation.
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
+#include "instrument/control.h"
+#include "qemu/thread.h"
+#include "qemu-instr/control.h"
+#include "qemu/error-report.h"
+
+
+typedef int64_t HandleID;
+
+typedef struct Handle
+{
+    HandleID id;
+    void *dlhandle;
+    void (*init)(int, const char **);
+    void (*fini)(void);
+    QSLIST_ENTRY(Handle) list;
+} Handle;
+
+HandleID handle_last_id;
+QSLIST_HEAD(, Handle) handles =3D QSLIST_HEAD_INITIALIZER(handles);
+static QemuMutex instr_lock;
+
+
+static Handle *handle_get(void)
+{
+    Handle *res =3D g_malloc0(sizeof(Handle));
+    res->id =3D handle_last_id++;
+    QSLIST_INSERT_HEAD(&handles, res, list);
+    return res;
+}
+
+static bool handle_put(HandleID id)
+{
+    Handle *prev =3D NULL;
+    Handle *handle;
+    QSLIST_FOREACH(handle, &handles, list) {
+        if (handle->id =3D=3D id) {
+            break;
+        }
+        prev =3D handle;
+    }
+    if (handle =3D=3D NULL) {
+        return false;
+    } else {
+        if (prev =3D=3D NULL) {
+            QSLIST_REMOVE_HEAD(&handles, list);
+        } else {
+            QSLIST_REMOVE_AFTER(prev, list);
+        }
+        g_free(handle);
+        return true;
+    }
+}
+
+#if defined(CONFIG_INSTRUMENT)
+static Handle *handle_find(HandleID id)
+{
+    Handle *handle;
+    QSLIST_FOREACH(handle, &handles, list) {
+        if (handle->id =3D=3D id) {
+            return handle;
+        }
+    }
+    return NULL;
+}
+#endif
+
+static bool instr_available(void)
+{
+#if defined(CONFIG_INSTRUMENT)
+    return true;
+#else
+    return false;
+#endif
+}
+
+InstrLoadError instr_load(const char * path, int argc, const char ** arg=
v,
+                          int64_t *handle_id)
+{
+    InstrLoadError res;
+
+    qemu_rec_mutex_lock(&instr_lock);
+
+    *handle_id =3D -1;
+    if (!instr_available()) {
+        res =3D INSTR_LOAD_UNAVAILABLE;
+        goto out;
+    }
+
+    if (!QSLIST_EMPTY(&handles) > 0) {
+        /* XXX: This is in fact a hard-coded limit, but there's no reaso=
n why a
+         *      real multi-library implementation should fail with somet=
hing like
+         *      "too many open libraries".
+         */
+        res =3D INSTR_LOAD_UNAVAILABLE;
+        goto out;
+    }
+
+    Handle * handle =3D handle_get();
+    handle->dlhandle =3D dlopen(path, RTLD_NOW);
+    if (handle->dlhandle =3D=3D NULL) {
+        goto err;
+    }
+
+    handle->init =3D dlsym(handle->dlhandle, "qi_init");
+    if (handle->init =3D=3D NULL) {
+        goto err;
+    }
+    handle->fini =3D dlsym(handle->dlhandle, "qi_fini");
+    if (handle->fini =3D=3D NULL) {
+        goto err;
+    }
+
+    handle->init(argc, argv);
+
+    *handle_id =3D handle->id;
+    res =3D INSTR_LOAD_OK;
+    goto out;
+
+err:
+    handle_put(handle->id);
+    res =3D INSTR_LOAD_ERROR;
+out:
+    qemu_rec_mutex_unlock(&instr_lock);
+    return res;
+}
+
+static inline bool instr_event_is_instrument(TraceEvent *ev)
+{
+#if defined(CONFIG_INSTRUMENT)
+    return ev->is_instr;
+#else
+    return false;
+#endif
+}
+
+InstrUnloadError instr_unload(int64_t handle_id)
+{
+    InstrLoadError res;
+
+    qemu_rec_mutex_lock(&instr_lock);
+
+    if (!instr_available()) {
+        res =3D INSTR_UNLOAD_UNAVAILABLE;
+        goto out;
+    }
+
+#if defined(CONFIG_INSTRUMENT)
+    Handle *handle =3D handle_find(handle_id);
+    if (handle =3D=3D NULL) {
+        res =3D INSTR_UNLOAD_INVALID;
+        goto out;
+    }
+
+    handle->fini();
+
+    TraceEventIter iter;
+    TraceEvent *ev =3D NULL;
+    trace_event_iter_init(&iter, NULL);
+    while ((ev =3D trace_event_iter_next(&iter)) !=3D NULL) {
+        if (instr_event_is_instrument(ev)) {
+            *ev->instr_cb =3D ev->instr_cb_default;
+        }
+    }
+
+    /* this should never fail */
+    if (dlclose(handle->dlhandle) < 0) {
+        res =3D INSTR_UNLOAD_ERROR;
+    } else {
+        res =3D INSTR_UNLOAD_OK;
+    }
+    handle_put(handle->id);
+#endif
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
+        Handle *handle =3D QSLIST_FIRST(&handles);
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
+void qi_ctrl_event_set(QIEvent *ev, void *cb)
+{
+    TraceEvent *tev =3D (TraceEvent *)ev;
+
+    if (unlikely(tev =3D=3D NULL)) {
+        error_report("qi_ctrl_event_set: event is NULL");
+        return;
+    }
+
+#if defined(CONFIG_INSTRUMENT)
+    if (unlikely(!tev->is_instr)) {
+        error_report("qi_ctrl_event_set: event is not instrumentable");
+        return;
+    }
+
+    if (cb =3D=3D NULL) {
+        *tev->instr_cb =3D tev->instr_cb_default;
+    } else {
+        *tev->instr_cb =3D cb;
+    }
+#else
+    assert(false);
+#endif  /* defined(CONFIG_INSTRUMENT) */
+}
+
+bool qi_trace_event_get_state_static(QIEvent *ev)
+{
+    if (unlikely(ev =3D=3D NULL)) {
+        error_report("qi_trace_event_get_state_static: event is NULL");
+        return false;
+    }
+    return trace_event_get_state_static((TraceEvent *)ev);
+}
+
+bool qi_trace_event_get_state_dynamic(QIEvent *ev)
+{
+    if (unlikely(ev =3D=3D NULL)) {
+        error_report("qi_trace_event_get_state_dynamic: event is NULL");
+        return false;
+    }
+    return trace_event_get_state_dynamic((TraceEvent *)ev);
+}
+
+bool qi_trace_event_get_vcpu_state_dynamic(QICPU *vcpu, QIEvent *ev)
+{
+    TraceEvent *tev =3D (TraceEvent *)ev;
+
+    if (unlikely(vcpu =3D=3D NULL)) {
+        error_report("qi_trace_event_get_vcpu_state_dynamic: vcpu is NUL=
L");
+        return false;
+    }
+    if (unlikely(tev =3D=3D NULL)) {
+        error_report("qi_trace_event_get_vcpu_state_dynamic: event is NU=
LL");
+        return false;
+    }
+    if (unlikely(!trace_event_is_vcpu(tev))) {
+        error_report("qi_trace_event_get_vcpu_state_dynamic: event does =
not have 'vcpu' property");
+        return false;
+    }
+    return trace_event_get_vcpu_state_dynamic((CPUState *)vcpu, tev);
+}
+
+void qi_trace_event_set_state_dynamic(QIEvent *ev, bool state)
+{
+    TraceEvent *tev =3D (TraceEvent *)ev;
+
+    if (unlikely(tev =3D=3D NULL)) {
+        error_report("qi_trace_event_set_state_dynamic: event is NULL");
+        return;
+    }
+    if (unlikely(!trace_event_get_state_static(tev))) {
+        error_report("qi_trace_event_set_state_dynamic: event is statica=
lly disabled");
+        return;
+    }
+    trace_event_set_state_dynamic(tev, state);
+}
+
+void qi_trace_event_set_vcpu_state_dynamic(QICPU *vcpu, QIEvent *ev, boo=
l state)
+{
+    TraceEvent *tev =3D (TraceEvent *)ev;
+
+    if (unlikely(vcpu =3D=3D NULL)) {
+        error_report("qi_trace_event_set_vcpu_state_dynamic: vcpu is NUL=
L");
+        return;
+    }
+    if (unlikely(tev =3D=3D NULL)) {
+        error_report("qi_trace_event_set_vcpu_state_dynamic: event is NU=
LL");
+        return;
+    }
+    if (unlikely(!trace_event_is_vcpu(tev))) {
+        error_report("qi_trace_event_set_vcpu_state_dynamic: event does =
not have 'vcpu' property");
+        return;
+    }
+    if (unlikely(!trace_event_get_state_static(tev))) {
+        error_report("qi_trace_event_set_vcpu_state_dynamic: event is st=
atically disabled");
+        return;
+    }
+    trace_event_set_vcpu_state_dynamic((CPUState *)vcpu, tev, state);
+}
+
+static void __attribute__((constructor)) instr_lock_init(void)
+{
+    qemu_rec_mutex_init(&instr_lock);
+}
diff --git a/instrument/control.h b/instrument/control.h
new file mode 100644
index 0000000000..a83a350faf
--- /dev/null
+++ b/instrument/control.h
@@ -0,0 +1,86 @@
+/*
+ * Interface for controlling dynamic trace instrumentation.
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
+#include <stdint.h>
+#include <stdbool.h>
+#include "qapi-types.h"
+#include "trace/control.h"
+
+
+/**
+ * InstrLoadError:
+ * @INSTR_LOAD_OK: Correctly loaded.
+ * @INSTR_LOAD_UNAVAILABLE: Service not available.
+ * @INSTR_LOAD_ERROR: Error with libdl (see dlerror).
+ *
+ * Error codes for instr_load().
+ *
+ * Warning: Keep in sync with #InstrLoadCode
+ */
+typedef enum {
+    INSTR_LOAD_OK,
+    INSTR_LOAD_UNAVAILABLE,
+    INSTR_LOAD_ERROR,
+} InstrLoadError;
+
+/**
+ * InstrUnloadError:
+ * @INSTR_UNLOAD_OK: Correctly unloaded.
+ * @INSTR_UNLOAD_UNAVAILABLE: Service not available.
+ * @INSTR_UNLOAD_INVALID: Invalid handle.
+ * @INSTR_UNLOAD_ERROR: Error with libdl (see dlerror).
+ *
+ * Error codes for instr_unload().
+ *
+ * Warning: Keep in sync with #InstrUnloadCode
+ */
+typedef enum {
+    INSTR_UNLOAD_OK,
+    INSTR_UNLOAD_UNAVAILABLE,
+    INSTR_UNLOAD_INVALID,
+    INSTR_UNLOAD_ERROR,
+} InstrUnloadError;
+
+/**
+ * instr_load:
+ * @path: Path to the shared library to load.
+ * @argc: Number of arguments passed to the initialization function of t=
he library.
+ * @argv: Arguments passed to the initialization function of the library.
+ * @handle: Instrumentation library handle (undefined in case of error).
+ *
+ * Load a dynamic trace instrumentation library.
+ *
+ * Returns: Whether the library could be loaded.
+ */
+InstrLoadError instr_load(const char * path, int argc, const char ** arg=
v,
+                          int64_t *handle);
+
+/**
+ * instr_unload:
+ * @handle: Instrumentation library handle returned by instr_load().
+ *
+ * Unload the given instrumentation library.
+ *
+ * Returns: Whether the library could be unloaded.
+ */
+InstrUnloadError instr_unload(int64_t handle);
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
+#endif  /* INSTRUMENT__CONTROL_H */
diff --git a/instrument/qemu-instr/control.h b/instrument/qemu-instr/cont=
rol.h
new file mode 100644
index 0000000000..83f20d42f2
--- /dev/null
+++ b/instrument/qemu-instr/control.h
@@ -0,0 +1,128 @@
+/*
+ * Interface for controlling the state of events.
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
+#include <qemu-instr/types.h>
+#include <qemu-instr/visibility-internal.h>
+
+
+/**
+ * SECTION:control
+ * @section_id: qi-control
+ * @title: Event control API for QEMU event instrumentation
+ */
+
+/**
+ * qi_ctrl_event_set:
+ * @ev: Event descriptor.
+ * @cb: Pointer to instrumentation callback.
+ *
+ * Set the instrumentation callback for the given event.
+ *
+ * @cb can also be set to #NULL to restore the default callback.
+ */
+QI_VPUBLIC void qi_ctrl_event_set(QIEvent *ev, void *cb);
+
+/**
+ * qi_trace_event_get_state:
+ * @ev: Event identifier name.
+ *
+ * Get the tracing state of an event (both static and dynamic).
+ *
+ * If the event has the disabled property, the check will have no perfor=
mance
+ * impact.
+ */
+#define qi_trace_event_get_state(ev)                                    =
\
+    ((ev ##_ENABLED) && qi_trace_event_get_state_dynamic(ev))
+
+/**
+ * qi_trace_event_get_vcpu_state:
+ * @vcpu: Target vCPU.
+ * @ev: Event identifier name.
+ *
+ * Get the tracing state of an event (both static and dynamic) for the g=
iven
+ * vCPU.
+ *
+ * If the event has the disabled property, the check will have no perfor=
mance
+ * impact.
+ */
+#define qi_trace_event_get_vcpu_state(vcpu, ev)                         =
\
+    ((ev ##_ENABLED) &&                                                 =
\
+     qi_trace_event_get_vcpu_state_dynamic(vcpu, ev))
+
+/**
+ * qi_trace_event_get_state_static:
+ * @ev: Event identifier.
+ *
+ * Get the static tracing state of an event.
+ *
+ * Use the define 'QI_EVENT_${EVENT}_ENABLED' for compile-time checks (i=
t will
+ * be set to 1 or 0 according to the presence of the disabled property).
+ */
+QI_VPUBLIC bool qi_trace_event_get_state_static(QIEvent *ev);
+
+/**
+ * qi_trace_event_get_state_dynamic:
+ * @ev: Event identifier.
+ *
+ * Get the dynamic tracing state of an event.
+ */
+QI_VPUBLIC bool qi_trace_event_get_state_dynamic(QIEvent *ev);
+
+/**
+ * qi_trace_event_get_vcpu_state_dynamic:
+ * @vcpu: Target vCPU.
+ * @ev: Event identifier.
+ *
+ * Get the dynamic tracing state of an event for the given vCPU.
+ */
+QI_VPUBLIC bool qi_trace_event_get_vcpu_state_dynamic(QICPU *vcpu,
+                                                      QIEvent *ev);
+
+/**
+ * qi_trace_event_set_state_dynamic:
+ * @ev: Event identifier.
+ * @state: Target tracing state.
+ *
+ * Set the dynamic tracing state of an event.
+ *
+ * Pre-condition: qi_trace_event_get_state_static(ev) =3D=3D true
+ */
+QI_VPUBLIC void qi_trace_event_set_state_dynamic(QIEvent *ev, bool state=
);
+
+/**
+ * qi_trace_event_set_vcpu_state_dynamic:
+ * @vcpu: Target vCPU.
+ * @ev: Event identifier.
+ * @state: Target tracing state.
+ *
+ * Set the dynamic tracing state of an event for the given vCPU.
+ *
+ * Pre-condition: qi_trace_event_get_state_static(ev) =3D=3D true
+ *
+ * Note: Changes for execution-time events with the 'tcg' property will =
not be
+ *       propagated until the next TB is executed (iff executing in TCG =
mode).
+ */
+QI_VPUBLIC void qi_trace_event_set_vcpu_state_dynamic(QICPU *vcpu,
+                                                      QIEvent *ev, bool =
state);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif  /* QI__CONTROL_H */
diff --git a/instrument/qemu-instr/types.h b/instrument/qemu-instr/types.=
h
index d3d26bbf73..58a84b6d01 100644
--- a/instrument/qemu-instr/types.h
+++ b/instrument/qemu-instr/types.h
@@ -25,6 +25,14 @@ extern "C" {
  */
=20
 /**
+ * QIEvent:
+ *
+ * Opaque structure defining an instrumentation event.
+ */
+struct QIEvent;
+typedef struct QIEvent QIEvent;
+
+/**
  * QICPU:
  *
  * Opaque guest CPU pointer.
diff --git a/scripts/tracetool/backend/instr_dynamic.py b/scripts/traceto=
ol/backend/instr_dynamic.py
index 6f9f8e49fb..2efd4a7eb1 100644
--- a/scripts/tracetool/backend/instr_dynamic.py
+++ b/scripts/tracetool/backend/instr_dynamic.py
@@ -90,7 +90,8 @@ def generate_instr_tcg_c(event, group):
     qargs =3D ["(%s)%s" % (arg[0], arg[1])
              for arg in iargs]
=20
-    out('QI_VPUBLIC void %(nop)s(%(api_args)s)',
+    out('QIEvent *%(qevent)s =3D (QIEvent *)&%(tevent)s;',
+        'QI_VPUBLIC void %(nop)s(%(api_args)s)',
         '{',
         '}',
         'QI_VPUBLIC void %(trace)s(%(api_args)s)',
@@ -99,7 +100,10 @@ def generate_instr_tcg_c(event, group):
         '}',
         'QI_VPUBLIC void %(gen)s(%(api_args)s)',
         '{',
+        # does not exist when event is disabled
+        '#if %(teventu)s_ENABLED',
         '     %(b_gen)s(%(qgargs)s);',
+        '#endif',
         '}',
         'QI_VPUBLIC void %(trace_gen)s(%(api_args)s)',
         '{',
@@ -107,6 +111,9 @@ def generate_instr_tcg_c(event, group):
         '}',
         'void *%(qi_cb)s_cb =3D %(trace_gen)s;',
         '',
+        qevent=3Devent.api(event.QI_TRACE_INSTRUMENT).upper(),
+        tevent=3Devent.api(event.QEMU_EVENT),
+        teventu=3Devent.api(event.QEMU_TRACE).upper(),
         api_args=3Dapi_args,
         nop=3Devent.api(event.QI_TRACE_NOP),
         trace=3Devent.api(event.QI_TRACE_TRACE),
@@ -133,7 +140,8 @@ def generate_instr_c(event, group):
     args =3D event.args.transform(TCG_2_QI_TCG)
     qargs =3D ["(%s)%s" % (arg[0], arg[1])
              for arg in event.args]
-    out('QI_VPUBLIC void %(nop)s(%(args)s)',
+    out('QIEvent *%(qevent)s =3D (QIEvent *)&%(tevent)s;',
+        'QI_VPUBLIC void %(nop)s(%(args)s)',
         '{',
         '}',
         'QI_VPUBLIC void %(trace)s(%(args)s)',
@@ -142,6 +150,8 @@ def generate_instr_c(event, group):
         '}',
         'void *%(qi_cb)s_cb =3D %(qi_trace)s;',
         '',
+        qevent=3Devent.api(event.QI_TRACE_INSTRUMENT).upper(),
+        tevent=3Devent.api(event.QEMU_EVENT),
         args=3Dargs,
         nop=3Devent.api(event.QI_TRACE_NOP),
         trace=3Devent.api(event.QI_TRACE_TRACE),
diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.p=
y
index 833c05a022..0b8bb98d24 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -6,7 +6,7 @@ trace/generated-tracers.c
 """
=20
 __author__     =3D "Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>"
-__copyright__  =3D "Copyright 2012-2014, Llu=C3=ADs Vilanova <vilanova@a=
c.upc.edu>"
+__copyright__  =3D "Copyright 2012-2017, Llu=C3=ADs Vilanova <vilanova@a=
c.upc.edu>"
 __license__    =3D "GPL version 2 or (at your option) any later version"
=20
 __maintainer__ =3D "Stefan Hajnoczi"
@@ -39,18 +39,49 @@ def generate(events, backend, group):
             vcpu_id =3D 0
         else:
             vcpu_id =3D "TRACE_VCPU_EVENT_NONE"
+
+        if "instrument" in e.properties:
+            is_instr =3D "true"
+            out('#if defined(CONFIG_INSTRUMENT)')
+            if "tcg-trans" in e.properties:
+                instr_cb =3D e.original.api(e.QI_TRACE_INSTRUMENT_TCG) +=
 "_cb"
+                instr_cb_default =3D e.api(e.QI_TRACE_TRACEGEN)
+                out('static void *_tmp__%(name1)s;',
+                    'extern void *%(name1)s __attribute__((weak, alias("=
_tmp__%(name1)s")));',
+                    name1=3Dinstr_cb)
+            else:
+                instr_cb =3D e.api(e.QI_TRACE_INSTRUMENT) + "_cb"
+                instr_cb_default =3D e.api(e.QI_TRACE_TRACE)
+            out('static void _tmp__%(name2)s(void) {};',
+                'void %(name2)s(void) __attribute__((weak, alias("_tmp__=
%(name2)s")));',
+                '#endif',
+                name2=3Dinstr_cb_default)
+            instr_cb =3D "&" + instr_cb
+        else:
+            is_instr =3D "false"
+            instr_cb =3D "NULL"
+            instr_cb_default =3D "NULL"
+
         out('TraceEvent %(event)s =3D {',
             '    .id =3D 0,',
             '    .vcpu_id =3D %(vcpu_id)s,',
             '    .name =3D \"%(name)s\",',
             '    .sstate =3D %(sstate)s,',
-            '    .dstate =3D &%(dstate)s ',
+            '    .dstate =3D &%(dstate)s,',
+            '#if defined(CONFIG_INSTRUMENT)',
+            '    .is_instr =3D %(is_instr)s,',
+            '    .instr_cb =3D %(instr_cb)s,',
+            '    .instr_cb_default =3D %(instr_cb_default)s,',
+            '#endif',
             '};',
             event =3D e.api(e.QEMU_EVENT),
             vcpu_id =3D vcpu_id,
             name =3D e.name,
             sstate =3D "TRACE_%s_ENABLED" % e.name.upper(),
-            dstate =3D e.api(e.QEMU_DSTATE))
+            dstate =3D e.api(e.QEMU_DSTATE),
+            is_instr=3Dis_instr,
+            instr_cb=3Dinstr_cb,
+            instr_cb_default=3Dinstr_cb_default)
=20
     out('TraceEvent *%(group)s_trace_events[] =3D {',
         group =3D group.lower())
diff --git a/scripts/tracetool/format/instr_api_h.py b/scripts/tracetool/=
format/instr_api_h.py
index d85f64df45..812a5d44ec 100644
--- a/scripts/tracetool/format/instr_api_h.py
+++ b/scripts/tracetool/format/instr_api_h.py
@@ -40,13 +40,24 @@ def generate(events, backend, group):
         '')
=20
     for e in events:
+        if "disable" in e.properties:
+            enabled =3D 0
+        else:
+            enabled =3D 1
+
         if "tcg-trans" in e.properties:
             args =3D tracetool.vcpu.transform_args("tcg_h", e.original)
             args =3D args.transform(TCG_2_QI_TCG)
         else:
             args =3D e.args.transform(TCG_2_QI_TCG)
-        out('QI_VPUBLIC void %(nop)s(%(args)s);',
+
+        out('#define %(qeventu)s_ENABLED %(enabled)d',
+            'extern QI_VPUBLIC QIEvent *%(event)s;',
+            'QI_VPUBLIC void %(nop)s(%(args)s);',
             'QI_VPUBLIC void %(trace)s(%(args)s);',
+            qeventu=3De.api(e.QI_TRACE_INSTRUMENT).upper(),
+            enabled=3Denabled,
+            event=3De.api(e.QI_TRACE_INSTRUMENT).upper(),
             args=3Dargs,
             nop=3De.api(e.QI_TRACE_NOP),
             trace=3De.api(e.QI_TRACE_TRACE))
diff --git a/trace/event-internal.h b/trace/event-internal.h
index f63500b37e..b12cc110b6 100644
--- a/trace/event-internal.h
+++ b/trace/event-internal.h
@@ -1,7 +1,7 @@
 /*
  * Interface for configuring and controlling the state of tracing events.
  *
- * Copyright (C) 2012-2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ * Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
@@ -23,6 +23,9 @@
  * @name: Event name.
  * @sstate: Static tracing state.
  * @dstate: Dynamic tracing state
+ * @is_instr: Whether the event is instrumentable.
+ * @instr_cb: Current instrumentation callback.
+ * @instr_cb_default: Default instrumentation callback.
  *
  * Interpretation of @dstate depends on whether the event has the 'vcpu'
  *  property:
@@ -37,6 +40,11 @@ typedef struct TraceEvent {
     const char * name;
     const bool sstate;
     uint16_t *dstate;
+#if defined(CONFIG_INSTRUMENT)
+    bool is_instr;
+    void **instr_cb;
+    void *instr_cb_default;
+#endif
 } TraceEvent;
=20
 void trace_event_set_state_dynamic_init(TraceEvent *ev, bool state);
