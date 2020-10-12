Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CA8C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B749820757
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVmhqiL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B749820757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRx0b-0001ym-Sw
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRwvx-0005qf-Fv
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:28:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRwvv-0006Cd-FI
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602505686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=plnZZZCVxgXXJPFVOHnuh5Pe0AHG0Eyi5aYw9WHIkco=;
 b=YVmhqiL8bAkcscVzkVpmmb6sRghjAZuvZumxwpuWJk0ZILeCelB1ftTYSEFHOsuR2BJf3E
 K59EVFawEpxE5yaA0/zp6nJoqQDSRAErKZwahdg992m5RPLPR+E5Y+dJcS242HqRjjLNV8
 ct1sQkpDz1ZNnN3G9UNNMFYfspLlhjQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-zIjWmsXmOUqnSCXwLU1sAQ-1; Mon, 12 Oct 2020 08:28:04 -0400
X-MC-Unique: zIjWmsXmOUqnSCXwLU1sAQ-1
Received: by mail-wr1-f72.google.com with SMTP id f11so9224239wro.15
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 05:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=plnZZZCVxgXXJPFVOHnuh5Pe0AHG0Eyi5aYw9WHIkco=;
 b=ImMB0bbT++vTEZdCEjUAzw/Cly4hEy5ogQg7Ih2PldvxHHcDgK5nycbXx+MI9NG1FH
 Ke0t2ATuU6PAvG2i1QWuQUdM2gr340+6/WsZwJo/Sk8Htx9iEC2xqFUpNylaqV9b1m7j
 cfestIQtGTC2HLPwNsVQGO6LyHFa2LcwwGKkBXIZi6e7olwinCHL7OFdPwpveihLPmQd
 zQNn8klj4c7JrcJw6vXPKyUqqrJm0YYzQQkYq5gcQZPuewaBGabVtk1S5Hgf04z6P8VO
 CBLynOQFD/Hic9Gnu4SChyKo6jq0WXxBAZ0RAdTMe84Nts2y4rSVy0zaqdPk2n5a9pBA
 pkxw==
X-Gm-Message-State: AOAM530RIwDUUEYtYHkJBTuS4B2XTtrCS5pmFc5ZAOYuijPrcYPcW6r0
 1bk3q7LHPAD3ko3q1zG0+QXGoOoqBTi1bqffhnwAmrRdkzHQ08GG9PoeVj91WqowyoAv4JdsDJn
 /NU4FKldcWOw23g4=
X-Received: by 2002:a1c:a3c2:: with SMTP id m185mr8633432wme.161.1602505681921; 
 Mon, 12 Oct 2020 05:28:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYvdBzLGTGinRNhKWAf4Orm0U7MgjIWG+FaAtJ+vTHylLfT5HKjpTu2oL31+36nsSCRx63Fg==
X-Received: by 2002:a1c:a3c2:: with SMTP id m185mr8633416wme.161.1602505681693; 
 Mon, 12 Oct 2020 05:28:01 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x15sm27756648wrr.36.2020.10.12.05.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 05:28:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] migration: stop returning errno from load_snapshot()
Date: Mon, 12 Oct 2020 14:27:43 +0200
Message-Id: <20201012122743.3390867-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012122743.3390867-1-philmd@redhat.com>
References: <20201012122743.3390867-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

None of the callers care about the errno value since there is a full
Error object populated. This gives consistency with save_snapshot()
which already just returns a boolean value.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
[PMD: Return false/true instead of -1/0, document function]
Acked-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/migration/snapshot.h |  9 ++++++++-
 migration/savevm.c           | 19 +++++++++----------
 monitor/hmp-cmds.c           |  2 +-
 replay/replay-snapshot.c     |  2 +-
 softmmu/vl.c                 |  2 +-
 5 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
index a40c34307b5..9bc989a6b49 100644
--- a/include/migration/snapshot.h
+++ b/include/migration/snapshot.h
@@ -23,6 +23,13 @@
  * On failure, store an error through @errp and return %false.
  */
 bool save_snapshot(const char *name, Error **errp);
-int load_snapshot(const char *name, Error **errp);
+/**
+ * save_snapshot: Load a snapshot.
+ * @name: path to snapshot
+ * @errp: pointer to error object
+ * On success, return %true.
+ * On failure, store an error through @errp and return %false.
+ */
+bool load_snapshot(const char *name, Error **errp);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index fd2e5e8b663..531bb2eca1e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2864,7 +2864,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     migration_incoming_state_destroy();
 }
 
-int load_snapshot(const char *name, Error **errp)
+bool load_snapshot(const char *name, Error **errp)
 {
     BlockDriverState *bs_vm_state;
     QEMUSnapshotInfo sn;
@@ -2874,16 +2874,16 @@ int load_snapshot(const char *name, Error **errp)
     MigrationIncomingState *mis = migration_incoming_get_current();
 
     if (!bdrv_all_can_snapshot(errp)) {
-        return -ENOTSUP;
+        return false;
     }
     ret = bdrv_all_find_snapshot(name, errp);
     if (ret < 0) {
-        return ret;
+        return false;
     }
 
     bs_vm_state = bdrv_all_find_vmstate_bs(errp);
     if (!bs_vm_state) {
-        return -ENOTSUP;
+        return false;
     }
     aio_context = bdrv_get_aio_context(bs_vm_state);
 
@@ -2892,11 +2892,11 @@ int load_snapshot(const char *name, Error **errp)
     ret = bdrv_snapshot_find(bs_vm_state, &sn, name);
     aio_context_release(aio_context);
     if (ret < 0) {
-        return ret;
+        return false;
     } else if (sn.vm_state_size == 0) {
         error_setg(errp, "This is a disk-only snapshot. Revert to it "
                    " offline using qemu-img");
-        return -EINVAL;
+        return false;
     }
 
     /*
@@ -2917,7 +2917,6 @@ int load_snapshot(const char *name, Error **errp)
     f = qemu_fopen_bdrv(bs_vm_state, 0);
     if (!f) {
         error_setg(errp, "Could not open VM state file");
-        ret = -EINVAL;
         goto err_drain;
     }
 
@@ -2933,14 +2932,14 @@ int load_snapshot(const char *name, Error **errp)
 
     if (ret < 0) {
         error_setg(errp, "Error %d while loading VM state", ret);
-        return ret;
+        return false;
     }
 
-    return 0;
+    return true;
 
 err_drain:
     bdrv_drain_all_end();
-    return ret;
+    return false;
 }
 
 void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index f48173820ff..521fcf96eba 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1123,7 +1123,7 @@ void hmp_loadvm(Monitor *mon, const QDict *qdict)
 
     vm_stop(RUN_STATE_RESTORE_VM);
 
-    if (load_snapshot(name, &err) == 0 && saved_vm_running) {
+    if (!load_snapshot(name, &err) && saved_vm_running) {
         vm_start();
     }
     hmp_handle_error(mon, err);
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 4f2560d1568..b2893659370 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -83,7 +83,7 @@ void replay_vmstate_init(void)
                 exit(1);
             }
         } else if (replay_mode == REPLAY_MODE_PLAY) {
-            if (load_snapshot(replay_snapshot, &err) != 0) {
+            if (!load_snapshot(replay_snapshot, &err)) {
                 error_report_err(err);
                 error_report("Could not load snapshot for icount replay");
                 exit(1);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 5a11a62f78a..6eaa6b3a09a 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4478,7 +4478,7 @@ void qemu_init(int argc, char **argv, char **envp)
     register_global_state();
     if (loadvm) {
         Error *local_err = NULL;
-        if (load_snapshot(loadvm, &local_err) < 0) {
+        if (!load_snapshot(loadvm, &local_err)) {
             error_report_err(local_err);
             autostart = 0;
             exit(1);
-- 
2.26.2


