Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1E2C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA7E208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bcjy5g/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA7E208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hho4Y-0006g8-PM
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 00:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56626)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2p-0004tK-86
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2n-0004UT-IP
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:35:59 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:33903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hho2n-0004U8-D5
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:35:57 -0400
Received: by mail-yw1-xc42.google.com with SMTP id q128so7864067ywc.1
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 21:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b0Q7dqcv9vs5YzYpWYUtfrjI6UloTcQSqD0LA78ybpg=;
 b=Bcjy5g/0/mNKfA5lDbU2xL9l5pFwlhnDiG2dgPdg3ZbEbxZAyqZfnUszJag4cYiy9p
 ak1I2OjBa1N2UzYd23t/3NFDwRolYqQ1RNHdTQg860CQSNPOJtkKisHLnjp/1JGaMI7j
 H3iN50ipPsgsUlsTT3VwKTtgBZWlWsuTs2fkqLXfdWXo9sTNLn7f+ysx7vTOfpvK5zur
 kQLm1uAUEUmu4G3j+et1FgZay2+mTNLyMbaxQJvfKYoLHtz/8t5p8Lk98UKjoTR8Bx/N
 yShlHcXS3GMKIeBCPa/uqU2lkfy8XqizmlStqAjlbKFvprTO0iek20mdn6f/8SqwyzV6
 zHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b0Q7dqcv9vs5YzYpWYUtfrjI6UloTcQSqD0LA78ybpg=;
 b=Yc27kBmZclTt5PjAfHmrQkwfYaIWxfsuvrvc2mefYXW2BvbJFl0Gi3PHdszj9Aut/Y
 +nHAr+z+mHyeUDTbF3kDtUuilnYlEuDkSJshPyy7yvn2DbM8EGuzkDJurDZjd7xZG+ox
 k9XDgJoo6ODHDUSAM4tlMnMywhlEGOdSGVw5Rg+cdGQDQpXWUfjjCvN1b1Y8WmCa7QVJ
 5mVihvbz1zk7PJ/nwPeMj5Q09vOCVEsm4Z6QYLY7DTCEUVbVci3Li8fEFvf96uvdYJmr
 SoDhnI3uoVER6ALK5ujWsHJVMDMJ/RaVdo7Kwo1WCvhWvyWxOg2ow64d23/bfYlXxRIZ
 svvQ==
X-Gm-Message-State: APjAAAXx00WQufWhssFe8TCQakO62hEV+CL7Rw+xbhs2D+ovLTqPMto5
 q437jFRVwVk7p2mpSRs/FKQqQMH8
X-Google-Smtp-Source: APXvYqye3jjpEq5MUaSdM/ZCT/Lfb/kUgD9KD+jR2y2aQ/oGMVoaweIPjUXf8T16H73D6LxWtRqR2A==
X-Received: by 2002:a81:1289:: with SMTP id 131mr13841414yws.19.1561955756547; 
 Sun, 30 Jun 2019 21:35:56 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id k126sm1108564ywf.36.2019.06.30.21.35.55
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 30 Jun 2019 21:35:56 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 00:35:24 -0400
Message-Id: <20190701043536.26019-3-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701043536.26019-1-jan.bobek@gmail.com>
References: <20190701043536.26019-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
Subject: [Qemu-devel] [RISU RFC PATCH v2 02/14] risugen_x86_asm: add module
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The module risugen_x86_asm.pm exports several constants and the
function write_insn, which work in tandem to allow emission of x86
instructions in more clear and structured manner.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risugen_x86_asm.pm | 252 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 252 insertions(+)
 create mode 100644 risugen_x86_asm.pm

diff --git a/risugen_x86_asm.pm b/risugen_x86_asm.pm
new file mode 100644
index 0000000..5640531
--- /dev/null
+++ b/risugen_x86_asm.pm
@@ -0,0 +1,252 @@
+#!/usr/bin/perl -w
+###############################################################################
+# Copyright (c) 2019 Linaro Limited
+# All rights reserved. This program and the accompanying materials
+# are made available under the terms of the Eclipse Public License v1.0
+# which accompanies this distribution, and is available at
+# http://www.eclipse.org/legal/epl-v10.html
+#
+# Contributors:
+#     Jan Bobek - initial implementation
+###############################################################################
+
+# risugen_x86_asm -- risugen_x86's helper module for x86 assembly
+package risugen_x86_asm;
+
+use strict;
+use warnings;
+
+use risugen_common;
+
+our @ISA    = qw(Exporter);
+our @EXPORT = qw(
+    write_insn
+    VEX_L_128 VEX_L_256
+    VEX_P_NONE VEX_P_DATA16 VEX_P_REP VEX_P_REPNE
+    VEX_M_0F VEX_M_0F38 VEX_M_0F3A
+    VEX_V_UNUSED
+    REG_EAX REG_ECX REG_EDX REG_EBX REG_ESP REG_EBP REG_ESI REG_EDI
+    MOD_INDIRECT MOD_INDIRECT_DISP8 MOD_INDIRECT_DISP32 MOD_DIRECT
+    X86PFX_DATA16 X86PFX_REPNE X86PFX_REP
+    X86OP_LEA X86OP_XOR X86OP_ALU_imm8 X86OP_MOV X86OP_SAHF X86OP_CALL
+    X86OP_JMP X86OP_UD1 X86OP_VMOVAPS X86OP_MOVAPS
+    );
+
+use constant {
+    VEX_L_128 => 0,
+    VEX_L_256 => 1,
+
+    VEX_P_NONE   => 0b00,
+    VEX_P_DATA16 => 0b01,
+    VEX_P_REP    => 0b10,
+    VEX_P_REPNE  => 0b11,
+
+    VEX_M_0F   => 0b00001,
+    VEX_M_0F38 => 0b00010,
+    VEX_M_0F3A => 0b00011,
+
+    VEX_V_UNUSED => 0b1111,
+
+    REG_EAX => 0,
+    REG_ECX => 1,
+    REG_EDX => 2,
+    REG_EBX => 3,
+    REG_ESP => 4,
+    REG_EBP => 5,
+    REG_ESI => 6,
+    REG_EDI => 7,
+
+    MOD_INDIRECT        => 0b00,
+    MOD_INDIRECT_DISP8  => 0b01,
+    MOD_INDIRECT_DISP32 => 0b10,
+    MOD_DIRECT          => 0b11,
+
+    X86PFX_DATA16 => {value => 0x66, len => 1},
+    X86PFX_REPNE  => {value => 0xF2, len => 1},
+    X86PFX_REP    => {value => 0xF3, len => 1},
+
+    X86OP_LEA      => {value => 0x8D, len => 1},
+    X86OP_XOR      => {value => 0x33, len => 1},
+    X86OP_ALU_imm8 => {value => 0x83, len => 1},
+    X86OP_MOV      => {value => 0x8B, len => 1},
+    X86OP_SAHF     => {value => 0x9E, len => 1},
+    X86OP_CALL     => {value => 0xE8, len => 1},
+    X86OP_JMP      => {value => 0xE9, len => 1},
+
+    X86OP_UD1      => {value => 0x0FB9, len => 2},
+    X86OP_VMOVAPS  => {value => 0x28, len => 1},
+    X86OP_MOVAPS   => {value => 0x0F28, len => 2},
+};
+
+sub rex_encode(%)
+{
+    my (%args) = @_;
+
+    $args{w} = 0 unless defined $args{w};
+    $args{r} = 0 unless defined $args{r};
+    $args{x} = 0 unless defined $args{x};
+    $args{b} = 0 unless defined $args{b};
+
+    return (value => 0x40
+            | (($args{w} ? 1 : 0) << 3)
+            | (($args{r} ? 1 : 0) << 2)
+            | (($args{x} ? 1 : 0) << 1)
+            | ($args{b} ? 1 : 0),
+            len => 1);
+}
+
+sub vex_encode(%)
+{
+    my (%args) = @_;
+
+    $args{r} = 1 unless defined $args{r};
+    $args{x} = 1 unless defined $args{x};
+    $args{b} = 1 unless defined $args{b};
+    $args{v} = VEX_V_UNUSED unless defined $args{v};
+    $args{p} = VEX_P_NONE unless defined $args{p};
+
+    die "l field undefined"
+        unless defined $args{l};
+    die "v field out-of-range: $args{v}"
+        unless 0b0000 <= $args{v} && $args{v} <= 0b1111;
+    die "p field out-of-range: $args{p}"
+        unless 0b00 <= $args{p} && $args{p} <= 0b11;
+
+    if ($args{x} && $args{b} && !defined $args{m} && !defined $args{w}) {
+        # We can use the 2-byte VEX prefix
+        return (value => (0xC5 << 8)
+                | (($args{r} ? 1 : 0) << 7)
+                | ($args{v} << 3)
+                | (($args{l} ? 1 : 0) << 2)
+                | $args{p},
+                len => 2);
+    } else {
+        # We have to use the 3-byte VEX prefix
+        die "m field undefined"
+            unless defined $args{m};
+        die "m field out-of-range: $args{m}"
+            unless 0b00000 <= $args{m} && $args{m} <= 0b11111;
+        die "w field undefined"
+            unless defined $args{w};
+
+        return (value => (0xC4 << 16)
+                | (($args{r} ? 1 : 0) << 15)
+                | (($args{x} ? 1 : 0) << 14)
+                | (($args{b} ? 1 : 0) << 13)
+                | ($args{m} << 8)
+                | (($args{w} ? 1 : 0) << 7)
+                | ($args{v} << 3)
+                | (($args{l} ? 1 : 0) << 2)
+                | $args{p},
+                len => 3);
+    }
+}
+
+sub modrm_encode(%)
+{
+    my (%args) = @_;
+
+    die "MOD field out-of-range: $args{mod}"
+        unless 0 <= $args{mod} && $args{mod} <= 3;
+    die "REG field out-of-range: $args{reg}"
+        unless 0 <= $args{reg} && $args{reg} <= 7;
+    die "RM field out-of-range: $args{rm}"
+        unless 0 <= $args{rm} && $args{rm} <= 7;
+
+    return (value =>
+            ($args{mod} << 6)
+            | ($args{reg} << 3)
+            | $args{rm},
+            len => 1);
+}
+
+sub sib_encode(%)
+{
+    my (%args) = @_;
+
+    die "SS field out-of-range: $args{ss}"
+        unless 0 <= $args{ss} && $args{ss} <= 3;
+    die "INDEX field out-of-range: $args{index}"
+        unless 0 <= $args{index} && $args{index} <= 7;
+    die "BASE field out-of-range: $args{base}"
+        unless 0 <= $args{base} && $args{base} <= 7;
+
+    return (value =>
+            ($args{ss} << 6)
+            | ($args{index} << 3)
+            | $args{base},
+            len => 1);
+}
+
+sub write_insn(%)
+{
+    my (%insn) = @_;
+
+    my @tokens;
+    push @tokens, "EVEX"   if defined $insn{evex};
+    push @tokens, "VEX"    if defined $insn{vex};
+    push @tokens, "REP"    if defined $insn{rep};
+    push @tokens, "REPNE"  if defined $insn{repne};
+    push @tokens, "DATA16" if defined $insn{data16};
+    push @tokens, "REX"    if defined $insn{rex};
+    push @tokens, "OP"     if defined $insn{opcode};
+    push @tokens, "MODRM"  if defined $insn{modrm};
+    push @tokens, "SIB"    if defined $insn{sib};
+    push @tokens, "DISP"   if defined $insn{disp};
+    push @tokens, "IMM"    if defined $insn{imm};
+    push @tokens, "END";
+
+    # (EVEX | VEX | ((REP | REPNE)? DATA16? REX?)) OP (MODRM SIB? DISP?)? IMM? END
+
+    my $token = shift @tokens;
+    if ($token eq "EVEX") {
+        insnv(evex_encode(%{$insn{evex}}));
+        $token = shift @tokens;
+    } elsif ($token eq "VEX") {
+        insnv(vex_encode(%{$insn{vex}}));
+        $token = shift @tokens;
+    } else {
+        if ($token eq "REP") {
+            insnv(%{&X86PFX_REP});
+            $token = shift @tokens;
+        } elsif ($token eq "REPNE") {
+            insnv(%{&X86PFX_REPNE});
+            $token = shift @tokens;
+        }
+        if ($token eq "DATA16") {
+            insnv(%{&X86PFX_DATA16});
+            $token = shift @tokens;
+        }
+        if ($token eq "REX") {
+            insnv(rex_encode(%{$insn{rex}}));
+            $token = shift @tokens;
+        }
+    }
+
+    die "Unexpected instruction tokens where OP expected: $token @tokens\n"
+        unless $token eq "OP";
+
+    insnv(%{$insn{opcode}});
+    $token = shift @tokens;
+
+    if ($token eq "MODRM") {
+        insnv(modrm_encode(%{$insn{modrm}}));
+        $token = shift @tokens;
+
+        if ($token eq "SIB") {
+            insnv(sib_encode(%{$insn{sib}}));
+            $token = shift @tokens;
+        }
+        if ($token eq "DISP") {
+            insnv(%{$insn{disp}}, bigendian => 0);
+            $token = shift @tokens;
+        }
+    }
+    if ($token eq "IMM") {
+        insnv(%{$insn{imm}}, bigendian => 0);
+        $token = shift @tokens;
+    }
+
+    die "Unexpected junk tokens at the end of instruction: $token @tokens\n"
+        unless $token eq "END";
+}
-- 
2.20.1


