Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123BCC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04C22070B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/ib/eEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04C22070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2dA2-0000sO-IT
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cwQ-0003OT-9n
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cwL-0003o7-GW
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:23 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39514)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i2cwJ-0003hl-Gb; Tue, 27 Aug 2019 10:59:21 -0400
Received: by mail-pl1-x642.google.com with SMTP id z3so11950714pln.6;
 Tue, 27 Aug 2019 07:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=F6B4x3xsQ3LrE7zY0k6hhCP8/PfH3NI3sEzMOKRn1i4=;
 b=U/ib/eEkHr5c84XKn4ipowSS2JNM1dcTy8P/bLaXcchh3YaFML8TYu2N8trKnyMLq1
 lKrfu9PD6rw7cVyOq0/qdsv2VtJIb3L1p3/2UCKkgkj7pjc9xzMBFpj8AxiUKpM7ri5I
 OMqkcvkmkdIgyZQ5adAhP40hFghyxpBD65WyeeRGL5Kws3m0CAw+8KfiLGISXAzmoKQX
 Nhh2bdBZpXx/aokfFpmx5ssrx/7OHwZQq7flA0/i2fBLTedaVl6ACi7mfJfOXlBJEtVg
 tWSh9Xbil2EKxRLZF2uA+3niDHvSAaVgOQUnE7NzxY1QcZxXoYOYbPSdv8wxPbSi7BJm
 Uq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=F6B4x3xsQ3LrE7zY0k6hhCP8/PfH3NI3sEzMOKRn1i4=;
 b=I0aUmVaFxw+mya9q9ZFOjx7agOXJ0WJ8pK/R3QuamO/NzhMtKTGO8LQZ8G9UDuAh4g
 ImKiyLqmKdA7SBymCZ+kTVllf9hD0aP40BgcaP9dFHCXbnrg5Ci52X6txHzSSKb0k3Er
 NfP5RHfsZCFoEdCz9guPh/6Bp8KmGVZa63Cvygu1bPzuNKG6UCqYWy8b7v54MRvU9eCn
 9+0G7YSuVXc88BcUl1rXX43Yk5/OMlBkJzbhXmT7TZnacXmggtOiN29yX0+V6D1qQDu4
 gZMg9i5iUh0TWeBIkW4CWffVUFmRGM0Jgj9AyGFcSoomXn8VUtcRlvMj2YpVIX1dB0+l
 JfHA==
X-Gm-Message-State: APjAAAU5+4zZzyjp0iFGwp8VrJMGxYm2vyFY2d/ryKUv6xktV0BwBCg/
 mtcpLS1TGDosZWY5v/O33rA=
X-Google-Smtp-Source: APXvYqytxNl5YAOykxVuMCHQhSWQZTBAAnyjdFasAMzqfAEKwM9kQr4RfctFBAkSw0SyOkG+k+nzCA==
X-Received: by 2002:a17:902:8609:: with SMTP id
 f9mr24460307plo.112.1566917945763; 
 Tue, 27 Aug 2019 07:59:05 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id j15sm14839344pfr.146.2019.08.27.07.59.04
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Tue, 27 Aug 2019 07:59:04 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Tue, 27 Aug 2019 07:58:27 -0700
Message-Id: <1566917919-25381-19-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
References: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v6 18/30] riscv: sifive_u: Update PLIC hart
 topology configuration string
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

With heterogeneous harts config, the PLIC hart topology configuration
string are "M,MS,.." because of the monitor hart #0.

Suggested-by: Fabien Chouteau <chouteau@adacore.com>
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 7f51d9d..24ae3d1 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -424,10 +424,11 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     plic_hart_config = g_malloc0(plic_hart_config_len);
     for (i = 0; i < ms->smp.cpus; i++) {
         if (i != 0) {
-            strncat(plic_hart_config, ",", plic_hart_config_len);
+            strncat(plic_hart_config, "," SIFIVE_U_PLIC_HART_CONFIG,
+                    plic_hart_config_len);
+        } else {
+            strncat(plic_hart_config, "M", plic_hart_config_len);
         }
-        strncat(plic_hart_config, SIFIVE_U_PLIC_HART_CONFIG,
-                plic_hart_config_len);
         plic_hart_config_len -= (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1);
     }
 
-- 
2.7.4


