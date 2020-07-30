Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FD3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DDCD206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T/1swMwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDCD206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Avw-0000fJ-Ei
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1Af4-00019k-Oh
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:40:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1Af1-0002Tl-5w
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:40:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXUoj007564;
 Thu, 30 Jul 2020 15:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=9yU3uF0G2s5qWsK/B3S+9s+ZnpI5bYaEDMA1bh3ly1A=;
 b=T/1swMwaDReppaREZ3DKXzoBsMTAo1crVZqkF5LvNqHCS3M/jzVpmronv4WUuwMZg16t
 EdhcrK1PTjRQToUEYZGVuTz2qlS4ooCSdqPXHk2bZZigUnT81pyllFNSj6RqVJsvrTUa
 hOkoCvn3Z6nprqMS06sq7Twvy10y8gG+/MXcD/kGVhHykr8klbjBsUx4/58pt5tzEeWx
 FRe2aAmqOcIlby767KqTLDWpgKdsQVES0/BdumyV85WrqaVyEaiq1EAIxoxVhhr6VLBK
 nrbIo0cfd6GZ3owxgow117wVItCvM2jeC7taVIswtN2CN3lHxY11k0xM2yJ2GBhBbiod 3Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 32hu1jmfsw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:39:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXSVk130767;
 Thu, 30 Jul 2020 15:37:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 32hu5wwgjp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:37:55 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UFbsQp001804;
 Thu, 30 Jul 2020 15:37:54 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:37:54 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 02/32] savevm: VM handlers mode mask
Date: Thu, 30 Jul 2020 08:14:06 -0700
Message-Id: <1596122076-341293-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=1 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=1 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=steven.sistare@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 11:37:58
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a new mode argument to qemu_savevm_state() and qemu_loadvm_state() that
can customize the operation.  Define the VMS_MIGRATE and VMS_SNAPSHOT modes
for the existing live migration and snapshot capabilities.

Provide a mode mask for vmstate handlers.  A handler is only processed by
SAVEVM_FOREACH if its mask includes the savevm_state.mode.  Unmodified
handler declarations have a zero mask field, which implicitly enables the
handler for all modes.

No functional change for the VMS_MIGRATE and VMS_SNAPSHOT modes.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/register.h |  3 +++
 include/migration/vmstate.h  |  9 ++++++++
 migration/migration.c        |  4 ++--
 migration/savevm.c           | 51 +++++++++++++++++++++++++++++++++++---------
 migration/savevm.h           |  4 +++-
 5 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index c1dcff0..c030a10 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -17,6 +17,9 @@
 #include "hw/vmstate-if.h"
 
 typedef struct SaveVMHandlers {
+    /* Mask of VMStateMode's that should use this handler */
+    unsigned mode_mask;
+
     /* This runs inside the iothread lock.  */
     SaveStateHandler *save_state;
 
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f68ed7d..fa575f9 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -158,6 +158,12 @@ typedef enum {
     MIG_PRI_MAX,
 } MigrationPriority;
 
+typedef enum {
+    VMS_MIGRATE  = (1U << 1),
+    VMS_SNAPSHOT = (1U << 2),
+    VMS_MODE_ALL = ~0U
+} VMStateMode;
+
 struct VMStateField {
     const char *name;
     const char *err_hint;
@@ -182,6 +188,7 @@ struct VMStateDescription {
     int minimum_version_id;
     int minimum_version_id_old;
     MigrationPriority priority;
+    unsigned mode_mask;
     LoadStateHandler *load_state_old;
     int (*pre_load)(void *opaque);
     int (*post_load)(void *opaque, int version_id);
@@ -1215,4 +1222,6 @@ void vmstate_register_ram_global(struct MemoryRegion *memory);
 
 bool vmstate_check_only_migratable(const VMStateDescription *vmsd);
 
+void savevm_set_mode(VMStateMode mode);
+
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 2ed9923..e3d0899 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -465,7 +465,7 @@ static void process_incoming_migration_co(void *opaque)
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
     migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
                       MIGRATION_STATUS_ACTIVE);
-    ret = qemu_loadvm_state(mis->from_src_file);
+    ret = qemu_loadvm_state(mis->from_src_file, VMS_MIGRATE);
 
     ps = postcopy_state_get();
     trace_process_incoming_migration_co_end(ret, ps);
@@ -3414,7 +3414,7 @@ static void *migration_thread(void *opaque)
 
     object_ref(OBJECT(s));
     update_iteration_initial_status(s);
-
+    savevm_set_mode(VMS_MIGRATE);
     qemu_savevm_state_header(s->to_dst_file);
 
     /*
diff --git a/migration/savevm.c b/migration/savevm.c
index a07fcad..ce02b6b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -256,6 +256,7 @@ typedef struct SaveState {
     const char *name;
     uint32_t target_page_bits;
     uint32_t caps_count;
+    VMStateMode mode;
     MigrationCapability *capabilities;
     QemuUUID uuid;
 } SaveState;
@@ -266,16 +267,15 @@ static SaveState savevm_state = {
     .global_section_id = 0,
 };
 
-/*
- * The FOREACH macros will filter handlers based on the current operation when
- * additional conditions are added in a subsequent patch.
- */
+/* The FOREACH macros filter handlers based on the current operation. */
 
 #define SAVEVM_FOREACH(se, entry)                                    \
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry)                \
+        if (savevm_state.mode & mode_mask(se))
 
 #define SAVEVM_FOREACH_SAFE(se, entry, new_se)                       \
     QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se)   \
+        if (savevm_state.mode & mode_mask(se))
 
 /* The FORALL macros unconditionally loop over all handlers. */
 
@@ -285,6 +285,33 @@ static SaveState savevm_state = {
 #define SAVEVM_FORALL_SAFE(se, entry, new_se)                        \
     QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se)
 
+/*
+ * Set the current mode to be used for filtering savevm handlers in
+ * SAVEVM_FOREACH.
+ */
+void savevm_set_mode(VMStateMode mode)
+{
+    savevm_state.mode = mode;
+}
+
+/*
+ * A savevm handler is selected in SAVEVM_FOREACH if its mask overlaps the
+ * current mode.  The mask is defined by either the new vmsd interface or the
+ * legacy ops interface.  If the mask is zero, it implicily includes all modes.
+ */
+static inline unsigned mode_mask(SaveStateEntry *se)
+{
+    const VMStateDescription *vmsd = se->vmsd;
+    unsigned mask = 0;
+
+    if (vmsd) {
+        mask = vmsd->mode_mask;
+    } else if (se->ops) {
+        mask = se->ops->mode_mask;
+    }
+    return mask ? mask : VMS_MODE_ALL;
+}
+
 static bool should_validate_capability(int capability)
 {
     assert(capability >= 0 && capability < MIGRATION_CAPABILITY__MAX);
@@ -1527,12 +1554,14 @@ void qemu_savevm_state_cleanup(void)
     }
 }
 
-static int qemu_savevm_state(QEMUFile *f, Error **errp)
+static int qemu_savevm_state(QEMUFile *f, VMStateMode mode, Error **errp)
 {
     int ret;
     MigrationState *ms = migrate_get_current();
     MigrationStatus status;
 
+    savevm_set_mode(mode);
+
     if (migration_is_running(ms->state)) {
         error_setg(errp, QERR_MIGRATION_ACTIVE);
         return -EINVAL;
@@ -2557,13 +2586,14 @@ out:
     return ret;
 }
 
-int qemu_loadvm_state(QEMUFile *f)
+int qemu_loadvm_state(QEMUFile *f, VMStateMode mode)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     Error *local_err = NULL;
     int ret;
 
-    if (qemu_savevm_state_blocked(&local_err)) {
+    if ((mode & (VMS_SNAPSHOT | VMS_MIGRATE)) &&
+        qemu_savevm_state_blocked(&local_err)) {
         error_report_err(local_err);
         return -EINVAL;
     }
@@ -2736,7 +2766,7 @@ int save_snapshot(const char *name, Error **errp)
         error_setg(errp, "Could not open VM state file");
         goto the_end;
     }
-    ret = qemu_savevm_state(f, errp);
+    ret = qemu_savevm_state(f, VMS_SNAPSHOT, errp);
     vm_state_size = qemu_ftell(f);
     ret2 = qemu_fclose(f);
     if (ret < 0) {
@@ -2785,6 +2815,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
     int saved_vm_running;
     int ret;
 
+    savevm_set_mode(VMS_MIGRATE);
     if (!has_live) {
         /* live default to true so old version of Xen tool stack can have a
          * successfull live migration */
@@ -2850,7 +2881,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     f = qemu_fopen_channel_input(QIO_CHANNEL(ioc));
     object_unref(OBJECT(ioc));
 
-    ret = qemu_loadvm_state(f);
+    ret = qemu_loadvm_state(f, VMS_MIGRATE);
     qemu_fclose(f);
     if (ret < 0) {
         error_setg(errp, QERR_IO_ERROR);
@@ -2928,7 +2959,7 @@ int load_snapshot(const char *name, Error **errp)
     mis->from_src_file = f;
 
     aio_context_acquire(aio_context);
-    ret = qemu_loadvm_state(f);
+    ret = qemu_loadvm_state(f, VMS_SNAPSHOT);
     migration_incoming_state_destroy();
     aio_context_release(aio_context);
 
diff --git a/migration/savevm.h b/migration/savevm.h
index ba64a7e..4b7ce91 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -14,6 +14,8 @@
 #ifndef MIGRATION_SAVEVM_H
 #define MIGRATION_SAVEVM_H
 
+#include "migration/vmstate.h"
+
 #define QEMU_VM_FILE_MAGIC           0x5145564d
 #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
 #define QEMU_VM_FILE_VERSION         0x00000003
@@ -60,7 +62,7 @@ void qemu_savevm_send_colo_enable(QEMUFile *f);
 void qemu_savevm_live_state(QEMUFile *f);
 int qemu_save_device_state(QEMUFile *f);
 
-int qemu_loadvm_state(QEMUFile *f);
+int qemu_loadvm_state(QEMUFile *f, VMStateMode mode);
 void qemu_loadvm_state_cleanup(void);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
 int qemu_load_device_state(QEMUFile *f);
-- 
1.8.3.1


