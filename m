Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53464C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3682076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3wvticT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3682076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7ZK-0000ED-7k
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1jU7YN-0007P9-Fl
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1jU7XY-0007fH-ES
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:40:31 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jU7XY-0007ex-0H; Thu, 30 Apr 2020 07:39:40 -0400
Received: by mail-pl1-x642.google.com with SMTP id d24so2144560pll.8;
 Thu, 30 Apr 2020 04:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8DXEi3YX32S2HP+Om4VmIl6UeOwrxPzxC3D+Nx/dkrw=;
 b=X3wvticTXNuMrfJVSGu7v8BB3Ux8GVOoVg6rDo0YE3D89+tCMS3gN26LSJQWJfGuPS
 2hhnUatlkMh+Ec+PooGWHD//m98NDXECqNHuo3k9AJPljzM+9B2UR2V7f/Y3CC2dxCEc
 C8Ey/uIX5SCgjNzHmFhsU5NUAYqzsof+ahX6Ig4XXolB9RbWf0ZUNElPcI1r/yyxClu7
 PYS57DRXdUj+TVq1yPxZncWQYd6sHTpUjOY7RoeOmGr3SJuruu7I+hZgBLApMuQabv3U
 HWK1T7uaWbICy+qBWVYdMCrloN04M2cKIA9D3xpbmC+kms16KCxp1wfuvpgRHBC1wQwV
 P8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8DXEi3YX32S2HP+Om4VmIl6UeOwrxPzxC3D+Nx/dkrw=;
 b=ji0h0uAQZ5Fka82Snp8XG2ZKzKva4D+JmXC1wV8k8OcRIbz/mWAZXRUhndK0JrX9Vd
 SXtMCiBV99Jxad4DGY8WayO3LjoMKWV3GQK0FRAPKMnfaN8ESjWjZ7BZKJfJ/zbbnd/4
 5g8BCfoMV27sIF4l9AXSrSawc1eVtZYQyUt7ZazBMord9fOkQ78O1DluJJjWvIctA/ED
 s1BnTZelGmtsz6fW/VIxW/s+CybywPBZpkt87YGGTilP6uk1YJnBjW/FquY3ne6lIWbg
 oVa5+aA2mRuG4iWHzTOBezwP1crMNKIik4w4TRLPA8nYsPMdvNE2830obFXAVpyQGSuJ
 +Bcg==
X-Gm-Message-State: AGi0PuaITryVUqr81N9TyErNlbAC7eGDXldWnXukuiN7HOJrJOQAdk81
 d54BOMRje+K8+BzzfhuuzhU8XFCs
X-Google-Smtp-Source: APiQypJMjLTQa8LnWejvE9PXgij1KGKdwCrI4jhr35zKCc99bC/4GkzmXDiZ/Mc//ajjocwiNx8FIA==
X-Received: by 2002:a17:90a:71c2:: with SMTP id
 m2mr2505072pjs.21.1588246777587; 
 Thu, 30 Apr 2020 04:39:37 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:63f0:6080:6302:8919:92eb])
 by smtp.gmail.com with ESMTPSA id m3sm3068252pgt.27.2020.04.30.04.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:39:37 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/xtensa: work around missing SR definitions
Date: Thu, 30 Apr 2020 04:39:15 -0700
Message-Id: <20200430113915.19550-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Xtensa configuration overlays for recent releases may have special
registers for which [rwx]sr opcodes are defined, but they are not listed
as SR in xtensa_sysreg_name and associated functions. As a result
generic translate_[rwx]sr* functions generate access to uninitialized
cpu_SR causing segfault at runtime.
Don't try to access cpu_SR for such registers, ignore writes and return
0 for reads.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 48 +++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index e0beaf7abbbd..546d2fa2facf 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -2191,7 +2191,11 @@ static void translate_rsil(DisasContext *dc, const OpcodeArg arg[],
 static void translate_rsr(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    tcg_gen_mov_i32(arg[0].out, cpu_SR[par[0]]);
+    if (sr_name[par[0]]) {
+        tcg_gen_mov_i32(arg[0].out, cpu_SR[par[0]]);
+    } else {
+        tcg_gen_movi_i32(arg[0].out, 0);
+    }
 }
 
 static void translate_rsr_ccount(DisasContext *dc, const OpcodeArg arg[],
@@ -2563,13 +2567,17 @@ static void translate_wrmsk_expstate(DisasContext *dc, const OpcodeArg arg[],
 static void translate_wsr(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    tcg_gen_mov_i32(cpu_SR[par[0]], arg[0].in);
+    if (sr_name[par[0]]) {
+        tcg_gen_mov_i32(cpu_SR[par[0]], arg[0].in);
+    }
 }
 
 static void translate_wsr_mask(DisasContext *dc, const OpcodeArg arg[],
                                const uint32_t par[])
 {
-    tcg_gen_andi_i32(cpu_SR[par[0]], arg[0].in, par[2]);
+    if (sr_name[par[0]]) {
+        tcg_gen_andi_i32(cpu_SR[par[0]], arg[0].in, par[2]);
+    }
 }
 
 static void translate_wsr_acchi(DisasContext *dc, const OpcodeArg arg[],
@@ -2775,23 +2783,31 @@ static void translate_xor(DisasContext *dc, const OpcodeArg arg[],
 static void translate_xsr(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    TCGv_i32 tmp = tcg_temp_new_i32();
+    if (sr_name[par[0]]) {
+        TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_mov_i32(tmp, arg[0].in);
-    tcg_gen_mov_i32(arg[0].out, cpu_SR[par[0]]);
-    tcg_gen_mov_i32(cpu_SR[par[0]], tmp);
-    tcg_temp_free(tmp);
+        tcg_gen_mov_i32(tmp, arg[0].in);
+        tcg_gen_mov_i32(arg[0].out, cpu_SR[par[0]]);
+        tcg_gen_mov_i32(cpu_SR[par[0]], tmp);
+        tcg_temp_free(tmp);
+    } else {
+        tcg_gen_movi_i32(arg[0].out, 0);
+    }
 }
 
 static void translate_xsr_mask(DisasContext *dc, const OpcodeArg arg[],
                                const uint32_t par[])
 {
-    TCGv_i32 tmp = tcg_temp_new_i32();
+    if (sr_name[par[0]]) {
+        TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_mov_i32(tmp, arg[0].in);
-    tcg_gen_mov_i32(arg[0].out, cpu_SR[par[0]]);
-    tcg_gen_andi_i32(cpu_SR[par[0]], tmp, par[2]);
-    tcg_temp_free(tmp);
+        tcg_gen_mov_i32(tmp, arg[0].in);
+        tcg_gen_mov_i32(arg[0].out, cpu_SR[par[0]]);
+        tcg_gen_andi_i32(cpu_SR[par[0]], tmp, par[2]);
+        tcg_temp_free(tmp);
+    } else {
+        tcg_gen_movi_i32(arg[0].out, 0);
+    }
 }
 
 static void translate_xsr_ccount(DisasContext *dc, const OpcodeArg arg[],
@@ -2819,7 +2835,11 @@ static void translate_xsr_ccount(DisasContext *dc, const OpcodeArg arg[],
 { \
     TCGv_i32 tmp = tcg_temp_new_i32(); \
  \
-    tcg_gen_mov_i32(tmp, cpu_SR[par[0]]); \
+    if (sr_name[par[0]]) { \
+        tcg_gen_mov_i32(tmp, cpu_SR[par[0]]); \
+    } else { \
+        tcg_gen_movi_i32(tmp, 0); \
+    } \
     translate_wsr_##name(dc, arg, par); \
     tcg_gen_mov_i32(arg[0].out, tmp); \
     tcg_temp_free(tmp); \
-- 
2.20.1


