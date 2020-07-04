Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC01C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E5820771
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEU3YGRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E5820771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrnEB-0007Tk-8o
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmw7-0004eY-GC
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41256
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmw5-0001ee-NG
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YKm01s4uoYNcg0A8gRDSfiSMGc6pTEcCI5zK0YNeAPM=;
 b=CEU3YGRnp+POqEe3IafXrpsoSqJwpHJPXFyQyvE4rQfA4of7RjcbcaMLwpe6EHSdt0+sqZ
 4SKxERBIAcDxykdWZUmIvmksy49cJSEfzmj4uvXn6GIWpIpG54mOvGTFQryLy4IhNipcZ5
 h7Pg24LpbB4jE3I8xhDknrCUr40nIHk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-4cJR3tM8OBWWin4zQhvisA-1; Sat, 04 Jul 2020 14:30:47 -0400
X-MC-Unique: 4cJR3tM8OBWWin4zQhvisA-1
Received: by mail-wm1-f70.google.com with SMTP id e15so40108980wme.8
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YKm01s4uoYNcg0A8gRDSfiSMGc6pTEcCI5zK0YNeAPM=;
 b=fxyRYXXGM+nDbN1u32Nx8bvD+goctoeC4pGmjS/6JHVHXcybSBSWu91BpvqdWIlPlF
 xn5rogROSVjlkQbbJRkvCX5AhodYUWHuBj1Lu9WaNBAW6l5blR27GeB//IZJkmp8O4G0
 ztFeYjZCefeZzlZSAABbGe8rLoEzKvBFK8yisJ73cljuYADU2N87wBp4g8QoE2+dX+0Y
 YMhMQ51OEBK6HdC+OlO02ydV4qfeIxz8SaEDFcHgF/wHaZcp7eM18PM4Yp5PFNTrqQJX
 tu3w8WNABxxnCqNWP4G+eGXuhMpeUehynY3lncngpVFA7qcsZB7sf39awCZXILS0Blsv
 s/tg==
X-Gm-Message-State: AOAM531EhwCUklB8mQHqSHi6XHThsFClcCLuUQrhUA5OBA5njP/tDNxx
 3UXHCjkZ5GjCf++j9qSUtXE3ciAQmzFI3xw+DxsIsTh07GbpmOL0ffzqik83CHG1XFWjRIl76Rh
 5DlHott4C9J5wKbs=
X-Received: by 2002:a1c:5459:: with SMTP id p25mr40481905wmi.148.1593887446266; 
 Sat, 04 Jul 2020 11:30:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdJFFcurFv26+J+uBSmjWpKFT7XWXKjPBqYC57snZPoA2Zwth4gkWFB2oXn7Hlh98f9zuwFg==
X-Received: by 2002:a1c:5459:: with SMTP id p25mr40481897wmi.148.1593887446072; 
 Sat, 04 Jul 2020 11:30:46 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 a4sm18860735wrg.80.2020.07.04.11.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:30:45 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:30:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 31/41] virtio-pci: implement queue_enabled method
Message-ID: <20200704182750.1088103-32-mst@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 08:57:02
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

From: Jason Wang <jasowang@redhat.com>

With version 1, we can detect whether a queue is enabled via
queue_enabled.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20200701145538.22333-5-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/virtio-pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 7bc8c1c056..8554cf2a03 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1107,6 +1107,18 @@ static AddressSpace *virtio_pci_get_dma_as(DeviceState *d)
     return pci_get_address_space(dev);
 }
 
+static bool virtio_pci_queue_enabled(DeviceState *d, int n)
+{
+    VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        return proxy->vqs[vdev->queue_sel].enabled;
+    }
+
+    return virtio_queue_enabled(vdev, n);
+}
+
 static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
                                    struct virtio_pci_cap *cap)
 {
@@ -2064,6 +2076,7 @@ static void virtio_pci_bus_class_init(ObjectClass *klass, void *data)
     k->ioeventfd_enabled = virtio_pci_ioeventfd_enabled;
     k->ioeventfd_assign = virtio_pci_ioeventfd_assign;
     k->get_dma_as = virtio_pci_get_dma_as;
+    k->queue_enabled = virtio_pci_queue_enabled;
 }
 
 static const TypeInfo virtio_pci_bus_info = {
-- 
MST


