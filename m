Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3694C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A4D2206ED
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5m4lyxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4D2206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYTtx-0000vK-Q1
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 08:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmr-0000rK-0x
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmo-0000lF-Sh
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gHTVvLyQX/nQL7WIpglC+HzeG7xS+O6ap0K+bTpJUHA=;
 b=Z5m4lyxKUep1aBIR36mcu9iA0HgO0A6N2Nf1FDzrS97mf96OjAgxdG86mjJUvqoxAWtdhL
 291qKfz+OWEzPMhnTftFU1uVR17cQ3rFLQmIxQC2Df1rcrLSCD59YVqiJlu+6baFOR34cn
 i4St789DWidrraxcJnxvMv26GjC5PFQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-fRD7MxgeNv-MJNpKi-34cA-1; Fri, 30 Oct 2020 08:45:38 -0400
X-MC-Unique: fRD7MxgeNv-MJNpKi-34cA-1
Received: by mail-wm1-f72.google.com with SMTP id s25so1198358wmj.7
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 05:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gHTVvLyQX/nQL7WIpglC+HzeG7xS+O6ap0K+bTpJUHA=;
 b=AfU6DcsKI8EFoRXWLlYL4lX8njwA7o5ojyAgHqQQasxaljo8zhpkP3mJTtYKlrc8vV
 g7l/hF1XkWJT3Ba2BlisqH87xFu9jN8clLYRV45kLPFd/A97WGoKN/T7GdKlwNhbyXlZ
 DJqaFhiBd4XXyQ+0SKr6AV6UcKdb5oO6SZihkSepHR2o0zbIn8NG3MrkeyeJ7gwvCOql
 z048bhrNSVsFZ/mDn4O51fZw39xZCJBunGv1oeCvZEBsOx8KskCmWznkd+ArOKtkjV+l
 hfYQiXoZiGUgKNWrFlb+f0fd+U1gdfrKHkAtAtouTyoW2v2BtKOdGTp+0YbLtJ4Rzmce
 yu+Q==
X-Gm-Message-State: AOAM531sWuYFQ/mOwKypUkeHJH2tx5fKrFtQrMWGccwB/eRcOHcrp3Sr
 SV3RzFoNf77NoX3gjN7XfX8eSRgIcsANgcruasrt98+eYEoqSdbkC4TgBwjOFbpSfcM8dMqX+C4
 vprn9NpuzZtTVlWI=
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr2476049wmf.122.1604061936467; 
 Fri, 30 Oct 2020 05:45:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiy/jQLLTwTiDLjbFQgIW6Cx/VKSJbRoWuSY0x49NlHj7PxlqXZXYAZpOd2l4lHDUgn59c0Q==
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr2476031wmf.122.1604061936260; 
 Fri, 30 Oct 2020 05:45:36 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id i33sm10834024wri.79.2020.10.30.05.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 05:45:35 -0700 (PDT)
Date: Fri, 30 Oct 2020 08:45:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/15] vhost-blk: set features before setting inflight feature
Message-ID: <20201030124454.854286-14-mst@redhat.com>
References: <20201030124454.854286-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201030124454.854286-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
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
Message-Id: <20200910134851.7817-1-jin.yu@intel.com>
Acked-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost.h |  1 +
 hw/block/vhost-user-blk.c |  6 ++++++
 hw/virtio/vhost.c         | 18 ++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 94585067f7..839bfb153c 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -141,6 +141,7 @@ void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
 void vhost_dev_free_inflight(struct vhost_inflight *inflight);
 void vhost_dev_save_inflight(struct vhost_inflight *inflight, QEMUFile *f);
 int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f);
+int vhost_dev_prepare_inflight(struct vhost_dev *hdev);
 int vhost_dev_set_inflight(struct vhost_dev *dev,
                            struct vhost_inflight *inflight);
 int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index a076b1e54d..f67b29bbf3 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -131,6 +131,12 @@ static int vhost_user_blk_start(VirtIODevice *vdev)
 
     s->dev.acked_features = vdev->guest_features;
 
+    ret = vhost_dev_prepare_inflight(&s->dev);
+    if (ret < 0) {
+        error_report("Error set inflight format: %d", -ret);
+        goto err_guest_notifiers;
+    }
+
     if (!s->inflight->addr) {
         ret = vhost_dev_get_inflight(&s->dev, s->queue_size, s->inflight);
         if (ret < 0) {
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 79b2be20df..f2482378c6 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1645,6 +1645,24 @@ int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f)
     return 0;
 }
 
+int vhost_dev_prepare_inflight(struct vhost_dev *hdev)
+{
+    int r;
+ 
+    if (hdev->vhost_ops->vhost_get_inflight_fd == NULL ||
+        hdev->vhost_ops->vhost_set_inflight_fd == NULL) {
+        return 0;
+    }
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


