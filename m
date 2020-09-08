Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEF2C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432422080A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKQW9dAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432422080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFi0F-0007Qx-Vl
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFhyN-0004Qf-U8
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:04:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46517
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFhyM-0004vX-D8
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599588241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QkwqpwV9K55PFTel8SazfLxb9PfIPnyx+3YiTKkFJro=;
 b=BKQW9dAcsaMCZQPv6hGQgHUVwxl33AoByQBtV+STeX3r9U9qYNSvyrnsI/sBxCVCWWfn5C
 RPThWtKiJMJ5MoZ1DH3Li5WhClWEbiUv09k7tdPBoNLDA1CvvkIKZlXjJSfV0pi+9JvUXp
 eYO9roQVKBzvr2JFz++FJZsAw6xjEN0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-Bn4NzZcLMFaPtS8YS-NYww-1; Tue, 08 Sep 2020 14:03:57 -0400
X-MC-Unique: Bn4NzZcLMFaPtS8YS-NYww-1
Received: by mail-wm1-f69.google.com with SMTP id x6so51547wmb.6
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 11:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QkwqpwV9K55PFTel8SazfLxb9PfIPnyx+3YiTKkFJro=;
 b=QxOFHgl4Rukw3M6o84ZyDrJeYxjSoNAtxbf2Keb3B/7YZuzKfdqWvXUxgWLGLuur//
 TKKmXPzPnMOFyat7EmdvRuvUP28h+UzcfIVqjr0/1wPrPB4CkCihCBkSrGUNsCQ3sa0f
 GHzIakJ/SmjufTZYGMsQtgIdbD7M32D4Cr0sW7qhmoy3hpVqy2qnc6o7ievIMS7VS5h2
 OJfgUO9Now8SSSRdbZcakeeKb1YvMgLVjydpuKQ4EZSDXy+uZxdN+V10kCBE2Utb70Gb
 bIoCbFfU4v3WJ0cXJKnJGzuC7BpkcL/p2wWvMLVTWkr1NZpIS8MAB7Pt2VBeZEWZdPWv
 6SBw==
X-Gm-Message-State: AOAM533W6Tci8nAO0zLAJpGeEV5DnbuQVxsDH0N986/dZUbbgUtLPsBg
 LOBVawLXnEoQ/Wy0+UehVpzhgtMw+Y5GljFn/4e2YcEEjFBVm43rwA5Xziry7cJEbgGICqBHu6Q
 mWsxx2MVg8h1eY6U=
X-Received: by 2002:a1c:678a:: with SMTP id b132mr362236wmc.10.1599588236177; 
 Tue, 08 Sep 2020 11:03:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz//4M1d+IJHQCXdJ2QV50tFS/dNKBh5bUfVhBLnE2TkgyYmtJcUcg+bni5dc+a3Y+Ay+Lw9w==
X-Received: by 2002:a1c:678a:: with SMTP id b132mr362209wmc.10.1599588235905; 
 Tue, 08 Sep 2020 11:03:55 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id j10sm351531wrn.2.2020.09.08.11.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 11:03:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v5 2/4] util/vfio-helpers: Report error when IOMMU page
 size is not supported
Date: Tue,  8 Sep 2020 20:03:40 +0200
Message-Id: <20200908180342.280749-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908180342.280749-1-philmd@redhat.com>
References: <20200908180342.280749-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 12:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
check if the size matches, and bails out with listing the sizes
the IOMMU supports.

Example on Aarch64:

 $ qemu-system-aarch64 -M virt -drive if=none,id=nvme0,file=nvme://0006:90:00.0/1,format=raw
 qemu-system-aarch64: -drive if=none,id=nvme0,file=nvme://0006:90:00.0/1,format=raw: Unsupported IOMMU page size: 4 KiB
 Available page size:
  64 KiB
  512 MiB

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 55b4107ce69..6d9ec7d365c 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
 #include "qapi/error.h"
@@ -316,6 +317,25 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
         ret = -errno;
         goto fail;
     }
+    if (!(iommu_info.flags & VFIO_IOMMU_INFO_PGSIZES)) {
+        error_setg(errp, "Failed to get IOMMU page size info");
+        ret = -errno;
+        goto fail;
+    }
+    if (!extract64(iommu_info.iova_pgsizes,
+                   ctz64(qemu_real_host_page_size), 1)) {
+        g_autofree char *host_page_size = size_to_str(qemu_real_host_page_size);
+        error_setg(errp, "Unsupported IOMMU page size: %s", host_page_size);
+        error_append_hint(errp, "Available page size:\n");
+        for (int i = 0; i < 64; i++) {
+            if (extract64(iommu_info.iova_pgsizes, i, 1)) {
+                g_autofree char *iova_pgsizes = size_to_str(1UL << i);
+                error_append_hint(errp, " %s\n", iova_pgsizes);
+            }
+        }
+        ret = -EINVAL;
+        goto fail;
+    }
 
     s->device = ioctl(s->group, VFIO_GROUP_GET_DEVICE_FD, device);
 
-- 
2.26.2


