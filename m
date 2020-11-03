Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C683C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:45:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9303223EA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SuYWGuc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9303223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxYx-0000jf-T0
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxP5-0005L3-Mj
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:35:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxP3-0006el-Dn
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ay6G7kYGtMwl+/IxEdsu272p/jXvwydr69tjR0/ihX0=;
 b=SuYWGuc3wXTPPJ6gB72QiQQO6rldnnf4pKILpm9/2XKkEFzMqWekJpuc1tEOAoCzny3hWx
 Gj6sOKQbsUOE267iyAYGRdIiibBrA1dpBxB7aBTgth6SwnYmKz9qsalxckhOfRoaI9T+ly
 lH76N6QK+mRrbJkno01mf4dBk3T92i8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-Q7uTG_fWOzyF1Ro24Aj6Zw-1; Tue, 03 Nov 2020 09:35:12 -0500
X-MC-Unique: Q7uTG_fWOzyF1Ro24Aj6Zw-1
Received: by mail-wm1-f70.google.com with SMTP id 13so4685667wmf.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:35:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ay6G7kYGtMwl+/IxEdsu272p/jXvwydr69tjR0/ihX0=;
 b=C5poTBvvwCbuG97d3X64tW/0VzWF0p/1XbgtnNmmFPIGjsHc4MgmV7OPWd1+Od3u0h
 rw654RQ0+6iZd3RYwBNcO0RedM7sBapx5+21kGwvyx3W5JpDHanEGimKKsOK31D/UY9D
 ZAD4EbNAzS6hoDA6l5633RDLB4svabDovjk7yZKdqIgd2OpCUp8TAfZtVnD9RS8hxRNK
 2eoEpPl88E4ZxEFLFpTd4YBbyru0vBtpslMJfU2aitqXq+w+gjrGD4zPZBnw8Zz1tg4t
 dXYeuD45Fh3Oka+7UG48pCHxRA9RZjvQipIf/3wVZTPqayqjvUyBljX/GM9wWC+Z1PIg
 1zMw==
X-Gm-Message-State: AOAM532DZiwYyLNRL1o+e9XCXdcAMtGx+ZOJBzNHjx9Qy4E5+GwZEAXg
 gT3HOnIQdh9iTV40MFgJvYvL40OX3NGgyx22yerjGILArDNDv9ZBCbQIyqk9xETDm99QvG+xwtV
 5soCmw+vrZ+Xsies=
X-Received: by 2002:a1c:750b:: with SMTP id o11mr94075wmc.32.1604414110652;
 Tue, 03 Nov 2020 06:35:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1hcFbfc36uCTcXTH0RBujb6aH3ehkwq4gFuYX+bJGZ0LL5T5YwBzGhm5W/v3/CIcSCjAnQA==
X-Received: by 2002:a1c:750b:: with SMTP id o11mr94059wmc.32.1604414110496;
 Tue, 03 Nov 2020 06:35:10 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id 66sm3321234wmb.3.2020.11.03.06.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:35:09 -0800 (PST)
Date: Tue, 3 Nov 2020 09:35:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/38] vhost-blk: set features before setting inflight feature
Message-ID: <20201103142306.71782-27-mst@redhat.com>
References: <20201103142306.71782-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103142306.71782-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Jin Yu <jin.yu@intel.com>,
 Max Reitz <mreitz@redhat.com>, Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jin Yu <jin.yu@intel.com>

Virtqueue has split and packed, so before setting inflight,
you need to inform the back-end virtqueue format.

Signed-off-by: Jin Yu <jin.yu@intel.com>
Acked-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <20201103123617.28256-1-jin.yu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost.h |  1 +
 hw/block/vhost-user-blk.c |  6 ++++++
 hw/virtio/vhost.c         | 20 ++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 94585067f7..4a8bc75415 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -141,6 +141,7 @@ void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
 void vhost_dev_free_inflight(struct vhost_inflight *inflight);
 void vhost_dev_save_inflight(struct vhost_inflight *inflight, QEMUFile *f);
 int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f);
+int vhost_dev_prepare_inflight(struct vhost_dev *hdev, VirtIODevice *vdev);
 int vhost_dev_set_inflight(struct vhost_dev *dev,
                            struct vhost_inflight *inflight);
 int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index a076b1e54d..2dd3d93ca0 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -131,6 +131,12 @@ static int vhost_user_blk_start(VirtIODevice *vdev)
 
     s->dev.acked_features = vdev->guest_features;
 
+    ret = vhost_dev_prepare_inflight(&s->dev, vdev);
+    if (ret < 0) {
+        error_report("Error set inflight format: %d", -ret);
+        goto err_guest_notifiers;
+    }
+
     if (!s->inflight->addr) {
         ret = vhost_dev_get_inflight(&s->dev, s->queue_size, s->inflight);
         if (ret < 0) {
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 79b2be20df..614ccc2bcb 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1645,6 +1645,26 @@ int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f)
     return 0;
 }
 
+int vhost_dev_prepare_inflight(struct vhost_dev *hdev, VirtIODevice *vdev)
+{
+    int r;
+
+    if (hdev->vhost_ops->vhost_get_inflight_fd == NULL ||
+        hdev->vhost_ops->vhost_set_inflight_fd == NULL) {
+        return 0;
+    }
+
+    hdev->vdev = vdev;
+
+    r = vhost_dev_set_features(hdev, hdev->log_enabled);
+    if (r < 0) {
+        VHOST_OPS_DEBUG("vhost_dev_prepare_inflight failed");
+        return r;
+    }
+
+    return 0;
+}
+
 int vhost_dev_set_inflight(struct vhost_dev *dev,
                            struct vhost_inflight *inflight)
 {
-- 
MST


