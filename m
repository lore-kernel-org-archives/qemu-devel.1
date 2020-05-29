Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E9EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5882073B
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2Pb2wbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5882073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefsM-00038n-3G
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jefiT-0005BP-0N
 for qemu-devel@nongnu.org; Fri, 29 May 2020 10:10:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37087
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jefiQ-0006B5-PF
 for qemu-devel@nongnu.org; Fri, 29 May 2020 10:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590761429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Opb4ICj/RJNY7bhW1ya4SaMYB/sKjJiaXY0i6jq720A=;
 b=h2Pb2wbXKWtITJ1DVOPJrUo8mUryTxXccbcLUv+gMY3WtKeumBEVP+rFkxdldalDLvqsUh
 do2pLIjtt4RRRLPX/N8/vzXCyojoO44LvtdVNNZV7yllRFCPsM2yXhOTbtBLuQmNXs3PL2
 jq0cRmmK3UAZWv9kE21r8kYFHMU+0NI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-1dgEwCNxMVecpWGz7q4VMg-1; Fri, 29 May 2020 10:10:28 -0400
X-MC-Unique: 1dgEwCNxMVecpWGz7q4VMg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79E5518A8223;
 Fri, 29 May 2020 14:10:25 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-13-84.pek2.redhat.com [10.72.13.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E4905D9D5;
 Fri, 29 May 2020 14:10:08 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [RFC v3 6/8] vhost-backend: export the vhost backend helper
Date: Fri, 29 May 2020 22:06:18 +0800
Message-Id: <20200529140620.28759-7-lulu@redhat.com>
In-Reply-To: <20200529140620.28759-1-lulu@redhat.com>
References: <20200529140620.28759-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:34:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

export the helper then we can reuse some of them in vhost-vdpa

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/virtio/vhost-backend.c         | 34 ++++++++++++++++++-------------
 include/hw/virtio/vhost-backend.h | 28 +++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 48905383f8..42efb4967b 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -14,7 +14,7 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "standard-headers/linux/vhost_types.h"
-
+#include "hw/virtio/vhost-vdpa.h"
 #ifdef CONFIG_VHOST_KERNEL
 #include <linux/vhost.h>
 #include <sys/ioctl.h>
@@ -22,10 +22,16 @@
 static int vhost_kernel_call(struct vhost_dev *dev, unsigned long int request,
                              void *arg)
 {
-    int fd = (uintptr_t) dev->opaque;
-
-    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_KERNEL);
-
+    int fd = -1;
+    struct vhost_vdpa *v = NULL;
+    if (dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_KERNEL) {
+        fd  = (uintptr_t) dev->opaque;
+    }
+    if (dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA) {
+        v = dev->opaque;
+        fd = v->device_fd;
+    }
+    assert(fd != -1);
     return ioctl(fd, request, arg);
 }
 
@@ -89,7 +95,7 @@ static int vhost_kernel_scsi_get_abi_version(struct vhost_dev *dev, int *version
     return vhost_kernel_call(dev, VHOST_SCSI_GET_ABI_VERSION, version);
 }
 
-static int vhost_kernel_set_log_base(struct vhost_dev *dev, uint64_t base,
+int vhost_kernel_set_log_base(struct vhost_dev *dev, uint64_t base,
                                      struct vhost_log *log)
 {
     return vhost_kernel_call(dev, VHOST_SET_LOG_BASE, &base);
@@ -101,7 +107,7 @@ static int vhost_kernel_set_mem_table(struct vhost_dev *dev,
     return vhost_kernel_call(dev, VHOST_SET_MEM_TABLE, mem);
 }
 
-static int vhost_kernel_set_vring_addr(struct vhost_dev *dev,
+int vhost_kernel_set_vring_addr(struct vhost_dev *dev,
                                        struct vhost_vring_addr *addr)
 {
     return vhost_kernel_call(dev, VHOST_SET_VRING_ADDR, addr);
@@ -113,31 +119,31 @@ static int vhost_kernel_set_vring_endian(struct vhost_dev *dev,
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
@@ -155,13 +161,13 @@ static int vhost_kernel_set_features(struct vhost_dev *dev,
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


