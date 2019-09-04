Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02824C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9B32073F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9B32073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.con
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5UwI-00035x-Ls
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 09:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.con>) id 1i5Rqu-0004s2-6b
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 05:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.con>) id 1i5Rqr-00007J-48
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 05:45:23 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:40540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.con>)
 id 1i5Rql-0008Mx-Gt; Wed, 04 Sep 2019 05:45:15 -0400
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 6973B96F51;
 Wed,  4 Sep 2019 09:38:47 +0000 (UTC)
From: damien.hedde@greensocs.con
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 11:38:35 +0200
Message-Id: <20190904093843.8765-2-damien.hedde@greensocs.con>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190904093843.8765-1-damien.hedde@greensocs.con>
References: <20190904093843.8765-1-damien.hedde@greensocs.con>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
X-Mailman-Approved-At: Wed, 04 Sep 2019 08:47:47 -0400
Subject: [Qemu-devel] [PATCH v6 1/9] hw/core/clock: introduce clock objects
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
 berrange@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 mark.burton@greensocs.com, pbonzini@redhat.com, qemu-arm@nongnu.org,
 marcandre.lureau@redhat.com, edgar.iglesias@gmail.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Damien Hedde <damien.hedde@greensocs.com>

Introduce clock objects: ClockIn and ClockOut.

These objects may be used to distribute clocks from an object to several
other objects. Each ClockIn object contains the current state of the
clock: the frequency; it allows an object to migrate its input clock stat=
e
independently of other objects.

A ClockIn may be connected to a ClockOut so that it receives update,
through a callback, whenever the Clockout is updated using the
ClockOut's set function.

This is based on the original work of Frederic Konrad.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 Makefile.objs         |   1 +
 hw/core/Makefile.objs |   1 +
 hw/core/clock.c       | 144 ++++++++++++++++++++++++++++++++++++++++++
 hw/core/trace-events  |   6 ++
 include/hw/clock.h    | 124 ++++++++++++++++++++++++++++++++++++
 5 files changed, 276 insertions(+)
 create mode 100644 hw/core/clock.c
 create mode 100644 include/hw/clock.h

diff --git a/Makefile.objs b/Makefile.objs
index a723a47e14..4da623c759 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -153,6 +153,7 @@ trace-events-subdirs +=3D hw/audio
 trace-events-subdirs +=3D hw/block
 trace-events-subdirs +=3D hw/block/dataplane
 trace-events-subdirs +=3D hw/char
+trace-events-subdirs +=3D hw/core
 trace-events-subdirs +=3D hw/dma
 trace-events-subdirs +=3D hw/hppa
 trace-events-subdirs +=3D hw/i2c
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 69b408ad1c..c66a5b2c6b 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -7,6 +7,7 @@ common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
 # irq.o needed for qdev GPIO handling:
 common-obj-y +=3D irq.o
 common-obj-y +=3D hotplug.o
+common-obj-y +=3D clock.o
 common-obj-$(CONFIG_SOFTMMU) +=3D nmi.o
 common-obj-$(CONFIG_SOFTMMU) +=3D vm-change-state-handler.o
=20
diff --git a/hw/core/clock.c b/hw/core/clock.c
new file mode 100644
index 0000000000..888f247f2a
--- /dev/null
+++ b/hw/core/clock.c
@@ -0,0 +1,144 @@
+/*
+ * Clock inputs and outputs
+ *
+ * Copyright GreenSocs 2016-2018
+ *
+ * Authors:
+ *  Frederic Konrad <fred.konrad@greensocs.com>
+ *  Damien Hedde <damien.hedde@greensocs.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/clock.h"
+#include "trace.h"
+
+#define CLOCK_PATH(_clk) (_clk->canonical_path)
+
+void clock_out_setup_canonical_path(ClockOut *clk)
+{
+    g_free(clk->canonical_path);
+    clk->canonical_path =3D object_get_canonical_path(OBJECT(clk));
+}
+
+void clock_in_setup_canonical_path(ClockIn *clk)
+{
+    g_free(clk->canonical_path);
+    clk->canonical_path =3D object_get_canonical_path(OBJECT(clk));
+}
+
+void clock_set_callback(ClockIn *clk, ClockCallback *cb, void *opaque)
+{
+    assert(clk);
+
+    clk->callback =3D cb;
+    clk->callback_opaque =3D opaque;
+}
+
+void clock_init_frequency(ClockIn *clk, uint64_t freq)
+{
+    assert(clk);
+
+    clk->frequency =3D freq;
+}
+
+void clock_clear_callback(ClockIn *clk)
+{
+    clock_set_callback(clk, NULL, NULL);
+}
+
+void clock_connect(ClockIn *clkin, ClockOut *clkout)
+{
+    assert(clkin && clkin->driver =3D=3D NULL);
+    assert(clkout);
+
+    trace_clock_connect(CLOCK_PATH(clkin), CLOCK_PATH(clkout));
+
+    QLIST_INSERT_HEAD(&clkout->followers, clkin, sibling);
+    clkin->driver =3D clkout;
+}
+
+static void clock_disconnect(ClockIn *clk)
+{
+    if (clk->driver =3D=3D NULL) {
+        return;
+    }
+
+    trace_clock_disconnect(CLOCK_PATH(clk));
+
+    clk->driver =3D NULL;
+    QLIST_REMOVE(clk, sibling);
+}
+
+void clock_set_frequency(ClockOut *clk, uint64_t freq)
+{
+    ClockIn *follower;
+    trace_clock_set_frequency(CLOCK_PATH(clk), freq);
+
+    QLIST_FOREACH(follower, &clk->followers, sibling) {
+        trace_clock_propagate(CLOCK_PATH(clk), CLOCK_PATH(follower));
+        if (follower->frequency !=3D freq) {
+            follower->frequency =3D freq;
+            if (follower->callback) {
+                follower->callback(follower->callback_opaque);
+            }
+        }
+    }
+}
+
+static void clock_out_initfn(Object *obj)
+{
+    ClockOut *clk =3D CLOCK_OUT(obj);
+
+    QLIST_INIT(&clk->followers);
+}
+
+static void clock_out_finalizefn(Object *obj)
+{
+    ClockOut *clk =3D CLOCK_OUT(obj);
+    ClockIn *follower, *next;
+
+    /* clear our list of followers */
+    QLIST_FOREACH_SAFE(follower, &clk->followers, sibling, next) {
+        clock_disconnect(follower);
+    }
+
+    g_free(clk->canonical_path);
+    clk->canonical_path =3D NULL;
+}
+
+static void clock_in_finalizefn(Object *obj)
+{
+    ClockIn *clk =3D CLOCK_IN(obj);
+
+    /* remove us from driver's followers list */
+    clock_disconnect(clk);
+
+    g_free(clk->canonical_path);
+    clk->canonical_path =3D NULL;
+}
+
+static const TypeInfo clock_out_info =3D {
+    .name              =3D TYPE_CLOCK_OUT,
+    .parent            =3D TYPE_OBJECT,
+    .instance_size     =3D sizeof(ClockOut),
+    .instance_init     =3D clock_out_initfn,
+    .instance_finalize =3D clock_out_finalizefn,
+};
+
+static const TypeInfo clock_in_info =3D {
+    .name              =3D TYPE_CLOCK_IN,
+    .parent            =3D TYPE_OBJECT,
+    .instance_size     =3D sizeof(ClockIn),
+    .instance_finalize =3D clock_in_finalizefn,
+};
+
+static void clock_register_types(void)
+{
+    type_register_static(&clock_in_info);
+    type_register_static(&clock_out_info);
+}
+
+type_init(clock_register_types)
diff --git a/hw/core/trace-events b/hw/core/trace-events
index ecf966c314..aa940e268b 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -34,3 +34,9 @@ resettable_phase_hold_end(void *obj, int needed) "obj=3D=
%p needed=3D%d"
 resettable_phase_exit(void *obj, const char *type) "obj=3D%p(%s)"
 resettable_phase_exit_end(void *obj, uint32_t count) "obj=3D%p count=3D%=
" PRIu32
 resettable_count_underflow(void *obj) "obj=3D%p"
+
+# hw/core/clock-port.c
+clock_connect(const char *clk, const char *driver) "'%s' drived-by '%s'"
+clock_disconnect(const char *clk) "'%s'"
+clock_set_frequency(const char *clk, uint64_t freq) "'%s' freq_hz=3D%" P=
RIu64
+clock_propagate(const char *clko, const char *clki) "'%s' =3D> '%s'"
diff --git a/include/hw/clock.h b/include/hw/clock.h
new file mode 100644
index 0000000000..fd11202ba4
--- /dev/null
+++ b/include/hw/clock.h
@@ -0,0 +1,124 @@
+#ifndef QEMU_HW_CLOCK_H
+#define QEMU_HW_CLOCK_H
+
+#include "qom/object.h"
+#include "qemu/queue.h"
+
+#define TYPE_CLOCK_IN "clock-in"
+#define CLOCK_IN(obj) OBJECT_CHECK(ClockIn, (obj), TYPE_CLOCK_IN)
+#define TYPE_CLOCK_OUT "clock-out"
+#define CLOCK_OUT(obj) OBJECT_CHECK(ClockOut, (obj), TYPE_CLOCK_OUT)
+
+typedef void ClockCallback(void *opaque);
+
+typedef struct ClockOut ClockOut;
+typedef struct ClockIn ClockIn;
+
+struct ClockIn {
+    /*< private >*/
+    Object parent_obj;
+    /*< private >*/
+    uint64_t frequency;
+    char *canonical_path; /* clock path cache */
+    ClockOut *driver; /* clock output controlling this clock */
+    ClockCallback *callback; /* local callback */
+    void *callback_opaque; /* opaque argument for the callback */
+    QLIST_ENTRY(ClockIn) sibling;  /* entry in a followers list */
+};
+
+struct ClockOut {
+    /*< private >*/
+    Object parent_obj;
+    /*< private >*/
+    char *canonical_path; /* clock path cache */
+    QLIST_HEAD(, ClockIn) followers; /* list of registered clocks */
+};
+
+/**
+ * clock_out_setup_canonical_path:
+ * @clk: clock
+ *
+ * compute the canonical path of the clock (used by log messages)
+ */
+void clock_out_setup_canonical_path(ClockOut *clk);
+
+/**
+ * clock_in_setup_canonical_path:
+ * @clk: clock
+ *
+ * compute the canonical path of the clock (used by log messages)
+ */
+void clock_in_setup_canonical_path(ClockIn *clk);
+
+/**
+ * clock_add_callback:
+ * @clk: the clock to register the callback into
+ * @cb: the callback function
+ * @opaque: the argument to the callback
+ *
+ * Register a callback called on every clock update.
+ */
+void clock_set_callback(ClockIn *clk, ClockCallback *cb, void *opaque);
+
+/**
+ * clock_clear_callback:
+ * @clk: the clock to delete the callback from
+ *
+ * Unregister the callback registered with clock_set_callback.
+ */
+void clock_clear_callback(ClockIn *clk);
+
+/**
+ * clock_init_frequency:
+ * @clk: the clock to initialize.
+ * @freq: the clock's frequency in Hz or 0 if unclocked.
+ *
+ * Initialize the local cached frequency value of @clk to @freq.
+ * Note: this function must only be called during device inititializatio=
n
+ * or migration.
+ */
+void clock_init_frequency(ClockIn *clk, uint64_t freq);
+
+/**
+ * clock_connect:
+ * @clkin: the drived clock.
+ * @clkout: the driving clock.
+ *
+ * Setup @clkout to drive @clkin: Any @clkout update will be propagated
+ * to @clkin.
+ */
+void clock_connect(ClockIn *clkin, ClockOut *clkout);
+
+/**
+ * clock_set_frequency:
+ * @clk: the clock to update.
+ * @freq: the new clock's frequency in Hz or 0 if unclocked.
+ *
+ * Update the @clk to the new @freq.
+ * This change will be propagated through registered clock inputs.
+ */
+void clock_set_frequency(ClockOut *clk, uint64_t freq);
+
+/**
+ * clock_get_frequency:
+ * @clk: the clk to fetch the clock
+ *
+ * @return: the current frequency of @clk in Hz. If @clk is NULL, return=
 0.
+ */
+static inline uint64_t clock_get_frequency(const ClockIn *clk)
+{
+    return clk ? clk->frequency : 0;
+}
+
+/**
+ * clock_is_enabled:
+ * @clk: a clock state
+ *
+ * @return: true if the clock is running. If @clk is NULL return false.
+ */
+static inline bool clock_is_enabled(const ClockIn *clk)
+{
+    return clock_get_frequency(clk) !=3D 0;
+}
+
+#endif /* QEMU_HW_CLOCK_H */
--=20
2.22.0


