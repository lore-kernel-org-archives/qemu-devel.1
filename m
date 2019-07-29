Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2B9C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:03:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4718D216C8
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="pv5U1pu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4718D216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7Be-0003Ti-GV
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37815)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs77D-00048N-J0
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs77A-0004XC-3W
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:07 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:47866)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs76z-0004Lq-7O; Mon, 29 Jul 2019 10:58:53 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 680C196F54;
 Mon, 29 Jul 2019 14:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uxjVvbIxNj4mVuniMLvjY/Wiyh5WRqlk3kJ9We1kpZg=;
 b=pv5U1pu+EDX9drgeHPg7L4f6A5RUt6PyVfXgTzuKw5czVagDIs2edhNVlrL4XtEN37nO2U
 dByyMLNmyCULZpzQdRCKA+zE8YdubaYl0aT3zPFji0Zxy0p98WrCBxlkWm1j1zmGvqKZxe
 Wqa2d3obJOU6VeukBWmnc5CQRtbhBWA=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:22 +0200
Message-Id: <20190729145654.14644-2-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uxjVvbIxNj4mVuniMLvjY/Wiyh5WRqlk3kJ9We1kpZg=;
 b=jR5XfSyKayMyFJFy5VrZLiYMyAl3O52UYBIkEuIxR+BIn5hAV2hsY7Kk7LP8+Jt8d+HdO1
 t5GeHCbHcsey6A6zNOUguIRT12YIwNFLbm20BGxpTfLNN67kUwRvR9kdY5tc7iu5KZpJYM
 aSUUHiYkqETISKQK4YpjG+KB49JkfcU=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412331; a=rsa-sha256; cv=none;
 b=zdBwvNCtBRKbsbLqJqoD1r6KrLg+TPM6z8TrbkvNPBM7ZPvDaqqIuv0N4K5oqijQBau4EE
 PlPpWksNBjKOggBozLiWhHdR0P2MkNd+r5JPbDaW+aNrhkxKadrUvp8bozCjHOS0yKwoQs
 i1c8z2fLed1XrkoAMje4yXCCtkmUpvw=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 01/33] Create Resettable QOM interface
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, edgar.iglesias@xilinx.com, hare@suse.com,
 qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, rth@twiddle.net,
 thuth@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, clg@kaod.org, jsnow@redhat.com,
 david@gibson.dropbear.id.au, Damien Hedde <damien.hedde@greensocs.com>,
 berrange@redhat.com, cohuck@redhat.com, mark.burton@greensocs.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit defines an interface allowing multi-phase reset.
The phases are INIT, HOLD and EXIT. Each phase has an associated method
in the class.

The reset of a Resettable is controlled with 2 functions:
  - resettable_assert_reset which starts the reset operation.
  - resettable_deassert_reset which ends the reset operation.

There is also a `resettable_reset` helper function which does assert then
deassert allowing to do a proper reset in one call.

In addition, two functions, *resettable_reset_cold_fn* and
*resettable_reset_warm_fn*, are defined. They take only an opaque argumen=
t
(for the Resettable object) and can be used as callbacks.

The Resettable interface is "reentrant", _assert_ can be called several
times and _deasert_ must be called the same number of times so that the
Resettable leave reset state. It is supported by keeping a counter of
the current number of _assert_ calls. The counter maintainance is done
though 3 methods get/increment/decrement_count. A method set_cold is used
to set the cold flag of the reset. Another method set_host_needed is used
to ensure hold phase is executed only if required.

Reset hierarchy is also supported. Each Resettable may have
sub-Resettable objects. When resetting a Resettable, it is propagated to
its children using the foreach_child method.

When entering reset, init phases are executed parent-to-child order then
hold phases are executed child-parent order.
When leaving reset, exit phases are executed in child-to-parent order.
This will allow to replace current qdev_reset mechanism by this interface
without side-effects on reset order.

Note: I used an uint32 for the count. This match the type already used
in the existing resetting counter in hw/scsi/vmw_pvscsi.c for the
PVSCSIState.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 Makefile.objs           |   1 +
 hw/core/Makefile.objs   |   1 +
 hw/core/resettable.c    | 220 ++++++++++++++++++++++++++++++++++++++++
 hw/core/trace-events    |  39 +++++++
 include/hw/resettable.h | 126 +++++++++++++++++++++++
 5 files changed, 387 insertions(+)
 create mode 100644 hw/core/resettable.c
 create mode 100644 hw/core/trace-events
 create mode 100644 include/hw/resettable.h

diff --git a/Makefile.objs b/Makefile.objs
index 6a143dcd57..a723a47e14 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -191,6 +191,7 @@ trace-events-subdirs +=3D migration
 trace-events-subdirs +=3D net
 trace-events-subdirs +=3D ui
 endif
+trace-events-subdirs +=3D hw/core
 trace-events-subdirs +=3D hw/display
 trace-events-subdirs +=3D qapi
 trace-events-subdirs +=3D qom
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index f8481d959f..d9234aa98a 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -1,6 +1,7 @@
 # core qdev-related obj files, also used by *-user:
 common-obj-y +=3D qdev.o qdev-properties.o
 common-obj-y +=3D bus.o reset.o
+common-obj-y +=3D resettable.o
 common-obj-$(CONFIG_SOFTMMU) +=3D qdev-fw.o
 common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
 # irq.o needed for qdev GPIO handling:
diff --git a/hw/core/resettable.c b/hw/core/resettable.c
new file mode 100644
index 0000000000..d7d631ce8b
--- /dev/null
+++ b/hw/core/resettable.c
@@ -0,0 +1,220 @@
+/*
+ * Resettable interface.
+ *
+ * Copyright (c) 2019 GreenSocs SAS
+ *
+ * Authors:
+ *   Damien Hedde
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "hw/resettable.h"
+#include "trace.h"
+
+#define RESETTABLE_MAX_COUNT 50
+
+#define RESETTABLE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(ResettableClass, (obj), TYPE_RESETTABLE)
+
+static void resettable_init_reset(Object *obj, bool cold);
+
+static bool resettable_class_check(ResettableClass *rc)
+{
+    if (!rc->set_cold) {
+        return false;
+    }
+    if (!rc->set_hold_needed) {
+        return false;
+    }
+    if (!rc->increment_count) {
+        return false;
+    }
+    if (!rc->decrement_count) {
+        return false;
+    }
+    if (!rc->get_count) {
+        return false;
+    }
+    return true;
+}
+
+static void resettable_foreach_child(ResettableClass *rc,
+                                     Object *obj,
+                                     void (*func)(Object *))
+{
+    if (rc->foreach_child) {
+        rc->foreach_child(obj, func);
+    }
+}
+
+static void resettable_init_cold_reset(Object *obj)
+{
+    resettable_init_reset(obj, true);
+}
+
+static void resettable_init_warm_reset(Object *obj)
+{
+    resettable_init_reset(obj, false);
+}
+
+static void resettable_init_reset(Object *obj, bool cold)
+{
+    void (*func)(Object *);
+    ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
+    uint32_t count;
+    bool action_needed =3D false;
+    bool prev_cold;
+
+    assert(resettable_class_check(rc));
+
+    count =3D rc->increment_count(obj);
+    /* this assert is here to catch an eventual reset loop */
+    assert(count <=3D RESETTABLE_MAX_COUNT);
+
+    /*
+     * only take action if:
+     * + we really enter reset for the 1st time
+     * + or we are in warm reset and start a cold one
+     */
+    prev_cold =3D rc->set_cold(obj, cold);
+    if (count =3D=3D 1) {
+        action_needed =3D true;
+    } else if (cold && !prev_cold) {
+        action_needed =3D true;
+    }
+    trace_resettable_phase_init(obj, object_get_typename(obj), cold, cou=
nt,
+                                action_needed);
+
+    /* exec init phase */
+    if (action_needed) {
+        rc->set_hold_needed(obj, true);
+        if (rc->phases.init) {
+            rc->phases.init(obj);
+        }
+    }
+
+    /*
+     * handle the children even if action_needed is at false so that
+     * children counts are incremented too
+     */
+    func =3D cold ? resettable_init_cold_reset : resettable_init_warm_re=
set;
+    resettable_foreach_child(rc, obj, func);
+    trace_resettable_phase_init_end(obj);
+}
+
+static void resettable_hold_reset(Object *obj)
+{
+    ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
+    bool hold_needed;
+
+    assert(resettable_class_check(rc));
+    trace_resettable_phase_hold(obj, object_get_typename(obj));
+
+    /* handle children first */
+    resettable_foreach_child(rc, obj, resettable_hold_reset);
+
+    /* exec hold phase */
+    hold_needed =3D rc->set_hold_needed(obj, false);
+    if (hold_needed) {
+        if (rc->phases.hold) {
+            rc->phases.hold(obj);
+        }
+    }
+    trace_resettable_phase_hold_end(obj, hold_needed);
+}
+
+static void resettable_exit_reset(Object *obj)
+{
+    uint32_t count;
+    ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
+
+    assert(resettable_class_check(rc));
+    trace_resettable_phase_exit(obj, object_get_typename(obj));
+
+    resettable_foreach_child(rc, obj, resettable_deassert_reset);
+
+    count =3D rc->get_count(obj);
+    /*
+     * we could assert that count > 0 but there are some corner cases
+     * where we prefer to let it go as it is probably harmless.
+     * For example: if there is reset support addition between
+     * hosts when doing a migration. We may do such things as
+     * deassert a non-existing reset.
+     */
+    if (count > 0) {
+        count =3D rc->decrement_count(obj);
+    } else {
+        trace_resettable_count_underflow(obj);
+    }
+    if (count =3D=3D 0) {
+        if (rc->phases.exit) {
+            rc->phases.exit(obj);
+        }
+    }
+    trace_resettable_phase_exit_end(obj, count);
+}
+
+void resettable_assert_reset(Object *obj, bool cold)
+{
+    trace_resettable_reset_assert(obj, object_get_typename(obj), cold);
+    resettable_init_reset(obj, cold);
+    resettable_hold_reset(obj);
+}
+
+void resettable_deassert_reset(Object *obj)
+{
+    trace_resettable_reset_deassert(obj, object_get_typename(obj));
+    resettable_exit_reset(obj);
+}
+
+void resettable_reset(Object *obj, bool cold)
+{
+    trace_resettable_reset(obj, object_get_typename(obj), cold);
+    resettable_assert_reset(obj, cold);
+    resettable_deassert_reset(obj);
+}
+
+void resettable_reset_warm_fn(void *opaque)
+{
+    resettable_reset((Object *) opaque, false);
+}
+
+void resettable_reset_cold_fn(void *opaque)
+{
+    resettable_reset((Object *) opaque, true);
+}
+
+void resettable_class_set_parent_reset_phases(ResettableClass *rc,
+                                              ResettableInitPhase init,
+                                              ResettableHoldPhase hold,
+                                              ResettableExitPhase exit,
+                                              ResettablePhases *parent_p=
hases)
+{
+    *parent_phases =3D rc->phases;
+    if (init) {
+        rc->phases.init =3D init;
+    }
+    if (hold) {
+        rc->phases.hold =3D hold;
+    }
+    if (exit) {
+        rc->phases.exit =3D exit;
+    }
+}
+
+static const TypeInfo resettable_interface_info =3D {
+    .name       =3D TYPE_RESETTABLE,
+    .parent     =3D TYPE_INTERFACE,
+    .class_size =3D sizeof(ResettableClass),
+};
+
+static void reset_register_types(void)
+{
+    type_register_static(&resettable_interface_info);
+}
+
+type_init(reset_register_types)
diff --git a/hw/core/trace-events b/hw/core/trace-events
new file mode 100644
index 0000000000..489d96d445
--- /dev/null
+++ b/hw/core/trace-events
@@ -0,0 +1,39 @@
+# See docs/devel/tracing.txt for syntax documentation.
+#
+# This file is processed by the tracetool script during the build.
+#
+# To add a new trace event:
+#
+# 1. Choose a name for the trace event.  Declare its arguments and forma=
t
+#    string.
+#
+# 2. Call the trace event from code using trace_##name, e.g. multiwrite_=
cb() ->
+#    trace_multiwrite_cb().  The source file must #include "trace.h".
+#
+# Format of a trace event:
+#
+# [disable] <name>(<type1> <arg1>[, <type2> <arg2>] ...) "<format-string=
>"
+#
+# Example: g_malloc(size_t size) "size %zu"
+#
+# The "disable" keyword will build without the trace event.
+#
+# The <name> must be a valid as a C function name.
+#
+# Types should be standard C types.  Use void * for pointers because the=
 trace
+# system may not have the necessary headers included.
+#
+# The <format-string> should be a sprintf()-compatible format string.
+
+# resettable.c
+resettable_reset(void *obj, const char *type, int cold) "obj=3D%p(%s) co=
ld=3D%d"
+resettable_reset_assert(void *obj, const char *type, int cold) "obj=3D%p=
(%s) cold=3D%d"
+resettable_reset_deassert(void *obj, const char *type) "obj=3D%p(%s)"
+resettable_reset_deassert_end(void *obj) "obj=3D%p"
+resettable_phase_init(void *obj, const char *type, int cold, uint32_t co=
unt, int needed) "obj=3D%p(%s) cold=3D%d count=3D%" PRIu32 " needed=3D%d"
+resettable_phase_init_end(void *obj) "obj=3D%p"
+resettable_phase_hold(void *obj, const char *type) "obj=3D%p(%s)"
+resettable_phase_hold_end(void *obj, int needed) "obj=3D%p needed=3D%d"
+resettable_phase_exit(void *obj, const char *type) "obj=3D%p(%s)"
+resettable_phase_exit_end(void *obj, uint32_t count) "obj=3D%p count=3D%=
" PRIu32
+resettable_count_underflow(void *obj) "obj=3D%p"
diff --git a/include/hw/resettable.h b/include/hw/resettable.h
new file mode 100644
index 0000000000..e617a8e875
--- /dev/null
+++ b/include/hw/resettable.h
@@ -0,0 +1,126 @@
+#ifndef HW_RESETTABLE_H
+#define HW_RESETTABLE_H
+
+#include "qom/object.h"
+
+#define TYPE_RESETTABLE "resettable"
+
+#define RESETTABLE_CLASS(class) \
+    OBJECT_CLASS_CHECK(ResettableClass, (class), TYPE_RESETTABLE)
+
+/*
+ * ResettableClass:
+ * Interface for resettable objects.
+ *
+ * The reset operation is divided in several phases each represented by =
a
+ * method.
+ *
+ * Each Ressetable must maintain a reset counter in its state, 3 methods=
 allows
+ * to interact with it.
+ *
+ * @phases.init: should reset local state only. Takes a bool @cold argum=
ent
+ * specifying whether the reset is cold or warm. It must not do side-eff=
ect
+ * on others objects.
+ *
+ * @phases.hold: side-effects action on others objects due to staying in=
 a
+ * resetting state.
+ *
+ * @phases.exit: leave the reset state, may do side-effects action on ot=
hers
+ * objects.
+ *
+ * @set_cold: Set whether the current reset is cold or warm. Return the
+ * previous flag value. Return value has no meaning if @get_count return=
s
+ * a zero value.
+ *
+ * @set_hold_needed: Set hold_needed flag. Return the previous flag valu=
e.
+ *
+ * @get_count: Get the current reset count
+ * @increment_count: Increment the reset count, returns the new count
+ * @decrement_count: decrement the reset count, returns the new count
+ *
+ * @foreach_child: Executes a given function on every Resettable child.
+ * A child is not a QOM child, but a child a reset meaning.
+ */
+typedef void (*ResettableInitPhase)(Object *obj);
+typedef void (*ResettableHoldPhase)(Object *obj);
+typedef void (*ResettableExitPhase)(Object *obj);
+typedef bool (*ResettableSetCold)(Object *obj, bool cold);
+typedef bool (*ResettableSetHoldNeeded)(Object *obj, bool hold_needed);
+typedef uint32_t (*ResettableGetCount)(Object *obj);
+typedef uint32_t (*ResettableIncrementCount)(Object *obj);
+typedef uint32_t (*ResettableDecrementCount)(Object *obj);
+typedef void (*ResettableForeachChild)(Object *obj, void (*visitor)(Obje=
ct *));
+typedef struct ResettableClass {
+    InterfaceClass parent_class;
+
+    struct ResettablePhases {
+        ResettableInitPhase init;
+        ResettableHoldPhase hold;
+        ResettableExitPhase exit;
+    } phases;
+
+    ResettableSetCold set_cold;
+    ResettableSetHoldNeeded set_hold_needed;
+    ResettableGetCount get_count;
+    ResettableIncrementCount increment_count;
+    ResettableDecrementCount decrement_count;
+    ResettableForeachChild foreach_child;
+} ResettableClass;
+typedef struct ResettablePhases ResettablePhases;
+
+/**
+ * resettable_assert_reset:
+ * Increments the reset count and executes the init and hold phases.
+ * Each time resettable_assert_reset is called, resettable_deassert_rese=
t
+ * must eventually be called once.
+ * It will also impact reset children.
+ *
+ * @obj object to reset, must implement Resettable interface.
+ * @cold boolean indicating the type of reset (cold or warm)
+ */
+void resettable_assert_reset(Object *obj, bool cold);
+
+/**
+ * resettable_deassert_reset:
+ * Decrements the reset count by one and executes the exit phase if it h=
its
+ * zero.
+ * It will also impact reset children.
+ *
+ * @obj object to reset, must implement Resettable interface.
+ */
+void resettable_deassert_reset(Object *obj);
+
+/**
+ * resettable_reset:
+ * Calling this function is equivalent to call @assert_reset then
+ * @deassert_reset.
+ */
+void resettable_reset(Object *obj, bool cold);
+
+/**
+ * resettable_reset_warm_fn:
+ * Helper to call resettable_reset(opaque, false)
+ */
+void resettable_reset_warm_fn(void *opaque);
+
+/**
+ * resettable_reset_cold_fn:
+ * Helper to call resettable_reset(opaque, true)
+ */
+void resettable_reset_cold_fn(void *opaque);
+
+/**
+ * resettable_class_set_parent_reset_phases:
+ *
+ * Save @rc current reset phases into @parent_phases and override @rc ph=
ases
+ * by the given new methods (@init, @hold and @exit).
+ * Each phase is overriden only if the new one is not NULL allowing to
+ * override a subset of phases.
+ */
+void resettable_class_set_parent_reset_phases(ResettableClass *rc,
+                                              ResettableInitPhase init,
+                                              ResettableHoldPhase hold,
+                                              ResettableExitPhase exit,
+                                              ResettablePhases *parent_p=
hases);
+
+#endif
--=20
2.22.0


