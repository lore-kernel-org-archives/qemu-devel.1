Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0DBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:16:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA2A20787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PX3L34on"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA2A20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyDfR-0007Ob-TC
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 08:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDZ2-00065I-So
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:09:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32957
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDZ1-0006bu-C1
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595419774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nCEOZP6B1lWOOd8FiK7LTx/qy5GESWgBrYMgTCL8coc=;
 b=PX3L34onG1uMprc00GRXCeSABPFLJ4nh/lfxZHp8jW5A5fK90kUD6saN1LMiz159Zr6Zl7
 +9cSQdq+uGh0cLo/TtYF2R/c7OUiyDB79bV/gylbOpWRMi7Y/TNSeqcIckJXeKOLAaOptv
 mpMnQ4qNVS7smwtFywxfFiuKocN7ze0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-zKtS2YTBO3SBLALWwTxmsA-1; Wed, 22 Jul 2020 08:09:32 -0400
X-MC-Unique: zKtS2YTBO3SBLALWwTxmsA-1
Received: by mail-wr1-f70.google.com with SMTP id a18so548264wrm.14
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 05:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nCEOZP6B1lWOOd8FiK7LTx/qy5GESWgBrYMgTCL8coc=;
 b=q4a0jhJClUXACeKfHhXkA7w2eDZkcROBPck5ynkT7se6ISvLq3hIzYWASjBNXhDquK
 x4AVUr/qgRSrLW9fjZWWhUf66bSDgxUE5enG8ipFO30bh45q+AaF9KFS5uRch8PB2Uut
 FLjwC+/uuI9pvclYeaHo9bBoAPDSNeucVPlJMBo7xMpFKDkX0QS8Q5ZMTZZVYjW30yXI
 FN8i8NfG/lNGo05KnYIc98jpeSvTC859xRz4AmjcRKzeYPWFTgVnIF4Xb+bKUSYcN1CP
 1/A6HGJq6Hf7zyOH2qUAaOe41tVp3yI9TDhJMyKwhWIIsetqgJ3pEYHAPrPI68JpZjDL
 5wrg==
X-Gm-Message-State: AOAM532yIE5EcPm2SCqWOTJWPCQOu/o8ktivlMnmstilRlhu6L2Jz8R7
 PtL1Kyod+Z9M0kbQ0pQ40KUqo5FiOg/g7hwEk/kVS4naYtNx7OIuHD1PAtM7l2HFebN1s7nRkG1
 56Yl2g5qYviX1/6c=
X-Received: by 2002:adf:a351:: with SMTP id d17mr5346391wrb.111.1595419770797; 
 Wed, 22 Jul 2020 05:09:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzs2RXXrkj1wCwHt7f7ieiuuMd88rSEUw6c7z5Gixub12VESK+W10JpwmjC/Nt2e0Bc1Kwzeg==
X-Received: by 2002:adf:a351:: with SMTP id d17mr5346378wrb.111.1595419770542; 
 Wed, 22 Jul 2020 05:09:30 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id f186sm6997734wmf.29.2020.07.22.05.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 05:09:29 -0700 (PDT)
Date: Wed, 22 Jul 2020 08:09:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/9] virtio: list legacy-capable devices
Message-ID: <20200722120853.9144-7-mst@redhat.com>
References: <20200722120853.9144-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200722120853.9144-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cornelia Huck <cohuck@redhat.com>

Several types of virtio devices had already been around before the
virtio standard was specified. These devices support virtio in legacy
(and transitional) mode.

Devices that have been added in the virtio standard are considered
non-transitional (i.e. with no support for legacy virtio).

Provide a helper function so virtio transports can figure that out
easily.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200707105446.677966-2-cohuck@redhat.com>
Cc: qemu-stable@nongnu.org
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h |  2 ++
 hw/virtio/virtio.c         | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index b69d517496..198ffc7626 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -396,4 +396,6 @@ static inline bool virtio_device_disabled(VirtIODevice *vdev)
     return unlikely(vdev->disabled || vdev->broken);
 }
 
+bool virtio_legacy_allowed(VirtIODevice *vdev);
+
 #endif
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 5bd2a2f621..546a198e79 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -27,6 +27,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "sysemu/dma.h"
 #include "sysemu/runstate.h"
+#include "standard-headers/linux/virtio_ids.h"
 
 /*
  * The alignment to use between consumer and producer parts of vring.
@@ -3279,6 +3280,30 @@ void virtio_init(VirtIODevice *vdev, const char *name,
     vdev->use_guest_notifier_mask = true;
 }
 
+/*
+ * Only devices that have already been around prior to defining the virtio
+ * standard support legacy mode; this includes devices not specified in the
+ * standard. All newer devices conform to the virtio standard only.
+ */
+bool virtio_legacy_allowed(VirtIODevice *vdev)
+{
+    switch (vdev->device_id) {
+    case VIRTIO_ID_NET:
+    case VIRTIO_ID_BLOCK:
+    case VIRTIO_ID_CONSOLE:
+    case VIRTIO_ID_RNG:
+    case VIRTIO_ID_BALLOON:
+    case VIRTIO_ID_RPMSG:
+    case VIRTIO_ID_SCSI:
+    case VIRTIO_ID_9P:
+    case VIRTIO_ID_RPROC_SERIAL:
+    case VIRTIO_ID_CAIF:
+        return true;
+    default:
+        return false;
+    }
+}
+
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n)
 {
     return vdev->vq[n].vring.desc;
-- 
MST


