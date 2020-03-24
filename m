Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D444AC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA4720786
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeKGpvwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA4720786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGhCf-0003b9-QK
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 06:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jGhC6-0003Ch-DF
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jGhC5-0007qm-HO
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:54:02 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37080)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuval.shaia.ml@gmail.com>)
 id 1jGhC5-0007p7-AZ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:54:01 -0400
Received: by mail-wr1-x444.google.com with SMTP id w10so20847250wrm.4
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 03:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Yj3ch/cH2zbMx2GwtNnqIDoF1vA+x9H7mM6pq3Y2x6w=;
 b=TeKGpvwRhDl24RHiuod/9uYizxKfA188rFwJHypyvhuxSm7MBfB3cHi42m82hDCpu/
 u0QLzzamsgb/hLU8ARZyp3HrXLh5QRaT9kSvAb9t1Y336kxEXJPYpT2YKw7Kqeba1VQr
 VpLv6nu+adKULnyN4qqXeSv6YY1oeInKCSALPxjZrImrIuioq4Yv+jMuTehEDieokUFZ
 +/2EkJhRCNqGzBilwuVGPWd6VsBcYqBZ0jM1WiXVQpL4iYUI+aeEHzcyRql1z82oo/V+
 jifi/Fci+kSPi1ueMADv+5r5NV17PM3K8cph6YO+RL+r6ObETp5O1tOoqs5l0P5+qQQk
 ByBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Yj3ch/cH2zbMx2GwtNnqIDoF1vA+x9H7mM6pq3Y2x6w=;
 b=t9Kllet9lL+xBRuZgw9IaOrzXUEs24sN2BQJDbFWxGWXGGqxzRyJZSeEQwo0Qnh4ub
 D/HWCW713YdRx8sB5yr/w5lvisuFWyQ2h2lnrBWWGRyByK343p0WurmUbp5LGWlDX7aV
 0gVPUUoXGxqY00K8ltkVpTRLx1K0BYlr32j+Db8RGIeKGoRW5CrmhxcII8Ko989eOpd7
 P8TyMbVmU6UISeu8h4D/j3u0L3ZpKD4aRpIEWPjgw8Yhk1+xQFbVyt74KOqR1iWWF3Vu
 A2cvzQB/VsEospNtTA3xcFV5hu6+Te01CNSixVcTpM/Z0H8z53YHOsi0Iu5KVDLHzWAi
 kOjQ==
X-Gm-Message-State: ANhLgQ1fUaBzckY6xVMLdi+ceIBn2xbRd80WQRqXYPPBse/aXp5Klsyc
 xoBC00cj35/9Me3xDcJiAYo=
X-Google-Smtp-Source: ADFU+vtzcbMvjdALDUQ6IVPAzuD6PGV7GO7ZXSMBaGe3qBYsh3I4HJiy8tHf1BQVI5FfIYbPPB6vhQ==
X-Received: by 2002:adf:eb48:: with SMTP id u8mr35462094wrn.283.1585047240302; 
 Tue, 24 Mar 2020 03:54:00 -0700 (PDT)
Received: from lap2.lan ([77.138.185.144])
 by smtp.gmail.com with ESMTPSA id s8sm23676142wrv.97.2020.03.24.03.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 03:53:59 -0700 (PDT)
From: Yuval Shaia <yuval.shaia.ml@gmail.com>
To: yuval.shaia.ml@gmail.com, marcel.apfelbaum@gmail.com,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH] hw/rdma: Lock before destroy
Date: Tue, 24 Mar 2020 12:53:56 +0200
Message-Id: <20200324105356.7998-1-yuval.shaia.ml@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To protect from the case that users of the protected_qlist are still
using the qlist let's lock before detsroying it.

Reported-by: Coverity (CID 1421951)
Signed-off-by: Yuval Shaia <yuval.shaia.ml@gmail.com>
---
 hw/rdma/rdma_utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/rdma/rdma_utils.c b/hw/rdma/rdma_utils.c
index 73f279104c..55779cbef6 100644
--- a/hw/rdma/rdma_utils.c
+++ b/hw/rdma/rdma_utils.c
@@ -63,6 +63,7 @@ void rdma_protected_qlist_init(RdmaProtectedQList *list)
 void rdma_protected_qlist_destroy(RdmaProtectedQList *list)
 {
     if (list->list) {
+        qemu_mutex_lock(&list->lock);
         qlist_destroy_obj(QOBJECT(list->list));
         qemu_mutex_destroy(&list->lock);
         list->list = NULL;
-- 
2.25.1


