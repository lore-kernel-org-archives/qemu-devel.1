Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E82C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C153E23A1E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQaptuIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C153E23A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKdpp-00074D-OB
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKdoo-0005HF-OJ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKdon-0008AM-3l
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600763912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGl0Wf6pnfWpWYSfHB9A49lGc8kjUq8riXJkPMG2AM8=;
 b=dQaptuIU0GNJ65rR2chV9Z9R4c4kaCFVQexLeTJhTJJlJC21reUrnGW5yMmQZjJ+OyIFZV
 b/rJEEz944r1j+J/J7DheRatRUZyKQpnylrTAdphNTiZshjplRXaHzgPDONJ26od2Eqq8o
 rCoT67OrJvBXbcN/5rL8MsqPYwYsUlw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-X1FNmsQ5NjazXw-vQEd1yg-1; Tue, 22 Sep 2020 04:38:30 -0400
X-MC-Unique: X1FNmsQ5NjazXw-vQEd1yg-1
Received: by mail-wm1-f71.google.com with SMTP id l26so386164wmg.7
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 01:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xGl0Wf6pnfWpWYSfHB9A49lGc8kjUq8riXJkPMG2AM8=;
 b=Dnd52xM4JRsZ9AytE5SN24gFAL80EdfSIgaeWj9SirjD1235GkFnRM3LLyG1N8AZiN
 mTuCDZWSfQvT81uJTkk+0m8XbL7LGSPMzmNA8Tqrhta+5TCiCGyUFsvJrGyANUorzrZS
 S8na+YGDGZ6Nj0GtPA2lcJjML8kg8zbL4dbJybyTl/l4dl1NzdMnvADUJFMAOiGc4b5/
 Rg5jAK0kxphWaSqR6os3K60D+AVOrB6hLGVo+1opZYjJfRpuHTWgrQ2Q/Mer4JfIeN4b
 kFHa99ESXdyzz3SvWujeZt3Vmbq+TTeerJxamCYgfV4pMhb6EvhQCVwVxdevS4bxJtK6
 +9wg==
X-Gm-Message-State: AOAM531elu0PEv1BD4murCytrrcanhfw61YP5XYvRTpcTWhb/TglR5/p
 Lqr4r40nv2XhBo/xTw7mh8MgH/Kexg/AgeM98q7/uJbv6Lu/IAoXpV1MAsyP3Fz+L8KWXObI+MY
 LcCDKHXQCLax28u4=
X-Received: by 2002:a05:600c:4149:: with SMTP id
 h9mr3316535wmm.86.1600763909478; 
 Tue, 22 Sep 2020 01:38:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQLofMZAoDPTa2aZvcFu29fhUcwukrKKrzgPM8+1ptGSVoTwwZnHD0D9289WJpCJRdzF5n3g==
X-Received: by 2002:a05:600c:4149:: with SMTP id
 h9mr3316519wmm.86.1600763909260; 
 Tue, 22 Sep 2020 01:38:29 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id i83sm3541626wma.22.2020.09.22.01.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 01:38:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 1/6] util/vfio-helpers: Pass page protections to
 qemu_vfio_pci_map_bar()
Date: Tue, 22 Sep 2020 10:38:16 +0200
Message-Id: <20200922083821.578519-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200922083821.578519-1-philmd@redhat.com>
References: <20200922083821.578519-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pages are currently mapped READ/WRITE. To be able to use different
protections, add a new argument to qemu_vfio_pci_map_bar().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/vfio-helpers.h | 2 +-
 block/nvme.c                | 3 ++-
 util/vfio-helpers.c         | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
index 1f057c2b9e4..4491c8e1a6e 100644
--- a/include/qemu/vfio-helpers.h
+++ b/include/qemu/vfio-helpers.h
@@ -22,7 +22,7 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
 int qemu_vfio_dma_reset_temporary(QEMUVFIOState *s);
 void qemu_vfio_dma_unmap(QEMUVFIOState *s, void *host);
 void *qemu_vfio_pci_map_bar(QEMUVFIOState *s, int index,
-                            uint64_t offset, uint64_t size,
+                            uint64_t offset, uint64_t size, int prot,
                             Error **errp);
 void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
                              uint64_t offset, uint64_t size);
diff --git a/block/nvme.c b/block/nvme.c
index f4f27b6da7d..5a4dc6a722a 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -712,7 +712,8 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         goto out;
     }
 
-    s->regs = qemu_vfio_pci_map_bar(s->vfio, 0, 0, NVME_BAR_SIZE, errp);
+    s->regs = qemu_vfio_pci_map_bar(s->vfio, 0, 0, NVME_BAR_SIZE,
+                                    PROT_READ | PROT_WRITE, errp);
     if (!s->regs) {
         ret = -EINVAL;
         goto out;
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 583bdfb36fc..9ac307e3d42 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -146,13 +146,13 @@ static int qemu_vfio_pci_init_bar(QEMUVFIOState *s, int index, Error **errp)
  * Map a PCI bar area.
  */
 void *qemu_vfio_pci_map_bar(QEMUVFIOState *s, int index,
-                            uint64_t offset, uint64_t size,
+                            uint64_t offset, uint64_t size, int prot,
                             Error **errp)
 {
     void *p;
     assert_bar_index_valid(s, index);
     p = mmap(NULL, MIN(size, s->bar_region_info[index].size - offset),
-             PROT_READ | PROT_WRITE, MAP_SHARED,
+             prot, MAP_SHARED,
              s->device, s->bar_region_info[index].offset + offset);
     if (p == MAP_FAILED) {
         error_setg_errno(errp, errno, "Failed to map BAR region");
-- 
2.26.2


