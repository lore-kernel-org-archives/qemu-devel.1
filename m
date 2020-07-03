Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9FEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13BF620723
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cC2t/zq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BF620723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHtN-0002AJ-AE
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHdI-0001YB-C7
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:05:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51858
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHdG-0004d1-Gj
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lL5Gr+1OC50JlOP4HvsRLOyw+1DMZM80TfKgTML516o=;
 b=cC2t/zq5/sTgf7LGtO28sVbFSbuukMxf4SK91a+FgFpe6L6L/EkGfOPJbg0Ot5MASv34jD
 4rw598et98+PgQPkm+KYedcAsZ9fBcr2HClsD4kSw/XNM91pqdE0Y0Zd8h71osn/bb2ySJ
 bG3HRHrWh98ZxxfN84kUHc0rO7TXmdA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-w0oIFGEPNRSa9z6DL-RNzw-1; Fri, 03 Jul 2020 05:05:16 -0400
X-MC-Unique: w0oIFGEPNRSa9z6DL-RNzw-1
Received: by mail-wr1-f69.google.com with SMTP id o25so31021879wro.16
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lL5Gr+1OC50JlOP4HvsRLOyw+1DMZM80TfKgTML516o=;
 b=qDlmXFFWD1r9Bo+NkNHE0evcM8NLGuztL0AqUBXdMZkKIdIzyJIEW004DZc9OH4Et7
 UX2dpFR/D2/edUivJe6xU9FQOH41IAVbqhXr5vGf4mso7GyfVH3RYhFb02oDYwu3XOpk
 lMM4RpJqmN0qS9S6pOoSPjF0U6WBYXccjWuzVvjqgk2W+D5VdArW+y9kT1aYu4++s3+a
 X5ZcBFgqfvpBLaT3D0EwVcMkIic0SY6MICB4b8hNR190bSM4TvzApJKl4eTReIS1qlqr
 XtMqUejekQJDcpNX6q23XyiBwjKoAw7+AwlRZuZ9A9z8XUBQzYtoCEAOgMAqroRfmD1T
 9ziA==
X-Gm-Message-State: AOAM531ZygJT7vyFSCz1SRjpJwXH0nrgWh3EjH/qyvDtwWA7rxrypW3p
 OUtBaBqEu4PJ+GNWRKdzcnphJsx9I/Vz/r2PLaIn3hwHZfe4mkIOZ73c1vCl6KzBamwN1QgjpbR
 0bfTF3aUQx6rN/HA=
X-Received: by 2002:a7b:c5d5:: with SMTP id n21mr35538742wmk.106.1593767114618; 
 Fri, 03 Jul 2020 02:05:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqE3dzdHZcMxlcpdgDkxpfw5Qz5od0FMPxaGCfISCQt9I7/6UPtziHfyN95BgyNnjk4uIdTw==
X-Received: by 2002:a7b:c5d5:: with SMTP id n21mr35538721wmk.106.1593767114448; 
 Fri, 03 Jul 2020 02:05:14 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 m4sm13028664wmi.48.2020.07.03.02.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:05:13 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:05:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 39/41] vhost_net: introduce set_config & get_config
Message-ID: <20200703090252.368694-40-mst@redhat.com>
References: <20200703090252.368694-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703090252.368694-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
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

This patch introduces set_config & get_config  method which allows
vhost_net set/get the config to backend

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20200701145538.22333-13-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/net/vhost_net.h |  5 +++++
 hw/net/vhost_net-stub.c | 11 +++++++++++
 hw/net/vhost_net.c      | 10 ++++++++++
 3 files changed, 26 insertions(+)

diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index 77e47398c4..172b0051d8 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -28,6 +28,11 @@ void vhost_net_cleanup(VHostNetState *net);
 uint64_t vhost_net_get_features(VHostNetState *net, uint64_t features);
 void vhost_net_ack_features(VHostNetState *net, uint64_t features);
 
+int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
+                         uint32_t config_len);
+
+int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
+                         uint32_t offset, uint32_t size, uint32_t flags);
 bool vhost_net_virtqueue_pending(VHostNetState *net, int n);
 void vhost_net_virtqueue_mask(VHostNetState *net, VirtIODevice *dev,
                               int idx, bool mask);
diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
index aac0e98228..a7f4252630 100644
--- a/hw/net/vhost_net-stub.c
+++ b/hw/net/vhost_net-stub.c
@@ -52,6 +52,17 @@ uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
     return features;
 }
 
+int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
+                         uint32_t config_len)
+{
+    return 0;
+}
+int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
+                         uint32_t offset, uint32_t size, uint32_t flags)
+{
+    return 0;
+}
+
 void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
 {
 }
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 4096d64aaf..4561665f6b 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -110,6 +110,16 @@ uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
     return vhost_get_features(&net->dev, vhost_net_get_feature_bits(net),
             features);
 }
+int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
+                         uint32_t config_len)
+{
+    return vhost_dev_get_config(&net->dev, config, config_len);
+}
+int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
+                         uint32_t offset, uint32_t size, uint32_t flags)
+{
+    return vhost_dev_set_config(&net->dev, data, offset, size, flags);
+}
 
 void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
 {
-- 
MST


