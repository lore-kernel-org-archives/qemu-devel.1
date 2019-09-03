Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1212C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C50F2077B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jtOX8o8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C50F2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5B1i-0003c2-64
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArO-0002mQ-KR
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArN-0005vE-9x
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:46 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:35654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5ArN-0005uc-3i
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:45 -0400
Received: by mail-wr1-x435.google.com with SMTP id g7so18034427wrx.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=NH3h4g6hlFhS6RKG3sIpGzTOMf5SCVInEe1V7vBG3qg=;
 b=jtOX8o8auFMGzcrCxB3sDZjE0P/pUUOUS1eLpjgznJPW5k+JqxaO6x2RwfJ/E9XU72
 FL8x8XUij3JXYpngGMtEFf5D8XXrW95TgEyT56ekRn84SHWAb38/s1E1CblICNayx/s9
 ma95EjmuUy8NTc72TpJT/mtfkhWOPdRRcAEHqADf8ZrvuHSfcK8QxIGwKXR5R+/sO+wI
 xDAiF62eokHL/Y8zFvDY0LcXgcfVY4C38l+k875wHUrJGyhAi/dHYTXAj8GDwABntoL1
 MTrFSEQzkgynUAbRfNC9YsOG/YsH2RnjEi4XnSCBo/bqqo9E1LMsP6m53NC0RGrH/cY/
 CEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NH3h4g6hlFhS6RKG3sIpGzTOMf5SCVInEe1V7vBG3qg=;
 b=C1dwUBkhTPeC6nmE84kgwL9om0X2r59McqkDj0WObhTKPV9ipDVK0AVdb6CicBs7ps
 SqevrnOUqyDKlZ95cRmwfncxs4Nh4qRi4UkXEw3q++4aXGz8MsHcLMloSoUj2Jsp686f
 xWip/CVM5ZHNZyvIkS8ixUA3sztqWwC9D7fA+j+7wFPVYk1fu7ipOtRRdXY/lO6YS/pm
 b2t1mmoqFKAcVSUvt69/wTn31KSnAJv7p9aFpQKtyIkc2NpaXOUj0iZ0YKrx9lY38Mrb
 BblRSHMOxnpvCqnJg6NP7P9WZA5x411XD77vmH4y2M3vSnYCs6dIp8f+w6xoySWhDE5q
 agGQ==
X-Gm-Message-State: APjAAAUipdff4vSWdZWfqZMnBRgmM/dG/nyUwEO2nBOf3x1hxZag5Mb/
 jaf9v46MU+rqs2hhZCtLBKlkZPQs+XOd4A==
X-Google-Smtp-Source: APXvYqwCMgmyCLGLfOq74oSrV6xyF0mt1fKoM5Es+YOSXm8R+uQv2qRzjaeagkArVyZV0zmgj6l2HA==
X-Received: by 2002:adf:e74c:: with SMTP id c12mr7481836wrn.173.1567525003715; 
 Tue, 03 Sep 2019 08:36:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:18 +0100
Message-Id: <20190903153633.6651-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
References: <20190903153633.6651-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: [Qemu-devel] [PULL 06/21] memory: Remove unused
 memory_region_iommu_replay_all()
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

From: Eric Auger <eric.auger@redhat.com>

memory_region_iommu_replay_all is not used. Remove it.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-id: 20190822172350.12008-2-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memory.h | 10 ----------
 memory.c              |  9 ---------
 2 files changed, 19 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index fddc2ff48a7..ecca388e69d 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1086,16 +1086,6 @@ void memory_region_register_iommu_notifier(MemoryRegion *mr,
  */
 void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n);
 
-/**
- * memory_region_iommu_replay_all: replay existing IOMMU translations
- * to all the notifiers registered.
- *
- * Note: this is not related to record-and-replay functionality.
- *
- * @iommu_mr: the memory region to observe
- */
-void memory_region_iommu_replay_all(IOMMUMemoryRegion *iommu_mr);
-
 /**
  * memory_region_unregister_iommu_notifier: unregister a notifier for
  * changes to IOMMU translation entries.
diff --git a/memory.c b/memory.c
index 7fd93b1d42d..a23ff3cc2ac 100644
--- a/memory.c
+++ b/memory.c
@@ -1922,15 +1922,6 @@ void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     }
 }
 
-void memory_region_iommu_replay_all(IOMMUMemoryRegion *iommu_mr)
-{
-    IOMMUNotifier *notifier;
-
-    IOMMU_NOTIFIER_FOREACH(notifier, iommu_mr) {
-        memory_region_iommu_replay(iommu_mr, notifier);
-    }
-}
-
 void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
                                              IOMMUNotifier *n)
 {
-- 
2.20.1


