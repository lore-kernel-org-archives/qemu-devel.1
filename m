Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D36C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F3D22248
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fi/IPpAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F3D22248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG11u-0000en-C7
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 10:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kG11A-0007cv-0b
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:24:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31217
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kG118-0004KS-9G
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599661449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=raP/5IjyHL4k0lzw1JuIvnOdpYCQNl82Msw0GzdIoBQ=;
 b=Fi/IPpAizPt1X/tVtTtBMx4KDIkMO10jIr310ijfY69sdkqUX8jTYYZMf8rDdoE/bhgW7U
 LZlYa0DZJVkbLJXuGjHIYPYtnwK82TEHePISV2emY6/0IRIhG0Q269eDxs6PPQbhRSXTuL
 +4KWeGzmTOmcES41khFmB6hWfDzuNRY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-AsEodwYQPPytSIeoFa0AUA-1; Wed, 09 Sep 2020 10:24:08 -0400
X-MC-Unique: AsEodwYQPPytSIeoFa0AUA-1
Received: by mail-wm1-f72.google.com with SMTP id c72so892763wme.4
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 07:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=raP/5IjyHL4k0lzw1JuIvnOdpYCQNl82Msw0GzdIoBQ=;
 b=e4mkIxt5LTvX4GuebAJEGf8FKXFEiGcvldna/nyfo2EF5FsrgdLl2+rJd3dze5h0y2
 MoLdd5dt0s7SWXU3wBPdQcbQqh2Dl8NlrlibHiksQywoXHlsSPiF8F5qZqP3J8Imkpy2
 q2y2XioFZPRR+jKCCzvNfY6QmL+AF9MYXrzpcPtFa+GOWRzkhKIO7DJrOBhvWr6PCC5t
 s+FOOBycd42luIWlCIt65tbjBXhlsCxlRmguzVW1loG1c8QgTgFvE371+cBojzplnWHG
 ndfWav/3sOuWGm6rNYvnMDbwnr8ScUd2cLvr7eeT5hzjCgJP7MVmRZS95+v1CzcCXZNh
 iorQ==
X-Gm-Message-State: AOAM532mcKdS6Cgc1gdlntq8AuTm1vIpapKq0U2ms0dOV14lhU4Qswp5
 NPPRJ1GoFxPfg4TeHIPntoqJt1iJFXgsUq9JdPf+llDosHIrudbsVrhX6h7J5FxwnUsgBxeC2go
 nHRH+Ocz7R3C5h8M=
X-Received: by 2002:adf:ec87:: with SMTP id z7mr4474432wrn.57.1599661446654;
 Wed, 09 Sep 2020 07:24:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaNfNrnJUOLCzWyQWlZEF+O41lcTg3EHiH9WT43krXGSQu9NVvkkCw5phaI2FWTa4XDKaOxg==
X-Received: by 2002:adf:ec87:: with SMTP id z7mr4474410wrn.57.1599661446463;
 Wed, 09 Sep 2020 07:24:06 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id k8sm4388721wma.16.2020.09.09.07.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 07:24:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 2/4] util/vfio-helpers: Report error when IOMMU page size
 is not supported
Date: Wed,  9 Sep 2020 16:23:52 +0200
Message-Id: <20200909142354.334859-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909142354.334859-1-philmd@redhat.com>
References: <20200909142354.334859-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 02:43:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reviewed-by: Fam Zheng <fam@euphon.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 55b4107ce69..4cc5697dcb2 100644
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
+        ret = -EINVAL;
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


