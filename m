Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C809C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A782F2184D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYzJ6c04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A782F2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQa4F-0000kQ-Au
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQa1k-0005tv-6E
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:48:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQa1i-0003Lp-Bo
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602179305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lKl/VVHXc4ERkMK0MKUUbJBmIyHe52WPOzLGwwT5H0E=;
 b=iYzJ6c048P5bwMdz2GAIFIJhoZIYXKkfi6feFCPBPcVSGiTV5+en8CFqd/1BzCVcsgqK4J
 1VKeVfqewVNNO2I8SS0+2DllMRI+5oiMPiX97rbnVWKnhDqHUgUQjefhtA9OdTcDA5oE0l
 rJG0cRfaXT9G2eOOK1cnzjw8FXG/Wu4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-IvDpjHoTP0yrnUW3X4Hj4w-1; Thu, 08 Oct 2020 13:48:22 -0400
X-MC-Unique: IvDpjHoTP0yrnUW3X4Hj4w-1
Received: by mail-wm1-f72.google.com with SMTP id z7so3412161wmi.3
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 10:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lKl/VVHXc4ERkMK0MKUUbJBmIyHe52WPOzLGwwT5H0E=;
 b=iMECXfGpT4IB0zGSDyIG/cuxIn0ImzmdyfMafyYsusEFHZHFkwcwhFLhYqJHQQ/Yb9
 jl2KDMC7GB+zv3fJ0CIrsNK7rT7Ik8i/BsoPs9e5mNg4CBPVHjqfPyLbh0ubokdwWxbo
 iCxVs6RyZOei5NClKQVNMd/Bb3ko0OYeJRU3KV7nFcgqoeEWMR3FNEVw2bYIf8pZlp+/
 NsAs/YcyQ0JyedhTbp6CmNj9VLcfjGv9a4ruLACFas/WpuCCzHscrKCpT8UHTda9wOog
 MIMzuhITmG+AFM+xmFZLZixXgwFt0mmUqHtQxs4lqe/tIkqP4z9oywHZr/DvwQ0MpqIe
 Uiog==
X-Gm-Message-State: AOAM533BxJ5l2JG3Uu9HfCTHCX5EDrseZKTW59F+8NwqUQP9R/09Sj8J
 0T22VtHct0Ytq5HQRj0MESiYbdKt+MAcPwAbwSPGz6PmPyz899V9Fp79ZIQ7rFepuGR+5q/XqoE
 t230IswOrHZ6Uq90=
X-Received: by 2002:a1c:2808:: with SMTP id o8mr10153454wmo.150.1602179300564; 
 Thu, 08 Oct 2020 10:48:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4joHFgeXMcy2LyT6WF9mCH9bqVKJeLVtNMhyKie6pjpcB1RUjJhiZZnkwQjsaxNMe5pm+6A==
X-Received: by 2002:a1c:2808:: with SMTP id o8mr10153429wmo.150.1602179300352; 
 Thu, 08 Oct 2020 10:48:20 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id m11sm8119229wmf.10.2020.10.08.10.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 10:48:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] migration: stop returning errno from load_snapshot()
Date: Thu,  8 Oct 2020 19:48:03 +0200
Message-Id: <20201008174803.2696619-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201008174803.2696619-1-philmd@redhat.com>
References: <20201008174803.2696619-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/migration/snapshot.h |  9 ++++++++-
 migration/savevm.c           | 19 +++++++++----------
 monitor/hmp-cmds.c           |  2 +-
 replay/replay-snapshot.c     |  2 +-
 softmmu/vl.c                 |  2 +-
 5 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
index a40c34307b..9bc989a6b4 100644
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
index fd2e5e8b66..531bb2eca1 100644
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
index 14848a3381..ff0e3df8a3 100644
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
index 4f2560d156..b289365937 100644
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
index 5a11a62f78..6eaa6b3a09 100644
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


