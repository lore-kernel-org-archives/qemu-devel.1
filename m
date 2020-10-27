Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDC0C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D02920760
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BIDvoG7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D02920760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXTwJ-0005BB-4R
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTc2-0004Qe-Ni
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43842)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTbr-00032p-CZ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603822928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qw1VERdZScWEw2GW3fkpxjBe9i8Cmxz9eFQMCTMwu6I=;
 b=BIDvoG7nDqa+oGNbIR113O93xzxwTqDNnceJKP0gfmDYA8+9y71KVWHuUa14IhLOaaJ+JF
 BZ/CE0Tyvju8DdnWCmJK+P5C1AOfPvCGQj955tCpo5m31wZzJuvmEIcIYFG3lM+v9DhrS4
 fsbSUJxj1gHCGpVaEps2NYqVD6ZJnQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-aYhNrEvOMYKoWI7TJml5AA-1; Tue, 27 Oct 2020 14:22:06 -0400
X-MC-Unique: aYhNrEvOMYKoWI7TJml5AA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 782558A2A3D
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:54 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4434650B44
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/29] migration, vl: start migration via qmp_migrate_incoming
Date: Tue, 27 Oct 2020 14:21:39 -0400
Message-Id: <20201027182144.3315885-25-pbonzini@redhat.com>
In-Reply-To: <20201027182144.3315885-1-pbonzini@redhat.com>
References: <20201027182144.3315885-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make qemu_start_incoming_migration local to migration/migration.c.
By using the runstate instead of a separate flag, vl need not do
anything to setup deferred incoming migration.

qmp_migrate_incoming also does not need the deferred_incoming flag
anymore, because "-incoming PROTOCOL" will clear the "once" flag
before the main loop starts.  Therefore, later invocations of
the migrate-incoming command will fail with the existing
"The incoming migration has already been started" error message.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/migration/misc.h |  1 -
 migration/migration.c    | 33 ++++++++-------------------------
 softmmu/vl.c             | 11 +++++++----
 3 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 34e7d75713..bccc1b6b44 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -58,7 +58,6 @@ void dump_vmstate_json_to_file(FILE *out_fp);
 /* migration/migration.c */
 void migration_object_init(void);
 void migration_shutdown(void);
-void qemu_start_incoming_migration(const char *uri, Error **errp);
 bool migration_is_idle(void);
 bool migration_is_active(MigrationState *);
 void add_migration_state_change_notifier(Notifier *notify);
diff --git a/migration/migration.c b/migration/migration.c
index f48b03cac2..d078094c56 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -114,8 +114,6 @@
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
 
-static bool deferred_incoming;
-
 /* Messages sent on the return path from destination to source */
 enum mig_rp_message_type {
     MIG_RP_MSG_INVALID = 0,  /* Must be 0 */
@@ -257,19 +255,6 @@ static bool migrate_late_block_activate(void)
         MIGRATION_CAPABILITY_LATE_BLOCK_ACTIVATE];
 }
 
-/*
- * Called on -incoming with a defer: uri.
- * The migration can be started later after any parameters have been
- * changed.
- */
-static void deferred_incoming_migration(Error **errp)
-{
-    if (deferred_incoming) {
-        error_setg(errp, "Incoming migration already deferred");
-    }
-    deferred_incoming = true;
-}
-
 /*
  * Send a message on the return channel back to the source
  * of the migration.
@@ -380,16 +365,14 @@ void migrate_add_address(SocketAddress *address)
     addrs->value = QAPI_CLONE(SocketAddress, address);
 }
 
-void qemu_start_incoming_migration(const char *uri, Error **errp)
+static void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p = NULL;
 
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
-    if (!strcmp(uri, "defer")) {
-        deferred_incoming_migration(errp);
-    } else if (strstart(uri, "tcp:", &p) ||
-               strstart(uri, "unix:", NULL) ||
-               strstart(uri, "vsock:", NULL)) {
+    if (strstart(uri, "tcp:", &p) ||
+        strstart(uri, "unix:", NULL) ||
+        strstart(uri, "vsock:", NULL)) {
         socket_start_incoming_migration(p ? p : uri, errp);
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
@@ -1926,14 +1909,14 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
     Error *local_err = NULL;
     static bool once = true;
 
-    if (!deferred_incoming) {
-        error_setg(errp, "For use with '-incoming defer'");
-        return;
-    }
     if (!once) {
         error_setg(errp, "The incoming migration has already been started");
         return;
     }
+    if (!runstate_check(RUN_STATE_INMIGRATE)) {
+        error_setg(errp, "'-incoming' was not specified on the command line");
+        return;
+    }
 
     qemu_start_incoming_migration(uri, &local_err);
 
diff --git a/softmmu/vl.c b/softmmu/vl.c
index ae2854d8af..583366510b 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -109,6 +109,7 @@
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qapi-visit-ui.h"
 #include "qapi/qapi-commands-block-core.h"
+#include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-commands-run-state.h"
 #include "qapi/qapi-commands-ui.h"
 #include "qapi/qmp/qerror.h"
@@ -4557,10 +4558,12 @@ void qemu_init(int argc, char **argv, char **envp)
     }
     if (incoming) {
         Error *local_err = NULL;
-        qemu_start_incoming_migration(incoming, &local_err);
-        if (local_err) {
-            error_reportf_err(local_err, "-incoming %s: ", incoming);
-            exit(1);
+        if (strcmp(incoming, "defer") != 0) {
+            qmp_migrate_incoming(incoming, &local_err);
+            if (local_err) {
+                error_reportf_err(local_err, "-incoming %s: ", incoming);
+                exit(1);
+            }
         }
     } else if (autostart) {
         vm_start();
-- 
2.26.2



