Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC75FC4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F4B206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAHUYWJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F4B206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONzA-0002XP-GE
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 12:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kONuu-0004su-66
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:28:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kONur-0003F4-88
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601656096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3plWy8xd5puaJO8PLGzvTOa5TpIJt/++/ygJESkjJsA=;
 b=LAHUYWJavkf8/O681RTEdsViv2Riuw5qYvpe3SRCJj0fCo29c7lZEybBT31DcudaYIsJ/0
 5ILF6GzH8dXfAGUzZlUF7h++ivAS8tPEoBL5hwXX16IN21YAwS5H4Ji8zqOcowW1gtzKUB
 3jtgz5n9VC4FEzK/jx+9w3AGXFLpzpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-FqfXVlBPMcqtjyYy20VO8w-1; Fri, 02 Oct 2020 12:28:12 -0400
X-MC-Unique: FqfXVlBPMcqtjyYy20VO8w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82B27803F65;
 Fri,  2 Oct 2020 16:28:11 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0C7A1002C03;
 Fri,  2 Oct 2020 16:28:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 05/10] block: rename and alter bdrv_all_find_snapshot
 semantics
Date: Fri,  2 Oct 2020 17:27:42 +0100
Message-Id: <20201002162747.3123597-6-berrange@redhat.com>
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

Currently bdrv_all_find_snapshot() will return 0 if it finds
a snapshot, -1 if an error occurs, or if it fails to find a
snapshot. New callers to be added want to distinguish between
the error scenario and failing to find a snapshot.

Rename it to bdrv_all_has_snapshot and make it return -1 on
error, 0 if no snapshot is found and 1 if snapshot is found.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/monitor/block-hmp-cmds.c |  2 +-
 block/snapshot.c               | 19 ++++++++++++-------
 include/block/snapshot.h       |  6 +++---
 migration/savevm.c             |  7 ++++++-
 4 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 4a1fc1d6b0..2b38a0013e 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -952,7 +952,7 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
     total = 0;
     for (i = 0; i < nb_sns; i++) {
         SnapshotEntry *next_sn;
-        if (bdrv_all_find_snapshot(sn_tab[i].name, false, NULL, NULL) == 0) {
+        if (bdrv_all_has_snapshot(sn_tab[i].name, false, NULL, NULL) == 1) {
             global_snapshots[total] = i;
             total++;
             QTAILQ_FOREACH(image_entry, &image_list, next) {
diff --git a/block/snapshot.c b/block/snapshot.c
index 2c3edd9922..e1dc87e9da 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -603,9 +603,9 @@ int bdrv_all_goto_snapshot(const char *name,
     return 0;
 }
 
-int bdrv_all_find_snapshot(const char *name,
-                           bool has_devices, strList *devices,
-                           Error **errp)
+int bdrv_all_has_snapshot(const char *name,
+                          bool has_devices, strList *devices,
+                          Error **errp)
 {
     g_autoptr(GList) bdrvs = NULL;
     GList *iterbdrvs;
@@ -627,15 +627,20 @@ int bdrv_all_find_snapshot(const char *name,
         }
         aio_context_release(ctx);
         if (ret < 0) {
-            error_setg(errp, "Could not find snapshot '%s' on '%s'",
-                       name, bdrv_get_device_or_node_name(bs));
-            return -1;
+            if (ret == -ENOENT) {
+                return 0;
+            } else {
+                error_setg_errno(errp, errno,
+                                 "Could not check snapshot '%s' on '%s'",
+                                 name, bdrv_get_device_or_node_name(bs));
+                return -1;
+            }
         }
 
         iterbdrvs = iterbdrvs->next;
     }
 
-    return 0;
+    return 1;
 }
 
 int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index 4d25f17728..ce0fcff8e3 100644
--- a/include/block/snapshot.h
+++ b/include/block/snapshot.h
@@ -84,9 +84,9 @@ int bdrv_all_delete_snapshot(const char *name,
 int bdrv_all_goto_snapshot(const char *name,
                            bool has_devices, strList *devices,
                            Error **errp);
-int bdrv_all_find_snapshot(const char *name,
-                           bool has_devices, strList *devices,
-                           Error **errp);
+int bdrv_all_has_snapshot(const char *name,
+                          bool has_devices, strList *devices,
+                          Error **errp);
 int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
                              BlockDriverState *vm_state_bs,
                              uint64_t vm_state_size,
diff --git a/migration/savevm.c b/migration/savevm.c
index d89d8fe605..63578c461a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2877,10 +2877,15 @@ int load_snapshot(const char *name, Error **errp)
     if (!bdrv_all_can_snapshot(false, NULL, errp)) {
         return -1;
     }
-    ret = bdrv_all_find_snapshot(name, false, NULL, errp);
+    ret = bdrv_all_has_snapshot(name, false, NULL, errp);
     if (ret < 0) {
         return -1;
     }
+    if (ret == 0) {
+        error_setg(errp, "Snapshot '%s' does not exist in one or more devices",
+                   name);
+        return -1;
+    }
 
     bs_vm_state = bdrv_all_find_vmstate_bs(NULL, false, NULL, errp);
     if (!bs_vm_state) {
-- 
2.26.2


