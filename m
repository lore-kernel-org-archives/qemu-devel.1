Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22EBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:45:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4932074D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dx4wjxuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4932074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOdC-0005yY-P2
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnOYn-0007zL-58
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:40:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44727
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnOYl-0003hO-6w
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592840434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DepnZlL/bm0hHGf+dW+67jhLOZh9XVMNcbyUYjOici8=;
 b=dx4wjxuFZ6XSpa6OeMzSsNlK8Ukwa6ROk/e1O1dOc75iXBuoTZAJ9UlWVn2NOJeYJfcv7S
 8ZUrA9Uf5y2gv9NLranJs1TMICpycPxmprQkQ3thTay+eAWKBakNAMXBAFXPGUo5zhUMjR
 +055hvFI5aiBXeVMxMpOTKCY7RTl1NQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-w1ngTPbiMDyteOj9Le-B4Q-1; Mon, 22 Jun 2020 11:40:32 -0400
X-MC-Unique: w1ngTPbiMDyteOj9Le-B4Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 379A28064D8;
 Mon, 22 Jun 2020 15:40:30 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-13-110.pek2.redhat.com [10.72.13.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 249FE7167B;
 Mon, 22 Jun 2020 15:40:12 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [PATCH v1 06/10] vhsot_net: introduce set_config & get_config function
Date: Mon, 22 Jun 2020 23:37:52 +0800
Message-Id: <20200622153756.19189-7-lulu@redhat.com>
In-Reply-To: <20200622153756.19189-1-lulu@redhat.com>
References: <20200622153756.19189-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
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
Cc: mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, lulu@redhat.com, hanand@xilinx.com, hch@infradead.org,
 eperezma@redhat.com, jgg@mellanox.com, shahafs@mellanox.com,
 kevin.tian@intel.com, parav@mellanox.com, vmireyno@marvell.com,
 cunming.liang@intel.com, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, stefanha@redhat.com, zhihong.wang@intel.com,
 aadam@redhat.com, rdunlap@infradead.org, maxime.coquelin@redhat.com,
 lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch introduces set_config & get_config  method which allows
vhost_net set/get the config to backend

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/vhost_net.c      | 11 +++++++++++
 include/net/vhost_net.h |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 4096d64aaf..04cc3db264 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -111,6 +111,17 @@ uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
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
+
 void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
 {
     net->dev.acked_features = net->dev.backend_features;
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index 77e47398c4..abfb0e8e68 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -27,6 +27,11 @@ void vhost_net_cleanup(VHostNetState *net);
 
 uint64_t vhost_net_get_features(VHostNetState *net, uint64_t features);
 void vhost_net_ack_features(VHostNetState *net, uint64_t features);
+int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
+                         uint32_t config_len);
+
+int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
+                         uint32_t offset, uint32_t size, uint32_t flags);
 
 bool vhost_net_virtqueue_pending(VHostNetState *net, int n);
 void vhost_net_virtqueue_mask(VHostNetState *net, VirtIODevice *dev,
-- 
2.21.1


