Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E2FC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 15:10:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27C1204EC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 15:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27C1204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htZCB-0005NU-2c
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 11:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47246)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jfreimann@redhat.com>) id 1htZ8s-0006AN-FQ
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 11:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1htZ8r-0005Tq-43
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 11:06:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1htZ8q-0005TL-Rf
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 11:06:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 18BABC057EC0
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2019 15:06:48 +0000 (UTC)
Received: from localhost (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A889A5D9D3;
 Fri,  2 Aug 2019 15:06:47 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 17:06:03 +0200
Message-Id: <20190802150605.5880-8-jfreimann@redhat.com>
In-Reply-To: <20190802150605.5880-1-jfreimann@redhat.com>
References: <20190802150605.5880-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 02 Aug 2019 15:06:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 7/9] migration: Add new migration state
 wait-unplug
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
 mst@redhat.com, aadam@redhat.com, laine@redhat.com, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch is not ready for inclusion yet, I'm looking for
feedback/ideas on a particular problem. See below.

This patch adds a new migration state called wait-unplug.  It is
entered after the SETUP state and will transition into ACTIVE once all
devices were succesfully unplugged from the guest.

So if a guest doesn't respond or takes long to honor the unplug
request the user will see the migration state 'wait-unplug'.

It adds a new function callback to VMStateDescription which is
called for every device that implements it and reports its
device_pending status.

Now this loop in the migration thread:

while (qemu_savevm_state_guest_unplug_pending()) { continue; }

clearly needs a condition to terminate after a while/or a certain
number of iterations. But I'm not sure what is a good solution. How much
waiting time is acceptable for a migration?

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 include/migration/vmstate.h |  2 ++
 migration/migration.c       | 14 ++++++++++++++
 migration/savevm.c          | 18 ++++++++++++++++++
 migration/savevm.h          |  1 +
 qapi/migration.json         |  5 ++++-
 5 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index c2bfa7a7f0..8b2a125c4c 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -187,6 +187,8 @@ struct VMStateDescription {
     int (*pre_save)(void *opaque);
     int (*post_save)(void *opaque);
     bool (*needed)(void *opaque);
+    bool (*dev_unplug_pending)(void *opaque);
+
     const VMStateField *fields;
     const VMStateDescription **subsections;
 };
diff --git a/migration/migration.c b/migration/migration.c
index 8a607fe1e2..a7d21b73fe 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -946,6 +946,9 @@ static void fill_source_migration_info(MigrationInfo =
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
@@ -1680,6 +1683,7 @@ bool migration_is_idle(void)
     case MIGRATION_STATUS_COLO:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
+    case MIGRATION_STATUS_WAIT_UNPLUG:
         return false;
     case MIGRATION_STATUS__MAX:
         g_assert_not_reached();
@@ -1712,6 +1716,7 @@ void migrate_init(MigrationState *s)
     error_free(s->error);
     s->error =3D NULL;
=20
+    /* go to WAIT_UNPLUG first? */
     migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS=
_SETUP);
=20
     s->start_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
@@ -3218,6 +3223,15 @@ static void *migration_thread(void *opaque)
=20
     qemu_savevm_state_setup(s->to_dst_file);
=20
+    migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
+                      MIGRATION_STATUS_WAIT_UNPLUG);
+    while (qemu_savevm_state_guest_unplug_pending()) {
+        continue;
+    }
+    migrate_set_state(&s->state, MIGRATION_STATUS_WAIT_UNPLUG,
+                      MIGRATION_STATUS_ACTIVE);=20
+
+
     s->setup_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
     migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                       MIGRATION_STATUS_ACTIVE);
diff --git a/migration/savevm.c b/migration/savevm.c
index 79ed44d475..2bb54b3a8a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1085,6 +1085,24 @@ void qemu_savevm_state_header(QEMUFile *f)
     }
 }
=20
+bool qemu_savevm_state_guest_unplug_pending(void)
+{
+    SaveStateEntry *se;
+    bool ret =3D false;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->vmsd || !se->vmsd->dev_unplug_pending) {
+            continue;
+        }
+        ret =3D se->vmsd->dev_unplug_pending(se->opaque);
+        if (ret) {
+            break;
+        }
+    }
+
+    return ret;
+}
+
 void qemu_savevm_state_setup(QEMUFile *f)
 {
     SaveStateEntry *se;
diff --git a/migration/savevm.h b/migration/savevm.h
index 51a4b9caa8..ba64a7e271 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -31,6 +31,7 @@
=20
 bool qemu_savevm_state_blocked(Error **errp);
 void qemu_savevm_state_setup(QEMUFile *f);
+bool qemu_savevm_state_guest_unplug_pending(void);
 int qemu_savevm_state_resume_prepare(MigrationState *s);
 void qemu_savevm_state_header(QEMUFile *f);
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
diff --git a/qapi/migration.json b/qapi/migration.json
index d567ac9fc3..c42381a85f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -133,6 +133,9 @@
 # @device: During device serialisation when pause-before-switchover is e=
nabled
 #        (since 2.11)
 #
+# @wait-unplug: wait for device unplug request by guest OS to be complet=
ed.
+#               (since 4.2)=20
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


