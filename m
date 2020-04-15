Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F468C352BE
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C7720732
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C7720732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOWcP-0001Si-Id
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 21:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOWPC-0001RE-BP
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOWP9-0005Cp-5D
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:54 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49106)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOWP8-00052Q-Ih
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:51 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 165A53074838; Wed, 15 Apr 2020 03:59:36 +0300 (EEST)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id EE47F305B7A4;
 Wed, 15 Apr 2020 03:59:35 +0300 (EEST)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 20/26] kvm: vmi: intercept live migration
Date: Wed, 15 Apr 2020 03:59:32 +0300
Message-Id: <20200415005938.23895-21-alazar@bitdefender.com>
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
 Marian Rotariu <marian.c.rotariu@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marian Rotariu <marian.c.rotariu@gmail.com>

It is possible that the introspection tool has made some changes inside
the introspected VM which can make the guest crash if the introspection
connection is suddenly closed.

When the live migration starts, for now, the introspection tool is
signaled to remove its hooks from the introspected VM.

CC: Juan Quintela <quintela@redhat.com>
CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Marian Rotariu <marian.c.rotariu@gmail.com>
Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
---
 accel/kvm/vmi.c                | 31 +++++++++++++++++++++++++++----
 include/sysemu/vmi-intercept.h |  1 +
 migration/migration.c          | 18 +++++++++++++++---
 migration/migration.h          |  2 ++
 4 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/accel/kvm/vmi.c b/accel/kvm/vmi.c
index 90906478b4..ea7191e48d 100644
--- a/accel/kvm/vmi.c
+++ b/accel/kvm/vmi.c
@@ -21,6 +21,8 @@
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 #include "migration/vmstate.h"
+#include "migration/migration.h"
+#include "migration/misc.h"
=20
 #include "sysemu/vmi-intercept.h"
 #include "sysemu/vmi-handshake.h"
@@ -58,6 +60,7 @@ typedef struct VMIntrospection {
     int64_t vm_start_time;
=20
     Notifier machine_ready;
+    Notifier migration_state_change;
     bool created_from_command_line;
=20
     bool kvmi_hooked;
@@ -74,9 +77,11 @@ static const char *action_string[] =3D {
     "suspend",
     "resume",
     "force-reset",
+    "migrate",
 };
=20
 static bool suspend_pending;
+static bool migrate_pending;
=20
 #define TYPE_VM_INTROSPECTION "introspection"
=20
@@ -88,6 +93,15 @@ static bool suspend_pending;
 static Error *vm_introspection_init(VMIntrospection *i);
 static void vm_introspection_reset(void *opaque);
=20
+static void migration_state_notifier(Notifier *notifier, void *data)
+{
+    MigrationState *s =3D data;
+
+    if (migration_has_failed(s)) {
+        migrate_pending =3D false;
+    }
+}
+
 static void machine_ready(Notifier *notifier, void *data)
 {
     VMIntrospection *i =3D container_of(notifier, VMIntrospection, machi=
ne_ready);
@@ -144,6 +158,9 @@ static void complete(UserCreatable *uc, Error **errp)
=20
     ic->uniq =3D i;
=20
+    i->migration_state_change.notify =3D migration_state_notifier;
+    add_migration_state_change_notifier(&i->migration_state_change);
+
     qemu_register_reset(vm_introspection_reset, i);
 }
=20
@@ -478,6 +495,9 @@ static void continue_with_the_intercepted_action(VMIn=
trospection *i)
     case VMI_INTERCEPT_SUSPEND:
         vm_stop(RUN_STATE_PAUSED);
         break;
+    case VMI_INTERCEPT_MIGRATE:
+        start_live_migration_thread(migrate_get_current());
+        break;
     default:
         error_report("VMI: %s: unexpected action %d",
                      __func__, i->intercepted_action);
@@ -571,9 +591,9 @@ static void chr_event_open(VMIntrospection *i)
 {
     Error *local_err =3D NULL;
=20
-    if (suspend_pending) {
-        info_report("VMI: %s: too soon (suspend=3D%d)",
-                    __func__, suspend_pending);
+    if (suspend_pending || migrate_pending) {
+        info_report("VMI: %s: too soon (suspend=3D%d, migrate=3D%d)",
+                    __func__, suspend_pending, migrate_pending);
         maybe_disable_socket_reconnect(i);
         qemu_chr_fe_disconnect(&i->sock);
         return;
@@ -608,7 +628,7 @@ static void chr_event_close(VMIntrospection *i)
     cancel_unhook_timer(i);
     cancel_handshake_timer(i);
=20
-    if (suspend_pending) {
+    if (suspend_pending || migrate_pending) {
         maybe_disable_socket_reconnect(i);
=20
         if (i->intercepted_action !=3D VMI_INTERCEPT_NONE) {
@@ -680,6 +700,9 @@ static bool record_intercept_action(VMI_intercept_com=
mand action)
         break;
     case VMI_INTERCEPT_FORCE_RESET:
         break;
+    case VMI_INTERCEPT_MIGRATE:
+        migrate_pending =3D true;
+        break;
     default:
         return false;
     }
diff --git a/include/sysemu/vmi-intercept.h b/include/sysemu/vmi-intercep=
t.h
index ef591b49e7..b4a9a3faa7 100644
--- a/include/sysemu/vmi-intercept.h
+++ b/include/sysemu/vmi-intercept.h
@@ -15,6 +15,7 @@ typedef enum {
     VMI_INTERCEPT_SUSPEND,
     VMI_INTERCEPT_RESUME,
     VMI_INTERCEPT_FORCE_RESET,
+    VMI_INTERCEPT_MIGRATE,
 } VMI_intercept_command;
=20
 bool vm_introspection_intercept(VMI_intercept_command ic, Error **errp);
diff --git a/migration/migration.c b/migration/migration.c
index 187ac0410c..222037d739 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -55,6 +55,8 @@
 #include "qemu/queue.h"
 #include "multifd.h"
=20
+#include "sysemu/vmi-intercept.h"
+
 #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed thrott=
ling */
=20
 /* Amount of time to allocate to each "chunk" of bandwidth-throttled
@@ -3471,6 +3473,13 @@ static void *migration_thread(void *opaque)
     return NULL;
 }
=20
+void start_live_migration_thread(MigrationState *s)
+{
+    qemu_thread_create(&s->thread, "live_migration", migration_thread, s=
,
+                    QEMU_THREAD_JOINABLE);
+    s->migration_thread_running =3D true;
+}
+
 void migrate_fd_connect(MigrationState *s, Error *error_in)
 {
     Error *local_err =3D NULL;
@@ -3534,9 +3543,12 @@ void migrate_fd_connect(MigrationState *s, Error *=
error_in)
         migrate_fd_cleanup(s);
         return;
     }
-    qemu_thread_create(&s->thread, "live_migration", migration_thread, s=
,
-                       QEMU_THREAD_JOINABLE);
-    s->migration_thread_running =3D true;
+
+    if (vm_introspection_intercept(VMI_INTERCEPT_MIGRATE, &error_in)) {
+        return;
+    }
+
+    start_live_migration_thread(s);
 }
=20
 void migration_global_dump(Monitor *mon)
diff --git a/migration/migration.h b/migration/migration.h
index 507284e563..eb5668e1f2 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -263,6 +263,8 @@ struct MigrationState
     uint8_t clear_bitmap_shift;
 };
=20
+void start_live_migration_thread(MigrationState *s);
+
 void migrate_set_state(int *state, int old_state, int new_state);
=20
 void migration_fd_process_incoming(QEMUFile *f, Error **errp);

