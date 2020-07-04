Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0583C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1EB20747
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEjwfFeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1EB20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrn8E-0001jT-RZ
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmwC-0004pg-DK
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52803
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmwA-0001gI-PH
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YYDftXcBQrqsgbkpJ5iu6MhYnQVu4atwyoFfOVtYo8s=;
 b=cEjwfFePD/j2dB6/fBeSombGns3Q0yhP3U0jQwT31PkEZcCTfaxs2WRaJdohrjJSyCYQo0
 uYkNqYtTT431eHJqXxeRfq43jxRcFkxNEZA8dIKAfgNt2lerFC3ytEpM/nAmibDGeWGsGK
 OkMe35sqWgWbDi5B/Su0r03GYTB76hk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-ErJfnVj8OHG84cYCtRcQgA-1; Sat, 04 Jul 2020 14:30:52 -0400
X-MC-Unique: ErJfnVj8OHG84cYCtRcQgA-1
Received: by mail-wr1-f69.google.com with SMTP id y13so36374361wrp.13
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YYDftXcBQrqsgbkpJ5iu6MhYnQVu4atwyoFfOVtYo8s=;
 b=ieLq9vmrtnjQBEKjB5IR/V0WUYTXu8j2oeGZG+4DjarZRYU65l0zwtkWAIrzLoA5u1
 P/ns0Vz0UEcU++WDYRUzgbZfg95Yc2fTeAVJNPE5sp+XF4cq6BikLgtfREa2J2nNbZUu
 v20eE3O5YNKoAGby+TS7EHKfVSXSnlSGkrw32XF4mmZSInGm5ghN544SttXeReQ/nO4Z
 yJlgTU9eQNYseMGFdYgO0JFgAw+7BSgHxpSdFRrwJg6AuYo0Pn8arP/tVr/L7pkvbkwf
 URp/VYxgLfiBllzaTBlj2ctdAq7o7RIxq7Oa6u8i/l4oR47WOhl/E9aAm2MHQBwu3Zdf
 8tSA==
X-Gm-Message-State: AOAM532niuD3EYPYLXdvKjfpDPX+X8priWEzgMbOQukhKbdzhRez05kw
 Z8z1h5lVPZa5kWat6xJIeN/83SngbRtfykW0HM352FfWGVms3DM4hcU2KaXdp2m7Yy8jG15H0Rg
 oc8LL3PqXNEr/45Y=
X-Received: by 2002:a1c:29c6:: with SMTP id p189mr38530685wmp.70.1593887451071; 
 Sat, 04 Jul 2020 11:30:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEWruZyg5Ir5vuXKr7DhssaD6SH8GIaifOSnuAAXGN1CCkskJTSCjQoqMuy6MpOiu1D8RjkQ==
X-Received: by 2002:a1c:29c6:: with SMTP id p189mr38530674wmp.70.1593887450876; 
 Sat, 04 Jul 2020 11:30:50 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 y77sm7176284wmd.36.2020.07.04.11.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:30:50 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:30:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 33/41] vhost: introduce new VhostOps vhost_dev_start
Message-ID: <20200704182750.1088103-34-mst@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:14
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

This patch introduces new VhostOps vhost_dev_start callback which allows the
vhost_net set the start/stop status to backend

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20200701145538.22333-7-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/hw/virtio/vhost-backend.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 6f6670783f..b80f344cd6 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -112,6 +112,7 @@ typedef int (*vhost_get_inflight_fd_op)(struct vhost_dev *dev,
 typedef int (*vhost_set_inflight_fd_op)(struct vhost_dev *dev,
                                         struct vhost_inflight *inflight);
 
+typedef int (*vhost_dev_start_op)(struct vhost_dev *dev, bool started);
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
@@ -152,6 +153,7 @@ typedef struct VhostOps {
     vhost_backend_mem_section_filter_op vhost_backend_mem_section_filter;
     vhost_get_inflight_fd_op vhost_get_inflight_fd;
     vhost_set_inflight_fd_op vhost_set_inflight_fd;
+    vhost_dev_start_op vhost_dev_start;
 } VhostOps;
 
 extern const VhostOps user_ops;
-- 
MST


