Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6DEC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1FC2177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISg6A0V8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1FC2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVH0s-0004ns-F1
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 12:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVGxt-0002Gc-1c
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVGxm-0004v9-R2
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603297665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYZZulZ23FVJUsben6alamPKuOW6q+o8+svTP6y2P14=;
 b=ISg6A0V8AUqjuks6SMi8luuM9d5knp5Apuv7jEOSdvrh78NLrKXx4A/q7PwiO+6n+vA0fB
 VrFvUmsS3HdCbgBGlECHxjWE9VUmYrEaUt2cNtUHH7BdYIxlVO6Yw+zO5TYYjrVVF1HkYt
 /6lHaKh1JCR1wek1lwd70xViUYLjATM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-fjyln2hePcqpXPbWMNMMSA-1; Wed, 21 Oct 2020 12:27:41 -0400
X-MC-Unique: fjyln2hePcqpXPbWMNMMSA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 980EA1006C94;
 Wed, 21 Oct 2020 16:27:40 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9998610013C1;
 Wed, 21 Oct 2020 16:27:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 07/11] migration: control whether snapshots are ovewritten
Date: Wed, 21 Oct 2020 17:27:00 +0100
Message-Id: <20201021162704.3652555-8-berrange@redhat.com>
In-Reply-To: <20201021162704.3652555-1-berrange@redhat.com>
References: <20201021162704.3652555-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The traditional HMP "savevm" command will overwrite an existing snapshot
if it already exists with the requested name. This new flag allows this
to be controlled allowing for safer behaviour with a future QMP command.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/migration/snapshot.h |  3 ++-
 migration/savevm.c           | 19 ++++++++++++++++---
 monitor/hmp-cmds.c           |  2 +-
 replay/replay-debugging.c    |  2 +-
 replay/replay-snapshot.c     |  2 +-
 5 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
index d7d210820c..d8c22d343c 100644
--- a/include/migration/snapshot.h
+++ b/include/migration/snapshot.h
@@ -18,11 +18,12 @@
 /**
  * save_snapshot: Save an internal snapshot.
  * @name: name of internal snapshot
+ * @overwrite: replace existing snapshot with @name
  * @errp: pointer to error object
  * On success, return %true.
  * On failure, store an error through @errp and return %false.
  */
-bool save_snapshot(const char *name, Error **errp);
+bool save_snapshot(const char *name, bool overwrite, Error **errp);
 
 /**
  * load_snapshot: Load an internal snapshot.
diff --git a/migration/savevm.c b/migration/savevm.c
index d20244d898..4f194e95cc 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2658,7 +2658,7 @@ int qemu_load_device_state(QEMUFile *f)
     return 0;
 }
 
-bool save_snapshot(const char *name, Error **errp)
+bool save_snapshot(const char *name, bool overwrite, Error **errp)
 {
     BlockDriverState *bs;
     QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
@@ -2686,8 +2686,21 @@ bool save_snapshot(const char *name, Error **errp)
 
     /* Delete old snapshots of the same name */
     if (name) {
-        if (bdrv_all_delete_snapshot(name, false, NULL, errp) < 0) {
-            return false;
+        if (overwrite) {
+            if (bdrv_all_delete_snapshot(name, false, NULL, errp) < 0) {
+                return false;
+            }
+        } else {
+            ret2 = bdrv_all_has_snapshot(name, false, NULL, errp);
+            if (ret2 < 0) {
+                return false;
+            }
+            if (ret2 == 1) {
+                error_setg(errp,
+                           "Snapshot '%s' already exists in one or more devices",
+                           name);
+                return false;
+            }
         }
     }
 
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 8fef194d80..d92398e1c8 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1133,7 +1133,7 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
 
-    save_snapshot(qdict_get_try_str(qdict, "name"), &err);
+    save_snapshot(qdict_get_try_str(qdict, "name"), true, &err);
     hmp_handle_error(mon, err);
 }
 
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 0082da52f6..2d21711fc2 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -331,7 +331,7 @@ void replay_gdb_attached(void)
      */
     if (replay_mode == REPLAY_MODE_PLAY
         && !replay_snapshot) {
-        if (!save_snapshot("start_debugging", NULL)) {
+        if (!save_snapshot("start_debugging", true, NULL)) {
             /* Can't create the snapshot. Continue conventional debugging. */
         }
     }
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index b289365937..31c5a8702b 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -77,7 +77,7 @@ void replay_vmstate_init(void)
 
     if (replay_snapshot) {
         if (replay_mode == REPLAY_MODE_RECORD) {
-            if (!save_snapshot(replay_snapshot, &err)) {
+            if (!save_snapshot(replay_snapshot, true, &err)) {
                 error_report_err(err);
                 error_report("Could not create snapshot for icount record");
                 exit(1);
-- 
2.26.2


