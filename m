Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B80C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF702206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/fUOl0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF702206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03XU-0008Bm-3Z
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03Vv-0005hT-G1
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:49:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49243
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03Vt-0001xB-R9
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595857797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nUT7Qbk7nFEddXYspzd8aisJc0jjaXW+jFGJmy8zWts=;
 b=D/fUOl0qy2yJwQb5d7WGqPMn/vusWcSkiZI/5Du5VjvNJEU2EXDbAx4URazqQvni2bEjdL
 U4K1NbWLMwkj+e/HiG4TVSuZacBQRuVeQYHSgtuxTrnkfmjkLQ5AYHq8Dpl4syKljJ5IrT
 1xwjiVk3dF6BbPCMKK45MAw52OZknN8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-oR3SZWCvMQGIzOBhVtD2xQ-1; Mon, 27 Jul 2020 09:49:55 -0400
X-MC-Unique: oR3SZWCvMQGIzOBhVtD2xQ-1
Received: by mail-wr1-f69.google.com with SMTP id w1so1938315wro.4
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 06:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nUT7Qbk7nFEddXYspzd8aisJc0jjaXW+jFGJmy8zWts=;
 b=uQDbxbuPMPbUQGTe+tEM7pY4VBc3a2IxrWxcUpPESJgw1aOAMEaopUweLoa6f8jHPX
 Yj8M802rZ8R3Ksg7SM98wJXzzl1ie/aN+CN8Hc/cj3KKiZ/y/OLkQrBDFUPMwwkRr4iN
 cfQlAoDMsETHbNGmhtYWQJNCW7wShcK2b9WGeDUSKaT4DQjBL8QvY6aXnCMFl7SwOCrl
 FrnV4aF02nJMYHcLeDKDwVjanfw4EmSh3BO6C/TBKr/zPahc51uMW3Kx9TkyciBAJkqS
 ukvjZLN3dzMmt2xUxpPsvQfvoHyV5khBud8umFY+SfHQkutoFj98kyHA6tKDdJg8nDT3
 Lq1w==
X-Gm-Message-State: AOAM532VwrWVzvcBxiKiWWkptAkpk7Fl6ZJU5Htqp2H1r0TuEdaLYAJZ
 3yTs+dPwYQPwgCgUwnNDxYFrcXsIE5bZ376sNDE8XDDA1ueEuJhMDRdCFV8Ti7sAS3tYNuNZHad
 jRPboy3CJi0Ss1V0=
X-Received: by 2002:adf:e504:: with SMTP id j4mr11918893wrm.205.1595857794108; 
 Mon, 27 Jul 2020 06:49:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOaDPnh1xHkg2DFqBjjWwSiQkfkAuecs0pJAXikVeUHKS/Oyy0GegQwgUA9uyZnNeEjmdooQ==
X-Received: by 2002:adf:e504:: with SMTP id j4mr11918879wrm.205.1595857793945; 
 Mon, 27 Jul 2020 06:49:53 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id b63sm18839144wme.41.2020.07.27.06.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 06:49:53 -0700 (PDT)
Date: Mon, 27 Jul 2020 09:49:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/7] vhost-vdpa :Fix Coverity CID 1430270 / CID 1420267
Message-ID: <20200727134614.96376-7-mst@redhat.com>
References: <20200727134614.96376-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727134614.96376-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Li Qiang <liq3ea@gmail.com>, qemu-stable@nongnu.org,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cindy Lu <lulu@redhat.com>

In the function vhost_vdpa_dma_map/unmap, The struct msg was not initialized all its fields.

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20200710064642.24505-1-lulu@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 65d5aaf08a..4580f3efd8 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -37,7 +37,7 @@ static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section)
 static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwaddr size,
                               void *vaddr, bool readonly)
 {
-    struct vhost_msg_v2 msg;
+    struct vhost_msg_v2 msg = {};
     int fd = v->device_fd;
     int ret = 0;
 
@@ -60,7 +60,7 @@ static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwaddr size,
 static int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, hwaddr iova,
                                 hwaddr size)
 {
-    struct vhost_msg_v2 msg;
+    struct vhost_msg_v2 msg = {};
     int fd = v->device_fd;
     int ret = 0;
 
-- 
MST


