Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD31C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5701D20771
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faASex5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5701D20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrnDq-0006gM-Jp
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmwR-0005MO-5g
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:31:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32779
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmwP-0001iA-CO
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lL5Gr+1OC50JlOP4HvsRLOyw+1DMZM80TfKgTML516o=;
 b=faASex5y1IkQ+1T47uycmGzTt7AuFFshjy/Ioo3XBLy6hU+ANBf3CbHQ/uOK30+WpimoJI
 Y6SUKjOVmFtcAiqPlUAwHInpXjKJbDO5l6wtIIJwf/kKnapseIH2dK7mpbYL+v6NDme6x6
 XGEUgA50YN1r7/MDnEz+HpEsqQbP1p4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-hW50DHe9PqmHZvVTkykwDQ-1; Sat, 04 Jul 2020 14:31:07 -0400
X-MC-Unique: hW50DHe9PqmHZvVTkykwDQ-1
Received: by mail-wr1-f69.google.com with SMTP id i14so36214933wru.17
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lL5Gr+1OC50JlOP4HvsRLOyw+1DMZM80TfKgTML516o=;
 b=evDOBrxmf6ZFWdqAcepeXS89CshVQiVHr3T4w/QLaQ1xAewUsxLFzRNBvjtuc4G9z0
 miQuFC7RPdZ+3aUv+c/iDcB03lRqPlTXIXjWTmLKlvP4bqs+pv+9LE63wBwmlrjDRq6C
 JWAgqXv9gDBYqySFnmAPa7miHyPckYacOIJE1olHOsWIBZas/oBwtGHIHdOeLrl0KfXZ
 Y9GYa8e08k2TxNYhswITlpktBZZCURl6sZkd09/+0fwHOXC1o8bJ8Fg3w/W+W0E+nsIl
 zOpnuU5auYuF24dZ8chr9UXzUpCfkaAc+IeM/KnCuYCAh1fpZpmLeQUBaqnzQveNgw3x
 a2dw==
X-Gm-Message-State: AOAM530KYMwawC4ld497SuGQjEU1l/nCbbGlkpq8fHOuxDQYgNUNtUoK
 sale5gCRkSKRBPq9xhgYoxZb1o1zhauR8JfcVSJSeSUUBHx+NlTj5SwuGMtnKwp5lAiXM3GXdxA
 d4lITnMM88uQ67pE=
X-Received: by 2002:a5d:6107:: with SMTP id v7mr40933419wrt.174.1593887465585; 
 Sat, 04 Jul 2020 11:31:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCrXpnvhqKhed4ADQJx15gnkgjLh4Rl+pWt/g+5w9ESzNyfPvIvZFBbTGkMPmgUbNymEFPYA==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr40933406wrt.174.1593887465349; 
 Sat, 04 Jul 2020 11:31:05 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 l8sm17584576wrq.15.2020.07.04.11.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:31:04 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:31:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 39/41] vhost_net: introduce set_config & get_config
Message-ID: <20200704182750.1088103-40-mst@redhat.com>
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


