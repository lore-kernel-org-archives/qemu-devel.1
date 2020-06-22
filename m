Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6F3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1393206EB
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9PJbjsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1393206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOZb-0000OG-TP
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnOYW-0007Pu-5I
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:40:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46812
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnOYU-0003ZN-6F
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592840417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w7ONpZZjErZHFUYN7YfFgaMMb15Ej0bi5uA6s5ZasrY=;
 b=D9PJbjsreLOIEedqsyurz+Ru+2jOBVFRSDZf/7SlKZ7GbF+EH1zA0aPqNlCOCvIUheVpJM
 94ui+BzNM4fhx4fAcatVG3do1L0AgGL7DNl5YwttcPPRhV3ENSYPTUMbnrBC5Cx/ECwyf1
 X3zEEMhX17GzjeiHVgUdkuWTZfGEqTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-wOAhls_zNha9fqcms68PcA-1; Mon, 22 Jun 2020 11:40:12 -0400
X-MC-Unique: wOAhls_zNha9fqcms68PcA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F787184D147;
 Mon, 22 Jun 2020 15:40:10 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-13-110.pek2.redhat.com [10.72.13.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8731A71679;
 Mon, 22 Jun 2020 15:39:49 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [PATCH v1 05/10] vhost-backend: export the vhost backend helper
Date: Mon, 22 Jun 2020 23:37:51 +0800
Message-Id: <20200622153756.19189-6-lulu@redhat.com>
In-Reply-To: <20200622153756.19189-1-lulu@redhat.com>
References: <20200622153756.19189-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
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

export the helper then we can reuse them in other backend

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/virtio/vhost-backend.c         | 18 +++++++++---------
 include/hw/virtio/vhost-backend.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 48905383f8..660e9e8588 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -89,7 +89,7 @@ static int vhost_kernel_scsi_get_abi_version(struct vhost_dev *dev, int *version
     return vhost_kernel_call(dev, VHOST_SCSI_GET_ABI_VERSION, version);
 }
 
-static int vhost_kernel_set_log_base(struct vhost_dev *dev, uint64_t base,
+int vhost_kernel_set_log_base(struct vhost_dev *dev, uint64_t base,
                                      struct vhost_log *log)
 {
     return vhost_kernel_call(dev, VHOST_SET_LOG_BASE, &base);
@@ -101,7 +101,7 @@ static int vhost_kernel_set_mem_table(struct vhost_dev *dev,
     return vhost_kernel_call(dev, VHOST_SET_MEM_TABLE, mem);
 }
 
-static int vhost_kernel_set_vring_addr(struct vhost_dev *dev,
+int vhost_kernel_set_vring_addr(struct vhost_dev *dev,
                                        struct vhost_vring_addr *addr)
 {
     return vhost_kernel_call(dev, VHOST_SET_VRING_ADDR, addr);
@@ -113,31 +113,31 @@ static int vhost_kernel_set_vring_endian(struct vhost_dev *dev,
     return vhost_kernel_call(dev, VHOST_SET_VRING_ENDIAN, ring);
 }
 
-static int vhost_kernel_set_vring_num(struct vhost_dev *dev,
+int vhost_kernel_set_vring_num(struct vhost_dev *dev,
                                       struct vhost_vring_state *ring)
 {
     return vhost_kernel_call(dev, VHOST_SET_VRING_NUM, ring);
 }
 
-static int vhost_kernel_set_vring_base(struct vhost_dev *dev,
+int vhost_kernel_set_vring_base(struct vhost_dev *dev,
                                        struct vhost_vring_state *ring)
 {
     return vhost_kernel_call(dev, VHOST_SET_VRING_BASE, ring);
 }
 
-static int vhost_kernel_get_vring_base(struct vhost_dev *dev,
+int vhost_kernel_get_vring_base(struct vhost_dev *dev,
                                        struct vhost_vring_state *ring)
 {
     return vhost_kernel_call(dev, VHOST_GET_VRING_BASE, ring);
 }
 
-static int vhost_kernel_set_vring_kick(struct vhost_dev *dev,
+int vhost_kernel_set_vring_kick(struct vhost_dev *dev,
                                        struct vhost_vring_file *file)
 {
     return vhost_kernel_call(dev, VHOST_SET_VRING_KICK, file);
 }
 
-static int vhost_kernel_set_vring_call(struct vhost_dev *dev,
+int vhost_kernel_set_vring_call(struct vhost_dev *dev,
                                        struct vhost_vring_file *file)
 {
     return vhost_kernel_call(dev, VHOST_SET_VRING_CALL, file);
@@ -155,13 +155,13 @@ static int vhost_kernel_set_features(struct vhost_dev *dev,
     return vhost_kernel_call(dev, VHOST_SET_FEATURES, &features);
 }
 
-static int vhost_kernel_get_features(struct vhost_dev *dev,
+int vhost_kernel_get_features(struct vhost_dev *dev,
                                      uint64_t *features)
 {
     return vhost_kernel_call(dev, VHOST_GET_FEATURES, features);
 }
 
-static int vhost_kernel_set_owner(struct vhost_dev *dev)
+int vhost_kernel_set_owner(struct vhost_dev *dev)
 {
     return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
 }
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 6f6670783f..300b59c172 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -172,4 +172,32 @@ int vhost_backend_handle_iotlb_msg(struct vhost_dev *dev,
 
 int vhost_user_gpu_set_socket(struct vhost_dev *dev, int fd);
 
+
+int vhost_kernel_set_log_base(struct vhost_dev *dev, uint64_t base,
+                                     struct vhost_log *log);
+
+int vhost_kernel_set_vring_addr(struct vhost_dev *dev,
+                                       struct vhost_vring_addr *addr);
+
+int vhost_kernel_set_vring_num(struct vhost_dev *dev,
+                                      struct vhost_vring_state *ring);
+
+int vhost_kernel_set_vring_base(struct vhost_dev *dev,
+                                       struct vhost_vring_state *ring);
+
+int vhost_kernel_get_vring_base(struct vhost_dev *dev,
+                                       struct vhost_vring_state *ring);
+
+int vhost_kernel_set_vring_kick(struct vhost_dev *dev,
+                                       struct vhost_vring_file *file);
+
+int vhost_kernel_set_vring_call(struct vhost_dev *dev,
+                                       struct vhost_vring_file *file);
+
+int vhost_kernel_set_owner(struct vhost_dev *dev);
+
+int vhost_kernel_get_features(struct vhost_dev *dev,
+                                     uint64_t *features);
+
+
 #endif /* VHOST_BACKEND_H */
-- 
2.21.1


