Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4907C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52CC220872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSibIvQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CC220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI9HH-0002xo-8v
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 07:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kI9Fe-00015z-8d
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 07:35:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kI9Fc-0002t0-CW
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 07:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600169755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VIHBo0+PGzZGYjd+Q9x3Rb3YHDy7kVsnXfqxvTTnOFM=;
 b=ZSibIvQtBr3sgLAO/UeDAm3oX2JrFMsP4zcaapI0wDGcBUyKoONYKYT7MaZuVI4FfcbbZz
 xHTUlMrhQFkrcsJta51BIllC2p+J2CXUZCtw7Qgm81ro7T/Rk94rghYfdtgHOuqCSPnk6g
 8/XDQ0gpTxmd6I7jD6RSvW9BzZNSsCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-0L9gRBW_Os-LyS_kVHcm_Q-1; Tue, 15 Sep 2020 07:35:54 -0400
X-MC-Unique: 0L9gRBW_Os-LyS_kVHcm_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2C11420E9;
 Tue, 15 Sep 2020 11:35:52 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE75D7513D;
 Tue, 15 Sep 2020 11:35:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/9] block: allow specifying name of block device for
 vmstate storage
Date: Tue, 15 Sep 2020 12:35:18 +0100
Message-Id: <20200915113523.2520317-5-berrange@redhat.com>
In-Reply-To: <20200915113523.2520317-1-berrange@redhat.com>
References: <20200915113523.2520317-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the vmstate will be stored in the first block device that
supports snapshots. Historically this would have usually been the
root device, but with UEFI it might be the variable store. There
needs to be a way to override the choice of block device to store
the state in.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/monitor/block-hmp-cmds.c |  2 +-
 block/snapshot.c               | 23 ++++++++++++++++++++---
 include/block/snapshot.h       |  3 ++-
 migration/savevm.c             |  4 ++--
 4 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 30279bd15a..4a1fc1d6b0 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -900,7 +900,7 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
     SnapshotEntry *snapshot_entry;
     Error *err = NULL;
 
-    bs = bdrv_all_find_vmstate_bs(false, NULL, &err);
+    bs = bdrv_all_find_vmstate_bs(NULL, false, NULL, &err);
     if (!bs) {
         error_report_err(err);
         return;
diff --git a/block/snapshot.c b/block/snapshot.c
index 155b8aad88..d2caaa88b5 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -678,7 +678,9 @@ int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
     return 0;
 }
 
-BlockDriverState *bdrv_all_find_vmstate_bs(bool has_devices, strList *devices,
+
+BlockDriverState *bdrv_all_find_vmstate_bs(const char *vmstate_bs,
+                                           bool has_devices, strList *devices,
                                            Error **errp)
 {
     g_autoptr(GList) bdrvs = NULL;
@@ -699,13 +701,28 @@ BlockDriverState *bdrv_all_find_vmstate_bs(bool has_devices, strList *devices,
             bdrv_can_snapshot(bs);
         aio_context_release(ctx);
 
-        if (found) {
+        if (vmstate_bs) {
+            if (g_str_equal(vmstate_bs,
+                            bdrv_get_node_name(bs))) {
+                if (found) {
+                    return bs;
+                } else {
+                    error_setg(errp, "vmstate block device '%s' does not support snapshots",
+                               vmstate_bs);
+                    return NULL;
+                }
+            }
+        } else if (found) {
             return bs;
         }
 
         iterbdrvs = iterbdrvs->next;
     }
 
-    error_setg(errp, "No block device supports snapshots");
+    if (vmstate_bs) {
+        error_setg(errp, "vmstate block device '%s' does not exist", vmstate_bs);
+    } else {
+        error_setg(errp, "no block device can store vmstate for snapshot");
+    }
     return NULL;
 }
diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index bac3409669..4d25f17728 100644
--- a/include/block/snapshot.h
+++ b/include/block/snapshot.h
@@ -94,7 +94,8 @@ int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
                              strList *devices,
                              Error **errp);
 
-BlockDriverState *bdrv_all_find_vmstate_bs(bool has_devices, strList *devices,
+BlockDriverState *bdrv_all_find_vmstate_bs(const char *vmstate_bs,
+                                           bool has_devices, strList *devices,
                                            Error **errp);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 0b3454f2e8..76972d69b0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2691,7 +2691,7 @@ int save_snapshot(const char *name, Error **errp)
         }
     }
 
-    bs = bdrv_all_find_vmstate_bs(false ,NULL, errp);
+    bs = bdrv_all_find_vmstate_bs(NULL, false, NULL, errp);
     if (bs == NULL) {
         return ret;
     }
@@ -2881,7 +2881,7 @@ int load_snapshot(const char *name, Error **errp)
         return -1;
     }
 
-    bs_vm_state = bdrv_all_find_vmstate_bs(false, NULL, errp);
+    bs_vm_state = bdrv_all_find_vmstate_bs(NULL, false, NULL, errp);
     if (!bs_vm_state) {
         return -1;
     }
-- 
2.26.2


