Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D2EC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B6C220709
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Se6gP4o2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6C220709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmVt-0007mw-Mn
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKmOj-00086M-Et
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:48:13 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKmOf-0004LA-MT
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:48:13 -0400
Received: by mail-pf1-x443.google.com with SMTP id n14so13132292pff.6
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 10:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c3L7ongZcFIrjIrL9FZxznJ0aLcGoTeG6OyijrdzkkY=;
 b=Se6gP4o2PGt3zFRfnC4L3JHF73dkbf7H8OpwU7H88ODAfQa9oAwOQYNo9Wp23pqZqM
 6VPYtk5fvOk1n3sXjf38ySkcCEbqmG+xIJL+FE/nmZV+c/RbpqvZabIIvBGrZa2lwWCU
 6aVsU+dTmXjtoFyF0n2rL5U594+mOXHdiUgqKG6bS8ErMsX4FIkZoXONL9PwziUf6ysi
 IG82e7G0W5A1aYRGU/HnUCLAWz5oO2CMX2Ws4QY1zzk54xWNojcifDASM47MU4eKGaY6
 Lm2awsgBBlVK3bhZe0le+HG6Ssa7AXZZUlsgSesDghkH5aIbLDwbDqmslsVxFAZKFMng
 FOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c3L7ongZcFIrjIrL9FZxznJ0aLcGoTeG6OyijrdzkkY=;
 b=YDNrtZytmQBJ7tCJsBEcgQflFkBFT48t/LmDNAdHxkUEW1USOZ0O2Kx837wjYA5H/U
 XhKx3U0WJmO249//7GUv9vf+YO6g8PN2r96E+Om+eTDLe/dL5NPvYXYBymzBwvu6PUUK
 UGH0Y3GdxEKim1rZAZqbDzVvj+0xf5NsMmLbyIJ4aTf8+YoHOniYnOJEj6Jz6cIeb1hG
 n79o8wYkAPKTJ/X+rsH77TwnnMQTUJHTayPmJ4VJ+vzrtKeBHejuQTylaCo8XIqQcmSQ
 UBnhrELJSl9KdENaxJmtgsLVxJMBWoXEkipmqpYhGYygl5AptaUC426okrTXAtK7kxRJ
 cbVQ==
X-Gm-Message-State: AOAM532Qzke6rINP0ef98LTdKTeKp2Zro59216VAWKde4smNnymqmltO
 QhJSHGbvG3oZVuSzgfKHqgM2sGw9j+qQAg==
X-Google-Smtp-Source: ABdhPJxIybTfPjzUTkxU2jMCrWRYL32D1s7+4a8JZiz2E7mI1OyJ7NAacAeukYklcVeAABQN6w24mw==
X-Received: by 2002:a62:7c82:0:b029:13c:1611:66b9 with SMTP id
 x124-20020a627c820000b029013c161166b9mr5018303pfc.4.1600796874830; 
 Tue, 22 Sep 2020 10:47:54 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id r1sm14825310pgl.66.2020.09.22.10.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 10:47:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/11] disas: Cleanup plugin_disas
Date: Tue, 22 Sep 2020 10:47:37 -0700
Message-Id: <20200922174741.475876-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922174741.475876-1-richard.henderson@linaro.org>
References: <20200922174741.475876-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not retain a GString in thread-local storage.  Allocate a
new one and free it on every invocation.  Do not g_strdup the
result; return the buffer from the GString.  Do not use
warn_report.

Using cs_disasm allocated memory via the &insn parameter, but
that was never freed.  Use cs_disasm_iter so that we use the
memory that we've already allocated, and so that we only try
to disassemble one insn, as desired.  Do not allocate 1k to
hold the bytes for a single instruction.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c | 55 +++++++++++++++++++------------------------------------
 1 file changed, 19 insertions(+), 36 deletions(-)

diff --git a/disas.c b/disas.c
index 8d1403dedc..54a540180f 100644
--- a/disas.c
+++ b/disas.c
@@ -493,13 +493,12 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
     }
 }
 
-static __thread GString plugin_disas_output;
-
 static int plugin_printf(FILE *stream, const char *fmt, ...)
 {
-    va_list va;
-    GString *s = &plugin_disas_output;
+    /* We abuse the FILE parameter to pass a GString. */
+    GString *s = (GString *)stream;
     int initial_len = s->len;
+    va_list va;
 
     va_start(va, fmt);
     g_string_append_vprintf(s, fmt, va);
@@ -519,28 +518,20 @@ static void plugin_print_address(bfd_vma addr, struct disassemble_info *info)
 static
 bool cap_disas_plugin(disassemble_info *info, uint64_t pc, size_t size)
 {
-    uint8_t cap_buf[1024];
+    uint8_t cap_buf[64];
+    const uint8_t *cbuf = cap_buf;
     csh handle;
-    cs_insn *insn;
-    size_t csize = 0;
-    int count;
-    GString *s = &plugin_disas_output;
 
     if (cap_disas_start(info, &handle) != CS_ERR_OK) {
         return false;
     }
-    insn = cap_insn;
 
-    size_t tsize = MIN(sizeof(cap_buf) - csize, size);
-    const uint8_t *cbuf = cap_buf;
-    target_read_memory(pc, cap_buf, tsize, info);
+    assert(size < sizeof(cap_buf));
+    target_read_memory(pc, cap_buf, size, info);
 
-    count = cs_disasm(handle, cbuf, size, 0, 1, &insn);
-
-    if (count) {
-        g_string_printf(s, "%s %s", insn->mnemonic, insn->op_str);
-    } else {
-        g_string_printf(s, "cs_disasm failed");
+    if (cs_disasm_iter(handle, &cbuf, &size, &pc, cap_insn)) {
+        GString *s = (GString *)info->stream;
+        g_string_printf(s, "%s %s", cap_insn->mnemonic, cap_insn->op_str);
     }
 
     cs_close(&handle);
@@ -555,34 +546,26 @@ bool cap_disas_plugin(disassemble_info *info, uint64_t pc, size_t size)
  */
 char *plugin_disas(CPUState *cpu, uint64_t addr, size_t size)
 {
-    int count;
     CPUDebug s;
-    GString *ds = g_string_set_size(&plugin_disas_output, 0);
-
-    g_assert(ds == &plugin_disas_output);
+    GString *ds = g_string_new(NULL);
 
     initialize_debug_target(&s, cpu);
     s.info.fprintf_func = plugin_printf;
+    s.info.stream = (FILE *)ds;  /* abuse this slot */
     s.info.buffer_vma = addr;
     s.info.buffer_length = size;
     s.info.print_address_func = plugin_print_address;
 
     if (s.info.cap_arch >= 0 && cap_disas_plugin(&s.info, addr, size)) {
-        return g_strdup(ds->str);
+        ; /* done */
+    } else if (s.info.print_insn) {
+        s.info.print_insn(addr, &s.info);
+    } else {
+        ; /* cannot disassemble -- return empty string */
     }
 
-    if (s.info.print_insn == NULL) {
-        s.info.print_insn = print_insn_od_target;
-    }
-
-    count = s.info.print_insn(addr, &s.info);
-
-    /* The decoder probably read more than it needed it's not critical */
-    if (count < size) {
-        warn_report("%s: %zu bytes left over", __func__, size - count);
-    }
-
-    return g_strdup(ds->str);
+    /* Return the buffer, freeing the GString container.  */
+    return g_string_free(ds, false);
 }
 
 /* Disassemble this for me please... (debugging). */
-- 
2.25.1


