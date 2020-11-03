Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A897CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ABB0206DB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8i8S/Ne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABB0206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxoj-0006O7-1s
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxRm-0008SL-1z
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:38:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxRk-0007eC-3m
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oxFgfij5tGa7wsPJMg6guJqSTCSDLHe43Ge56aYH6Hc=;
 b=C8i8S/NewW1T8m1wUQZq1XI+plyexXQ0dv7q6dCrKBqKID6mv0V5VP9nPAQCF7eZPxIixb
 lyK0gLH+9zaSyJxyzU8pNK+6NL5crF9GV1GXqbWhRJlWSQ6f59+kcDNecd5NFJ9MqwB/Oc
 Ik5N6DLgBnRKASp4CurMI3KvNeiUb00=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-at3wqhQ0NLif2AUus-734w-1; Tue, 03 Nov 2020 09:35:09 -0500
X-MC-Unique: at3wqhQ0NLif2AUus-734w-1
Received: by mail-wr1-f69.google.com with SMTP id j15so7902599wrd.16
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oxFgfij5tGa7wsPJMg6guJqSTCSDLHe43Ge56aYH6Hc=;
 b=L+B1MhXzdPUu6Hx821V0zujW9MECfhhoBLNG2MMWmYuAOywPs/2LsFbrXd+dv9FKTe
 IyaT0UWgzuv1jU3Y0iRXz3OpKhX0DSv0qUiFueCIkY3ZRbqVV7RATdBvZoiMjYQ0DAHF
 KqnEHB2jpPAAEMfegIJknVb3TOG1y6O+8knu/8NXSyDF+Kl+Wo53tVm+dhuTobfoH7nH
 +6jdhc/i+sL50DMg28Hd/S8SxwaSM8WBK651IA25AE4Bn4HKNDemoy2E3g7qSWbDBiJ5
 FIegz8D3FM5SHpz25VjxUbyhQQ5T5kO4w7a2FbYIyYCeFNzWsd38H59G55H8u/jPyTw6
 j0lA==
X-Gm-Message-State: AOAM531F4dw1eeWQwWuMx1iDoB7oMz/OpcpPimsPZpM7iDPe0oOcxYcL
 5CjOwNbIRVVL8UkTu3sKbCLgDTQjBmyFy7wOXNscw+qdKlA6derb7Mx09V5qjuc/ucoLDoMZ0kl
 0tpO6mrcyyG12QKI=
X-Received: by 2002:a1c:4d4:: with SMTP id 203mr9851wme.153.1604414107910;
 Tue, 03 Nov 2020 06:35:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/D/b40QJ0pHTZNqKXjbVDdRAZjhK7ooCtOmACtwoJyaIglUuFToAG3zLzZG61sGw505MbHw==
X-Received: by 2002:a1c:4d4:: with SMTP id 203mr9829wme.153.1604414107749;
 Tue, 03 Nov 2020 06:35:07 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id n4sm10608825wrv.13.2020.11.03.06.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:35:07 -0800 (PST)
Date: Tue, 3 Nov 2020 09:35:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/38] Revert "vhost-blk: set features before setting inflight
 feature"
Message-ID: <20201103142306.71782-26-mst@redhat.com>
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
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

This reverts commit adb29c027341ba095a3ef4beef6aaef86d3a520e.

The commit broke -device vhost-user-blk-pci because the
vhost_dev_prepare_inflight() function it introduced segfaults in
vhost_dev_set_features() when attempting to access struct vhost_dev's
vdev pointer before it has been assigned.

To reproduce the segfault simply launch a vhost-user-blk device with the
contrib vhost-user-blk device backend:

  $ build/contrib/vhost-user-blk/vhost-user-blk -s /tmp/vhost-user-blk.sock -r -b /var/tmp/foo.img
  $ build/qemu-system-x86_64 \
        -device vhost-user-blk-pci,id=drv0,chardev=char1,addr=4.0 \
        -object memory-backend-memfd,id=mem,size=1G,share=on \
        -M memory-backend=mem,accel=kvm \
        -chardev socket,id=char1,path=/tmp/vhost-user-blk.sock
  Segmentation fault (core dumped)

Cc: Jin Yu <jin.yu@intel.com>
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20201102165709.232180-1-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost.h |  1 -
 hw/block/vhost-user-blk.c |  6 ------
 hw/virtio/vhost.c         | 18 ------------------
 3 files changed, 25 deletions(-)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 839bfb153c..94585067f7 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -141,7 +141,6 @@ void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
 void vhost_dev_free_inflight(struct vhost_inflight *inflight);
 void vhost_dev_save_inflight(struct vhost_inflight *inflight, QEMUFile *f);
 int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f);
-int vhost_dev_prepare_inflight(struct vhost_dev *hdev);
 int vhost_dev_set_inflight(struct vhost_dev *dev,
                            struct vhost_inflight *inflight);
 int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index f67b29bbf3..a076b1e54d 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -131,12 +131,6 @@ static int vhost_user_blk_start(VirtIODevice *vdev)
 
     s->dev.acked_features = vdev->guest_features;
 
-    ret = vhost_dev_prepare_inflight(&s->dev);
-    if (ret < 0) {
-        error_report("Error set inflight format: %d", -ret);
-        goto err_guest_notifiers;
-    }
-
     if (!s->inflight->addr) {
         ret = vhost_dev_get_inflight(&s->dev, s->queue_size, s->inflight);
         if (ret < 0) {
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index f2482378c6..79b2be20df 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1645,24 +1645,6 @@ int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f)
     return 0;
 }
 
-int vhost_dev_prepare_inflight(struct vhost_dev *hdev)
-{
-    int r;
- 
-    if (hdev->vhost_ops->vhost_get_inflight_fd == NULL ||
-        hdev->vhost_ops->vhost_set_inflight_fd == NULL) {
-        return 0;
-    }
- 
-    r = vhost_dev_set_features(hdev, hdev->log_enabled);
-    if (r < 0) {
-        VHOST_OPS_DEBUG("vhost_dev_prepare_inflight failed");
-        return r;
-    }
-
-    return 0;
-}
-
 int vhost_dev_set_inflight(struct vhost_dev *dev,
                            struct vhost_inflight *inflight)
 {
-- 
MST


