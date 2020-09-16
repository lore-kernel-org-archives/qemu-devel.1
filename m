Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9454EC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 20:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC8B420770
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 20:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoameEtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8B420770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIeFx-0007pS-O6
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 16:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIeE9-0006IP-Dj
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 16:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIeE6-0002yc-DB
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 16:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600288825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5dfg09EHj5Ati1T5gFLGt5bazj5HbyhTa8QLgR4w0EM=;
 b=VoameEtr0tZlAT3TTSySzRJrjz/DJ3EKqnKtg9CBJ7ZFNcIOFoGvqO5NvUuXH3tjLO7GCp
 9AjwBUVa+7T+g3JVCKLlUjJeRgGD/DNJif1tRizqhQL9WYcjQj9i4E2mchMbsdPXRGX4Sv
 AsxIXhOvU79yE25K0O7AFmmExvbIA3k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-RbYPAsNqOdCqjww-71CYUg-1; Wed, 16 Sep 2020 16:40:24 -0400
X-MC-Unique: RbYPAsNqOdCqjww-71CYUg-1
Received: by mail-wr1-f69.google.com with SMTP id g6so3019598wrv.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 13:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5dfg09EHj5Ati1T5gFLGt5bazj5HbyhTa8QLgR4w0EM=;
 b=HEG5JWoFFJwMbeMKCvw3b9RKCVLCmn2Gf2EKUWKMLHzbSIcokRRLt5ZzT6A3mEK7UM
 /dLKH1/4WEz8W41VNdLFX159/ClBVAkzdABi5AyoR9W14lPLkNJaKi8z1gg5hu8kiEfo
 1oabdcbxDikqToPbXsrVwl17HCQlpwfoOPy+txXA88/CQrBs+G5uk5ShkcyrAiKQZ3q9
 WraMbhQvVH+zsnYN1+Su2iYRZtcfGV4SDEXvAnkKYFLP12gIGybRu7cBuwnBiZhXXpPf
 hB9QC+BzVXGjthqkTXPTxkEra1Yi0eYkO+XXH3RdtVkwszGnU/GqdrMa59fEJzqrgSxv
 JYkA==
X-Gm-Message-State: AOAM533eZinq1SvspYo88LB0X42cM6XHMTle//LBcOuoSl+E6XHHZpuV
 Tw/rsFTQLWLZrocQx9r/Mu5YBHGur7GBULTgdqk6DOH1WEL7FKFNizIyVLG9tfspoMFBNzTjyny
 WJ9uEGropZYG5FY8=
X-Received: by 2002:a7b:ca56:: with SMTP id m22mr6189488wml.12.1600288822609; 
 Wed, 16 Sep 2020 13:40:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjWbMmuJceCnFQDrGpD02GAKDl/p1/zQd5pK1QMUdRT0pzVXEffjd6g682HXYmfxCPwgwGXg==
X-Received: by 2002:a7b:ca56:: with SMTP id m22mr6189478wml.12.1600288822462; 
 Wed, 16 Sep 2020 13:40:22 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id c14sm27424529wrm.64.2020.09.16.13.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 13:40:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] block/nvme: Align NVMeRegs structure to 4KiB and mark it
 packed
Date: Wed, 16 Sep 2020 22:40:04 +0200
Message-Id: <20200916204004.1511985-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200916204004.1511985-1-philmd@redhat.com>
References: <20200916204004.1511985-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit e5ff22ba9fc we changed the doorbells register
declaration but forgot to mark the structure packed (as
MMIO registers), allowing the compiler to optimize it.
Fix by marking it packed, and align it to avoid:

  block/nvme.c: In function ‘nvme_create_queue_pair’:
  block/nvme.c:252:22: error: taking address of packed member of ‘struct <anonymous>’ may result in an unaligned pointer value [-Werror=address-of-packed-member]
      252 |     q->sq.doorbell = &s->regs->doorbells[idx * s->doorbell_scale].sq_tail;
          |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: e5ff22ba9fc ("block/nvme: Pair doorbell registers")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index be80ea1f410..2f9f560ccd5 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include <linux/vfio.h>
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
@@ -82,13 +83,15 @@ typedef struct {
 } NVMeQueuePair;
 
 /* Memory mapped registers */
-typedef struct {
+typedef struct QEMU_PACKED {
     NvmeBar ctrl;
     struct {
         uint32_t sq_tail;
         uint32_t cq_head;
     } doorbells[];
-} NVMeRegs;
+} QEMU_ALIGNED(4 * KiB) NVMeRegs;
+
+QEMU_BUILD_BUG_ON(offsetof(NVMeRegs, doorbells[1]) != 4096 + 8);
 
 #define INDEX_ADMIN     0
 #define INDEX_IO(n)     (1 + n)
-- 
2.26.2


