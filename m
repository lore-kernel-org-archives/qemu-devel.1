Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1B1C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E612620663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdpGXKpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E612620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDslT-0007OV-4J
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jDqiK-0007dL-3p
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jDqiJ-0005Vy-4F
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:27:32 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:35316)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jDqiG-0005AD-9b; Mon, 16 Mar 2020 10:27:28 -0400
Received: by mail-pj1-x1043.google.com with SMTP id mq3so8801312pjb.0;
 Mon, 16 Mar 2020 07:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8p47syJONdd8/zj3ZHq151z5Oq8HeNZBxFWwhkRlYos=;
 b=YdpGXKpA+0VYhg51FcX4vAq+oOr5b/DeAXbKc2wCNWV2lDbn6yAGotm2pUQe4gS8Cf
 PBS4+SZvLS9mK3mRTFUhRqLk9fK4MwdPpCu+mBhRgIi4Hl+AYZdcEZhMcH2zycFzL3mU
 VTB+VLIUPBywqgylfovnlLwTcCmstyFN+7WeOL827XEq623E9KUh3v83ihZ6bGc3sce0
 NfYuRghm4OIu1jJwjXeDyPU2P0qEWzDnKUbv7OtdNP1Vjt7J3b4T89JjcmRC6nlJ5vOH
 L0YZTFu3tu0KM2wrtYrI203wDU6HHhlTFBGvOv1Md6xslRSeTXdADMaENzNpVqJy1Sjx
 qxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8p47syJONdd8/zj3ZHq151z5Oq8HeNZBxFWwhkRlYos=;
 b=umiEVTHVCoHmS9KfE3346JQhLfL6yB7NWttwIL4Ezvn5wvwYCyJBqpqldSTU2CWk1n
 viAlGinSbq61X7Eca+ZzZE1AJj2yGeK1AgKJ0mvwo4/CF5YuWq5i/8GDOw4abUYh1R4e
 RLLDyd1Ucxpw+u5HFc4ZDVH6TD7ouwZH/1a8Pp4OuEsHI0a9DejEtm3W2nYPiFsE0U9n
 eTTteQV3Vbo/H/U5RP2/7H+SPwCVjfW4sd7Gu2qmzU8bQgteE3VAXr4MqWvjiL30CUSu
 TXBhWYNpxLpXNELmTrrSrqehlyp09m4bjVnBdVUkx90SyOjxTaqJE38xUS2JoemhYqJJ
 fSSg==
X-Gm-Message-State: ANhLgQ1RYmzDON0ZD4B1ThG6BLuP5P3YO0edCHCVqewsBXnjk4xEDIqx
 wKvlfvUSvEjtCLDpzDtNu8oNRwp7+nA=
X-Google-Smtp-Source: ADFU+vsNOsvEcg8XN6hd4REZRuCcn6hqW5WYnKD3laHhrTv/laLcuwweN+wtx9+h6YnnseEpNVUmCQ==
X-Received: by 2002:a17:902:a588:: with SMTP id
 az8mr2163506plb.163.1584368847300; 
 Mon, 16 Mar 2020 07:27:27 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.63.160.49])
 by smtp.gmail.com with ESMTPSA id v1sm45564pjy.35.2020.03.16.07.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 07:27:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v2 8/8] ppc/spapr: Ignore common "ibm, nmi-interlock" Linux bug
Date: Tue, 17 Mar 2020 00:26:13 +1000
Message-Id: <20200316142613.121089-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200316142613.121089-1-npiggin@gmail.com>
References: <20200316142613.121089-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Linux kernels call "ibm,nmi-interlock" in their system reset handlers
contrary to PAPR. Returning an error because the CPU does not hold the
interlock here causes Linux to print warning messages. PowerVM returns
success in this case, so do the same for now.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_rtas.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 521e6b0b72..9fb8c8632a 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -461,8 +461,18 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
     }
 
     if (spapr->fwnmi_machine_check_interlock != cpu->vcpu_id) {
-        /* The vCPU that hit the NMI should invoke "ibm,nmi-interlock" */
-        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        /*
+	 * The vCPU that hit the NMI should invoke "ibm,nmi-interlock"
+         * This should be PARAM_ERROR, but Linux calls "ibm,nmi-interlock"
+	 * for system reset interrupts, despite them not being interlocked.
+	 * PowerVM silently ignores this and returns success here. Returning
+	 * failure causes Linux to print the error "FWNMI: nmi-interlock
+	 * failed: -3", although no other apparent ill effects, this is a
+	 * regression for the user when enabling FWNMI. So for now, match
+	 * PowerVM. When most Linux clients are fixed, this could be
+	 * changed.
+	 */
+        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
         return;
     }
 
-- 
2.23.0


