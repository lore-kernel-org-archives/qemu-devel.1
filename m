Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DFDC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB91022277
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5W5ELuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB91022277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZpw2-0001dt-92
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 01:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZpv3-0000tX-G2
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:35:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZpv0-00036s-TX
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604385345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TzTQd6zsga848TZhSH4IIn0GT9mIurRHr8Lw0mt05Oc=;
 b=Y5W5ELuZXFxO43DKXRbN3T3DsM3DHgNz8rL2nRkHjEi8sq7IlTVe7V3erSAyWqaFnjl22o
 4byne6tcKTiBn5cA1ebvq8eGjISdRobovgv3/Mzhb2nfNHLyH98kA+yLdTJnr1g2F0t/zs
 Ay5BGr1fDnj6Gqz/48gyR+H2DfY+NfM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-a-Yaiu-xN4es_XkKOiE3AQ-1; Tue, 03 Nov 2020 01:35:44 -0500
X-MC-Unique: a-Yaiu-xN4es_XkKOiE3AQ-1
Received: by mail-wr1-f72.google.com with SMTP id h11so4466923wrq.20
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 22:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TzTQd6zsga848TZhSH4IIn0GT9mIurRHr8Lw0mt05Oc=;
 b=poUlm6ujaw/W324g6CqzVkqxDaJwUahnDBxTlBZQxrHj4AiC0jrk5rcplZo0AA0QSl
 Vb9qA5SN+BgPXkhH886bWC7aa0+gCJRFJbyk/aEMKgB+KYAED6uaBSmw4+pyXGN1REmY
 iUMfV983hx4zX7RllJsUKRrxC0T6NPcRlibX+/jy+ea7+RiIine4wUu86c7jFFln6l0P
 1CI2LU+Lu23vSn9NrTO8kJnPEie0xKswZMhCW7n/Cw7MWqHPE5QTTHjxd1tlRiJ0YyKe
 tsqOnCei9J8bl7gzPsnWAWzCgE8GuiEk38CqeE/DR5ondgcl/frsEB70M05X+KGmHNkj
 pvpg==
X-Gm-Message-State: AOAM530JVKvmRtLY0MpLqIa6ziwyJTFWpcyLIvjS876J081h8rJkApOt
 izjbM3nBrYiTqIuUpOq6Zw5ew8sXXreqWqcce+6PC58Yp6qyKmsAbnmDsIWbJZnyOLGpqEpYsJ3
 EoCpfLQqCFsqAlA0=
X-Received: by 2002:a05:600c:d5:: with SMTP id
 u21mr1866028wmm.28.1604385343152; 
 Mon, 02 Nov 2020 22:35:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDxYt5GtMt+qrxaNt9L6v08RKe4SQ9boutdzJR3FLKPWpjQnafJ1rQNgYRZf6OOXGo9VeA1g==
X-Received: by 2002:a05:600c:d5:: with SMTP id
 u21mr1866007wmm.28.1604385342949; 
 Mon, 02 Nov 2020 22:35:42 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id r1sm26295157wro.18.2020.11.02.22.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 22:35:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2] hw/virtio/vhost-backend: Fix Coverity CID 1432871
Date: Tue,  3 Nov 2020 07:35:41 +0100
Message-Id: <20201103063541.2463363-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix uninitialized value issues reported by Coverity:

  Field 'msg.reserved' is uninitialized when calling write().

While the 'struct vhost_msg' does not have a 'reserved' field,
we still initialize it to have the two parts of the function
consistent.

Reported-by: Coverity (CID 1432864: UNINIT)
Fixes: c471ad0e9bd ("vhost_net: device IOTLB support")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v2: comment 'struct vhost_msg' is also initialized (Peter)
---
 hw/virtio/vhost-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 88c8ecc9e03..222bbcc62de 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -257,7 +257,7 @@ static int vhost_kernel_send_device_iotlb_msg(struct vhost_dev *dev,
                                               struct vhost_iotlb_msg *imsg)
 {
     if (dev->backend_cap & (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)) {
-        struct vhost_msg_v2 msg;
+        struct vhost_msg_v2 msg = {};
 
         msg.type = VHOST_IOTLB_MSG_V2;
         msg.iotlb = *imsg;
@@ -267,7 +267,7 @@ static int vhost_kernel_send_device_iotlb_msg(struct vhost_dev *dev,
             return -EFAULT;
         }
     } else {
-        struct vhost_msg msg;
+        struct vhost_msg msg = {};
 
         msg.type = VHOST_IOTLB_MSG;
         msg.iotlb = *imsg;
-- 
2.26.2


