Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0845CC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F00720738
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCPolFsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F00720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY9Fr-0004E3-UC
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kY9Ee-0003TX-7o
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:49:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kY9Ec-0000Tl-0Y
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603982939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fvVMqZSd4VN1ZLw8n4EK7pU8ZfGt/oolMQPE84iYdls=;
 b=LCPolFshlOU0CYLoSXZIl14RXsSk+dGRwPojrHAPMIuVAn2DYTO7+bZ1dZ/4FQ7WHOu6T7
 srkyI0doOBGIgon9vd8QulqgaOZfuYqkmSiLfw60e/uXN2fs12I6gKc2S8G4mlpenl2Te8
 /whCPI6gEF7A60He4l2nEWIkFBdwmPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-0gFQdUguOhuQbsrx1Mf05g-1; Thu, 29 Oct 2020 10:48:57 -0400
X-MC-Unique: 0gFQdUguOhuQbsrx1Mf05g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A13891019635
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 14:48:56 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-112-127.ams2.redhat.com
 [10.36.112.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F095F5B4CD;
 Thu, 29 Oct 2020 14:48:50 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] vhost-vsock: set vhostfd to non-blocking mode
Date: Thu, 29 Oct 2020 15:48:49 +0100
Message-Id: <20201029144849.70958-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vhost IOTLB API uses read()/write() to exchange iotlb messages with
the kernel module.
The QEMU implementation expects a non-blocking fd, indeed commit
c471ad0e9b ("vhost_net: device IOTLB support") set it for vhost-net.

Without this patch, if we enable iommu for the vhost-vsock device,
QEMU can hang when exchanging IOTLB messages.

As commit 894022e616 ("net: check if the file descriptor is valid
before using it") did for tap, let's use qemu_try_set_nonblock()
when fd is provided by the user.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/virtio/vhost-vsock.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index f9db4beb47..8ddfb9abfe 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "hw/virtio/virtio-access.h"
 #include "qemu/error-report.h"
+#include "qemu/sockets.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
@@ -148,6 +149,13 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
             return;
         }
+
+        ret = qemu_try_set_nonblock(vhostfd);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret,
+                             "vhost-vsock: unable to set non-blocking mode");
+            return;
+        }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
@@ -155,6 +163,8 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
                              "vhost-vsock: failed to open vhost device");
             return;
         }
+
+        qemu_set_nonblock(vhostfd);
     }
 
     vhost_vsock_common_realize(vdev, "vhost-vsock");
-- 
2.26.2


