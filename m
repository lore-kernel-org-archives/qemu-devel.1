Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BF2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C00E2067C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IJ6wvDCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C00E2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k858o-0000bs-Pc
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 13:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1k856w-0006bA-39
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 13:09:22 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:53076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1k856u-00031H-E4
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 13:09:21 -0400
Received: by mail-pj1-x1041.google.com with SMTP id kr4so9697118pjb.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 10:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7Qs2rtxT3/R6MXxuyS8SeDFTvt7qJW/PWlDHxREUlis=;
 b=IJ6wvDCaYyYTd8iJBQmGXJen7uE0lCKJb82qNKLRSnR0uLgVUPAlKLOPm4qNkMysb+
 W8y2RWutT5Rjat0lFAJhQxbbeSfrkiNO1lfa6HaOuQoiH9f1gQNFVADIi8eRBHJIUcQN
 KWmPWP4fURUqXVFAX/73z1pJSMxNmkTTYWlVS/ySo5jfzENtiNPCwpg8wFWQQMvSgbsT
 x8neLqoS/XVHDEyF97ugKOCoMQpomrmqar+ufbKF4DzFPkzS7BmE9k/Cszo/GJ8QP9YX
 Dwo1haTDiOsW+WzPZsd8twYQrbusqsq2U6md4HLw3U7x0eob10AD3G3ABUAIQeYZ8Zbq
 6ZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7Qs2rtxT3/R6MXxuyS8SeDFTvt7qJW/PWlDHxREUlis=;
 b=JzGSjNnmBTUv7sfuobs/kuZw1qtdTw46SD8Uowco7GFWy+K7Ev3ch8+S/v/H5XJ31F
 QDSeyY09rocQ8PZEN7LhkjJ84PiM7ogPg++waBzr+lJh65SscR/J+5yOaBhz4aDaziNP
 bWTUkaNWu8A1SlLLC9NqfcnljWxqXgG6I+ftl/3a2z+tMEuebY6cak2azr74iWGshDAs
 xXW3jEA2KtQ/WMMywm2LtTXfWp4Z8QggVVtNOGpCGuvTXr6QCDNbtJDSWmsicuOsYYqa
 P4/kokQpb0k51ad7CJiSGKS0UE7ww8AJ7Xpu0oU2PiZ7NjnpNFWJl1g3rUXZHxQKGEIp
 c3gA==
X-Gm-Message-State: AOAM530LEug8XwacnO5CMtJmpiB3ptpwYlctGmc/0bIRoSGqjmsNt3c2
 fgTU4uPbjl3sj1kPi6DVl8wMcA==
X-Google-Smtp-Source: ABdhPJyvpzGZC4y9LR5A5GfY9hssJdpYIbJZFCgV36uJgWaH6t/csFklP88LK/eBzG+D/GZriJmC4Q==
X-Received: by 2002:a17:902:b594:: with SMTP id
 a20mr15887590pls.339.1597770557934; 
 Tue, 18 Aug 2020 10:09:17 -0700 (PDT)
Received: from localhost.localdomain (114-47-163-2.dynamic-ip.hinet.net.
 [114.47.163.2])
 by smtp.gmail.com with ESMTPSA id m3sm460043pjs.22.2020.08.18.10.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 10:09:17 -0700 (PDT)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [RFC PATCH v3 2/2] hw/riscv: sifive_u: Add write-once protection.
Date: Wed, 19 Aug 2020 01:08:39 +0800
Message-Id: <20200818170839.20258-3-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818170839.20258-1-green.wan@sifive.com>
References: <20200818170839.20258-1-green.wan@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=green.wan@sifive.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Green Wan <green.wan@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add array to store the 'written' status for all bit of OTP to block
the write operation to the same bit. Ignore the control register
offset from 0x0 to 0x38 of OTP memory mapping.

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 hw/riscv/sifive_u_otp.c         | 21 +++++++++++++++++++++
 include/hw/riscv/sifive_u_otp.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
index 4552b2409e..3a25652735 100644
--- a/hw/riscv/sifive_u_otp.c
+++ b/hw/riscv/sifive_u_otp.c
@@ -27,6 +27,12 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/block-backend.h"
 
+#define SET_WRITTEN_BIT(map, idx, bit)    \
+    (map[idx] |= (0x1 << bit))
+
+#define GET_WRITTEN_BIT(map, idx, bit)    \
+    ((map[idx] >> bit) & 0x1)
+
 static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
 {
     SiFiveUOTPState *s = opaque;
@@ -135,6 +141,18 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
         s->ptrim = val32;
         break;
     case SIFIVE_U_OTP_PWE:
+        /* Keep written state for data only and PWE is enabled. Ignore PAS=1 */
+        if ((s->pa > SIFIVE_U_OTP_PWE) && (val32 & 0x1) && !s->pas) {
+            if (GET_WRITTEN_BIT(s->fuse_wo, s->pa, s->paio)) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Error: write idx<%u>, bit<%u>\n",
+                              s->pa, s->paio);
+                break;
+            } else {
+                SET_WRITTEN_BIT(s->fuse_wo, s->pa, s->paio);
+            }
+        }
+
         /* write to backend */
         if (s->blk) {
             blk_pwrite(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD, &val32,
@@ -215,6 +233,9 @@ static void sifive_u_otp_reset(DeviceState *dev)
     /* Make a valid content of serial number */
     s->fuse[SIFIVE_U_OTP_SERIAL_ADDR] = s->serial;
     s->fuse[SIFIVE_U_OTP_SERIAL_ADDR + 1] = ~(s->serial);
+
+    /* Initialize write-once map */
+    memset(s->fuse_wo, 0x00, sizeof(s->fuse_wo));
 }
 
 static void sifive_u_otp_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive_u_otp.h
index dea1df6f6c..ab6e46b013 100644
--- a/include/hw/riscv/sifive_u_otp.h
+++ b/include/hw/riscv/sifive_u_otp.h
@@ -74,6 +74,7 @@ typedef struct SiFiveUOTPState {
     uint32_t ptrim;
     uint32_t pwe;
     uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
+    uint32_t fuse_wo[SIFIVE_U_OTP_NUM_FUSES];
     /* config */
     uint32_t serial;
     BlockBackend   *blk;
-- 
2.17.1


