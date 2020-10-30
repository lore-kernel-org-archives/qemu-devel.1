Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD41C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 417A7206ED
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kj0fbqhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417A7206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYTvr-0003GM-2N
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 08:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmr-0000rV-JX
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34172)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmp-0000m1-Sv
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=509YkEUpGBV1ErtRUsNd1psMy3xW+1ruB0fSsKITRuw=;
 b=Kj0fbqhMbrD8KrQg+FFD++cUXlv5uT7Z6BWDQYzkUI/yzsqH0QkwKH/DmK3Oxp9SqqNayi
 sjzqB588sChaYseAWJ5oat8oWQBs1cP8Xcf+DOFMyo4K/vkAc6Wzcn66exkyxETdgwGjwq
 AcmpWbvt7MhiEgJwb4VU7wf/J508UNA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-XDvEhtB3OUGMLzKGcyWpug-1; Fri, 30 Oct 2020 08:45:40 -0400
X-MC-Unique: XDvEhtB3OUGMLzKGcyWpug-1
Received: by mail-wr1-f69.google.com with SMTP id t11so2619292wrv.10
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 05:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=509YkEUpGBV1ErtRUsNd1psMy3xW+1ruB0fSsKITRuw=;
 b=iOyakfwa3XU7T/pWED7Q9EuDcGuOWtEbqIR23XwWYT9Sy/zNSkeIF0QVxfXuI8yonn
 avfUlRLORCgWWhnYlaEGguDIyaLpXqBxhmuzuOK29MK1cyW19ac8O47vgRYgOf7jTDB6
 75pqvgh+UIfpOfG2KBKyc3YNu9YAyegemK2kbImW4VT2aYUhmpKJGl/7h82N8HOjz3gr
 q1lkBByJ6+vj1yy4cYgy8Z1E2G4mimrBSWgiLhDQfq5xJYPsidTwnf9BjRgWmmjCe54G
 zdGy/hhgtHeYC5qa0U49RtLwn3Mj3s3esGqqfbQMLYLjoXCd4bHmCb4/rKDzqHYk6CsW
 sJcg==
X-Gm-Message-State: AOAM531p+JnHSiwo5CVo3MDIz/mPlhgbC+4C3quThzZaRukrnyDdbEEt
 vh1JD5bfY0pnL+dVQCtrqDZ1HBsVs5bI10SpXtjIVlDcX9onTzzT7S7YsR68t8bRwfhci4at6ae
 1MOqtwFDFdF27oXU=
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr3150539wrp.394.1604061939079; 
 Fri, 30 Oct 2020 05:45:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxW2gRd5skutD/4hjKT7rnhkZQYjgaIPNjN5aQtq2s6a92ZLCTTAzcrIojcPp7UFH1c3rpOAQ==
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr3150520wrp.394.1604061938861; 
 Fri, 30 Oct 2020 05:45:38 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id 71sm11021534wrm.20.2020.10.30.05.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 05:45:38 -0700 (PDT)
Date: Fri, 30 Oct 2020 08:45:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/15] virtio: skip guest index check on device load
Message-ID: <20201030124454.854286-15-mst@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Felipe Franciosi <felipe@nutanix.com>

QEMU must be careful when loading device state off migration streams to
prevent a malicious source from exploiting the emulator. Overdoing these
checks has the side effect of allowing a guest to "pin itself" in cloud
environments by messing with state which is entirely in its control.

Similarly to what f3081539 achieved in usb_device_post_load(), this
commit removes such a check from virtio_load(). Worth noting, the result
of a load without this check is the same as if a guest enables a VQ with
invalid indexes to begin with. That is, the virtual device is set in a
broken state (by the datapath handler) and must be reset.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
Message-Id: <20201028134643.110698-1-felipe@nutanix.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 6f8f865aff..ceb58fda6c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -17,6 +17,7 @@
 #include "trace.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "hw/virtio/virtio.h"
@@ -3160,12 +3161,12 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
             nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
             /* Check it isn't doing strange things with descriptor numbers. */
             if (nheads > vdev->vq[i].vring.num) {
-                error_report("VQ %d size 0x%x Guest index 0x%x "
-                             "inconsistent with Host index 0x%x: delta 0x%x",
-                             i, vdev->vq[i].vring.num,
-                             vring_avail_idx(&vdev->vq[i]),
-                             vdev->vq[i].last_avail_idx, nheads);
-                return -1;
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "VQ %d size 0x%x Guest index 0x%x "
+                              "inconsistent with Host index 0x%x: delta 0x%x",
+                              i, vdev->vq[i].vring.num,
+                              vring_avail_idx(&vdev->vq[i]),
+                              vdev->vq[i].last_avail_idx, nheads);
             }
             vdev->vq[i].used_idx = vring_used_idx(&vdev->vq[i]);
             vdev->vq[i].shadow_avail_idx = vring_avail_idx(&vdev->vq[i]);
-- 
MST


