Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E97CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 20:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 834912082C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 20:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834912082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLYmz-0001AI-BL
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 16:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iLYlA-00076i-Pp
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 16:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iLYl8-0005ue-Qg
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 16:22:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55944)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iLYl8-0005uR-6L
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 16:22:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6A70B307C650;
 Fri, 18 Oct 2019 20:22:01 +0000 (UTC)
Received: from localhost (ovpn-116-92.ams2.redhat.com [10.36.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7CCE5D70E;
 Fri, 18 Oct 2019 20:21:53 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/11] migration: add new migration state wait-unplug
Date: Fri, 18 Oct 2019 22:20:37 +0200
Message-Id: <20191018202040.30349-9-jfreimann@redhat.com>
In-Reply-To: <20191018202040.30349-1-jfreimann@redhat.com>
References: <20191018202040.30349-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 18 Oct 2019 20:22:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds a new migration state called wait-unplug.  It is entered
after the SETUP state if failover devices are present. It will transition
into ACTIVE once all devices were succesfully unplugged from the guest.

So if a guest doesn't respond or takes long to honor the unplug request
the user will see the migration state 'wait-unplug'.

In the migration thread we query failover devices if they're are still
pending the guest unplug. When all are unplugged the migration
continues. If one device won't unplug migration will stay in wait_unplug
state.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 include/migration/vmstate.h |  2 ++
 migration/migration.c       | 21 +++++++++++++++++++++
 migration/migration.h       |  3 +++
 migration/savevm.c          | 36 ++++++++++++++++++++++++++++++++++++
 migration/savevm.h          |  2 ++
 qapi/migration.json         |  5 ++++-
 6 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index b9ee563aa4..ac4f46a67d 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -186,6 +186,8 @@ struct VMStateDescription {
     int (*pre_save)(void *opaque);
     int (*post_save)(void *opaque);
     bool (*needed)(void *opaque);
+    bool (*dev_unplug_pending)(void *opaque);
+
     const VMStateField *fields;
     const VMStateDescription **subsections;
 };
diff --git a/migration/migration.c b/migration/migration.c
index 3febd0f8f3..51764f2565 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -52,6 +52,7 @@
 #include "hw/qdev-properties.h"
 #include "monitor/monitor.h"
 #include "net/announce.h"
+#include "qemu/queue.h"
=20
 #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed thrott=
ling */
=20
@@ -819,6 +820,7 @@ bool migration_is_setup_or_active(int state)
     case MIGRATION_STATUS_SETUP:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
+    case MIGRATION_STATUS_WAIT_UNPLUG:
         return true;
=20
     default:
@@ -954,6 +956,9 @@ static void fill_source_migration_info(MigrationInfo =
*info)
     case MIGRATION_STATUS_CANCELLED:
         info->has_status =3D true;
         break;
+    case MIGRATION_STATUS_WAIT_UNPLUG:
+        info->has_status =3D true;
+        break;
     }
     info->status =3D s->state;
 }
@@ -1694,6 +1699,7 @@ bool migration_is_idle(void)
     case MIGRATION_STATUS_COLO:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
+    case MIGRATION_STATUS_WAIT_UNPLUG:
         return false;
     case MIGRATION_STATUS__MAX:
         g_assert_not_reached();
@@ -3264,6 +3270,19 @@ static void *migration_thread(void *opaque)
=20
     qemu_savevm_state_setup(s->to_dst_file);
=20
+    if (qemu_savevm_nr_failover_devices()) {
+        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
+                          MIGRATION_STATUS_WAIT_UNPLUG);
+
+        while (s->state =3D=3D MIGRATION_STATUS_WAIT_UNPLUG &&
+                !qemu_savevm_state_guest_unplug_pending()) {
+            qemu_sem_timedwait(&s->wait_unplug_sem, 250);
+        }
+
+        migrate_set_state(&s->state, MIGRATION_STATUS_WAIT_UNPLUG,
+                MIGRATION_STATUS_ACTIVE);
+    }
+
     s->setup_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
     migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                       MIGRATION_STATUS_ACTIVE);
@@ -3511,6 +3530,7 @@ static void migration_instance_finalize(Object *obj=
)
     qemu_mutex_destroy(&ms->qemu_file_lock);
     g_free(params->tls_hostname);
     g_free(params->tls_creds);
+    qemu_sem_destroy(&ms->wait_unplug_sem);
     qemu_sem_destroy(&ms->rate_limit_sem);
     qemu_sem_destroy(&ms->pause_sem);
     qemu_sem_destroy(&ms->postcopy_pause_sem);
@@ -3556,6 +3576,7 @@ static void migration_instance_init(Object *obj)
     qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
     qemu_sem_init(&ms->rp_state.rp_sem, 0);
     qemu_sem_init(&ms->rate_limit_sem, 0);
+    qemu_sem_init(&ms->wait_unplug_sem, 0);
     qemu_mutex_init(&ms->qemu_file_lock);
 }
=20
diff --git a/migration/migration.h b/migration/migration.h
index 4f2fe193dc..79b3dda146 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -206,6 +206,9 @@ struct MigrationState
     /* Flag set once the migration thread called bdrv_inactivate_all */
     bool block_inactive;
=20
+    /* Migration is waiting for guest to unplug device */
+    QemuSemaphore wait_unplug_sem;
+
     /* Migration is paused due to pause-before-switchover */
     QemuSemaphore pause_sem;
=20
diff --git a/migration/savevm.c b/migration/savevm.c
index 8d95e261f6..0f18dea49e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1113,6 +1113,42 @@ void qemu_savevm_state_header(QEMUFile *f)
     }
 }
=20
+int qemu_savevm_nr_failover_devices(void)
+{
+    SaveStateEntry *se;
+    int n =3D 0;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (se->vmsd && se->vmsd->dev_unplug_pending) {
+            n++;
+        }
+    }
+
+    return n;
+}
+
+bool qemu_savevm_state_guest_unplug_pending(void)
+{
+    int nr_failover_devs;
+    SaveStateEntry *se;
+    bool ret =3D false;
+    int n =3D 0;
+
+    nr_failover_devs =3D qemu_savevm_nr_failover_devices();
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->vmsd || !se->vmsd->dev_unplug_pending) {
+            continue;
+        }
+        ret =3D se->vmsd->dev_unplug_pending(se->opaque);
+        if (!ret) {
+            n++;
+        }
+    }
+
+    return n =3D=3D nr_failover_devs;
+}
+
 void qemu_savevm_state_setup(QEMUFile *f)
 {
     SaveStateEntry *se;
diff --git a/migration/savevm.h b/migration/savevm.h
index 51a4b9caa8..c42b9c80ee 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -31,6 +31,8 @@
=20
 bool qemu_savevm_state_blocked(Error **errp);
 void qemu_savevm_state_setup(QEMUFile *f);
+int qemu_savevm_nr_failover_devices(void);
+bool qemu_savevm_state_guest_unplug_pending(void);
 int qemu_savevm_state_resume_prepare(MigrationState *s);
 void qemu_savevm_state_header(QEMUFile *f);
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
diff --git a/qapi/migration.json b/qapi/migration.json
index 52e69e2868..5a06cd489f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -133,6 +133,9 @@
 # @device: During device serialisation when pause-before-switchover is e=
nabled
 #        (since 2.11)
 #
+# @wait-unplug: wait for device unplug request by guest OS to be complet=
ed.
+#               (since 4.2)
+#
 # Since: 2.3
 #
 ##
@@ -140,7 +143,7 @@
   'data': [ 'none', 'setup', 'cancelling', 'cancelled',
             'active', 'postcopy-active', 'postcopy-paused',
             'postcopy-recover', 'completed', 'failed', 'colo',
-            'pre-switchover', 'device' ] }
+            'pre-switchover', 'device', 'wait-unplug' ] }
=20
 ##
 # @MigrationInfo:
--=20
2.21.0


