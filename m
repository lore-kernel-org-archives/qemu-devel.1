Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E3CC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B4620757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hw4Aih1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B4620757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7wy-00043Q-Oo
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jf-0003CA-R7
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jb-0000Po-UE
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:11 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jb-0000PG-FJ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:07 -0400
Received: by mail-wr1-x443.google.com with SMTP id f13so6474430wrm.13
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=JuJOerU6YgiBx+PFXtHPe81yp45kyRPlfXNEXqsYBhk=;
 b=Hw4Aih1j0qnxIB51sU7fnDk4V/KbrlKtHcRFTtudDX439l+jEPN6E1Um6ek/6eFs61
 OlcS/PgBt0RHZrwZ1A+15JpLSeKtj/Ukqm3m2nrj6SZDMlY4f4GmwLeBZScqas3TA7xr
 w/g3J97/xj0IcueFMJeYKKMPfECADnSUvfio0kZnraofXwwNC3brZEVHUy9BQjBi7DQn
 1zWvBiTPxqhAzfjmiItGp0rxycHY1VzwLXz3fKWIsJ18lHur1odud9pXGnBDFIqU1CuW
 XztyMUXLGiQTqPrCLZ7Aivb5LQLPOUeO/ezIZL09sLEiCUKpz9T3bVT2veTPX1imJF5p
 uHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JuJOerU6YgiBx+PFXtHPe81yp45kyRPlfXNEXqsYBhk=;
 b=Lec0OAMR9DrqCI+m9aQxpg5HNkKZ6K7brDhflndWB1mPLsZow64TI4vhR6HWZc9sNg
 K2OGbujX9B4gIBuUH4JnOaf8g5tbYGvTHpLGUEYk4MBbl+gKVWFKE8BQdaIgTVZicoBA
 /0/qbO2DOTXPlDz/NWKrIRDVKX6LnjewsSapPygQ6vgSNTDBeRad7Xzsu/uILptap+Zq
 UG4UaEgPlbTN9EXzloImuiF/w7Krdjr2uMkFIHQ9VSTJwB4FCU2Z3wZWdxCxO6f8IsYD
 YOkXMie9GKsHFuRWAROwXSKJEgzoKGfjizU11pp1TbpaTICFtczRN/rnNo54GuLEv5p7
 Pzig==
X-Gm-Message-State: AGi0Pubuk8hYAORtWDIqsXoSWB4IOZhdPZ17UVF86Hl6K5y6J5RlGwBT
 h/Y08ggRhPzEY6uZO3ITgzhru+qW89kNeQ==
X-Google-Smtp-Source: APiQypIM0vR3lLpnWodUOE/KgXc41B1eP1VD/zr7MePdbGMIkwo1h47EPmZ8Hl1W6jek4hXSPLWwdg==
X-Received: by 2002:a05:6000:1089:: with SMTP id
 y9mr1497285wrw.306.1588247525837; 
 Thu, 30 Apr 2020 04:52:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.52.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:52:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/31] Cadence: gem: fix wraparound in 64bit descriptors
Date: Thu, 30 Apr 2020 12:51:30 +0100
Message-Id: <20200430115142.13430-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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

From: Ramon Fried <rfried.dev@gmail.com>

Wraparound of TX descriptor cyclic buffer only updated
the low 32 bits of the descriptor.
Fix that by checking if we're working with 64bit descriptors.

Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20200417171736.441607-1-rfried.dev@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/cadence_gem.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 51ec5a072d0..b7b7985bf26 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1238,7 +1238,14 @@ static void gem_transmit(CadenceGEMState *s)
             /* read next descriptor */
             if (tx_desc_get_wrap(desc)) {
                 tx_desc_set_last(desc);
-                packet_desc_addr = s->regs[GEM_TXQBASE];
+
+                if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
+                    packet_desc_addr = s->regs[GEM_TBQPH];
+                    packet_desc_addr <<= 32;
+                } else {
+                    packet_desc_addr = 0;
+                }
+                packet_desc_addr |= s->regs[GEM_TXQBASE];
             } else {
                 packet_desc_addr += 4 * gem_get_desc_len(s, false);
             }
-- 
2.20.1


