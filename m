Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6A1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40CBB20757
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBOzvtcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40CBB20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwxf-0007UT-2u
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRwvq-0005je-L4
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRwvo-0006Bv-4E
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602505679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GF3rPFB8TmDLVdIBNNrbowCvUxvjAQ6sUwTvdnLn0c0=;
 b=QBOzvtcKtRXR/4j0FT5N9DqQk8hEBom3fg0jXN5TlQrEcRzedkkSpkkM5gBTg2uPr1gwvw
 FEkrNdcOuf56KPP51eQhkXCP7xVAqolN7CLNKnmGmsbjBteWqOqwaQNovebJP2oKpIAqnq
 g4dTiLR0o8g/RRWGs3AFDdXG1kWFJzg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-spifWCxNMVqdgSWE3XOjEw-1; Mon, 12 Oct 2020 08:27:58 -0400
X-MC-Unique: spifWCxNMVqdgSWE3XOjEw-1
Received: by mail-wr1-f69.google.com with SMTP id l17so9166196wrw.11
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 05:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GF3rPFB8TmDLVdIBNNrbowCvUxvjAQ6sUwTvdnLn0c0=;
 b=fjw4o9bEAJOblXcOJfTSfO8qJeVnuqlYpmNDnWj8pUawrZV2J8c02j3DTuUnmh8UX1
 9AxP/S4aNkVKvNdhnEORlxLN+sS0RXR47FqPEyqpRRMAK+hlO3EfWWjWN3Wwj3RRh2x5
 Z6SmRfcprdcOgGycO0P7L7UYLAXPjlWBkguICMQnuwcvXL/zAp5hlaqyN7T0rPcFuu1Z
 lymgHh1gAEvv18aG3Mr/+Z6+QmaH/SpRSsLnws1eYBz2u+UGQN9k5RDnHMWb16wuV2RW
 BA3GxeDjrC8GWq4djS78sYD0JCAeGmn1tel3JSLAsoGKRzr7mzRNxKM+V0zP34vtF05J
 95hA==
X-Gm-Message-State: AOAM531heSSPjtnV0UmAKA/GmY3YRgXYIJMLGqxVXuBpv/b3OlrGsDNk
 PPI7MOjtI/3pHfeXUsly9iFctC0Cq5GTTmFWF28MpNdznRGzXABcwRhhk6iGgoyYhKtwfqwttoe
 wFIgLaAke9fufEA4=
X-Received: by 2002:a1c:e444:: with SMTP id b65mr11312702wmh.65.1602505676783; 
 Mon, 12 Oct 2020 05:27:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx41js+WBMb2MispfLdqaz4gLSVYW8awTTGLAgTHE5/rIMaRjQ/nDK3HficsiAXqvS9xlAYjw==
X-Received: by 2002:a1c:e444:: with SMTP id b65mr11312685wmh.65.1602505676574; 
 Mon, 12 Oct 2020 05:27:56 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id c185sm1996288wma.44.2020.10.12.05.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 05:27:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] migration: Make save_snapshot() return bool, not 0/-1
Date: Mon, 12 Oct 2020 14:27:42 +0200
Message-Id: <20201012122743.3390867-3-philmd@redhat.com>
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
 Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just for consistency, following the example documented since
commit e3fe3988d7 ("error: Document Error API usage rules"),
return a boolean value indicating an error is set or not.

Acked-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/migration/snapshot.h |  9 ++++++++-
 migration/savevm.c           | 16 ++++++++--------
 replay/replay-debugging.c    |  2 +-
 replay/replay-snapshot.c     |  2 +-
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
index c85b6ec75b7..a40c34307b5 100644
--- a/include/migration/snapshot.h
+++ b/include/migration/snapshot.h
@@ -15,7 +15,14 @@
 #ifndef QEMU_MIGRATION_SNAPSHOT_H
 #define QEMU_MIGRATION_SNAPSHOT_H
 
-int save_snapshot(const char *name, Error **errp);
+/**
+ * save_snapshot: Save a snapshot.
+ * @name: path to snapshot
+ * @errp: pointer to error object
+ * On success, return %true.
+ * On failure, store an error through @errp and return %false.
+ */
+bool save_snapshot(const char *name, Error **errp);
 int load_snapshot(const char *name, Error **errp);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index a52da440f4b..fd2e5e8b663 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2658,7 +2658,7 @@ int qemu_load_device_state(QEMUFile *f)
     return 0;
 }
 
-int save_snapshot(const char *name, Error **errp)
+bool save_snapshot(const char *name, Error **errp)
 {
     BlockDriverState *bs;
     QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
@@ -2671,29 +2671,29 @@ int save_snapshot(const char *name, Error **errp)
     AioContext *aio_context;
 
     if (migration_is_blocked(errp)) {
-        return ret;
+        return false;
     }
 
     if (!replay_can_snapshot()) {
         error_setg(errp, "Record/replay does not allow making snapshot "
                    "right now. Try once more later.");
-        return ret;
+        return false;
     }
 
     if (!bdrv_all_can_snapshot(errp)) {
-        return ret;
+        return false;
     }
 
     /* Delete old snapshots of the same name */
     if (name) {
         if (bdrv_all_delete_snapshot(name, errp) < 0) {
-            return ret;
+            return false;
         }
     }
 
     bs = bdrv_all_find_vmstate_bs(errp);
     if (bs == NULL) {
-        return ret;
+        return false;
     }
     aio_context = bdrv_get_aio_context(bs);
 
@@ -2702,7 +2702,7 @@ int save_snapshot(const char *name, Error **errp)
     ret = global_state_store();
     if (ret) {
         error_setg(errp, "Error saving global state");
-        return ret;
+        return false;
     }
     vm_stop(RUN_STATE_SAVE_VM);
 
@@ -2779,7 +2779,7 @@ int save_snapshot(const char *name, Error **errp)
     if (saved_vm_running) {
         vm_start();
     }
-    return ret;
+    return ret == 0;
 }
 
 void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 8785489c02d..5458a73fced 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -327,7 +327,7 @@ void replay_gdb_attached(void)
      */
     if (replay_mode == REPLAY_MODE_PLAY
         && !replay_snapshot) {
-        if (save_snapshot("start_debugging", NULL) != 0) {
+        if (!save_snapshot("start_debugging", NULL)) {
             /* Can't create the snapshot. Continue conventional debugging. */
         }
     }
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index e26fa4c892e..4f2560d1568 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -77,7 +77,7 @@ void replay_vmstate_init(void)
 
     if (replay_snapshot) {
         if (replay_mode == REPLAY_MODE_RECORD) {
-            if (save_snapshot(replay_snapshot, &err) != 0) {
+            if (!save_snapshot(replay_snapshot, &err)) {
                 error_report_err(err);
                 error_report("Could not create snapshot for icount record");
                 exit(1);
-- 
2.26.2


