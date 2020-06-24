Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2C5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B8F20836
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gqb6rlhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B8F20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo8dl-00017O-BS
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 12:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8VJ-0003Gd-1r
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:44:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51081
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8V8-000553-R8
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593017033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dwfmYuFFzBqquslyFAL9cyvY0xnkZl2pG7W0QNEk3/k=;
 b=Gqb6rlhyxDBWbxc127rjl5+q10400A/TRDFJiwkeuq20jK3b5S0nZN9ZzkhkU53LWbQq5a
 QgnAxfgAyF7BAEYoOubEmCPWjrWPHQ927QFUL+KNWF1vo+pAXhr44nPH00FTgEbroONdfc
 mpm3XyGc/JQYaSS6R2L4vjUeOx625UQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-a-1vYrnZMyCPJNn89rxwcQ-1; Wed, 24 Jun 2020 12:43:50 -0400
X-MC-Unique: a-1vYrnZMyCPJNn89rxwcQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5BBF800D5C;
 Wed, 24 Jun 2020 16:43:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CA715C578;
 Wed, 24 Jun 2020 16:43:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 03BD71138476; Wed, 24 Jun 2020 18:43:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/46] error: Avoid error_propagate() after
 migrate_add_blocker()
Date: Wed, 24 Jun 2020 18:43:07 +0200
Message-Id: <20200624164344.3778251-10-armbru@redhat.com>
In-Reply-To: <20200624164344.3778251-1-armbru@redhat.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When migrate_add_blocker(blocker, &errp) is followed by
error_propagate(errp, err), we can often just as well do
migrate_add_blocker(..., errp).

Do that with this Coccinelle script:

    @@
    expression blocker, err, errp;
    expression ret;
    @@
    -    ret = migrate_add_blocker(blocker, &err);
    -    if (err) {
    +    ret = migrate_add_blocker(blocker, errp);
    +    if (ret < 0) {
	     ... when != err;
    -        error_propagate(errp, err);
	     ...
	 }

    @@
    expression blocker, err, errp;
    @@
    -    migrate_add_blocker(blocker, &err);
    -    if (err) {
    +    if (migrate_add_blocker(blocker, errp) < 0) {
	     ... when != err;
    -        error_propagate(errp, err);
	     ...
	 }

Double-check @err is not used afterwards.  Dereferencing it would be
use after free, but checking whether it's null would be legitimate.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/parallels.c            | 5 ++---
 block/qcow.c                 | 6 ++----
 block/vdi.c                  | 6 ++----
 block/vhdx.c                 | 5 ++---
 block/vmdk.c                 | 6 ++----
 block/vpc.c                  | 5 ++---
 block/vvfat.c                | 5 ++---
 hw/display/virtio-gpu-base.c | 5 +----
 hw/intc/arm_gic_kvm.c        | 4 +---
 hw/intc/arm_gicv3_its_kvm.c  | 4 +---
 hw/intc/arm_gicv3_kvm.c      | 4 +---
 hw/misc/ivshmem.c            | 4 +---
 hw/scsi/vhost-scsi.c         | 4 +---
 13 files changed, 20 insertions(+), 43 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index a84ec6a518..860dbb80a2 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -862,9 +862,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     error_setg(&s->migration_blocker, "The Parallels format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    ret = migrate_add_blocker(s->migration_blocker, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    ret = migrate_add_blocker(s->migration_blocker, errp);
+    if (ret < 0) {
         error_free(s->migration_blocker);
         goto fail;
     }
diff --git a/block/qcow.c b/block/qcow.c
index dca2a1fe7d..eefa3b63da 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -121,7 +121,6 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
     unsigned int len, i, shift;
     int ret;
     QCowHeader header;
-    Error *local_err = NULL;
     QCryptoBlockOpenOptions *crypto_opts = NULL;
     unsigned int cflags = 0;
     QDict *encryptopts = NULL;
@@ -314,9 +313,8 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
     error_setg(&s->migration_blocker, "The qcow format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    ret = migrate_add_blocker(s->migration_blocker, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    ret = migrate_add_blocker(s->migration_blocker, errp);
+    if (ret < 0) {
         error_free(s->migration_blocker);
         goto fail;
     }
diff --git a/block/vdi.c b/block/vdi.c
index 2f506a01ba..5fca67f52d 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -375,7 +375,6 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
     VdiHeader header;
     size_t bmap_size;
     int ret;
-    Error *local_err = NULL;
     QemuUUID uuid_link, uuid_parent;
 
     bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
@@ -496,9 +495,8 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
     error_setg(&s->migration_blocker, "The vdi format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    ret = migrate_add_blocker(s->migration_blocker, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    ret = migrate_add_blocker(s->migration_blocker, errp);
+    if (ret < 0) {
         error_free(s->migration_blocker);
         goto fail_free_bmap;
     }
diff --git a/block/vhdx.c b/block/vhdx.c
index ac5a9094c4..b9ef4ff074 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1089,9 +1089,8 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
     error_setg(&s->migration_blocker, "The vhdx format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    ret = migrate_add_blocker(s->migration_blocker, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    ret = migrate_add_blocker(s->migration_blocker, errp);
+    if (ret < 0) {
         error_free(s->migration_blocker);
         goto fail;
     }
diff --git a/block/vmdk.c b/block/vmdk.c
index 9a09193f3b..28cec50f38 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1263,7 +1263,6 @@ static int vmdk_open(BlockDriverState *bs, QDict *options, int flags,
     int ret;
     BDRVVmdkState *s = bs->opaque;
     uint32_t magic;
-    Error *local_err = NULL;
 
     bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
                                BDRV_CHILD_IMAGE, false, errp);
@@ -1317,9 +1316,8 @@ static int vmdk_open(BlockDriverState *bs, QDict *options, int flags,
     error_setg(&s->migration_blocker, "The vmdk format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    ret = migrate_add_blocker(s->migration_blocker, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    ret = migrate_add_blocker(s->migration_blocker, errp);
+    if (ret < 0) {
         error_free(s->migration_blocker);
         goto fail;
     }
diff --git a/block/vpc.c b/block/vpc.c
index 36412f764d..7290f36514 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -448,9 +448,8 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
     error_setg(&s->migration_blocker, "The vpc format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    ret = migrate_add_blocker(s->migration_blocker, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    ret = migrate_add_blocker(s->migration_blocker, errp);
+    if (ret < 0) {
         error_free(s->migration_blocker);
         goto fail;
     }
diff --git a/block/vvfat.c b/block/vvfat.c
index c65a98e3ee..a28e3fa442 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1282,9 +1282,8 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
                    "The vvfat (rw) format used by node '%s' "
                    "does not support live migration",
                    bdrv_get_device_or_node_name(bs));
-        ret = migrate_add_blocker(s->migration_blocker, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        ret = migrate_add_blocker(s->migration_blocker, errp);
+        if (ret < 0) {
             error_free(s->migration_blocker);
             goto fail;
         }
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index c159351be3..7961308606 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -128,7 +128,6 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(qdev);
     VirtIOGPUBase *g = VIRTIO_GPU_BASE(qdev);
-    Error *local_err = NULL;
     int i;
 
     if (g->conf.max_outputs > VIRTIO_GPU_MAX_SCANOUTS) {
@@ -139,9 +138,7 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
     g->use_virgl_renderer = false;
     if (virtio_gpu_virgl_enabled(g->conf)) {
         error_setg(&g->migration_blocker, "virgl is not yet migratable");
-        migrate_add_blocker(g->migration_blocker, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (migrate_add_blocker(g->migration_blocker, errp) < 0) {
             error_free(g->migration_blocker);
             return false;
         }
diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index d7df423a7a..07b95143c9 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -517,9 +517,7 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
     if (!kvm_arm_gic_can_save_restore(s)) {
         error_setg(&s->migration_blocker, "This operating system kernel does "
                                           "not support vGICv2 migration");
-        migrate_add_blocker(s->migration_blocker, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (migrate_add_blocker(s->migration_blocker, errp) < 0) {
             error_free(s->migration_blocker);
             return;
         }
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index ad0ebabc87..87bc4aeca1 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -113,9 +113,7 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
         GITS_CTLR)) {
         error_setg(&s->migration_blocker, "This operating system kernel "
                    "does not support vITS migration");
-        migrate_add_blocker(s->migration_blocker, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (migrate_add_blocker(s->migration_blocker, errp) < 0) {
             error_free(s->migration_blocker);
             return;
         }
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index ca43bf87ca..eddd07c743 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -858,9 +858,7 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
                                GICD_CTLR)) {
         error_setg(&s->migration_blocker, "This operating system kernel does "
                                           "not support vGICv3 migration");
-        migrate_add_blocker(s->migration_blocker, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (migrate_add_blocker(s->migration_blocker, errp) < 0) {
             error_free(s->migration_blocker);
             return;
         }
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index a8dc9b377d..fc128b25e2 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -898,9 +898,7 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
     if (!ivshmem_is_master(s)) {
         error_setg(&s->migration_blocker,
                    "Migration is disabled when using feature 'peer mode' in device 'ivshmem'");
-        migrate_add_blocker(s->migration_blocker, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (migrate_add_blocker(s->migration_blocker, errp) < 0) {
             error_free(s->migration_blocker);
             return;
         }
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index c1b012aea4..13b05af29b 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -207,9 +207,7 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
                 "When external environment supports it (Orchestrator migrates "
                 "target SCSI device state or use shared storage over network), "
                 "set 'migratable' property to true to enable migration.");
-        migrate_add_blocker(vsc->migration_blocker, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (migrate_add_blocker(vsc->migration_blocker, errp) < 0) {
             error_free(vsc->migration_blocker);
             goto free_virtio;
         }
-- 
2.26.2


