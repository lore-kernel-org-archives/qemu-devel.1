Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB14CC3567B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 06:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EE9520714
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 06:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE9520714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j67Th-00016w-PB
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 01:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <longpeng2@huawei.com>) id 1j67S9-000792-WB
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 01:42:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <longpeng2@huawei.com>) id 1j67S9-0008WJ-1h
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 01:42:53 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:56942 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <longpeng2@huawei.com>)
 id 1j67S8-0008V1-MF
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 01:42:52 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 836BE7125658CEED0852;
 Mon, 24 Feb 2020 14:42:50 +0800 (CST)
Received: from DESKTOP-27KDQMV.china.huawei.com (10.173.228.124) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Feb 2020 14:42:43 +0800
From: "Longpeng(Mike)" <longpeng2@huawei.com>
To: <mst@redhat.com>, <alex.williamson@redhat.com>
Subject: [PATCH RESEND 2/3] vhost: fix a null pointer reference of vhost_log
Date: Mon, 24 Feb 2020 14:42:18 +0800
Message-ID: <20200224064219.1434-3-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <20200224064219.1434-1-longpeng2@huawei.com>
References: <20200224064219.1434-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.228.124]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: longpeng2@huawei.com, arei.gonglei@huawei.com, huangzhichao@huawei.com,
 qemu-devel@nongnu.org, weifuqiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Longpeng <longpeng2@huawei.com>

vhost_log_alloc() may fails and returned pointer of log is null.
However there're two places derefernce the return pointer without
check.

Signed-off-by: Longpeng <longpeng2@huawei.com>
---
 hw/virtio/vhost.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 9edfadc..c7ad6e5 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -219,6 +219,10 @@ static struct vhost_log *vhost_log_get(uint64_t size=
, bool share)
=20
     if (!log || log->size !=3D size) {
         log =3D vhost_log_alloc(size, share);
+        if (!log) {
+            return NULL;
+        }
+
         if (share) {
             vhost_log_shm =3D log;
         } else {
@@ -270,10 +274,17 @@ static bool vhost_dev_log_is_shared(struct vhost_de=
v *dev)
=20
 static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t =
size)
 {
-    struct vhost_log *log =3D vhost_log_get(size, vhost_dev_log_is_share=
d(dev));
-    uint64_t log_base =3D (uintptr_t)log->log;
+    struct vhost_log *log;
+    uint64_t log_base;
     int r;
=20
+    log =3D vhost_log_get(size, vhost_dev_log_is_shared(dev));
+    if (!log) {
+        return;
+    }
+
+    log_base =3D (uintptr_t)log->log;
+
     /* inform backend of log switching, this must be done before
        releasing the current log, to ensure no logging is lost */
     r =3D dev->vhost_ops->vhost_set_log_base(dev, log_base, log);
@@ -1640,6 +1651,10 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIO=
Device *vdev)
         hdev->log_size =3D vhost_get_log_size(hdev);
         hdev->log =3D vhost_log_get(hdev->log_size,
                                   vhost_dev_log_is_shared(hdev));
+        if (!hdev->log) {
+            goto fail_vq;
+        }
+
         log_base =3D (uintptr_t)hdev->log->log;
         r =3D hdev->vhost_ops->vhost_set_log_base(hdev,
                                                 hdev->log_size ? log_bas=
e : 0,
--=20
1.8.3.1


