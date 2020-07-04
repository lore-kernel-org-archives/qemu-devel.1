Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D07EC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBEC820771
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOcqpmq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBEC820771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrnBR-0000Fk-07
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmwM-0005CV-FA
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:31:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55272
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmwK-0001hp-Ql
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zxsZyEl0Ic2zeqGPCHFNr5fX901vp9gn578GtCCySkg=;
 b=cOcqpmq6a+/cCzu4qfGOk59R620AVwjUD7d6DbXUsX1AmEZxBhITJdQ/YwBV06oojnmhEl
 xpAnShfqfS4/9PylAP9XcOoRDhKvmOUBdUz0tclqhFoJ5wrKnITCHVz137z5EAl1Om8neG
 VTa+9TW1y22pWhWQBRZS38bRGkNoZJY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-T_oxx4DBNsCNOUrys1a_RQ-1; Sat, 04 Jul 2020 14:31:02 -0400
X-MC-Unique: T_oxx4DBNsCNOUrys1a_RQ-1
Received: by mail-wm1-f71.google.com with SMTP id o13so40189995wmh.9
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zxsZyEl0Ic2zeqGPCHFNr5fX901vp9gn578GtCCySkg=;
 b=JLnabfiSqcCQX0n6mYtRWLWMQivqRvei9i64OoHBZzvunnXs3D3lvMPk+2O8T7wdvj
 JTWOowH5+x4y3+XlmET7BZPqdYuYEFwGykmuNhL8BCP5TrgULsbfMm2SHcb8cjqDC16O
 mHkjgGGhHU+RbRUMjGREev+FwtWj/Vevf4j5miGcM/qlxrxveQdKXbOnqgTicGnNPE9n
 GtNiczRvYCKo3Zh11qAnccqYUPk2bH/LoNRCtCFUAyMQEFptvS9MdN/uTtMnAasp8kpK
 gW6pDQd0yxL5buHsjkFBulcEy9uO3XmTcZDhgdgMhMnhV9BRIeG9qAodgn5SJS8xm9Yj
 LwOw==
X-Gm-Message-State: AOAM531xua1Tmtm9xUai+IgNdpNa6cENKCWx9aAg/MOYUaQrLReQ/qw1
 aCTxYjDD8ZwvHGxOUqvSYqQJ5JcanFCgQVt2rnSeL2dZVsWyKj08eUkxmboVa7mLjTMwc6M6rMp
 /aKf1xyFzUUjOLbM=
X-Received: by 2002:a5d:6b8c:: with SMTP id n12mr42148509wrx.352.1593887460671; 
 Sat, 04 Jul 2020 11:31:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwu4j4NZqOoPOYexPsdJ/qusDiClakwVkxT1uLaeahCIfg+cNTjhrzmLBJTBx+46lyfkluqkw==
X-Received: by 2002:a5d:6b8c:: with SMTP id n12mr42148505wrx.352.1593887460527; 
 Sat, 04 Jul 2020 11:31:00 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 68sm17479697wmz.40.2020.07.04.11.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:31:00 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:30:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 37/41] vhost: introduce new VhostOps vhost_force_iommu
Message-ID: <20200704182750.1088103-38-mst@redhat.com>
References: <20200704182750.1088103-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704182750.1088103-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 08:57:02
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cindy Lu <lulu@redhat.com>

This patch introduces new VhostOps vhost_force_iommu callback
to force enable features bit VIRTIO_F_IOMMU_PLATFORM.

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20200701145538.22333-11-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/hw/virtio/vhost-backend.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index bfc24207e2..e7cb8d028c 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -121,6 +121,8 @@ typedef int (*vhost_vq_get_addr_op)(struct vhost_dev *dev,
 
 typedef int (*vhost_get_device_id_op)(struct vhost_dev *dev, uint32_t *dev_id);
 
+typedef bool (*vhost_force_iommu_op)(struct vhost_dev *dev);
+
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
@@ -164,6 +166,7 @@ typedef struct VhostOps {
     vhost_dev_start_op vhost_dev_start;
     vhost_vq_get_addr_op  vhost_vq_get_addr;
     vhost_get_device_id_op vhost_get_device_id;
+    vhost_force_iommu_op vhost_force_iommu;
 } VhostOps;
 
 extern const VhostOps user_ops;
-- 
MST


