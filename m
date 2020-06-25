Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420B9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C1512089D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpgAjOzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1512089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUFR-0007wR-9b
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joU7I-0000oL-L5
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:48:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30603
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joU7G-0001pR-Ax
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593100121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FzbqnuPX20sDvDHUM+oOXdQ4t5AmvSu8Cf6mUxiLPD0=;
 b=gpgAjOzHG+7Z0f3mrFMekt0+kbPBU3s4hf5zqdnBaHRiLLAoPea8B+wFPRnWmXtTpE3dAW
 x3SJ96RsAn1Bxufl+oJV23ewd6+U1u1dWF5SWrRQwdkT8bvqsqtEmerqbOr0o0mCUxbSUi
 CpGIPHbOKxO/9YiqDDNizTPl93kv2h8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-ldCpxu1TP8u0PzruxfYlLg-1; Thu, 25 Jun 2020 11:48:38 -0400
X-MC-Unique: ldCpxu1TP8u0PzruxfYlLg-1
Received: by mail-wr1-f70.google.com with SMTP id j5so7038997wro.6
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 08:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FzbqnuPX20sDvDHUM+oOXdQ4t5AmvSu8Cf6mUxiLPD0=;
 b=Wnnt8a3xISd+6FTHyQps3FoQyCDpqHdoE6f9CJ18I1YgIqQ7gAzdcLyeV3VOI6xFno
 OTpPDX0SMzQnCYuz+5QqgeHiBhZbBuXhK2ZzvRm2yL46r9Yp+gROSFGFjDqfr73PTgpr
 sXPZUJkJildjJVqYHNswf1sEtVAgxo2eG0h2hiCr5FeyDnEql73boubzLfof4E4tB+89
 NPkTZb63m1oVbL1l1sO8Zj2ZbcUfhT8tmftx/NQ8Xi2KY5XbkJY+xTjDfj/2EvsMpJyZ
 vvunqwCbib0SyH7SX1CN3chyJvFMFU8tHOBaOVpQrixp7LBdreup2PyZLAHdt7tOv3mA
 ieAw==
X-Gm-Message-State: AOAM531zZTx7JlM67J99nVzHATk10uP5VBiU7xkmGijlORjoqX3aaQEh
 VoPdwwrQqQ+GgOIrKqmNxTiCBvWW10Xw3xs9WrYBO07J5d0FHI8O7Iy42MKVAmgWLYK0i6KINik
 oGyH1rF3NRAbHsOI=
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr29368262wrn.94.1593100116459; 
 Thu, 25 Jun 2020 08:48:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznb7jSIx5F46MjRYt0OiN5hKxL1Iu0Qgb4RdR4Vadyz06sX0Ns5Jvm7NVgd0J0+zedjHmslQ==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr29368230wrn.94.1593100116126; 
 Thu, 25 Jun 2020 08:48:36 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id n16sm25569374wrq.39.2020.06.25.08.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 08:48:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/block/nvme: Align I/O BAR to 4 KiB
Date: Thu, 25 Jun 2020 17:48:33 +0200
Message-Id: <20200625154834.367-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simplify the NVMe emulated device by aligning the I/O BAR to 4 KiB.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/block/nvme.h | 3 +++
 hw/block/nvme.c      | 5 ++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 1720ee1d51..6d87c9c146 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -22,6 +22,8 @@ typedef struct NvmeBar {
     uint32_t    pmrebs;
     uint32_t    pmrswtp;
     uint32_t    pmrmsc;
+    uint32_t    reserved[58];
+    uint8_t     cmd_set_specfic[0x100];
 } NvmeBar;
 
 enum NvmeCapShift {
@@ -879,6 +881,7 @@ enum NvmeIdNsDps {
 
 static inline void _nvme_check_size(void)
 {
+    QEMU_BUILD_BUG_ON(sizeof(NvmeBar) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeAerResult) != 4);
     QEMU_BUILD_BUG_ON(sizeof(NvmeCqe) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeDsmRange) != 16);
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 1aee042d4c..1938891e50 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -55,7 +55,6 @@
 #include "nvme.h"
 
 #define NVME_MAX_IOQPAIRS 0xffff
-#define NVME_REG_SIZE 0x1000
 #define NVME_DB_SIZE  4
 #define NVME_CMB_BIR 2
 #define NVME_PMR_BIR 2
@@ -1322,7 +1321,7 @@ static void nvme_mmio_write(void *opaque, hwaddr addr, uint64_t data,
     NvmeCtrl *n = (NvmeCtrl *)opaque;
     if (addr < sizeof(n->bar)) {
         nvme_write_bar(n, addr, data, size);
-    } else if (addr >= 0x1000) {
+    } else {
         nvme_process_db(n, addr, data);
     }
 }
@@ -1416,7 +1415,7 @@ static void nvme_init_state(NvmeCtrl *n)
 {
     n->num_namespaces = 1;
     /* add one to max_ioqpairs to account for the admin queue pair */
-    n->reg_size = pow2ceil(NVME_REG_SIZE +
+    n->reg_size = pow2ceil(sizeof(NvmeBar) +
                            2 * (n->params.max_ioqpairs + 1) * NVME_DB_SIZE);
     n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
     n->sq = g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
-- 
2.21.3


