Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68521C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 06:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10FBE2076A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 06:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCogYCPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FBE2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtmoz-0004Yk-4e
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 02:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jtmoP-000492-H6
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 02:47:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27304
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jtmoN-0000sN-Uo
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 02:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594363626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=J1co7jhKacm7ZhmElNtaoAsJib0guSf82gXuorCixLc=;
 b=WCogYCPhJsKHZoMyTLoRpUn+OU9eai0tehrk3f3cPY+k8vWLoQRefjQIj2G/1m89/9jsfO
 BrwHvmU1B4+Q/YngYDWvZY2Q1dQlOFsiOlQdjkZZplqyzsp1K9qpHV6XZFlUJ1w68hUxjD
 upmekBgPQWUUI5enqnOPOcIIg+y/H7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-29_0nGIkPuG6sLWOaAHLtg-1; Fri, 10 Jul 2020 02:47:05 -0400
X-MC-Unique: 29_0nGIkPuG6sLWOaAHLtg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E2C080183C;
 Fri, 10 Jul 2020 06:47:02 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-12-227.pek2.redhat.com [10.72.12.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4239960E1C;
 Fri, 10 Jul 2020 06:46:45 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com,
	peter.maydell@linaro.org,
	jasowang@redhat.com
Subject: [PATCH v2] vhost-vdpa :Fix Coverity CID 1430270 / CID 1420267
Date: Fri, 10 Jul 2020 14:46:42 +0800
Message-Id: <20200710064642.24505-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 ian@iankelling.org, aadam@redhat.com, rdunlap@infradead.org,
 maxime.coquelin@redhat.com, lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the function vhost_vdpa_dma_map/unmap, The struct msg was not initialized all its fields.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index a3d17fe0f9..b9265f3761 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -38,7 +38,7 @@ static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section)
 static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwaddr size,
                               void *vaddr, bool readonly)
 {
-    struct vhost_msg_v2 msg;
+    struct vhost_msg_v2 msg = {};
     int fd = v->device_fd;
     int ret = 0;
 
@@ -61,7 +61,7 @@ static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwaddr size,
 static int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, hwaddr iova,
                                 hwaddr size)
 {
-    struct vhost_msg_v2 msg;
+    struct vhost_msg_v2 msg = {};
     int fd = v->device_fd;
     int ret = 0;
 
-- 
2.21.1


