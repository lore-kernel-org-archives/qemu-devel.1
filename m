Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492E7C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:20:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4542087E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4542087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOWjG-0002YT-8I
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 21:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOWPC-0001S5-J8
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOWP9-0005Cu-6k
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:54 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49108)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOWP8-00052c-NL
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:51 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 2B6703074839; Wed, 15 Apr 2020 03:59:36 +0300 (EEST)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 175AE305B7A0;
 Wed, 15 Apr 2020 03:59:36 +0300 (EEST)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 21/26] kvm: vmi: postpone the OK response from
 qmp_stop()
Date: Wed, 15 Apr 2020 03:59:33 +0300
Message-Id: <20200415005938.23895-22-alazar@bitdefender.com>
In-Reply-To: <20200415005938.23895-1-alazar@bitdefender.com>
References: <20200415005938.23895-1-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.199.104.161
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
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The method to postpone the intercepted command (pause/suspend/migrate)
until the introspection tool has the chance to remove its hooks
(e.g. breakpoints) from guest doesn't work on snapshot+memory (at
least as it is done by libvirt/virt-manager 1.3.1). The sequence
qmp_stop()+save_vm+qmp_cont() doesn't wait for the STOP event.  save_vm()
is called right after qmp_stop() returns OK. What we do is postpone
this OK response until the introspection tools finishes the unhook
process.

CC: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
---
 accel/kvm/vmi.c                | 29 +++++++++++++++++++++++++++++
 accel/stubs/vmi-stubs.c        |  7 +++++++
 include/monitor/monitor.h      |  1 +
 include/sysemu/vmi-intercept.h |  2 +-
 monitor/Makefile.objs          |  2 +-
 monitor/qmp.c                  | 11 +++++++++++
 monitor/stubs.c                |  9 +++++++++
 7 files changed, 59 insertions(+), 2 deletions(-)
 create mode 100644 monitor/stubs.c

diff --git a/accel/kvm/vmi.c b/accel/kvm/vmi.c
index ea7191e48d..01034d460e 100644
--- a/accel/kvm/vmi.c
+++ b/accel/kvm/vmi.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qemu/error-report.h"
 #include "qom/object_interfaces.h"
 #include "sysemu/sysemu.h"
@@ -23,6 +24,8 @@
 #include "migration/vmstate.h"
 #include "migration/migration.h"
 #include "migration/misc.h"
+#include "qapi/qmp/qobject.h"
+#include "monitor/monitor.h"
=20
 #include "sysemu/vmi-intercept.h"
 #include "sysemu/vmi-handshake.h"
@@ -63,6 +66,9 @@ typedef struct VMIntrospection {
     Notifier migration_state_change;
     bool created_from_command_line;
=20
+    void *qmp_monitor;
+    QDict *qmp_rsp;
+
     bool kvmi_hooked;
 } VMIntrospection;
=20
@@ -333,6 +339,8 @@ static void instance_finalize(Object *obj)
=20
     error_free(i->init_error);
=20
+    qobject_unref(i->qmp_rsp);
+
     ic->instance_counter--;
     if (!ic->instance_counter) {
         ic->uniq =3D NULL;
@@ -506,6 +514,12 @@ static void continue_with_the_intercepted_action(VMI=
ntrospection *i)
=20
     info_report("VMI: continue with '%s'",
                 action_string[i->intercepted_action]);
+
+    if (i->qmp_rsp) {
+        monitor_qmp_respond_later(i->qmp_monitor, i->qmp_rsp);
+        i->qmp_monitor =3D NULL;
+        i->qmp_rsp =3D NULL;
+    }
 }
=20
 /*
@@ -676,6 +690,21 @@ static VMIntrospection *vm_introspection_object(void=
)
     return ic ? ic->uniq : NULL;
 }
=20
+bool vm_introspection_qmp_delay(void *mon, QDict *rsp)
+{
+    VMIntrospection *i =3D vm_introspection_object();
+    bool intercepted;
+
+    intercepted =3D i && i->intercepted_action =3D=3D VMI_INTERCEPT_SUSP=
END;
+
+    if (intercepted) {
+        i->qmp_monitor =3D mon;
+        i->qmp_rsp =3D rsp;
+    }
+
+    return intercepted;
+}
+
 /*
  * This ioctl succeeds only when KVM signals the introspection tool.
  * (the socket is connected and the event was sent without error).
diff --git a/accel/stubs/vmi-stubs.c b/accel/stubs/vmi-stubs.c
index 1bd93b2ca5..0cb1d6572b 100644
--- a/accel/stubs/vmi-stubs.c
+++ b/accel/stubs/vmi-stubs.c
@@ -1,7 +1,14 @@
 #include "qemu/osdep.h"
+#include "qapi/qmp/qdict.h"
+
 #include "sysemu/vmi-intercept.h"
=20
 bool vm_introspection_intercept(VMI_intercept_command ic, Error **errp)
 {
     return false;
 }
+
+bool vm_introspection_qmp_delay(void *mon, QDict *rsp)
+{
+    return false;
+}
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 1018d754a6..1b3debc635 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -47,5 +47,6 @@ int monitor_fdset_get_fd(int64_t fdset_id, int flags);
 int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd);
 void monitor_fdset_dup_fd_remove(int dup_fd);
 int64_t monitor_fdset_dup_fd_find(int dup_fd);
+void monitor_qmp_respond_later(void *_mon, QDict *rsp);
=20
 #endif /* MONITOR_H */
diff --git a/include/sysemu/vmi-intercept.h b/include/sysemu/vmi-intercep=
t.h
index b4a9a3faa7..4b93d17f2b 100644
--- a/include/sysemu/vmi-intercept.h
+++ b/include/sysemu/vmi-intercept.h
@@ -19,6 +19,6 @@ typedef enum {
 } VMI_intercept_command;
=20
 bool vm_introspection_intercept(VMI_intercept_command ic, Error **errp);
-bool vm_introspection_qmp_delay(void *mon, QObject *id, bool resume);
+bool vm_introspection_qmp_delay(void *mon, QDict *rsp);
=20
 #endif /* QEMU_VMI_INTERCEPT_H */
diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
index a8533c9dd7..16652ed162 100644
--- a/monitor/Makefile.objs
+++ b/monitor/Makefile.objs
@@ -3,4 +3,4 @@ common-obj-y +=3D monitor.o qmp.o hmp.o
 common-obj-y +=3D qmp-cmds.o qmp-cmds-control.o
 common-obj-y +=3D hmp-cmds.o
=20
-storage-daemon-obj-y +=3D monitor.o qmp.o qmp-cmds-control.o
+storage-daemon-obj-y +=3D monitor.o qmp.o qmp-cmds-control.o stubs.o
diff --git a/monitor/qmp.c b/monitor/qmp.c
index f89e7daf27..fc9ea7eafa 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -32,6 +32,7 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qstring.h"
+#include "sysemu/vmi-intercept.h"
 #include "trace.h"
=20
 struct QMPRequest {
@@ -158,6 +159,16 @@ static void monitor_qmp_dispatch(MonitorQMP *mon, QO=
bject *req)
         }
     }
=20
+    if (!vm_introspection_qmp_delay(mon, rsp)) {
+        monitor_qmp_respond(mon, rsp);
+        qobject_unref(rsp);
+    }
+}
+
+void monitor_qmp_respond_later(void *_mon, QDict *rsp)
+{
+    MonitorQMP *mon =3D _mon;
+
     monitor_qmp_respond(mon, rsp);
     qobject_unref(rsp);
 }
diff --git a/monitor/stubs.c b/monitor/stubs.c
new file mode 100644
index 0000000000..fc5707ae13
--- /dev/null
+++ b/monitor/stubs.c
@@ -0,0 +1,9 @@
+#include "qemu/osdep.h"
+#include "qapi/qmp/qdict.h"
+
+#include "sysemu/vmi-intercept.h"
+
+bool vm_introspection_qmp_delay(void *mon, QDict *rsp)
+{
+    return false;
+}

