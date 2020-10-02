Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DEBC4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76685206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/0Ml6vD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76685206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONw8-0006hT-FU
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 12:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kONuv-0004wA-Gp
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kONus-0003FD-UI
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601656098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0V/7MV4TMbUSIio5lJb+Z0mOui7Up5WBvBP8HHJsOhg=;
 b=T/0Ml6vDfAASqW4hadY3//7zlmJMcJF1dFUCgj8BOEa9hutm5D85XPey+xeT7fd9zJH8yJ
 smT7gR5oP9R8C6tPZnXBtkECX6rfcbQKJuTEY9vjDHwRLxpvsiLU02xrADnpKqc6vzX3I1
 OpZI/fMeUqsaGe2WIOkVIWtdTnzNOQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-DdEP-veqNgqK6Ms1azCu1Q-1; Fri, 02 Oct 2020 12:28:16 -0400
X-MC-Unique: DdEP-veqNgqK6Ms1azCu1Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63B3B81E20C;
 Fri,  2 Oct 2020 16:28:15 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F27701002C03;
 Fri,  2 Oct 2020 16:28:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 06/10] migration: control whether snapshots are ovewritten
Date: Fri,  2 Oct 2020 17:27:43 +0100
Message-Id: <20201002162747.3123597-7-berrange@redhat.com>
In-Reply-To: <20201002162747.3123597-1-berrange@redhat.com>
References: <20201002162747.3123597-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The traditional HMP "savevm" command will overwrite an existing snapshot
if it already exists with the requested name. This new flag allows this
to be controlled allowing for safer behaviour with a future QMP command.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/migration/snapshot.h |  2 +-
 migration/savevm.c           | 19 ++++++++++++++++---
 monitor/hmp-cmds.c           |  2 +-
 replay/replay-snapshot.c     |  2 +-
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
index c85b6ec75b..d7db1174ef 100644
--- a/include/migration/snapshot.h
+++ b/include/migration/snapshot.h
@@ -15,7 +15,7 @@
 #ifndef QEMU_MIGRATION_SNAPSHOT_H
 #define QEMU_MIGRATION_SNAPSHOT_H
 
-int save_snapshot(const char *name, Error **errp);
+int save_snapshot(const char *name, bool overwrite, Error **errp);
 int load_snapshot(const char *name, Error **errp);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 63578c461a..95c14ba5ec 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2658,7 +2658,7 @@ int qemu_load_device_state(QEMUFile *f)
     return 0;
 }
 
-int save_snapshot(const char *name, Error **errp)
+int save_snapshot(const char *name, bool overwrite, Error **errp)
 {
     BlockDriverState *bs;
     QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
@@ -2686,8 +2686,21 @@ int save_snapshot(const char *name, Error **errp)
 
     /* Delete old snapshots of the same name */
     if (name) {
-        if (bdrv_all_delete_snapshot(name, false, NULL, errp) < 0) {
-            return ret;
+        if (overwrite) {
+            if (bdrv_all_delete_snapshot(name, false, NULL, errp) < 0) {
+                return ret;
+            }
+        } else {
+            ret2 = bdrv_all_has_snapshot(name, false, NULL, errp);
+            if (ret2 < 0) {
+                return -1;
+            }
+            if (ret2 == 1) {
+                error_setg(errp,
+                           "Snapshot '%s' already exists in one or more devices",
+                           name);
+                return -1;
+            }
         }
     }
 
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index f1b9df7250..685014b544 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1133,7 +1133,7 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
 
-    save_snapshot(qdict_get_try_str(qdict, "name"), &err);
+    save_snapshot(qdict_get_try_str(qdict, "name"), true, &err);
     hmp_handle_error(mon, err);
 }
 
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index e26fa4c892..8e7ff97d11 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -77,7 +77,7 @@ void replay_vmstate_init(void)
 
     if (replay_snapshot) {
         if (replay_mode == REPLAY_MODE_RECORD) {
-            if (save_snapshot(replay_snapshot, &err) != 0) {
+            if (save_snapshot(replay_snapshot, true, &err) != 0) {
                 error_report_err(err);
                 error_report("Could not create snapshot for icount record");
                 exit(1);
-- 
2.26.2


