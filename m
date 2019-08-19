Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC799C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9293A214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fe3pQIVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9293A214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpqy-0002GV-CY
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMj-0002WC-5x
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMh-0006hW-JV
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:01 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37306)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMh-0006g1-C5
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:59 -0400
Received: by mail-pf1-x441.google.com with SMTP id 129so1947366pfa.4
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ciKrEcP+T8tnigUgJH1zluGMRq2FWUolUVP3r6kA9kc=;
 b=fe3pQIVmFqXxhHGKfazmDZloPrTMVRi1ogE0ZrUkuBENnP7krpW/s6a9ftqrY6fHEa
 lOlCC+GTZIaKPVykfUKA3LXzvXyW0eHOppJCLgB1uw8En+RRr2t+3B+1TzjrC4Ud422C
 I1JkzqsxsAGVZkIA47vt3jByG9+lL7NmGOv1XN6gMFmeEXQXpat8hrP1zu2g4yXS0xVX
 bg33uRQjlJprecdBHQt9rUi3yxTyap7SVfrzvxB5cShNyLigU+E1pj0bjMIfWClneSJa
 BjTNSK7o6wyw5yPWM0RXHL2uxvEMwvkC7yVAoyBqr4Q+j7cEoZ94QUC+wap4WdWrnI5P
 iXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ciKrEcP+T8tnigUgJH1zluGMRq2FWUolUVP3r6kA9kc=;
 b=iQMZ5Q4iekf79zcCq8k/zjrp7b7Sq0t6yEUIvJHAH46NwaViIZjElcCKAL7LV0LUtx
 iePm/h+KSiEXwR0CXF3tgx6RbiM8K/SC7WEuGnLXUued17VGwskVMhMRavM4XuwmINL7
 elBo3ZrTimCNikCvry2ez9G1pyzztbik8vHXNigY50Nfl8D7HLZP7oYic03cy334DWSO
 N8ZKGMR+adsiTVlYETf5MLaYy8B0UBbsGVQdYbZD9hylYF69P3Iaw18vkzBLiwR+RaQ8
 tAbiTlLfMPfy6wr5STEx+PiRWbMhk10OPJenooQeAwZDhSB9JGyRmV7YOmrKmFl/aqLt
 M5ig==
X-Gm-Message-State: APjAAAUO78tfz34Mn8sZYDzRBXbzjqKio/ajbo4JyvZj89YsvfV5OEcP
 HhNCCis/VsmB75BfbMDU3bc72R7Pxsw=
X-Google-Smtp-Source: APXvYqwFnMsViS2bWAZDeKw7eQx4W39QJDewszgeNLoKjeT37b+tNFbRePKg4SnOlZ0XRlZlRh8IZg==
X-Received: by 2002:aa7:818b:: with SMTP id g11mr26769834pfi.122.1566250736820; 
 Mon, 19 Aug 2019 14:38:56 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:36 -0700
Message-Id: <20190819213755.26175-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v2 49/68] target/arm: Convert T16 load/store
 multiple
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 48 ++++++++----------------------------------
 target/arm/t16.decode  |  8 +++++++
 2 files changed, 17 insertions(+), 39 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2640f50fcf..d417958b23 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9976,6 +9976,14 @@ static bool trans_LDM_t32(DisasContext *s, arg_ldst_block *a)
     return do_ldm(s, a, 2);
 }
 
+static bool trans_LDM_t16(DisasContext *s, arg_ldst_block *a)
+{
+    /* Writeback is conditional on the base register not being loaded.  */
+    a->w = !(a->list & (1 << a->rn));
+    /* BitCount(list) < 1 is UNPREDICTABLE */
+    return do_ldm(s, a, 1);
+}
+
 /*
  * Branch, branch with link
  */
@@ -10750,6 +10758,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     case 8: /* load/store halfword immediate offset, in decodetree */
     case 9: /* load/store from stack, in decodetree */
     case 10: /* add PC/SP (immediate), in decodetree */
+    case 12: /* load/store multiple, in decodetree */
         goto illegal_op;
 
     case 11:
@@ -10973,45 +10982,6 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         }
         break;
 
-    case 12:
-    {
-        /* load/store multiple */
-        TCGv_i32 loaded_var = NULL;
-        rn = (insn >> 8) & 0x7;
-        addr = load_reg(s, rn);
-        for (i = 0; i < 8; i++) {
-            if (insn & (1 << i)) {
-                if (insn & (1 << 11)) {
-                    /* load */
-                    tmp = tcg_temp_new_i32();
-                    gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                    if (i == rn) {
-                        loaded_var = tmp;
-                    } else {
-                        store_reg(s, i, tmp);
-                    }
-                } else {
-                    /* store */
-                    tmp = load_reg(s, i);
-                    gen_aa32_st32(s, tmp, addr, get_mem_index(s));
-                    tcg_temp_free_i32(tmp);
-                }
-                /* advance to the next address */
-                tcg_gen_addi_i32(addr, addr, 4);
-            }
-        }
-        if ((insn & (1 << rn)) == 0) {
-            /* base reg not in list: base register writeback */
-            store_reg(s, rn, addr);
-        } else {
-            /* base reg in list: if load, complete it now */
-            if (insn & (1 << 11)) {
-                store_reg(s, rn, loaded_var);
-            }
-            tcg_temp_free_i32(addr);
-        }
-        break;
-    }
     case 13:
         /* conditional branch or swi */
         cond = (insn >> 8) & 0xf;
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 71b3e8f02e..a7a437f930 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -26,6 +26,7 @@
 &ri              !extern rd imm
 &ldst_rr         !extern p w u rn rt rm shimm shtype
 &ldst_ri         !extern p w u rn rt imm
+&ldst_block      !extern rn i b u w list
 
 # Set S if the instruction is outside of an IT block.
 %s               !function=t16_setflags
@@ -109,3 +110,10 @@ LDR_ri          10011 ... ........              @ldst_spec_i rn=13
 ADR             10100 rd:3 ........             imm=%imm8_0x4
 ADD_rri         10101 rd:3 ........ \
                 &s_rri_rot rn=13 s=0 rot=0 imm=%imm8_0x4  # SP
+
+# Load/store multiple
+
+@ldstm          ..... rn:3 list:8               &ldst_block i=1 b=0 u=0 w=1
+
+STM             11000 ... ........              @ldstm
+LDM_t16         11001 ... ........              @ldstm
-- 
2.17.1


