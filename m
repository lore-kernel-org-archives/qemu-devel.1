Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97440C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5EFD2222D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTUtH8i2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5EFD2222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvRX-0003nC-Po
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvNd-0006Cq-AT
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvNY-0007vM-4V
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5tWL17xtY4KbK/NCVI9WhU1DjcEuaI56sUEhUSi0l/w=;
 b=dTUtH8i2FWIpnzrSy2Q8YFdeHrBr9MoSapIhjNp5FkD1g+hJz9myrO0LosGwkR4xsSPfGc
 ELkj6oJFJndHc+kGRf2+vMb4D7rkmX430Z6P6b4C1yN6Jt/7qr4pxTl3Pl3FlmjyqyRL3J
 +Xj84fvh6lY+hMBowEzx8EvuXpK/h9E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-NhqtAEFnMQ2IlyQtLaKxjg-1; Tue, 20 Oct 2020 13:24:53 -0400
X-MC-Unique: NhqtAEFnMQ2IlyQtLaKxjg-1
Received: by mail-wm1-f72.google.com with SMTP id l22so628081wmi.4
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5tWL17xtY4KbK/NCVI9WhU1DjcEuaI56sUEhUSi0l/w=;
 b=iPzQjJ+66fne23H5nwxoNImksNcm6FGodwhcI5PE2/gR871pgSdz/Yls66URBGIElx
 AS3uXpz3ZhgVqp6I4wM3jfG5NZidkioQlT9BfNAHR5JHcqOUxzmwoxtrfsT/ZX9TkCaD
 qrwi9XVf9Syg/HxwwLQiAoIQflRegKqDUOiB1+22gr74BQg52A5v/N72ZHMUCMRBmkwX
 MWbJyT8eHoO61FCDYMkeiCvm+AnQ22iqZx4lq+mbyvWtE7s2VMT0a+rVIunZ0TL2Bzkv
 kkV62H1kXVlMCT6F0snYr/zHpWkx46EYhgURFGn3dULxEoPdPxb2R3Vmw3uv7v4TLAY2
 i2Xw==
X-Gm-Message-State: AOAM531KS7iSgiJEYqNEwbjAekv23nTUae1oxt+HqT1Yofr0uBHh84QN
 k37vXLJJAqUOOaz+aSbotzHfTnnxc++7Zl3Cjpfj892vfSpKNGutdv1oubE6uC67FLOHqG7ODPA
 73aKTwZ3QCX8mmIk=
X-Received: by 2002:a5d:5387:: with SMTP id d7mr4648723wrv.224.1603214691182; 
 Tue, 20 Oct 2020 10:24:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkr2NnhtZ8sFt+k39xD3IYZ6ad+P3a32ER6vfyb6CzWdVkw0gV8yUx+9GGe9yOoaqE3Eabfg==
X-Received: by 2002:a5d:5387:: with SMTP id d7mr4648699wrv.224.1603214690988; 
 Tue, 20 Oct 2020 10:24:50 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id m14sm4058942wro.43.2020.10.20.10.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 10:24:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/16] util/vfio-helpers: Report error when IOMMU page size is
 not supported
Date: Tue, 20 Oct 2020 19:24:16 +0200
Message-Id: <20201020172428.2220726-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201020172428.2220726-1-philmd@redhat.com>
References: <20201020172428.2220726-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This driver uses the host page size to align its memory regions,
but this size is not always compatible with the IOMMU. Add a
check if the size matches, and bails out providing a hint what
is the minimum page size the driver should use.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 28 ++++++++++++++++++++++++++--
 util/trace-events   |  1 +
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index a2b084c69c1..bce2cdb2f3c 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
 #include "qapi/error.h"
@@ -273,7 +274,7 @@ static void collect_usable_iova_ranges(QEMUVFIOState *s, void *buf)
 }
 
 static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
-                              Error **errp)
+                              size_t *requested_page_size, Error **errp)
 {
     int ret;
     int i;
@@ -284,6 +285,8 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
     struct vfio_device_info device_info = { .argsz = sizeof(device_info) };
     char *group_file = NULL;
 
+    assert(requested_page_size && is_power_of_2(*requested_page_size));
+
     s->usable_iova_ranges = NULL;
 
     /* Create a new container */
@@ -358,6 +361,27 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
         ret = -errno;
         goto fail;
     }
+    if (!(iommu_info->flags & VFIO_IOMMU_INFO_PGSIZES)) {
+        error_setg(errp, "Failed to get IOMMU page size info");
+        ret = -EINVAL;
+        goto fail;
+    }
+    trace_qemu_vfio_iommu_iova_pgsizes(iommu_info->iova_pgsizes);
+    if (!(iommu_info->iova_pgsizes & *requested_page_size)) {
+        g_autofree char *req_page_size_str = size_to_str(*requested_page_size);
+        g_autofree char *min_page_size_str = NULL;
+        uint64_t pgsizes_masked;
+
+        pgsizes_masked = MAKE_64BIT_MASK(0, ctz64(*requested_page_size));
+        *requested_page_size = 1U << ctz64(iommu_info->iova_pgsizes
+                                           & ~pgsizes_masked);
+        min_page_size_str = size_to_str(*requested_page_size);
+        error_setg(errp, "Unsupported IOMMU page size: %s", req_page_size_str);
+        error_append_hint(errp, "Minimum IOMMU page size: %s\n",
+                          min_page_size_str);
+        ret = -EINVAL;
+        goto fail;
+    }
 
     /*
      * if the kernel does not report usable IOVA regions, choose
@@ -500,7 +524,7 @@ QEMUVFIOState *qemu_vfio_open_pci(const char *device, size_t *min_page_size,
     int r;
     QEMUVFIOState *s = g_new0(QEMUVFIOState, 1);
 
-    r = qemu_vfio_init_pci(s, device, errp);
+    r = qemu_vfio_init_pci(s, device, min_page_size, errp);
     if (r) {
         g_free(s);
         return NULL;
diff --git a/util/trace-events b/util/trace-events
index 24c31803b01..19f03f14a33 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -85,3 +85,4 @@ qemu_vfio_new_mapping(void *s, void *host, size_t size, int index, uint64_t iova
 qemu_vfio_do_mapping(void *s, void *host, size_t size, uint64_t iova) "s %p host %p size 0x%zx iova 0x%"PRIx64
 qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64_t *iova) "s %p host %p size 0x%zx temporary %d iova %p"
 qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
+qemu_vfio_iommu_iova_pgsizes(uint64_t iova_pgsizes) "iommu page size bitmask: 0x%08"PRIx64
-- 
2.26.2


