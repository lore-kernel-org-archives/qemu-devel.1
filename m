Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22E5C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DCFA20747
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwclBJun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCFA20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrn9l-0005HB-Le
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmwH-000530-Tm
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:31:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48853
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmwG-0001hH-7i
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h8govD67lanJJAmIgSTuxQeH9ZylAQ7cIEwKwJSkzkc=;
 b=NwclBJungDvBflgY6ZA7zM5yFUntwpLH2u7mOGIaMFeYgrV2Tvz2oDdJA6yoGvQ3NYMPSv
 fdB1LF6SLY1FsFFfIfcFKhTzu85jpKN0BU8kkcnYWsZYZhY+6QmR9RVPOYB53Ilr7WJWlT
 oIwBEGAlJ/dZLW/83k1MZMItYtlISDI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-sMLozI-AMiygTSCdW7_JzA-1; Sat, 04 Jul 2020 14:30:57 -0400
X-MC-Unique: sMLozI-AMiygTSCdW7_JzA-1
Received: by mail-wr1-f71.google.com with SMTP id s16so23281627wrv.1
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=h8govD67lanJJAmIgSTuxQeH9ZylAQ7cIEwKwJSkzkc=;
 b=sVgjc8dQFmcgzNTZPx6tMyQ4lq52iYrEwfrO9BuXrcHuS3+O5NoX0eUubEfi4IpWWw
 U7zbElFpMEg2yVUp15YN7tJAvdgBJbaR6TJEUyTP2m8xuOGdOAgy+uS9K1jtNOyerATv
 dVgVVPNoAAlRrMQHHwEViSUTO10W/Y/aGKU5rHwP1KZkxjcmyoxbP1qaBo4+UGaX2J3w
 fEFI1Bx3ErXeMWSLyiiecz7F78cLAanan6dvPlf3ia3YZwDol2wjhYwUawVKhGdqx+Hj
 siRg4jExFa0ylGgauoP+dclkcm1yM4MjNEcxJdPjtV8yogoBDVGSg3m6Ptm+rT8Ym1Qk
 Nw6w==
X-Gm-Message-State: AOAM532SJSZopriiQdpdMYgH7MIv7xO9Y+8EIySAP5oreMGKeTHt9RDJ
 L3CYd814dKOwRCyiYQzdgK/wSUZULpSkFBY7hw0Jb4PMp0Zi2fpEVSCUK8cPWbRA1GbsWvLTJdX
 eEtKyeCl8UK9496c=
X-Received: by 2002:adf:ed4f:: with SMTP id u15mr40768083wro.318.1593887456093; 
 Sat, 04 Jul 2020 11:30:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7o45bmOSP6iFycd0u9lYGGBcNJgMmsmANcbnppIhjuLucrWxib+DrU/VAyrzufzddRSdwtw==
X-Received: by 2002:adf:ed4f:: with SMTP id u15mr40768078wro.318.1593887455964; 
 Sat, 04 Jul 2020 11:30:55 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 r8sm17523480wrp.40.2020.07.04.11.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:30:55 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:30:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 35/41] vhost: introduce new VhostOps vhost_vq_get_addr
Message-ID: <20200704182750.1088103-36-mst@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:15
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

This patch introduces new VhostOps vhost_vq_get_addr_op callback to get
the vring addr from the backend

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20200701145538.22333-9-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/hw/virtio/vhost-backend.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index b80f344cd6..fa84abac97 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -34,6 +34,7 @@ struct vhost_vring_state;
 struct vhost_vring_addr;
 struct vhost_scsi_target;
 struct vhost_iotlb_msg;
+struct vhost_virtqueue;
 
 typedef int (*vhost_backend_init)(struct vhost_dev *dev, void *opaque);
 typedef int (*vhost_backend_cleanup)(struct vhost_dev *dev);
@@ -113,6 +114,10 @@ typedef int (*vhost_set_inflight_fd_op)(struct vhost_dev *dev,
                                         struct vhost_inflight *inflight);
 
 typedef int (*vhost_dev_start_op)(struct vhost_dev *dev, bool started);
+
+typedef int (*vhost_vq_get_addr_op)(struct vhost_dev *dev,
+                    struct vhost_vring_addr *addr,
+                    struct vhost_virtqueue *vq);
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
@@ -154,6 +159,7 @@ typedef struct VhostOps {
     vhost_get_inflight_fd_op vhost_get_inflight_fd;
     vhost_set_inflight_fd_op vhost_set_inflight_fd;
     vhost_dev_start_op vhost_dev_start;
+    vhost_vq_get_addr_op  vhost_vq_get_addr;
 } VhostOps;
 
 extern const VhostOps user_ops;
-- 
MST


