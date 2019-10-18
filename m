Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8B9CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D02222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="gP0uOnw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D02222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLU7J-0002Tl-GK
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 11:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iLTrF-0006oN-RG
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iLTrC-0000Jd-NC
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:08:01 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:38650)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iLTr5-0000C0-Ol; Fri, 18 Oct 2019 11:07:52 -0400
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 3E49696F51;
 Fri, 18 Oct 2019 15:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1571411270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwhi/uzgewkp6apuMSLyeKjVzFR+jEBviLDTLa1uf+k=;
 b=gP0uOnw+b+b//355dm54WLDWApORagBpctJuyAhC6G+O/bfbxIaeqvqt+w4XZynEYlbZ63
 kT/zreo3VBXCPio60Zz5WSrlwZYT2VHvBfHNEoYYPlUzRXIKizd0r7v38WPTgojoXpEEOe
 En3SM64Jt9iiUkcjjLvUCsjWw9LLodA=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 03/13] hw/core: create Resettable QOM interface
Date: Fri, 18 Oct 2019 17:06:20 +0200
Message-Id: <20191018150630.31099-4-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018150630.31099-1-damien.hedde@greensocs.com>
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1571411270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwhi/uzgewkp6apuMSLyeKjVzFR+jEBviLDTLa1uf+k=;
 b=JD4yzSsJOQWanbv22V7ZC6/xiQ7U65lkfDWUPAE3LGHLxMVVsU8/83MLzDonEX3NvNoJDv
 N8C98jeG1pYDd6yevqeGllqW+MQ+uOVhuiL7KCAp+KDVep2E+FNKNvhv6+ncfFKvJ+Oz7y
 6SGSEwnAFuv3om5+fHFy0LaLqdViJ+Q=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1571411270; a=rsa-sha256; cv=none;
 b=S6H6nAaT2kwmnrMGqw+gHMdHt7dYFQ5AyRTQWbEvmv/GyxbwhSa5US1GcBIl7fpbAmKB7G
 7xZ6SikGWPI4rqIo28TlcmjWy5NC2h8x3AplkZho+iYL50rReTu3FQLXd8exPDByQnnyjW
 8Ah6TODw5O7qrANHbyVA7zlKSHlhy7k=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 berrange@redhat.com, ehabkost@redhat.com, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit defines an interface allowing multi-phase reset. This aims
to solve a problem of the actual single-phase reset (built in
DeviceClass and BusClass): reset behavior is dependent on the order
in which reset handlers are called. In particular doing external
side-effect (like setting an qemu_irq) is problematic because receiving
object may not be reset yet.

The Resettable interface divides the reset in 3 well defined phases.
To reset an object tree, all 1st phases are executed then all 2nd then
all 3rd. See the comments in include/hw/resettable.h for a more complete
description. The interface defines 3 phases to let the future
possibility of holding an object into reset for some time.

The qdev/qbus reset in DeviceClass and BusClass will be modified in
following commits to use this interface. A mechanism is provided
to allow executing a transitional reset handler in place of the 2nd
phase which is executed in children-then-parent order inside a tree.
This will allow to transition devices and buses smoothly while
keeping the exact current qdev/qbus reset behavior for now.

Documentation will be added in a following commit.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---

In this patch only a single reset type is supported, but the interface
allows for more to be defined.

I had some thought about problems which may arise when having multiple
reset types:

- reset type propagation. Right now we propagate the same reset type
  to the children. I don't think it will work that with multiple
  types.
  For example, if we add pci_bus_reset type: a pci device will
  implement the reset type but not its children (they may have
  nothing to do with pci).
  This can be solved by changing the child_foreach method rules.
  We should say that child_foreach may change the type it
  propagates to its children (on a children by children basis).
  For example, the pci device may just propagate cold reset type
  to its children.
  For this we need to pass the type as parameter to child_foreach()
  method.

- are all children concerned ? For a given reset type, some child
  may not need to be reset. As above we can handle that with
  child_foreach: an resettable object can propagate the reset only
  to a partial set of its child.
  For this we need to know the type when we release the reset,
  that's why I added it to resettable_release_reset() even if it
  is unused right now.
  I've also added an opaque parameter to child_foreach. I think
  we will need that to handle the change of parent because we
  will need to test if a child is concerned by a reset type: the
  opaque will allow to use a test callback and get some result.

- several reset types at the same time. I don't another solution
  than saying we execute *enter* and *hold* phase for every reset
  type. *exit* will still be executed once for all at the end.
  It will be up for each object to cope with it if it handle
  multiple reset types. For *enter* is trivial, calling it twice
  in a row is no problem given that it should only reset internal
  state. For *hold* there may be some complication.

- Obviously we will need to at least an interface class field to hold
  the supported reset types by the class. Also the reset state will
  need some modification.
---
 Makefile.objs           |   1 +
 hw/core/Makefile.objs   |   1 +
 hw/core/resettable.c    | 230 ++++++++++++++++++++++++++++++++++++++++
 hw/core/trace-events    |  17 +++
 include/hw/resettable.h | 199 ++++++++++++++++++++++++++++++++++
 5 files changed, 448 insertions(+)
 create mode 100644 hw/core/resettable.c
 create mode 100644 include/hw/resettable.h

diff --git a/Makefile.objs b/Makefile.objs
index abcbd89654..9c3fc37e29 100644
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
index fd0550d1d9..18f5ddebce 100644
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
index 0000000000..c5e11cff4f
--- /dev/null
+++ b/hw/core/resettable.c
@@ -0,0 +1,230 @@
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
+/**
+ * resettable_phase_enter/hold/exit:
+ * Function executing a phase recursively in a resettable object and its
+ * children.
+ */
+static void resettable_phase_enter(Object *obj, void *opaque, ResetType =
type);
+static void resettable_phase_hold(Object *obj, void *opaque, ResetType t=
ype);
+static void resettable_phase_exit(Object *obj, void *opaque, ResetType t=
ype);
+
+/**
+ * enter_phase_in_progress:
+ * Flag telling whether we are currently in an enter phase where side
+ * effects are forbidden. This flag allows us to catch if reset is calle=
d
+ * again during during this phase.
+ */
+static bool enter_phase_in_progress;
+
+void resettable_reset(Object *obj, ResetType type)
+{
+    trace_resettable_reset(obj, type);
+    resettable_assert_reset(obj, type);
+    resettable_release_reset(obj, type);
+}
+
+void resettable_assert_reset(Object *obj, ResetType type)
+{
+    assert(!enter_phase_in_progress);
+    /* TODO: change that assert when adding support for other reset type=
s */
+    assert(type =3D=3D RESET_TYPE_COLD);
+    trace_resettable_reset_assert_begin(obj, type);
+    enter_phase_in_progress =3D true;
+    resettable_phase_enter(obj, NULL, type);
+    enter_phase_in_progress =3D false;
+    resettable_phase_hold(obj, NULL, type);
+    trace_resettable_reset_assert_end(obj);
+}
+
+void resettable_release_reset(Object *obj, ResetType type)
+{
+    assert(!enter_phase_in_progress);
+    /* TODO: change that assert when adding support for other reset type=
s */
+    assert(type =3D=3D RESET_TYPE_COLD);
+    trace_resettable_reset_release_begin(obj, type);
+    resettable_phase_exit(obj, NULL, type);
+    trace_resettable_reset_release_end(obj);
+}
+
+bool resettable_is_in_reset(Object *obj)
+{
+    ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
+    ResettableState *s =3D rc->get_state(obj);
+
+    return (s->count > 0);
+}
+
+/**
+ * resettable_child_foreach:
+ * helper to avoid checking the existence of the method.
+ */
+static void resettable_child_foreach(ResettableClass *rc, Object *obj,
+                                     ResettableChildCallback cb,
+                                     void *opaque, ResetType type)
+{
+    if (rc->child_foreach) {
+        rc->child_foreach(obj, cb, opaque, type);
+    }
+}
+
+/**
+ * resettable_get_tr_func:
+ * helper to fetch transitional reset callback if any.
+ */
+static ResettableTrFunction resettable_get_tr_func(ResettableClass *rc,
+                                                   Object *obj)
+{
+    ResettableTrFunction tr_func =3D NULL;
+    if (rc->get_transitional_function) {
+        tr_func =3D rc->get_transitional_function(obj);
+    }
+    return tr_func;
+}
+
+static void resettable_phase_enter(Object *obj, void *opaque, ResetType =
type)
+{
+    ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
+    ResettableState *s =3D rc->get_state(obj);
+    const char *obj_typename =3D object_get_typename(obj);
+    bool action_needed =3D false;
+
+    /* exit phase has to finish properly before entering back in reset *=
/
+    assert(!s->exit_phase_in_progress);
+
+    trace_resettable_phase_enter_begin(obj, obj_typename, s->count, type=
);
+
+    /* Only take action if we really enter reset for the 1st time. */
+    /*
+     * TODO: if adding more ResetType support, some additional checks
+     * are probably needed here.
+     */
+    if (s->count++ =3D=3D 0) {
+        action_needed =3D true;
+    }
+    /*
+     * We limit the count to an arbitrary "big" value. The value is big
+     * enough not to be triggered nominally.
+     * The assert will stop an infinite loop if there is a cycle in the
+     * reset tree. The loop goes through resettable_foreach_child below
+     * which at some point will call us again.
+     */
+    assert(s->count <=3D 50);
+
+    /*
+     * handle the children even if action_needed is at false so that
+     * children counts are incremented too
+     */
+    resettable_child_foreach(rc, obj, resettable_phase_enter, NULL, type=
);
+
+    /* execute enter phase for the object if needed */
+    if (action_needed) {
+        trace_resettable_phase_enter_exec(obj, obj_typename, type,
+                                          !!rc->phases.enter);
+        if (rc->phases.enter && !resettable_get_tr_func(rc, obj)) {
+            rc->phases.enter(obj, type);
+        }
+        s->hold_phase_pending =3D true;
+    }
+    trace_resettable_phase_enter_end(obj, obj_typename, s->count);
+}
+
+static void resettable_phase_hold(Object *obj, void *opaque, ResetType t=
ype)
+{
+    ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
+    ResettableState *s =3D rc->get_state(obj);
+    const char *obj_typename =3D object_get_typename(obj);
+
+    /* exit phase has to finish properly before entering back in reset *=
/
+    assert(!s->exit_phase_in_progress);
+
+    trace_resettable_phase_hold_begin(obj, obj_typename, s->count, type)=
;
+
+    /* handle children first */
+    resettable_child_foreach(rc, obj, resettable_phase_hold, NULL, type)=
;
+
+    /* exec hold phase */
+    if (s->hold_phase_pending) {
+        s->hold_phase_pending =3D false;
+        ResettableTrFunction tr_func =3D resettable_get_tr_func(rc, obj)=
;
+        trace_resettable_phase_hold_exec(obj, obj_typename, !!rc->phases=
.hold);
+        if (tr_func) {
+            trace_resettable_transitional_function(obj, obj_typename);
+            tr_func(obj);
+        } else if (rc->phases.hold) {
+            rc->phases.hold(obj);
+        }
+    }
+    trace_resettable_phase_hold_end(obj, obj_typename, s->count);
+}
+
+static void resettable_phase_exit(Object *obj, void *opaque, ResetType t=
ype)
+{
+    ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
+    ResettableState *s =3D rc->get_state(obj);
+    const char *obj_typename =3D object_get_typename(obj);
+
+    assert(!s->exit_phase_in_progress);
+    trace_resettable_phase_exit_begin(obj, obj_typename, s->count, type)=
;
+
+    /* exit_phase_in_progress ensure this phase is 'atomic' */
+    s->exit_phase_in_progress =3D true;
+    resettable_child_foreach(rc, obj, resettable_phase_exit, NULL, type)=
;
+
+    assert(s->count > 0);
+    if (s->count =3D=3D 1) {
+        trace_resettable_phase_exit_exec(obj, obj_typename, !!rc->phases=
.exit);
+        if (rc->phases.exit && !resettable_get_tr_func(rc, obj)) {
+            rc->phases.exit(obj);
+        }
+        s->count =3D 0;
+    }
+    s->exit_phase_in_progress =3D false;
+    trace_resettable_phase_exit_end(obj, obj_typename, s->count);
+}
+
+void resettable_class_set_parent_phases(ResettableClass *rc,
+                                        ResettableEnterPhase enter,
+                                        ResettableHoldPhase hold,
+                                        ResettableExitPhase exit,
+                                        ResettablePhases *parent_phases)
+{
+    *parent_phases =3D rc->phases;
+    if (enter) {
+        rc->phases.enter =3D enter;
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
+    .name       =3D TYPE_RESETTABLE_INTERFACE,
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
index 1a669be0ea..66081d0fb4 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -9,3 +9,20 @@ qbus_reset(void *obj, const char *objtype) "obj=3D%p(%s)=
"
 qbus_reset_all(void *obj, const char *objtype) "obj=3D%p(%s)"
 qbus_reset_tree(void *obj, const char *objtype) "obj=3D%p(%s)"
 qdev_update_parent_bus(void *obj, void *oldp, void *newp) "obj=3D%p old_=
parent=3D%p new_parent=3D%p"
+
+# resettable.c
+resettable_reset(void *obj, int cold) "obj=3D%p cold=3D%d"
+resettable_reset_assert_begin(void *obj, int cold) "obj=3D%p cold=3D%d"
+resettable_reset_assert_end(void *obj) "obj=3D%p"
+resettable_reset_release_begin(void *obj, int cold) "obj=3D%p cold=3D%d"
+resettable_reset_release_end(void *obj) "obj=3D%p"
+resettable_phase_enter_begin(void *obj, const char *objtype, uint32_t co=
unt, int type) "obj=3D%p(%s) count=3D%" PRIu32 " type=3D%d"
+resettable_phase_enter_exec(void *obj, const char *objtype, int type, in=
t has_method) "obj=3D%p(%s) type=3D%d method=3D%d"
+resettable_phase_enter_end(void *obj, const char *objtype, uint32_t coun=
t) "obj=3D%p(%s) count=3D%" PRIu32
+resettable_phase_hold_begin(void *obj, const char *objtype, uint32_t cou=
nt, int type) "obj=3D%p(%s) count=3D%" PRIu32 " type=3D%d"
+resettable_phase_hold_exec(void *obj, const char *objtype, int has_metho=
d) "obj=3D%p(%s) method=3D%d"
+resettable_phase_hold_end(void *obj, const char *objtype, uint32_t count=
) "obj=3D%p(%s) count=3D%" PRIu32
+resettable_phase_exit_begin(void *obj, const char *objtype, uint32_t cou=
nt, int type) "obj=3D%p(%s) count=3D%" PRIu32 " type=3D%d"
+resettable_phase_exit_exec(void *obj, const char *objtype, int has_metho=
d) "obj=3D%p(%s) method=3D%d"
+resettable_phase_exit_end(void *obj, const char *objtype, uint32_t count=
) "obj=3D%p(%s) count=3D%" PRIu32
+resettable_transitional_function(void *obj, const char *objtype) "obj=3D=
%p(%s)"
diff --git a/include/hw/resettable.h b/include/hw/resettable.h
new file mode 100644
index 0000000000..6b24e1633b
--- /dev/null
+++ b/include/hw/resettable.h
@@ -0,0 +1,199 @@
+#ifndef HW_RESETTABLE_H
+#define HW_RESETTABLE_H
+
+#include "qom/object.h"
+
+#define TYPE_RESETTABLE_INTERFACE "resettable"
+
+#define RESETTABLE_CLASS(class) \
+    OBJECT_CLASS_CHECK(ResettableClass, (class), TYPE_RESETTABLE_INTERFA=
CE)
+
+#define RESETTABLE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(ResettableClass, (obj), TYPE_RESETTABLE_INTERFACE)
+
+typedef struct ResettableState ResettableState;
+
+/**
+ * ResetType:
+ * Types of reset.
+ *
+ * + Cold: reset resulting from a power cycle of the object.
+ *
+ * TODO: Support has to be added to handle more types. In particular,
+ * ResettableState structure needs to be expanded.
+ */
+typedef enum ResetType {
+    RESET_TYPE_COLD,
+} ResetType;
+
+/*
+ * ResettableClass:
+ * Interface for resettable objects.
+ *
+ * See docs/devel/reset.rst for more detailed information about
+ * how QEMU models reset.
+ *
+ * All objects which can be reset must implement this interface;
+ * it is usually provided by a base class such as DeviceClass or BusClas=
s.
+ * Every Resettable object must maintain some state tracking the
+ * progress of a reset operation by providing a ResettableState structur=
e.
+ * The functions defined in this module take care of updating the
+ * state of the reset.
+ * The base class implementation of the interface provides this
+ * state and implements the associated method: get_state.
+ *
+ * Concrete object implementations (typically specific devices
+ * such as a UART model) should provide the functions
+ * for the phases.enter, phases.hold and phases.exit methods, which
+ * they can set in their class init function, either directly or
+ * by calling resettable_class_set_parent_phases().
+ * The phase methods are guaranteed to only only ever be called once
+ * for any reset event, in the order 'enter', 'hold', 'exit'.
+ * An object will always move quickly from 'enter' to 'hold'
+ * but might remain in 'hold' for an arbitrary period of time
+ * before eventually reset is deasserted and the 'exit' phase is called.
+ * Object implementations should be prepared for functions handling
+ * inbound connections from other devices (such as qemu_irq handler
+ * functions) to be called at any point during reset after their
+ * 'enter' method has been called.
+ *
+ * Users of a resettable object should not call these methods
+ * directly, but instead use the function resettable_reset().
+ *
+ * @phases.enter: This phase is called when the object enters reset. It
+ * should reset local state of the object, but it must not do anything t=
hat
+ * has a side-effect on other objects, such as raising or lowering a qem=
u_irq
+ * line or reading or writing guest memory. It takes the reset's type as
+ * argument.
+ *
+ * @phases.hold: This phase is called for entry into reset, once every o=
bject
+ * in the system which is being reset has had its @phases.enter method c=
alled.
+ * At this point devices can do actions that affect other objects.
+ *
+ * @phases.exit: This phase is called when the object leaves the reset s=
tate.
+ * Actions affecting other objects are permitted.
+ *
+ * @get_state: Mandatory method which must return a pointer to a
+ * ResettableState.
+ *
+ * @get_transitional_function: transitional method to handle Resettable =
objects
+ * not yet fully moved to this interface. It will be removed as soon as =
is not
+ * needed anymore. This method is optional and may return a pointer to a
+ * function to be used instead of the phases. In case the method exists =
and
+ * returns a non-NULL function pointer; it is executed as a replacement =
of the
+ * 'hold' phase method taking the object as argument. The two other phas=
e
+ * methods are not executed.
+ *
+ * @child_foreach: Executes a given callback on every Resettable child. =
Child
+ * in this context means a child in the qbus tree, so the children of a =
qbus
+ * are the devices on it, and the children of a device are all the buses=
 it
+ * owns. This is not the same as the QOM object hierarchy. The function =
takes
+ * additional opaque and ResetType arguments which must be passed unmodi=
fied to
+ * the callback.
+ */
+typedef void (*ResettableEnterPhase)(Object *obj, ResetType type);
+typedef void (*ResettableHoldPhase)(Object *obj);
+typedef void (*ResettableExitPhase)(Object *obj);
+typedef ResettableState * (*ResettableGetState)(Object *obj);
+typedef void (*ResettableTrFunction)(Object *obj);
+typedef ResettableTrFunction (*ResettableGetTrFunction)(Object *obj);
+typedef void (*ResettableChildCallback)(Object *, void *opaque,
+                                        ResetType type);
+typedef void (*ResettableChildForeach)(Object *obj,
+                                       ResettableChildCallback cb,
+                                       void *opaque, ResetType type);
+typedef struct ResettableClass {
+    InterfaceClass parent_class;
+
+    /* Phase methods */
+    struct ResettablePhases {
+        ResettableEnterPhase enter;
+        ResettableHoldPhase hold;
+        ResettableExitPhase exit;
+    } phases;
+
+    /* State access method */
+    ResettableGetState get_state;
+
+    /* Transitional method for legacy reset compatibility */
+    ResettableGetTrFunction get_transitional_function;
+
+    /* Hiearchy handling method */
+    ResettableChildForeach child_foreach;
+} ResettableClass;
+typedef struct ResettablePhases ResettablePhases;
+
+/**
+ * ResettableState:
+ * Structure holding reset related state. The fields should not be acces=
sed
+ * directly, the definition is here to allow further inclusion into othe=
r
+ * objects.
+ *
+ * @count: Number of reset level the object is into. It is incremented w=
hen
+ * the reset operation starts and decremented when it finishes.
+ * @hold_phase_pending: flag which indicates that we need to invoke the =
'hold'
+ * phase handler for this object.
+ * @exit_phase_in_progress: flag telling if currently in exit phase
+ */
+struct ResettableState {
+    uint32_t count;
+    bool hold_phase_pending;
+    bool exit_phase_in_progress;
+};
+
+/**
+ * resettable_reset:
+ * Trigger a reset on a object @obj of type @type. @obj must implement
+ * Resettable interface.
+ *
+ * Calling this function is equivalent to calling @resettable_assert_res=
et()
+ * then @resettable_release_reset().
+ */
+void resettable_reset(Object *obj, ResetType type);
+
+/**
+ * resettable_assert_reset:
+ * Put an object @obj into reset. @obj must implement Resettable interfa=
ce.
+ *
+ * @resettable_release_reset() must eventually be called after this call=
.
+ * There must be one call to @resettable_release_reset() per call of
+ * @resettable_assert_reset(), with the same type argument.
+ *
+ * NOTE: Until support for migration is added, the @resettable_release_r=
eset()
+ * must not be delayed. It have to occur just after @resettable_assert_r=
eset()
+ * so that migration cannot be triggered in between. Prefer using
+ * @resettable_reset() for now.
+ */
+void resettable_assert_reset(Object *obj, ResetType type);
+
+/**
+ * resettable_release_reset:
+ * Release the object @obj from reset. @obj must implement Resettable in=
terface.
+ *
+ * See @resettable_assert_reset() description for details.
+ */
+void resettable_release_reset(Object *obj, ResetType type);
+
+/**
+ * resettable_is_in_reset:
+ * Return true if @obj is under reset.
+ *
+ * @obj must implement Resettable interface.
+ */
+bool resettable_is_in_reset(Object *obj);
+
+/**
+ * resettable_class_set_parent_phases:
+ *
+ * Save @rc current reset phases into @parent_phases and override @rc ph=
ases
+ * by the given new methods (@enter, @hold and @exit).
+ * Each phase is overridden only if the new one is not NULL allowing to
+ * override a subset of phases.
+ */
+void resettable_class_set_parent_phases(ResettableClass *rc,
+                                        ResettableEnterPhase enter,
+                                        ResettableHoldPhase hold,
+                                        ResettableExitPhase exit,
+                                        ResettablePhases *parent_phases)=
;
+
+#endif
--=20
2.23.0


