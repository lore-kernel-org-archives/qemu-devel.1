Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21977C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:59:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2642071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WowQZmfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2642071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNjBs-0005rc-9J
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 16:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kNj05-0003Ra-Cu
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:46:59 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kNizu-0006Tc-OM
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:46:57 -0400
Received: by mail-wr1-x441.google.com with SMTP id t10so3266448wrv.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 13:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tznGg6PahzCiTHvqBDnQdacUpiDJQTIvczl8JYGIdek=;
 b=WowQZmfKQ+YTgzzsosUlcsOrViMtVJeYbTUaJSBJvithIRiz+kv7xRd8V02rEEaJxN
 V+em/xclm/xww6FJYP94JyYvqFmEPpd9mmAFWLVfyjz7lPQckXFHNGKGGB7X6swMvAty
 jHSFK/rpwwDAMZ9x6X5SaTCfSAzwPC/2vscjw0ybJkp4Ox4h7v4Y+afOINXUv6N3Elzg
 TSK4G65ltYPBs60vKEFYs8QO9eCQN8GndqwTq3dVHTNjNi/KqjDbxhHnNZAI8i0hJuGc
 katffUCfEIsIOjEX0TckZxiOTJgypydlAxjsQLLEBShDQXDy0YCXKB8ZlPQiNvEdfjWD
 cDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tznGg6PahzCiTHvqBDnQdacUpiDJQTIvczl8JYGIdek=;
 b=Avq5Qa0BZJp5ha8nq9D8u4SIJy9SxR/g6HuWDVEwZ+1odN5oRG8aF2OSROjaUx4Awk
 0vLbGdqGpTU67Zeu9sN6qzglHXmzAYNODGIY9UkCReoDL+jIRqr5rgjcvImezRape/8b
 Bnu6kDDE1fxPxqOWYHMbrHJ0zHSI6B3F5oYruOq3iXJNda5AOHS9HoJM7oUmgjU9GB3w
 2sKa0BvcpdLfC5I7c3jziUMpMBWbEqBZ3LuDMsyVEbfCBwVEtKoP22buM7kXQ1LA0OW+
 +CNOX2bZMTvqAFEwZvXccfcXZjDfjbAf5cDklSccUxk8slInvphwbbX8p7P+tHtA3/HH
 O7HA==
X-Gm-Message-State: AOAM532/tetdtS8qbpOSYxD8bYBkZHejaVnVsQlbe9jljDfUcpdI1fle
 MQt17+OHyUym8JG2mxDC0kQIQjKDaxY2Dw==
X-Google-Smtp-Source: ABdhPJwzgOTXjMSC91N8qABkWlL9kMTwJoc3aU6QwkuXyqd6JAINOeATJppkx4HPNQturtIqhWI7Dg==
X-Received: by 2002:a5d:470f:: with SMTP id y15mr4953985wrq.420.1601498803549; 
 Wed, 30 Sep 2020 13:46:43 -0700 (PDT)
Received: from cmiranda-laptop.localdomain ([188.251.240.167])
 by smtp.gmail.com with ESMTPSA id v204sm5310764wmg.20.2020.09.30.13.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 13:46:42 -0700 (PDT)
From: cupertinomiranda@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 07/14] arc: Add BCR and AUX registers implementation
Date: Wed, 30 Sep 2020 21:45:57 +0100
Message-Id: <20200930204604.20663-8-cupertinomiranda@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200930204604.20663-1-cupertinomiranda@gmail.com>
References: <20200930204604.20663-1-cupertinomiranda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=cupertinomiranda@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Claudiu Zissulescu <claziss@gmail.com>,
 Cupertino Miranda <cupertinomiranda@gmail.com>,
 Shahab Vahedi <shahab.vahedi@gmail.com>, Shahab Vahedi <shahab@synopsys.com>,
 Cupertino Miranda <cmiranda@synopsys.com>, linux-snps-arc@lists.infradead.org,
 Claudiu Zissulescu <claziss@synopsys.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cupertino Miranda <cmiranda@synopsys.com>

Add the infrastructure to define build configuration (BCR) and auxiliary
registers allowing independent modules (MMU, MPU, etc.) to use and extend
them.

Signed-off-by: Cupertino Miranda <cmiranda@synopsys.com>
---
 target/arc/cache.c         | 180 ++++++++++++
 target/arc/cache.h         |  42 +++
 target/arc/regs-detail.def | 542 +++++++++++++++++++++++++++++++++++++
 target/arc/regs.c          | 139 ++++++++++
 target/arc/regs.def        | 399 +++++++++++++++++++++++++++
 target/arc/regs.h          | 118 ++++++++
 6 files changed, 1420 insertions(+)
 create mode 100644 target/arc/cache.c
 create mode 100644 target/arc/cache.h
 create mode 100644 target/arc/regs-detail.def
 create mode 100644 target/arc/regs.c
 create mode 100644 target/arc/regs.def
 create mode 100644 target/arc/regs.h

diff --git a/target/arc/cache.c b/target/arc/cache.c
new file mode 100644
index 0000000000..fe0921823b
--- /dev/null
+++ b/target/arc/cache.c
@@ -0,0 +1,180 @@
+/*
+ * QEMU ARC CPU
+ *
+ * Copyright (c) 2019 Synopsys, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "cpu.h"
+#include "target/arc/regs.h"
+#include "target/arc/cache.h"
+
+void arc_cache_aux_set(const struct arc_aux_reg_detail *aux_reg_detail,
+                       uint32_t val, void *data)
+{
+
+    CPUARCState *env = (CPUARCState *) data;
+    struct arc_cache *cache = &env->cache;
+
+    switch (aux_reg_detail->id) {
+    case AUX_ID_ic_ivic:
+    case AUX_ID_ic_ivil:
+    case AUX_ID_dc_ivdc:
+    case AUX_ID_dc_ivdl:
+    case AUX_ID_dc_flsh:
+    case AUX_ID_dc_fldl:
+    case AUX_ID_dc_startr:
+       /* Do nothing as we don't simulate cache memories */
+       break;
+
+    case AUX_ID_ic_ctrl:
+        cache->ic_disabled = val & 1;
+        break;
+
+    case AUX_ID_ic_ivir:
+        cache->ic_ivir = val & 0xffffff00;
+        break;
+
+    case AUX_ID_ic_endr:
+        cache->ic_endr = val & 0xffffff00;
+        break;
+
+    case AUX_ID_ic_ptag:
+        cache->ic_ptag = val;
+        break;
+
+    case AUX_ID_ic_ptag_hi:
+        cache->ic_ptag_hi = val & 0xff;
+        break;
+
+/*
+ * Description of the register content in order:
+ *   DC - Disable Cache: Enables/Disables the cache: 0 - Enabled, 1 - Disabled
+ *   IM - Invalidate Mode: Selects the invalidate type
+ */
+    case AUX_ID_dc_ctrl:
+        cache->dc_disabled = val & 1; /* DC */
+        cache->dc_inv_mode = (val >> 6) & 1; /* IM */
+        break;
+
+    case AUX_ID_dc_endr:
+        cache->dc_endr = val & 0xffffff00;
+        break;
+
+    case AUX_ID_dc_ptag_hi:
+        cache->dc_ptag_hi = val & 0xff;
+        break;
+
+    default:
+        hw_error("%s@%d: Attempt to write read-only register 0x%02x!\n",
+                 __func__, __LINE__, (unsigned int)aux_reg_detail->id);
+        break;
+    }
+
+    return;
+}
+
+uint32_t arc_cache_aux_get(const struct arc_aux_reg_detail *aux_reg_detail,
+                           void *data)
+{
+    CPUARCState *env = (CPUARCState *) data;
+    struct arc_cache *cache = &env->cache;
+    uint32_t reg = 0;
+
+    switch (aux_reg_detail->id) {
+/*
+ * Description of the register content in order.
+ * Layout:  -------- -DFFBBBB CCCCAAAA VVVVVVVV
+ *   D - indicates that IC is disabled on reset
+ *   FL - Feature level: 10b - line lock, invalidate, advanced debug features
+ *   BSize - indicates the cache block size in bytes: 0011b - 64 bytes
+ *   Cache capacity: 0111b - 64 Kbytes
+ *   Cache Associativiy: 0010b - Four-way set associative
+ *   Version number: 4 - ARCv2
+ */
+    case AUX_ID_i_cache_build:
+        reg = (0 << 22) | /* D */
+              (2 << 20) | /* FL */
+              (3 << 16) | /* BBSixe*/
+              (7 << 12) | /* Cache capacity */
+              (2 << 8)  | /* Cache Associativiy */
+              (4 << 0);   /* Version Number */
+        break;
+
+    case AUX_ID_ic_ctrl:
+        reg = cache->ic_disabled & 1;
+        break;
+
+    case AUX_ID_ic_ivir:
+        reg = cache->ic_ivir;
+        break;
+
+    case AUX_ID_ic_endr:
+        reg = cache->ic_endr;
+        break;
+
+    case AUX_ID_ic_ptag:
+        reg = cache->ic_ptag;
+        break;
+
+    case AUX_ID_ic_ptag_hi:
+        reg = cache->ic_ptag_hi;
+        break;
+
+/*
+ * Description of the register content in order:
+ *   FL - Feature level: 10b - line lock, invalidate, advanced debug features
+ *   BSize - indicates the cache block size in bytes: 0010b - 64 bytes
+ *   Cache capacity: 0111b - 64 Kbytes
+ *   Cache Associativiy: 0001b - Two-way set associative
+ *   Version number: 4 - ARCv2 with fixed number of cycles
+ */
+    case AUX_ID_d_cache_build:
+        reg = (2 << 20) | /* FL */
+              (2 << 16) | /* BSize */
+              (7 << 12) | /* Cache capacity */
+              (1 << 8)  | /* Cache Associativiy */
+              (4 << 0);   /* Version number */
+        break;
+
+/*
+ * Description of the register content in order:
+ *   DC - Disable Cache: Enables/Disables the cache: 0 - Enabled, 1 - Disabled
+ *   SB - Success Bit: of last cache operation: 1 - succeded (immediately)
+ *   IM - Invalidate Mode: Selects the invalidate type
+ */
+    case AUX_ID_dc_ctrl:
+       reg = (cache->dc_disabled & 1) << 0 |  /* DC */
+             (1 << 2) |                       /* SB */
+             (cache->dc_inv_mode & 1) << 6;   /* IM */
+        break;
+
+    case AUX_ID_dc_endr:
+        reg = cache->dc_endr;
+        break;
+
+    case AUX_ID_dc_ptag_hi:
+        reg = cache->dc_ptag_hi;
+        break;
+
+    default:
+        hw_error("%s@%d: Attempt to read write-only register 0x%02x!\n",
+                 __func__, __LINE__, (unsigned int)aux_reg_detail->id);
+        break;
+    }
+
+    return reg;
+}
diff --git a/target/arc/cache.h b/target/arc/cache.h
new file mode 100644
index 0000000000..dbd8ba95ed
--- /dev/null
+++ b/target/arc/cache.h
@@ -0,0 +1,42 @@
+/*
+ * QEMU ARC CPU
+ *
+ * Copyright (c) 2020 Synopsys, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ARC_CACHE_H__
+#define __ARC_CACHE_H__
+
+#include "target/arc/regs.h"
+
+struct arc_cache {
+    bool ic_disabled;
+    bool dc_disabled;
+    bool dc_inv_mode;
+    uint32_t ic_ivir;
+    uint32_t ic_endr;
+    uint32_t ic_ptag;
+    uint32_t ic_ptag_hi;
+    uint32_t dc_endr;
+    uint32_t dc_ptag_hi;
+};
+
+void arc_cache_aux_set(const struct arc_aux_reg_detail *aux_reg_detail,
+                       uint32_t val, void *data);
+
+uint32_t arc_cache_aux_get(const struct arc_aux_reg_detail *aux_reg_detail,
+                           void *data);
+
+#endif /* __ARC_CACHE_H__ */
diff --git a/target/arc/regs-detail.def b/target/arc/regs-detail.def
new file mode 100644
index 0000000000..a28492b32c
--- /dev/null
+++ b/target/arc/regs-detail.def
@@ -0,0 +1,542 @@
+/*
+ * QEMU ARC Auxiliary register definitions
+ * Copyright (C) 2020 Free Software Foundation, Inc.
+ *
+ * Contributed by Claudiu Zissulescu (claziss@synopsys.com)
+ * Contributed by Cupertino Miranda (cmiranda@synopsys.com)
+ *
+ * This file is part of libopcodes.  This library is free software;
+ * you can redistribute it and/or modify it under the terms of the GNU
+ * General Public License as published by the Free Software
+ * Foundation; either version 3, or (at your option) any later
+ * version.
+ *
+ * It is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
+ * License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+
+/* INFO: this list must be kept ordered by address to allow
+ * binary search of register information based on address.
+ */
+
+DEF(0xffff,ARC_OPCODE_ARCALL,  NONE, unimp_bcr)
+DEF(0x1,   ARC_OPCODE_ARCV1,   NONE, semaphore)
+DEF(0x2,   ARC_OPCODE_ARCALL,  NONE, lp_start)
+DEF(0x3,   ARC_OPCODE_ARCALL,  NONE, lp_end)
+DEF(0x4,   ARC_OPCODE_ARCALL,  NONE, identity)
+DEF(0x5,   ARC_OPCODE_ARCALL,  NONE, debug)
+DEF(0x6,   ARC_OPCODE_ARCALL,  NONE, pc)
+DEF(0x7,   ARC_OPCODE_ARCv2HS, NONE, memseg)
+DEF(0x7,   ARC_OPCODE_ARCV1,   NONE, adcr)
+DEF(0x8,   ARC_OPCODE_ARCV1,   NONE, apcr)
+DEF(0x8,   ARC_OPCODE_ARCv2HS, NONE, exec_ctrl)
+DEF(0x9,   ARC_OPCODE_ARCV1,   NONE, acr)
+DEF(0x9,   ARC_OPCODE_ARCv2EM, NONE, sec_stat)
+DEF(0xa,   ARC_OPCODE_ARCALL,  NONE, status32)
+DEF(0xb,   ARC_OPCODE_ARCV2,   NONE, status32_p0)
+DEF(0xc,   ARC_OPCODE_ARCv2EM, NONE, sec_extra)
+DEF(0xd,   ARC_OPCODE_ARCV2,   NONE, aux_user_sp)
+DEF(0xe,   ARC_OPCODE_ARC700,  NONE, clk_enable)
+DEF(0xe,   ARC_OPCODE_ARCV2,   NONE, aux_irq_ctrl)
+DEF(0xf,   ARC_OPCODE_ARC700,  NONE, bpu_flush)
+DEF(0xf,   ARC_OPCODE_ARCv2HS, NONE, debugi)
+DEF(0x10,  ARC_OPCODE_ARCV1,   NONE, ivic)
+DEF(0x10,  ARC_OPCODE_ARCALL,  NONE, ic_ivic)
+DEF(0x11,  ARC_OPCODE_ARCV1,   NONE, che_mode)
+DEF(0x11,  ARC_OPCODE_ARCALL,  NONE, ic_ctrl)
+DEF(0x12,  ARC_OPCODE_ARC600,  NONE, mulhi)
+DEF(0x12,  ARC_OPCODE_ARCv2HS, NONE, ic_startr)
+DEF(0x13,  ARC_OPCODE_ARCV1,   NONE, lockline)
+DEF(0x13,  ARC_OPCODE_ARCV2,   NONE, ic_lil)
+DEF(0x14,  ARC_OPCODE_ARC600,  NONE, dmc_code_ram)
+DEF(0x15,  ARC_OPCODE_ARCV1,   NONE, tag_addr_mask)
+DEF(0x16,  ARC_OPCODE_ARCV1,   NONE, tag_data_mask)
+DEF(0x16,  ARC_OPCODE_ARCv2HS, NONE, ic_ivir)
+DEF(0x17,  ARC_OPCODE_ARCV1,   NONE, line_length_mask)
+DEF(0x17,  ARC_OPCODE_ARCv2HS, NONE, ic_endr)
+DEF(0x18,  ARC_OPCODE_ARC600,  NONE, aux_ldst_ram)
+DEF(0x18,  ARC_OPCODE_NONE,    NONE, aux_dccm)
+DEF(0x19,  ARC_OPCODE_ARCV1,   NONE, unlockline)
+DEF(0x19,  ARC_OPCODE_ARCALL,  NONE, ic_ivil)
+DEF(0x1a,  ARC_OPCODE_ARCALL,  NONE, ic_ram_address)
+DEF(0x1b,  ARC_OPCODE_ARCALL,  NONE, ic_tag)
+DEF(0x1c,  ARC_OPCODE_ARCALL,  NONE, ic_wp)
+DEF(0x1d,  ARC_OPCODE_ARCALL,  NONE, ic_data)
+DEF(0x1e,  ARC_OPCODE_ARCALL,  NONE, ic_ptag)
+DEF(0x1f,  ARC_OPCODE_ARCv2EM, NONE, debugi)
+DEF(0x1f,  ARC_OPCODE_ARCv2HS, NONE, ic_ptag_hi)
+DEF(0x20,  ARC_OPCODE_ARC600,  NONE, sram_seq)
+DEF(0x21,  ARC_OPCODE_ARCALL,  NONE, count0)
+DEF(0x22,  ARC_OPCODE_ARCALL,  NONE, control0)
+DEF(0x23,  ARC_OPCODE_ARCALL,  NONE, limit0)
+DEF(0x24,  ARC_OPCODE_ARCV1,   NONE, pcport)
+DEF(0x25,  ARC_OPCODE_ARC700,  NONE, int_vector_base)
+DEF(0x25,  ARC_OPCODE_ARCV2,   NONE, int_vector_base)
+DEF(0x26,  ARC_OPCODE_ARC600,  NONE, aux_vbfdw_mode)
+DEF(0x27,  ARC_OPCODE_ARC600,  NONE, aux_vbfdw_bm0)
+DEF(0x28,  ARC_OPCODE_ARC600,  NONE, aux_vbfdw_bm1)
+DEF(0x29,  ARC_OPCODE_ARC600,  NONE, aux_vbfdw_accu)
+DEF(0x2a,  ARC_OPCODE_ARC600,  NONE, aux_vbfdw_ofst)
+DEF(0x2b,  ARC_OPCODE_ARC600,  NONE, aux_vbfdw_intstat)
+DEF(0x2c,  ARC_OPCODE_ARC600,  NONE, aux_xmac0_24)
+DEF(0x2d,  ARC_OPCODE_ARC600,  NONE, aux_xmac1_24)
+DEF(0x2e,  ARC_OPCODE_ARC600,  NONE, aux_xmac2_24)
+DEF(0x2f,  ARC_OPCODE_ARC600,  NONE, aux_fbf_store_16)
+DEF(0x30,  ARC_OPCODE_ARCv2EM, NONE, acg_ctrl)
+DEF(0x30,  ARC_OPCODE_NONE,    NONE, ax0)
+DEF(0x31,  ARC_OPCODE_NONE,    NONE, ax1)
+DEF(0x32,  ARC_OPCODE_NONE,    NONE, aux_crc_poly)
+DEF(0x33,  ARC_OPCODE_NONE,    NONE, aux_crc_mode)
+DEF(0x34,  ARC_OPCODE_NONE,    NONE, mx0)
+DEF(0x35,  ARC_OPCODE_NONE,    NONE, mx1)
+DEF(0x36,  ARC_OPCODE_NONE,    NONE, my0)
+DEF(0x37,  ARC_OPCODE_NONE,    NONE, my1)
+DEF(0x38,  ARC_OPCODE_NONE,    NONE, xyconfig)
+DEF(0x38,  ARC_OPCODE_ARCv2EM, NONE, aux_kernel_sp)
+DEF(0x39,  ARC_OPCODE_NONE,    NONE, scratch_a)
+DEF(0x39,  ARC_OPCODE_ARCv2EM, NONE, aux_sec_u_sp)
+/* TODO: The commented lines are repeated for specific configurations. */
+/*
+DEF (0x3a,  ARC_OPCODE_NONE,    NONE, burstsys)
+DEF (0x3a,  ARC_OPCODE_NONE,    NONE, tsch)
+*/
+DEF(0x3a,  ARC_OPCODE_ARCv2EM, NONE, aux_sec_k_sp)
+DEF(0x3b,  ARC_OPCODE_NONE,    NONE, burstxym)
+DEF(0x3c,  ARC_OPCODE_NONE,    NONE, burstsz)
+DEF(0x3d,  ARC_OPCODE_NONE,    NONE, burstval)
+DEF(0x3e,  ARC_OPCODE_ARCv2EM, NONE, aux_sec_ctrl)
+DEF(0x3f,  ARC_OPCODE_ARCv2EM, NONE, erp_control)
+DEF(0x40,  ARC_OPCODE_ARCv2EM, NONE, rferp_status0)
+DEF(0x41,  ARC_OPCODE_ARCv2EM, NONE, rferp_status1)
+DEF(0x40,  ARC_OPCODE_ARC600,  NONE, xtp_newval)
+DEF(0x41,  ARC_OPCODE_ARCV1,   NONE, aux_macmode)
+DEF(0x42,  ARC_OPCODE_ARC600,  NONE, lsp_newval)
+DEF(0x43,  ARC_OPCODE_ARCV1,   NONE, aux_irq_lv12)
+DEF(0x43,  ARC_OPCODE_ARCV2,   NONE, aux_irq_act)
+DEF(0x44,  ARC_OPCODE_ARCV1,   NONE, aux_xmac0)
+DEF(0x45,  ARC_OPCODE_ARCV1,   NONE, aux_xmac1)
+DEF(0x46,  ARC_OPCODE_ARCV1,   NONE, aux_xmac2)
+DEF(0x47,  ARC_OPCODE_ARCALL,  NONE, dc_ivdc)
+DEF(0x48,  ARC_OPCODE_ARCALL,  NONE, dc_ctrl)
+DEF(0x49,  ARC_OPCODE_ARCALL,  NONE, dc_ldl)
+DEF(0x4a,  ARC_OPCODE_ARCALL,  NONE, dc_ivdl)
+DEF(0x4b,  ARC_OPCODE_ARCALL,  NONE, dc_flsh)
+DEF(0x4c,  ARC_OPCODE_ARCALL,  NONE, dc_fldl)
+DEF(0x4d,  ARC_OPCODE_ARCV2,   NONE, dc_startr)
+DEF(0x4e,  ARC_OPCODE_ARCV2,   NONE, dc_endr)
+DEF(0x50,  ARC_OPCODE_NONE,    NONE, hexdata)
+DEF(0x51,  ARC_OPCODE_NONE,    NONE, hexctrl)
+DEF(0x52,  ARC_OPCODE_NONE,    NONE, led)
+DEF(0x56,  ARC_OPCODE_NONE,    NONE, dilstat)
+DEF(0x57,  ARC_OPCODE_ARC600,  NONE, swstat)
+DEF(0x58,  ARC_OPCODE_ARCALL,  NONE, dc_ram_addr)
+DEF(0x59,  ARC_OPCODE_ARCALL,  NONE, dc_tag)
+DEF(0x5a,  ARC_OPCODE_ARCALL,  NONE, dc_wp)
+DEF(0x5b,  ARC_OPCODE_ARCALL,  NONE, dc_data)
+DEF(0x5c,  ARC_OPCODE_ARCALL,  NONE, dc_ptag)
+DEF(0x5e,  ARC_OPCODE_ARCv2HS, NONE, aux_volatile)
+DEF(0x5f,  ARC_OPCODE_ARCv2HS, NONE, dc_ptag_hi)
+DEF(0x80,  ARC_OPCODE_ARCALL,  NONE, ax0)
+DEF(0x81,  ARC_OPCODE_ARCALL,  NONE, ax1)
+DEF(0x82,  ARC_OPCODE_ARCALL,  NONE, ax2)
+DEF(0x83,  ARC_OPCODE_ARCALL,  NONE, ax3)
+DEF(0x84,  ARC_OPCODE_ARCALL,  NONE, ay0)
+DEF(0x85,  ARC_OPCODE_ARCALL,  NONE, ay1)
+DEF(0x86,  ARC_OPCODE_ARCALL,  NONE, ay2)
+DEF(0x87,  ARC_OPCODE_ARCALL,  NONE, ay3)
+DEF(0x88,  ARC_OPCODE_ARCALL,  NONE, mx00)
+DEF(0x89,  ARC_OPCODE_ARCALL,  NONE, mx01)
+DEF(0x8a,  ARC_OPCODE_ARCALL,  NONE, mx10)
+DEF(0x8b,  ARC_OPCODE_ARCALL,  NONE, mx11)
+DEF(0x8c,  ARC_OPCODE_ARCALL,  NONE, mx20)
+DEF(0x8d,  ARC_OPCODE_ARCALL,  NONE, mx21)
+DEF(0x8e,  ARC_OPCODE_ARCALL,  NONE, mx30)
+DEF(0x8f,  ARC_OPCODE_ARCALL,  NONE, mx31)
+DEF(0x90,  ARC_OPCODE_ARCALL,  NONE, my00)
+DEF(0x91,  ARC_OPCODE_ARCALL,  NONE, my01)
+DEF(0x92,  ARC_OPCODE_ARCALL,  NONE, my10)
+DEF(0x93,  ARC_OPCODE_ARCALL,  NONE, my11)
+DEF(0x94,  ARC_OPCODE_ARCALL,  NONE, my20)
+DEF(0x95,  ARC_OPCODE_ARCALL,  NONE, my21)
+DEF(0x96,  ARC_OPCODE_ARCALL,  NONE, my30)
+DEF(0x97,  ARC_OPCODE_ARCALL,  NONE, my31)
+DEF(0x98,  ARC_OPCODE_ARCALL,  NONE, xyconfig)
+DEF(0x99,  ARC_OPCODE_ARCALL,  NONE, burstsys)
+DEF(0x9a,  ARC_OPCODE_ARCALL,  NONE, burstxym)
+DEF(0x9b,  ARC_OPCODE_ARCALL,  NONE, burstsz)
+DEF(0x9c,  ARC_OPCODE_ARCALL,  NONE, burstval)
+DEF(0x9d,  ARC_OPCODE_ARCALL,  NONE, xylsbasex)
+DEF(0x9e,  ARC_OPCODE_ARCALL,  NONE, xylsbasey)
+DEF(0x9f,  ARC_OPCODE_ARCALL,  NONE, aux_xmaclw_h)
+DEF(0xa0,  ARC_OPCODE_ARCALL,  NONE, aux_xmaclw_l)
+DEF(0xa1,  ARC_OPCODE_ARCALL,  NONE, se_ctrl)
+DEF(0xa2,  ARC_OPCODE_ARCALL,  NONE, se_stat)
+DEF(0xa3,  ARC_OPCODE_ARCALL,  NONE, se_err)
+DEF(0xa4,  ARC_OPCODE_ARCALL,  NONE, se_eadr)
+DEF(0xa5,  ARC_OPCODE_ARCALL,  NONE, se_spc)
+DEF(0xa6,  ARC_OPCODE_ARCALL,  NONE, sdm_base)
+DEF(0xa7,  ARC_OPCODE_ARCALL,  NONE, scm_base)
+DEF(0xa8,  ARC_OPCODE_ARCALL,  NONE, se_dbg_ctrl)
+DEF(0xa9,  ARC_OPCODE_ARCALL,  NONE, se_dbg_data0)
+DEF(0xaa,  ARC_OPCODE_ARCALL,  NONE, se_dbg_data1)
+DEF(0xab,  ARC_OPCODE_ARCALL,  NONE, se_dbg_data2)
+DEF(0xac,  ARC_OPCODE_ARCALL,  NONE, se_dbg_data3)
+DEF(0xad,  ARC_OPCODE_ARCALL,  NONE, se_watch)
+DEF(0x100, ARC_OPCODE_ARCALL,  NONE, count1)
+DEF(0x101, ARC_OPCODE_ARCALL,  NONE, control1)
+DEF(0x102, ARC_OPCODE_ARCALL,  NONE, limit1)
+DEF(0x103, ARC_OPCODE_ARCV2,   NONE, aux_rtc_ctrl)
+DEF(0x104, ARC_OPCODE_ARCV2,   NONE, aux_rtc_low)
+DEF(0x105, ARC_OPCODE_ARCV2,   NONE, aux_rtc_high)
+DEF(0x200, ARC_OPCODE_ARCV1,   NONE, aux_irq_lev)
+DEF(0x200, ARC_OPCODE_ARCV2,   NONE, irq_priority_pending)
+DEF(0x201, ARC_OPCODE_ARCALL,  NONE, aux_irq_hint)
+DEF(0x202, ARC_OPCODE_ARC600,  NONE, aux_inter_core_interrupt)
+DEF(0x206, ARC_OPCODE_ARCV2,   NONE, irq_priority)
+DEF(0x210, ARC_OPCODE_ARC700,  NONE, aes_aux_0)
+DEF(0x211, ARC_OPCODE_ARC700,  NONE, aes_aux_1)
+DEF(0x212, ARC_OPCODE_ARC700,  NONE, aes_aux_2)
+DEF(0x213, ARC_OPCODE_ARC700,  NONE, aes_crypt_mode)
+DEF(0x214, ARC_OPCODE_ARC700,  NONE, aes_auxs)
+DEF(0x215, ARC_OPCODE_ARC700,  NONE, aes_auxi)
+DEF(0x216, ARC_OPCODE_ARC700,  NONE, aes_aux_3)
+DEF(0x217, ARC_OPCODE_ARC700,  NONE, aes_aux_4)
+DEF(0x218, ARC_OPCODE_ARC700,  NONE, arith_ctl_aux)
+DEF(0x219, ARC_OPCODE_ARC700,  NONE, des_aux)
+DEF(0x220, ARC_OPCODE_ARCALL,  NONE, ap_amv0)
+DEF(0x221, ARC_OPCODE_ARCALL,  NONE, ap_amm0)
+DEF(0x222, ARC_OPCODE_ARCALL,  NONE, ap_ac0)
+DEF(0x223, ARC_OPCODE_ARCALL,  NONE, ap_amv1)
+DEF(0x224, ARC_OPCODE_ARCALL,  NONE, ap_amm1)
+DEF(0x225, ARC_OPCODE_ARCALL,  NONE, ap_ac1)
+DEF(0x226, ARC_OPCODE_ARCALL,  NONE, ap_amv2)
+DEF(0x227, ARC_OPCODE_ARCALL,  NONE, ap_amm2)
+DEF(0x228, ARC_OPCODE_ARCALL,  NONE, ap_ac2)
+DEF(0x229, ARC_OPCODE_ARCALL,  NONE, ap_amv3)
+DEF(0x22a, ARC_OPCODE_ARCALL,  NONE, ap_amm3)
+DEF(0x22b, ARC_OPCODE_ARCALL,  NONE, ap_ac3)
+DEF(0x22c, ARC_OPCODE_ARCALL,  NONE, ap_amv4)
+DEF(0x22d, ARC_OPCODE_ARCALL,  NONE, ap_amm4)
+DEF(0x22e, ARC_OPCODE_ARCALL,  NONE, ap_ac4)
+DEF(0x22f, ARC_OPCODE_ARCALL,  NONE, ap_amv5)
+DEF(0x230, ARC_OPCODE_ARCALL,  NONE, ap_amm5)
+DEF(0x231, ARC_OPCODE_ARCALL,  NONE, ap_ac5)
+DEF(0x232, ARC_OPCODE_ARCALL,  NONE, ap_amv6)
+DEF(0x233, ARC_OPCODE_ARCALL,  NONE, ap_amm6)
+DEF(0x234, ARC_OPCODE_ARCALL,  NONE, ap_ac6)
+DEF(0x235, ARC_OPCODE_ARCALL,  NONE, ap_amv7)
+DEF(0x236, ARC_OPCODE_ARCALL,  NONE, ap_amm7)
+DEF(0x237, ARC_OPCODE_ARCALL,  NONE, ap_ac7)
+DEF(0x268, ARC_OPCODE_ARCv2EM, NONE, nsc_table_top)
+DEF(0x269, ARC_OPCODE_ARCv2EM, NONE, nsc_table_base)
+DEF(0x290, ARC_OPCODE_ARCV2,   NONE, jli_base)
+DEF(0x291, ARC_OPCODE_ARCV2,   NONE, ldi_base)
+DEF(0x292, ARC_OPCODE_ARCV2,   NONE, ei_base)
+DEF(0x300, ARC_OPCODE_ARCFPX,  DPX,  fp_status)
+/*
+DEF (0x301, ARC_OPCODE_ARCFPX,  DPX,  aux_dpfp1l)
+DEF (0x301, ARC_OPCODE_ARCFPX,  DPX,  d1l)
+*/
+/*
+DEF (0x302, ARC_OPCODE_ARCFPX,  DPX,  aux_dpfp1h)
+DEF (0x302, ARC_OPCODE_ARCFPX,  DPX,  d1h)
+*/
+DEF(0x302, ARC_OPCODE_ARCv2EM, DPA,  d1l)
+/*
+DEF (0x303, ARC_OPCODE_ARCFPX,  DPX,  aux_dpfp2l)
+DEF (0x303, ARC_OPCODE_ARCFPX,  DPX,  d2l)
+*/
+DEF(0x303, ARC_OPCODE_ARCv2EM, DPA,  d1h)
+/*
+DEF (0x304, ARC_OPCODE_ARCFPX,  DPX,  aux_dpfp2h)
+DEF (0x304, ARC_OPCODE_ARCFPX,  DPX,  d2h)
+*/
+DEF(0x304, ARC_OPCODE_ARCv2EM, DPA,  d2l)
+DEF(0x305, ARC_OPCODE_ARCFPX,  DPX,  dpfp_status)
+DEF(0x305, ARC_OPCODE_ARCv2EM, DPA,  d2h)
+DEF(0x400, ARC_OPCODE_ARCALL,  NONE, eret)
+DEF(0x401, ARC_OPCODE_ARCALL,  NONE, erbta)
+DEF(0x402, ARC_OPCODE_ARCALL,  NONE, erstatus)
+DEF(0x403, ARC_OPCODE_ARCALL,  NONE, ecr)
+DEF(0x404, ARC_OPCODE_ARCALL,  NONE, efa)
+DEF(0x405, ARC_OPCODE_ARC700,  NONE, tlbpd0)
+DEF(0x406, ARC_OPCODE_ARC700,  NONE, tlbpd1)
+DEF(0x406, ARC_OPCODE_ARCv2EM, NONE, ersec_stat)
+DEF(0x407, ARC_OPCODE_ARCv2EM, NONE, aux_sec_except)
+DEF(0x407, ARC_OPCODE_ARC700,  NONE, tlbindex)
+DEF(0x408, ARC_OPCODE_ARC700,  NONE, tlbcommand)
+DEF(0x409, ARC_OPCODE_ARC700,  NONE, pid)
+DEF(0x409, ARC_OPCODE_ARCALL,  NONE, mpuen)
+DEF(0x40a, ARC_OPCODE_ARCV2,   NONE, icause)
+DEF(0x40b, ARC_OPCODE_ARCV2,   NONE, irq_select)
+DEF(0x40c, ARC_OPCODE_ARCV2,   NONE, irq_enable)
+DEF(0x40d, ARC_OPCODE_ARCV2,   NONE, irq_trigger)
+DEF(0x40f, ARC_OPCODE_ARCV2,   NONE, irq_status)
+DEF(0x410, ARC_OPCODE_ARCALL,  NONE, xpu)
+DEF(0x412, ARC_OPCODE_ARCALL,  NONE, bta)
+DEF(0x413, ARC_OPCODE_ARC700,  NONE, bta_l1)
+DEF(0x414, ARC_OPCODE_ARC700,  NONE, bta_l2)
+DEF(0x415, ARC_OPCODE_ARCV2,   NONE, irq_pulse_cancel)
+DEF(0x416, ARC_OPCODE_ARCV2,   NONE, irq_pending)
+DEF(0x418, ARC_OPCODE_ARC700,  NONE, scratch_data0)
+DEF(0x420, ARC_OPCODE_ARCALL,  NONE, mpuic)
+DEF(0x421, ARC_OPCODE_ARCALL,  NONE, mpufa)
+DEF(0x422, ARC_OPCODE_ARCALL,  NONE, mpurdb0)
+DEF(0x423, ARC_OPCODE_ARCALL,  NONE, mpurdp0)
+DEF(0x424, ARC_OPCODE_ARCALL,  NONE, mpurdb1)
+DEF(0x425, ARC_OPCODE_ARCALL,  NONE, mpurdp1)
+DEF(0x426, ARC_OPCODE_ARCALL,  NONE, mpurdb2)
+DEF(0x427, ARC_OPCODE_ARCALL,  NONE, mpurdp2)
+DEF(0x428, ARC_OPCODE_ARCALL,  NONE, mpurdb3)
+DEF(0x429, ARC_OPCODE_ARCALL,  NONE, mpurdp3)
+DEF(0x42a, ARC_OPCODE_ARCALL,  NONE, mpurdb4)
+DEF(0x42b, ARC_OPCODE_ARCALL,  NONE, mpurdp4)
+DEF(0x42c, ARC_OPCODE_ARCALL,  NONE, mpurdb5)
+DEF(0x42d, ARC_OPCODE_ARCALL,  NONE, mpurdp5)
+DEF(0x42e, ARC_OPCODE_ARCALL,  NONE, mpurdb6)
+DEF(0x42f, ARC_OPCODE_ARCALL,  NONE, mpurdp6)
+DEF(0x430, ARC_OPCODE_ARCALL,  NONE, mpurdb7)
+DEF(0x431, ARC_OPCODE_ARCALL,  NONE, mpurdp7)
+DEF(0x432, ARC_OPCODE_ARCALL,  NONE, mpurdb8)
+DEF(0x433, ARC_OPCODE_ARCALL,  NONE, mpurdp8)
+DEF(0x434, ARC_OPCODE_ARCALL,  NONE, mpurdb9)
+DEF(0x435, ARC_OPCODE_ARCALL,  NONE, mpurdp9)
+DEF(0x436, ARC_OPCODE_ARCALL,  NONE, mpurdb10)
+DEF(0x437, ARC_OPCODE_ARCALL,  NONE, mpurdp10)
+DEF(0x438, ARC_OPCODE_ARCALL,  NONE, mpurdb11)
+DEF(0x439, ARC_OPCODE_ARCALL,  NONE, mpurdp11)
+DEF(0x43a, ARC_OPCODE_ARCALL,  NONE, mpurdb12)
+DEF(0x43b, ARC_OPCODE_ARCALL,  NONE, mpurdp12)
+DEF(0x43c, ARC_OPCODE_ARCALL,  NONE, mpurdb13)
+DEF(0x43d, ARC_OPCODE_ARCALL,  NONE, mpurdp13)
+DEF(0x43e, ARC_OPCODE_ARCALL,  NONE, mpurdb14)
+DEF(0x43f, ARC_OPCODE_ARCALL,  NONE, mpurdp14)
+DEF(0x440, ARC_OPCODE_ARCALL,  NONE, mpurdb15)
+DEF(0x441, ARC_OPCODE_ARCALL,  NONE, mpurdp15)
+DEF(0x450, ARC_OPCODE_ARC600,  NONE, pm_status)
+DEF(0x451, ARC_OPCODE_ARC600,  NONE, wake)
+DEF(0x452, ARC_OPCODE_ARC600,  NONE, dvfs_performance)
+DEF(0x453, ARC_OPCODE_ARC600,  NONE, pwr_ctrl)
+DEF(0x460, ARC_OPCODE_ARCv2HS, NONE, tlbpd0)
+DEF(0x461, ARC_OPCODE_ARCv2HS, NONE, tlbpd1)
+DEF(0x463, ARC_OPCODE_ARCv2HS, NONE, tlbpd1_hi)
+DEF(0x464, ARC_OPCODE_ARCv2HS, NONE, tlbindex)
+DEF(0x465, ARC_OPCODE_ARCv2HS, NONE, tlbcommand)
+DEF(0x468, ARC_OPCODE_ARCv2HS, NONE, pid)
+DEF(0x46a, ARC_OPCODE_ARCv2HS, NONE, sasid0)
+DEF(0x46b, ARC_OPCODE_ARCv2HS, NONE, sasid1)
+DEF(0x46c, ARC_OPCODE_ARCv2HS, NONE, scratch_data0)
+DEF(0x500, ARC_OPCODE_ARC700,  NONE, aux_vlc_buf_idx)
+DEF(0x501, ARC_OPCODE_ARC700,  NONE, aux_vlc_read_buf)
+DEF(0x502, ARC_OPCODE_ARC700,  NONE, aux_vlc_valid_bits)
+DEF(0x503, ARC_OPCODE_ARC700,  NONE, aux_vlc_buf_in)
+DEF(0x504, ARC_OPCODE_ARC700,  NONE, aux_vlc_buf_free)
+DEF(0x505, ARC_OPCODE_ARC700,  NONE, aux_vlc_ibuf_status)
+DEF(0x506, ARC_OPCODE_ARC700,  NONE, aux_vlc_setup)
+DEF(0x507, ARC_OPCODE_ARC700,  NONE, aux_vlc_bits)
+DEF(0x508, ARC_OPCODE_ARC700,  NONE, aux_vlc_table)
+DEF(0x509, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_symbol)
+DEF(0x50a, ARC_OPCODE_ARC700,  NONE, aux_vlc_read_symbol)
+DEF(0x510, ARC_OPCODE_ARC700,  NONE, aux_ucavlc_setup)
+DEF(0x511, ARC_OPCODE_ARC700,  NONE, aux_ucavlc_state)
+DEF(0x512, ARC_OPCODE_ARC700,  NONE, aux_cavlc_zero_left)
+DEF(0x514, ARC_OPCODE_ARC700,  NONE, aux_uvlc_i_state)
+DEF(0x51c, ARC_OPCODE_ARC700,  NONE, aux_vlc_dma_ptr)
+DEF(0x51d, ARC_OPCODE_ARC700,  NONE, aux_vlc_dma_end)
+DEF(0x51e, ARC_OPCODE_ARC700,  NONE, aux_vlc_dma_esc)
+DEF(0x51f, ARC_OPCODE_ARC700,  NONE, aux_vlc_dma_ctrl)
+DEF(0x520, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_0bit)
+DEF(0x521, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_1bit)
+DEF(0x522, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_2bit)
+DEF(0x523, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_3bit)
+DEF(0x524, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_4bit)
+DEF(0x525, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_5bit)
+DEF(0x526, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_6bit)
+DEF(0x527, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_7bit)
+DEF(0x528, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_8bit)
+DEF(0x529, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_9bit)
+DEF(0x52a, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_10bit)
+DEF(0x52b, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_11bit)
+DEF(0x52c, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_12bit)
+DEF(0x52d, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_13bit)
+DEF(0x52e, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_14bit)
+DEF(0x52f, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_15bit)
+DEF(0x530, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_16bit)
+DEF(0x531, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_17bit)
+DEF(0x532, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_18bit)
+DEF(0x533, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_19bit)
+DEF(0x534, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_20bit)
+DEF(0x535, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_21bit)
+DEF(0x536, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_22bit)
+DEF(0x537, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_23bit)
+DEF(0x538, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_24bit)
+DEF(0x539, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_25bit)
+DEF(0x53a, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_26bit)
+DEF(0x53b, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_27bit)
+DEF(0x53c, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_28bit)
+DEF(0x53d, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_29bit)
+DEF(0x53e, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_30bit)
+DEF(0x53f, ARC_OPCODE_ARC700,  NONE, aux_vlc_get_31bit)
+DEF(0x540, ARC_OPCODE_ARC700,  NONE, aux_cabac_ctrl)
+DEF(0x541, ARC_OPCODE_ARC700,  NONE, aux_cabac_ctx_state)
+DEF(0x542, ARC_OPCODE_ARC700,  NONE, aux_cabac_cod_param)
+DEF(0x543, ARC_OPCODE_ARC700,  NONE, aux_cabac_misc0)
+DEF(0x544, ARC_OPCODE_ARC700,  NONE, aux_cabac_misc1)
+DEF(0x545, ARC_OPCODE_ARC700,  NONE, aux_cabac_misc2)
+DEF(0x700, ARC_OPCODE_ARCALL,  NONE, smart_control)
+/*
+DEF (0x701, ARC_OPCODE_ARC700,  NONE, smart_data_0)
+DEF (0x701, ARC_OPCODE_ARC600,  NONE, smart_data)
+DEF (0x701, ARC_OPCODE_ARC700,  NONE, smart_data_2)
+DEF (0x701, ARC_OPCODE_ARC700,  NONE, smart_data_3)
+*/
+
+
+/* BCR aux registers */
+DEF(0x60, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x61, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x62, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x63, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x64, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x65, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x66, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x67, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x68, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x69, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x6a, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x6b, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x6c, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x6d, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x6e, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x6f, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x70, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x71, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x72, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x73, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x74, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x75, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x76, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x77, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x78, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x79, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x7a, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x7c, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x7d, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x7e, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0x7f, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xc0, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xc1, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xc2, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xc3, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xc4, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xc5, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xc6, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xc7, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xc8, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xc9, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xca, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xcb, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xcc, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xcd, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xce, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xcf, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xd0, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xd1, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xd2, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xd3, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xd4, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xd5, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xd6, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xd7, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xd8, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xd9, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xda, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xdb, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xdc, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xdd, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xde, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xdf, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xe0, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xe1, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xe2, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xe3, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xe4, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xe5, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xe6, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xe7, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xe8, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xe9, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xea, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xeb, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xec, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xed, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xee, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xef, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xf0, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xf1, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xf2, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xf3, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xf4, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xf5, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xf6, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xf7, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xf8, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xf9, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xfa, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xfb, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xfc, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xfd, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xfe, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+DEF(0xff, ARC_OPCODE_DEFAULT,  NONE, unimp_bcr)
+
+/* Actual BCR implementations */
+
+DEF(0x6d, ARC_OPCODE_ARCv2HS,  NONE, mpu_build)
+DEF(0x6f, ARC_OPCODE_ARCv2HS,  NONE, mmu_build)
+DEF(0x75,  ARC_OPCODE_ARCALL,  NONE, timer_build)
+DEF(0xf3,  ARC_OPCODE_ARCV2,   NONE, irq_build)
+DEF(0x72, ARC_OPCODE_ARCV2,    NONE, d_cache_build)
+DEF(0x77, ARC_OPCODE_ARCV2,    NONE, i_cache_build)
+DEF(0x7b, ARC_OPCODE_ARCV2,    NONE, mpy_build)
+
+/* OLD BCR definitions */
+/*
+DEF (0x61,  ARC_OPCODE_ARCALL,  NONE, dccm_base_build)
+DEF (0x63,  ARC_OPCODE_ARCALL,  NONE, bta_link_build)
+DEF (0x64,  ARC_OPCODE_ARCALL,  NONE, vbfdw_build)
+DEF (0x65,  ARC_OPCODE_ARCALL,  NONE, ea_build)
+DEF (0x66,  ARC_OPCODE_ARCALL,  NONE, dataspace)
+DEF (0x67,  ARC_OPCODE_ARCALL,  NONE, memsubsys)
+DEF (0x68,  ARC_OPCODE_ARCALL,  NONE, vecbase_ac_build)
+DEF (0x69,  ARC_OPCODE_ARCALL,  NONE, p_base_addr)
+DEF (0x6a,  ARC_OPCODE_ARCALL,  NONE, data_uncached_build)
+DEF (0x6b,  ARC_OPCODE_ARCALL,  NONE, fp_build)
+DEF (0x6c,  ARC_OPCODE_ARCALL,  NONE, dpfp_build)
+DEF (0x6d,  ARC_OPCODE_ARCALL,  NONE, mpu_build)
+DEF (0x6e,  ARC_OPCODE_ARCALL,  NONE, rf_build)
+DEF (0x6f,  ARC_OPCODE_ARCALL,  NONE, mmu_build)
+DEF (0x70,  ARC_OPCODE_ARCv2EM, NONE, sec_vecbase_build)
+DEF (0x71,  ARC_OPCODE_ARCALL,  NONE, vecbase_build)
+DEF (0x73,  ARC_OPCODE_ARCALL,  NONE, madi_build)
+
+DEF (0xc1,  ARC_OPCODE_ARC600,  NONE, arc600_build_config)
+DEF (0xc2,  ARC_OPCODE_ARCALL,  NONE, isa_config)
+DEF (0xf4,  ARC_OPCODE_ARCALL,  NONE, hwp_build)
+DEF (0xf5,  ARC_OPCODE_ARCALL,  NONE, pct_build)
+DEF (0xf6,  ARC_OPCODE_ARCALL,  NONE, cc_build)
+DEF (0xf7,  ARC_OPCODE_ARCALL,  NONE, pm_bcr)
+DEF (0xf8,  ARC_OPCODE_ARCALL,  NONE, scq_switch_build)
+DEF (0xf9,  ARC_OPCODE_ARCALL,  NONE, vraptor_build)
+DEF (0xfa,  ARC_OPCODE_ARCALL,  NONE, dma_config)
+DEF (0xfb,  ARC_OPCODE_ARCALL,  NONE, simd_config)
+DEF (0xfc,  ARC_OPCODE_ARCALL,  NONE, vlc_build)
+DEF (0xfd,  ARC_OPCODE_ARCALL,  NONE, simd_dma_build)
+DEF (0xfe,  ARC_OPCODE_ARCALL,  NONE, ifetch_queue_build)
+*/
diff --git a/target/arc/regs.c b/target/arc/regs.c
new file mode 100644
index 0000000000..f433f41b57
--- /dev/null
+++ b/target/arc/regs.c
@@ -0,0 +1,139 @@
+/*
+ * QEMU ARC CPU
+ *
+ * Copyright (c) 2018 Cupertino Miranda
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * http://www.gnu.org/licenses/lgpl-2.1.html
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "target/arc/regs.h"
+#include "target/arc/mmu.h"
+#include "target/arc/mpu.h"
+#include "target/arc/irq.h"
+#include "target/arc/timer.h"
+#include "target/arc/cache.h"
+
+struct arc_aux_reg_detail arc_aux_regs_detail[ARC_AUX_REGS_DETAIL_LAST] = {
+#define DEF(NUM, CPU, SUB, NAME) \
+  { \
+    NUM, \
+    CPU, \
+    SUB, \
+    AUX_ID_##NAME, \
+    #NAME, \
+    sizeof(#NAME) - 1, \
+    NULL, \
+    NULL, \
+  },
+#include "target/arc/regs-detail.def"
+#undef DEF
+};
+
+struct arc_aux_reg arc_aux_regs[ARC_AUX_REGS_LAST] = {
+#define AUX_REG(NAME, GET_FUNC, SET_FUNC) \
+  { \
+    NULL, \
+    GET_FUNC, \
+    SET_FUNC \
+  },
+#include "target/arc/regs.def"
+#undef AUX_REG
+};
+
+const char *arc_aux_reg_name[ARC_AUX_REGS_DETAIL_LAST] = {
+#define AUX_REG(NAME, GET, SET) #NAME,
+#include "target/arc/regs.def"
+#undef AUX_REG
+  "last_invalid_aux_reg"
+};
+
+
+void arc_aux_regs_init(void)
+{
+    int i;
+
+    for (i = 0; i < ARC_AUX_REGS_DETAIL_LAST; i++) {
+        enum arc_aux_reg_enum id = arc_aux_regs_detail[i].id;
+        struct arc_aux_reg_detail *next = arc_aux_regs[id].first;
+        arc_aux_regs_detail[i].next = next;
+        arc_aux_regs_detail[i].aux_reg = &(arc_aux_regs[id]);
+        arc_aux_regs[id].first = &(arc_aux_regs_detail[i]);
+    }
+}
+
+int
+arc_aux_reg_address_for(enum arc_aux_reg_enum aux_reg_def,
+                        int isa_mask)
+{
+    /* TODO: This must validate for CPU. */
+    struct arc_aux_reg_detail *detail = arc_aux_regs[aux_reg_def].first;
+    while (detail != NULL) {
+        if ((detail->cpu & isa_mask) != 0) {
+            return detail->address;
+        }
+        detail = detail->next;
+    }
+    assert(0);
+
+    /* We never get here but to accommodate -Werror ... */
+    return 0;
+}
+
+struct arc_aux_reg_detail *
+arc_aux_reg_struct_for_address(int address, int isa_mask)
+{
+    int i;
+    bool has_default = false;
+    struct arc_aux_reg_detail *default_ret = NULL;
+
+    /* TODO: Make this a binary search or something faster. */
+    for (i = 0; i < ARC_AUX_REGS_DETAIL_LAST; i++) {
+        if (arc_aux_regs_detail[i].address == address) {
+            if (arc_aux_regs_detail[i].cpu == ARC_OPCODE_DEFAULT) {
+                has_default = true;
+                default_ret = &(arc_aux_regs_detail[i]);
+            } else if ((arc_aux_regs_detail[i].cpu & isa_mask) != 0) {
+                return &(arc_aux_regs_detail[i]);
+            }
+        }
+    }
+
+    if (has_default == true) {
+        return default_ret;
+    }
+
+    return NULL;
+}
+
+uint32_t
+arc_regs_bcr_default_impl(const struct arc_aux_reg_detail *aux_reg,
+                          void *data)
+{
+    return 0;
+}
+
+/* TODO: Implement any non implemented auxs regs. */
+void TO_IMPLEMENT_SET(const struct arc_aux_reg_detail *aux_reg, uint32_t val,
+                      void *data)
+{
+    return;
+}
+uint32_t TO_IMPLEMENT_GET(const struct arc_aux_reg_detail *aux_reg, void *data)
+{
+    return 0;
+}
diff --git a/target/arc/regs.def b/target/arc/regs.def
new file mode 100644
index 0000000000..3d9bba84c4
--- /dev/null
+++ b/target/arc/regs.def
@@ -0,0 +1,399 @@
+/*
+ * QEMU ARC Auxiliary register definitions
+ * Copyright (C) 2020 Free Software Foundation, Inc.
+ *
+ * Contributed by Claudiu Zissulescu (claziss@synopsys.com)
+ * Contributed by Cupertino Miranda (cmiranda@synopsys.com)
+ *
+ * This file is part of libopcodes.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 3, NULL,
+ * NULL) any later version.
+ *
+ * It is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
+ * License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+
+AUX_REG (unimp_bcr, arc_regs_bcr_default_impl, NULL)
+AUX_REG (acg_ctrl, NULL, NULL)
+AUX_REG (acr, NULL, NULL)
+AUX_REG (adcr, NULL, NULL)
+AUX_REG (aes_aux_0, NULL, NULL)
+AUX_REG (aes_aux_1, NULL, NULL)
+AUX_REG (aes_aux_2, NULL, NULL)
+AUX_REG (aes_aux_3, NULL, NULL)
+AUX_REG (aes_aux_4, NULL, NULL)
+AUX_REG (aes_auxi, NULL, NULL)
+AUX_REG (aes_auxs, NULL, NULL)
+AUX_REG (aes_crypt_mode, NULL, NULL)
+AUX_REG (ap_ac0, NULL, NULL)
+AUX_REG (ap_ac1, NULL, NULL)
+AUX_REG (ap_ac2, NULL, NULL)
+AUX_REG (ap_ac3, NULL, NULL)
+AUX_REG (ap_ac4, NULL, NULL)
+AUX_REG (ap_ac5, NULL, NULL)
+AUX_REG (ap_ac6, NULL, NULL)
+AUX_REG (ap_ac7, NULL, NULL)
+AUX_REG (ap_amm0, NULL, NULL)
+AUX_REG (ap_amm1, NULL, NULL)
+AUX_REG (ap_amm2, NULL, NULL)
+AUX_REG (ap_amm3, NULL, NULL)
+AUX_REG (ap_amm4, NULL, NULL)
+AUX_REG (ap_amm5, NULL, NULL)
+AUX_REG (ap_amm6, NULL, NULL)
+AUX_REG (ap_amm7, NULL, NULL)
+AUX_REG (ap_amv0, NULL, NULL)
+AUX_REG (ap_amv1, NULL, NULL)
+AUX_REG (ap_amv2, NULL, NULL)
+AUX_REG (ap_amv3, NULL, NULL)
+AUX_REG (ap_amv4, NULL, NULL)
+AUX_REG (ap_amv5, NULL, NULL)
+AUX_REG (ap_amv6, NULL, NULL)
+AUX_REG (ap_amv7, NULL, NULL)
+AUX_REG (apcr, NULL, NULL)
+AUX_REG (arc600_build_config, NULL, NULL)
+AUX_REG (arith_ctl_aux, NULL, NULL)
+AUX_REG (aux_cabac_cod_param, NULL, NULL)
+AUX_REG (aux_cabac_ctrl, NULL, NULL)
+AUX_REG (aux_cabac_ctx_state, NULL, NULL)
+AUX_REG (aux_cabac_misc0, NULL, NULL)
+AUX_REG (aux_cabac_misc1, NULL, NULL)
+AUX_REG (aux_cabac_misc2, NULL, NULL)
+AUX_REG (aux_cavlc_zero_left, NULL, NULL)
+AUX_REG (aux_crc_mode, NULL, NULL)
+AUX_REG (aux_crc_poly, NULL, NULL)
+AUX_REG (aux_dccm, NULL, NULL)
+AUX_REG (aux_dpfp1h, NULL, NULL)
+AUX_REG (aux_dpfp1l, NULL, NULL)
+AUX_REG (aux_dpfp2h, NULL, NULL)
+AUX_REG (aux_dpfp2l, NULL, NULL)
+AUX_REG (aux_fbf_store_16, NULL, NULL)
+AUX_REG (aux_inter_core_interrupt, NULL, NULL)
+AUX_REG (irq_priority, aux_irq_get, aux_irq_set)
+AUX_REG (aux_irq_act, aux_irq_get, aux_irq_set)
+AUX_REG (aux_irq_hint, aux_irq_get, aux_irq_set)
+AUX_REG (aux_irq_lev, NULL, NULL)
+AUX_REG (aux_irq_lv12, NULL, NULL)
+AUX_REG (irq_pending, aux_irq_get, NULL)
+AUX_REG (irq_pulse_cancel, NULL, aux_irq_set)
+AUX_REG (aux_irq_ctrl, aux_irq_get, aux_irq_set)
+AUX_REG (aux_kernel_sp, NULL, NULL)
+AUX_REG (aux_ldst_ram, NULL, NULL)
+AUX_REG (aux_macmode, NULL, NULL)
+AUX_REG (aux_sec_ctrl, NULL, NULL)
+AUX_REG (aux_sec_except, NULL, NULL)
+AUX_REG (aux_sec_k_sp, NULL, NULL)
+AUX_REG (aux_sec_u_sp, NULL, NULL)
+AUX_REG (aux_ucavlc_setup, NULL, NULL)
+AUX_REG (aux_ucavlc_state, NULL, NULL)
+AUX_REG (aux_user_sp, aux_irq_get, aux_irq_set)
+AUX_REG (aux_uvlc_i_state, NULL, NULL)
+AUX_REG (aux_vbfdw_accu, NULL, NULL)
+AUX_REG (aux_vbfdw_bm0, NULL, NULL)
+AUX_REG (aux_vbfdw_bm1, NULL, NULL)
+AUX_REG (aux_vbfdw_intstat, NULL, NULL)
+AUX_REG (aux_vbfdw_mode, NULL, NULL)
+AUX_REG (aux_vbfdw_ofst, NULL, NULL)
+AUX_REG (aux_volatile, NULL, NULL)
+AUX_REG (aux_vlc_bits, NULL, NULL)
+AUX_REG (aux_vlc_buf_free, NULL, NULL)
+AUX_REG (aux_vlc_buf_idx, NULL, NULL)
+AUX_REG (aux_vlc_buf_in, NULL, NULL)
+AUX_REG (aux_vlc_dma_ctrl, NULL, NULL)
+AUX_REG (aux_vlc_dma_end, NULL, NULL)
+AUX_REG (aux_vlc_dma_esc, NULL, NULL)
+AUX_REG (aux_vlc_dma_ptr, NULL, NULL)
+AUX_REG (aux_vlc_get_0bit, NULL, NULL)
+AUX_REG (aux_vlc_get_10bit, NULL, NULL)
+AUX_REG (aux_vlc_get_11bit, NULL, NULL)
+AUX_REG (aux_vlc_get_12bit, NULL, NULL)
+AUX_REG (aux_vlc_get_13bit, NULL, NULL)
+AUX_REG (aux_vlc_get_14bit, NULL, NULL)
+AUX_REG (aux_vlc_get_15bit, NULL, NULL)
+AUX_REG (aux_vlc_get_16bit, NULL, NULL)
+AUX_REG (aux_vlc_get_17bit, NULL, NULL)
+AUX_REG (aux_vlc_get_18bit, NULL, NULL)
+AUX_REG (aux_vlc_get_19bit, NULL, NULL)
+AUX_REG (aux_vlc_get_1bit, NULL, NULL)
+AUX_REG (aux_vlc_get_20bit, NULL, NULL)
+AUX_REG (aux_vlc_get_21bit, NULL, NULL)
+AUX_REG (aux_vlc_get_22bit, NULL, NULL)
+AUX_REG (aux_vlc_get_23bit, NULL, NULL)
+AUX_REG (aux_vlc_get_24bit, NULL, NULL)
+AUX_REG (aux_vlc_get_25bit, NULL, NULL)
+AUX_REG (aux_vlc_get_26bit, NULL, NULL)
+AUX_REG (aux_vlc_get_27bit, NULL, NULL)
+AUX_REG (aux_vlc_get_28bit, NULL, NULL)
+AUX_REG (aux_vlc_get_29bit, NULL, NULL)
+AUX_REG (aux_vlc_get_2bit, NULL, NULL)
+AUX_REG (aux_vlc_get_30bit, NULL, NULL)
+AUX_REG (aux_vlc_get_31bit, NULL, NULL)
+AUX_REG (aux_vlc_get_3bit, NULL, NULL)
+AUX_REG (aux_vlc_get_4bit, NULL, NULL)
+AUX_REG (aux_vlc_get_5bit, NULL, NULL)
+AUX_REG (aux_vlc_get_6bit, NULL, NULL)
+AUX_REG (aux_vlc_get_7bit, NULL, NULL)
+AUX_REG (aux_vlc_get_8bit, NULL, NULL)
+AUX_REG (aux_vlc_get_9bit, NULL, NULL)
+AUX_REG (aux_vlc_get_symbol, NULL, NULL)
+AUX_REG (aux_vlc_ibuf_status, NULL, NULL)
+AUX_REG (aux_vlc_read_buf, NULL, NULL)
+AUX_REG (aux_vlc_read_symbol, NULL, NULL)
+AUX_REG (aux_vlc_setup, NULL, NULL)
+AUX_REG (aux_vlc_table, NULL, NULL)
+AUX_REG (aux_vlc_valid_bits, NULL, NULL)
+AUX_REG (aux_xmac0_24, NULL, NULL)
+AUX_REG (aux_xmac0, NULL, NULL)
+AUX_REG (aux_xmac1_24, NULL, NULL)
+AUX_REG (aux_xmac1, NULL, NULL)
+AUX_REG (aux_xmac2_24, NULL, NULL)
+AUX_REG (aux_xmac2, NULL, NULL)
+AUX_REG (aux_xmaclw_h, NULL, NULL)
+AUX_REG (aux_xmaclw_l, NULL, NULL)
+AUX_REG (ax0, NULL, NULL)
+AUX_REG (ax1, NULL, NULL)
+AUX_REG (ax2, NULL, NULL)
+AUX_REG (ax3, NULL, NULL)
+AUX_REG (ay0, NULL, NULL)
+AUX_REG (ay1, NULL, NULL)
+AUX_REG (ay2, NULL, NULL)
+AUX_REG (ay3, NULL, NULL)
+AUX_REG (bpu_flush, NULL, NULL)
+AUX_REG (bta_l1, NULL, NULL)
+AUX_REG (bta_l2, NULL, NULL)
+AUX_REG (bta_link_build, NULL, NULL)
+AUX_REG (bta, NULL, NULL)
+AUX_REG (burstsys, NULL, NULL)
+AUX_REG (burstsz, NULL, NULL)
+AUX_REG (burstval, NULL, NULL)
+AUX_REG (burstxym, NULL, NULL)
+AUX_REG (cc_build, NULL, NULL)
+AUX_REG (che_mode, NULL, NULL)
+AUX_REG (clk_enable, NULL, NULL)
+AUX_REG (control0, aux_timer_get, aux_timer_set)
+AUX_REG (control1, aux_timer_get, aux_timer_set)
+AUX_REG (count0, aux_timer_get, aux_timer_set)
+AUX_REG (count1, aux_timer_get, aux_timer_set)
+AUX_REG (d1h, NULL, NULL)
+AUX_REG (d1l, NULL, NULL)
+AUX_REG (d2h, NULL, NULL)
+AUX_REG (d2l, NULL, NULL)
+AUX_REG (dataspace, NULL, NULL)
+AUX_REG (data_uncached_build, NULL, NULL)
+AUX_REG (dccm_base_build, NULL, NULL)
+AUX_REG (d_cache_build, arc_cache_aux_get, NULL)
+AUX_REG (dc_ctrl, arc_cache_aux_get, arc_cache_aux_set)
+AUX_REG (dc_data, NULL, NULL)
+AUX_REG (dc_fldl, NULL, arc_cache_aux_set)
+AUX_REG (dc_flsh, NULL, arc_cache_aux_set)
+AUX_REG (dc_ivdc, NULL, arc_cache_aux_set)
+AUX_REG (dc_ivdl, NULL, arc_cache_aux_set)
+AUX_REG (dc_ldl, NULL, NULL)
+AUX_REG (dc_startr, NULL, arc_cache_aux_set)
+AUX_REG (dc_endr, arc_cache_aux_get, arc_cache_aux_set)
+AUX_REG (dc_ptag, NULL, NULL)
+AUX_REG (dc_ptag_hi, arc_cache_aux_get, arc_cache_aux_set)
+AUX_REG (dc_ram_addr, NULL, NULL)
+AUX_REG (dc_tag, NULL, NULL)
+AUX_REG (dc_wp, NULL, NULL)
+AUX_REG (debugi, NULL, NULL)
+AUX_REG (debug, NULL, NULL)
+AUX_REG (des_aux, NULL, NULL)
+AUX_REG (dilstat, NULL, NULL)
+AUX_REG (dma_config, NULL, NULL)
+AUX_REG (dmc_code_ram, NULL, NULL)
+AUX_REG (dpfp_build, NULL, NULL)
+AUX_REG (dpfp_status, NULL, NULL)
+AUX_REG (dvfs_performance, NULL, NULL)
+AUX_REG (ea_build, NULL, NULL)
+AUX_REG (ecr, NULL, NULL)
+AUX_REG (efa, NULL, NULL)
+AUX_REG (ei_base, NULL, NULL)
+AUX_REG (erbta, NULL, NULL)
+AUX_REG (eret, NULL, NULL)
+AUX_REG (erp_control, NULL, NULL)
+AUX_REG (ersec_stat, NULL, NULL)
+AUX_REG (erstatus, NULL, NULL)
+AUX_REG (exec_ctrl, NULL, NULL)
+AUX_REG (fp_build, NULL, NULL)
+AUX_REG (fp_status, NULL, NULL)
+AUX_REG (hexctrl, NULL, NULL)
+AUX_REG (hexdata, NULL, NULL)
+AUX_REG (hwp_build, NULL, NULL)
+AUX_REG (icause, aux_irq_get, NULL)
+AUX_REG (irq_select, aux_irq_get, aux_irq_set)
+AUX_REG (irq_enable, aux_irq_get, aux_irq_set)
+AUX_REG (irq_trigger, aux_irq_get, aux_irq_set)
+AUX_REG (irq_status, aux_irq_get, NULL)
+AUX_REG (i_cache_build, arc_cache_aux_get, NULL)
+AUX_REG (ic_ctrl, arc_cache_aux_get, arc_cache_aux_set)
+AUX_REG (ic_data, NULL, NULL)
+AUX_REG (ic_startr, NULL, arc_cache_aux_set)
+AUX_REG (ic_endr, arc_cache_aux_get, arc_cache_aux_set)
+AUX_REG (ic_ivic, NULL, arc_cache_aux_set)
+AUX_REG (ic_ivil, NULL, arc_cache_aux_set)
+AUX_REG (ic_ivir, arc_cache_aux_get, arc_cache_aux_set)
+AUX_REG (ic_lil, NULL, NULL)
+AUX_REG (ic_ptag, arc_cache_aux_get, arc_cache_aux_set)
+AUX_REG (ic_ptag_hi, arc_cache_aux_get, arc_cache_aux_set)
+AUX_REG (ic_ram_address, NULL, NULL)
+AUX_REG (ic_tag, NULL, NULL)
+AUX_REG (ic_wp, NULL, NULL)
+AUX_REG (identity, NULL, NULL)
+AUX_REG (ifetch_queue_build, NULL, NULL)
+AUX_REG (int_vector_base, aux_irq_get, aux_irq_set)
+AUX_REG (irq_build, aux_irq_get, NULL)
+AUX_REG (irq_priority_pending, NULL, NULL)
+AUX_REG (isa_config, NULL, NULL)
+AUX_REG (ivic, NULL, NULL)
+AUX_REG (jli_base, TO_IMPLEMENT_GET, TO_IMPLEMENT_SET)
+AUX_REG (ldi_base, NULL, NULL)
+AUX_REG (led, NULL, NULL)
+AUX_REG (limit0, aux_timer_get, aux_timer_set)
+AUX_REG (limit1, aux_timer_get, aux_timer_set)
+AUX_REG (line_length_mask, NULL, NULL)
+AUX_REG (lockline, NULL, NULL)
+AUX_REG (lp_end, NULL, NULL)
+AUX_REG (lp_start, NULL, NULL)
+AUX_REG (lsp_newval, NULL, NULL)
+AUX_REG (madi_build, NULL, NULL)
+AUX_REG (memseg, NULL, NULL)
+AUX_REG (memsubsys, NULL, NULL)
+AUX_REG (mmu_build, arc_mmu_aux_get, NULL)
+AUX_REG (mpu_build, arc_mpu_aux_get, NULL)
+AUX_REG (mpuen, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpufa, NULL, NULL)
+AUX_REG (mpuic, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdb0, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdb1, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdb2, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdb3, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdb4, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdb5, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdb6, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdb7, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdb8, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdb9, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdb10, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdb11, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdb12, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdb13, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdb14, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdb15, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdp0, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdp1, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdp2, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdp3, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdp4, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdp5, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdp6, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdp7, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdp8, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdp9, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdp10, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdp11, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdp12, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdp13, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdp14, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpurdp15, arc_mpu_aux_get, arc_mpu_aux_set)
+AUX_REG (mpy_build, NULL, NULL)
+AUX_REG (mulhi, NULL, NULL)
+AUX_REG (mx00, NULL, NULL)
+AUX_REG (mx01, NULL, NULL)
+AUX_REG (mx0, NULL, NULL)
+AUX_REG (mx10, NULL, NULL)
+AUX_REG (mx11, NULL, NULL)
+AUX_REG (mx1, NULL, NULL)
+AUX_REG (mx20, NULL, NULL)
+AUX_REG (mx21, NULL, NULL)
+AUX_REG (mx30, NULL, NULL)
+AUX_REG (mx31, NULL, NULL)
+AUX_REG (my00, NULL, NULL)
+AUX_REG (my01, NULL, NULL)
+AUX_REG (my0, NULL, NULL)
+AUX_REG (my10, NULL, NULL)
+AUX_REG (my11, NULL, NULL)
+AUX_REG (my1, NULL, NULL)
+AUX_REG (my20, NULL, NULL)
+AUX_REG (my21, NULL, NULL)
+AUX_REG (my30, NULL, NULL)
+AUX_REG (my31, NULL, NULL)
+AUX_REG (nsc_table_base, NULL, NULL)
+AUX_REG (nsc_table_top, NULL, NULL)
+AUX_REG (p_base_addr, NULL, NULL)
+AUX_REG (pc, NULL, NULL)
+AUX_REG (pcport, NULL, NULL)
+AUX_REG (pct_build, NULL, NULL)
+AUX_REG (pid,    arc_mmu_aux_get, arc_mmu_aux_set)
+AUX_REG (sasid0, arc_mmu_aux_get, arc_mmu_aux_set)
+AUX_REG (sasid1, arc_mmu_aux_get, arc_mmu_aux_set)
+AUX_REG (pm_bcr, NULL, NULL)
+AUX_REG (pm_status, NULL, NULL)
+AUX_REG (pwr_ctrl, NULL, NULL)
+AUX_REG (rf_build, NULL, NULL)
+AUX_REG (rferp_status0, NULL, NULL)
+AUX_REG (rferp_status1, NULL, NULL)
+AUX_REG (scm_base, NULL, NULL)
+AUX_REG (scq_switch_build, NULL, NULL)
+AUX_REG (scratch_a, NULL, NULL)
+AUX_REG (scratch_data0, arc_mmu_aux_get, arc_mmu_aux_set)
+AUX_REG (sdm_base, NULL, NULL)
+AUX_REG (sec_extra, NULL, NULL)
+AUX_REG (sec_stat, NULL, NULL)
+AUX_REG (se_ctrl, NULL, NULL)
+AUX_REG (sec_vecbase_build, NULL, NULL)
+AUX_REG (se_dbg_ctrl, NULL, NULL)
+AUX_REG (se_dbg_data0, NULL, NULL)
+AUX_REG (se_dbg_data1, NULL, NULL)
+AUX_REG (se_dbg_data2, NULL, NULL)
+AUX_REG (se_dbg_data3, NULL, NULL)
+AUX_REG (se_eadr, NULL, NULL)
+AUX_REG (se_err, NULL, NULL)
+AUX_REG (semaphore, NULL, NULL)
+AUX_REG (se_spc, NULL, NULL)
+AUX_REG (se_stat, NULL, NULL)
+AUX_REG (se_watch, NULL, NULL)
+AUX_REG (simd_config, NULL, NULL)
+AUX_REG (simd_dma_build, NULL, NULL)
+AUX_REG (smart_control, NULL, NULL)
+AUX_REG (smart_data_0, NULL, NULL)
+AUX_REG (smart_data_2, NULL, NULL)
+AUX_REG (smart_data_3, NULL, NULL)
+AUX_REG (smart_data, NULL, NULL)
+AUX_REG (sram_seq, NULL, NULL)
+AUX_REG (status32, NULL, NULL)
+AUX_REG (status32_p0, NULL, NULL)
+AUX_REG (swstat, NULL, NULL)
+AUX_REG (tag_addr_mask, NULL, NULL)
+AUX_REG (tag_data_mask, NULL, NULL)
+AUX_REG (timer_build, aux_timer_get, NULL)
+AUX_REG (tlbcommand,  arc_mmu_aux_get, arc_mmu_aux_set_tlbcmd)
+AUX_REG (tlbindex,    arc_mmu_aux_get, arc_mmu_aux_set)
+AUX_REG (tlbpd0,      arc_mmu_aux_get, arc_mmu_aux_set)
+AUX_REG (tlbpd1_hi,   arc_mmu_aux_get, arc_mmu_aux_set)
+AUX_REG (tlbpd1,      arc_mmu_aux_get, arc_mmu_aux_set)
+AUX_REG (tsch, NULL, NULL)
+AUX_REG (unlockline, NULL, NULL)
+AUX_REG (vbfdw_build, NULL, NULL)
+AUX_REG (vecbase_ac_build, aux_irq_get, NULL)
+AUX_REG (vecbase_build, NULL, NULL)
+AUX_REG (vlc_build, NULL, NULL)
+AUX_REG (vraptor_build, NULL, NULL)
+AUX_REG (wake, NULL, NULL)
+AUX_REG (xpu, NULL, NULL)
+AUX_REG (xtp_newval, NULL, NULL)
+AUX_REG (xyconfig, NULL, NULL)
+AUX_REG (xylsbasex, NULL, NULL)
+AUX_REG (xylsbasey, NULL, NULL)
+AUX_REG (aux_rtc_ctrl, aux_timer_get, aux_timer_set)
+AUX_REG (aux_rtc_low, aux_timer_get, aux_timer_set)
+AUX_REG (aux_rtc_high, aux_timer_get, aux_timer_set)
diff --git a/target/arc/regs.h b/target/arc/regs.h
new file mode 100644
index 0000000000..afafc60ef8
--- /dev/null
+++ b/target/arc/regs.h
@@ -0,0 +1,118 @@
+/*
+ * QEMU ARC CPU
+ *
+ * Copyright (c) 2020 Cupertino Miranda (cmiranda@synopsys.com)
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * http://www.gnu.org/licenses/lgpl-2.1.html
+ */
+
+#ifndef ARC_REGS_H
+#define ARC_REGS_H
+
+#include "target/arc/decoder.h"
+
+/*
+ * BCRs (Build configuration registers) are very special AUX regs
+ * as they are always readable even if corresponding HW module is absent.
+ * Thus we may always safely read them and learn what HW we have.
+ * All other AUX regs outside of 2 BCR areas are only readable if their
+ * HW is really implemented, otherwise "Instruction error" exception
+ * is raised by the CPU.
+ */
+
+/* First BCR region. */
+#define ARC_BCR1_START          0x60
+#define ARC_BCR1_END            0x7f
+/* Second BCR region. */
+#define ARC_BCR2_START          0xc0
+#define ARC_BCR2_END            0xff
+
+enum arc_aux_reg_enum {
+    ARC_AUX_REGS_INVALID = -1,
+#define AUX_REG(NAME, GET, SET) AUX_ID_##NAME,
+#include "target/arc/regs.def"
+#undef AUX_REG
+    ARC_AUX_REGS_LAST
+};
+
+enum arc_aux_reg_detail_enum {
+    ARC_AUX_REGS_DETAIL_INVALID = -1,
+#define DEF(NUM, CPU, SUB, NAME) CPU##_##NUM,
+#include "target/arc/regs-detail.def"
+#undef DEF
+    ARC_AUX_REGS_DETAIL_LAST
+};
+
+struct arc_aux_regs_data;
+struct arc_aux_reg_detail {
+    /* Register address. */
+    int address;
+
+    /*
+     * One bit flags for the opcode. These are primarily used to
+     * indicate specific processors and environments support the
+     * instructions.
+     */
+    enum arc_cpu_family cpu;
+
+    /* AUX register subclass. */
+    insn_subclass_t subclass;
+
+    /* Enum for aux-reg. */
+    enum arc_aux_reg_enum id;
+
+    /* Register name. */
+    const char *name;
+
+    /* Size of the string. */
+    size_t length;
+
+    /* pointer to the first element in the list. */
+    struct arc_aux_reg_detail *next;
+
+    /* pointer to the first element in the list. */
+    struct arc_aux_reg *aux_reg;
+};
+
+typedef void (* aux_reg_set_func)(const struct arc_aux_reg_detail *aux_reg,
+                                  uint32_t val, void *data);
+typedef uint32_t (* aux_reg_get_func)(const struct arc_aux_reg_detail *aux_reg,
+                                      void *data);
+
+struct arc_aux_reg {
+    /* pointer to the first element in the list. */
+    struct arc_aux_reg_detail *first;
+
+    /* get and set function for lr and sr helpers */
+    aux_reg_get_func get_func;
+    aux_reg_set_func set_func;
+};
+
+extern struct arc_aux_reg_detail arc_aux_regs_detail[ARC_AUX_REGS_DETAIL_LAST];
+extern struct arc_aux_reg arc_aux_regs[ARC_AUX_REGS_LAST];
+extern const char *arc_aux_reg_name[ARC_AUX_REGS_DETAIL_LAST];
+
+void arc_aux_regs_init(void);
+int arc_aux_reg_address_for(enum arc_aux_reg_enum, int);
+struct arc_aux_reg_detail *arc_aux_reg_struct_for_address(int, int);
+
+uint32_t arc_regs_bcr_default_impl(const struct arc_aux_reg_detail *aux_reg,
+                                   void *data);
+
+void TO_IMPLEMENT_SET(const struct arc_aux_reg_detail *aux_reg, uint32_t val,
+                      void *data);
+uint32_t TO_IMPLEMENT_GET(const struct arc_aux_reg_detail *aux_reg, void *data);
+
+#endif /* ARC_REGS_H */
-- 
2.20.1


