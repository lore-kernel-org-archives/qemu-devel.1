Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A16C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E71208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AO45s9p6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E71208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35164 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdSop-0005yg-3e
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 01:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34413)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hdSmT-0003u7-96
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hdSmP-0001dj-OW
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:07 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:45564)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hdSmO-0001cn-Ry
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:05 -0400
Received: by mail-yb1-xb43.google.com with SMTP id v104so7061827ybi.12
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 22:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GrCB6QTzLlLkXLJ1pjbX8m/2ezWqViG2Pyz6v1pzFWQ=;
 b=AO45s9p6s4eOYyANLVLC5l1Kz2KWIq2WNrzTPzaz9UWWN/FxCjus/wKsDBvBYIsgj8
 OCqU4gw+DPdFQ8bCIr4K86nMjhv7zpY9Es3A+xr/p2hZj6X7L9xJodfPXzRiv5cKZJGQ
 14ql2ekNJsb90+K/n0hQGbcecwTQIxn15QMeTbn4Ei0HFj6pXRhebCELmrX2EY2pmL0z
 65dCYXkwAfjTpiU3w+WF+GrzKou6nCr26McAEfs4te9s43D/oj4Gld0mfKkhaKpfdwNc
 fZsn5XoXrnZtNyFCiMsERkrd2YhjH7Sr7hv5JOObA9VpYrIK1Xoy46FslEME2J7fzZeP
 8FhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GrCB6QTzLlLkXLJ1pjbX8m/2ezWqViG2Pyz6v1pzFWQ=;
 b=iFvAQuc2I3n1cnsFhLj6Wcwt/CYa28M5EvuNbkqxTuM4srRY+qxBEE8EqdDYRzcM+w
 v886tVsclZ9sBAEtE1OzFBciCkXaRPGToGUUAU8dWzzqwY4svVxmkwvW/3wD37K5wA/C
 ORQuxPApZdRDscUxOOssQx/QRTamR7Gb4h15VTVCS1uuAViFkGiLK+cwHNOpSoQjQdvI
 RyJ2WnRPMDBv8d/cWDPDIFkcq+A1UcqL8ZbzK9EwqMJjDdrJsZiSLZxJmahZRFXZACf1
 QxTTDsBv4Eim2FRkLjAEjcl5fzUV9qgJGWpuB/niAFpSf1Rcjxa/UgOYnH8lf5AeDNaJ
 He6g==
X-Gm-Message-State: APjAAAW2ylXiPaJbf4AZxklop9vvX7XdICVAtn1qYRa1au3A0a/3cHuN
 Z6aDZm4sGnX079ATxhFs+K4DVQWJ
X-Google-Smtp-Source: APXvYqyuJwV8AU6a9idVKcNd/y06SM4Cjr4P5SAyivrdgzElTVdShhTP731icKt8g8BxGnrjD5pl8g==
X-Received: by 2002:a5b:2:: with SMTP id a2mr59124816ybp.244.1560920704043;
 Tue, 18 Jun 2019 22:05:04 -0700 (PDT)
Received: from localhost.localdomain (67-9-99-67.biz.bhn.net. [67.9.99.67])
 by smtp.gmail.com with ESMTPSA id e12sm1714426ywe.85.2019.06.18.22.05.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 18 Jun 2019 22:05:03 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 01:04:42 -0400
Message-Id: <20190619050447.22201-3-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619050447.22201-1-jan.bobek@gmail.com>
References: <20190619050447.22201-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RISU RFC PATCH v1 2/7] risugen_x86_asm: add module
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
 risugen_x86_asm.pm | 186 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100644 risugen_x86_asm.pm

diff --git a/risugen_x86_asm.pm b/risugen_x86_asm.pm
new file mode 100644
index 0000000..b10d3e7
--- /dev/null
+++ b/risugen_x86_asm.pm
@@ -0,0 +1,186 @@
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
+    REG_EAX REG_ECX REG_EDX REG_EBX REG_ESP REG_EBP REG_ESI REG_EDI
+    MOD_INDIRECT MOD_INDIRECT_DISP8 MOD_INDIRECT_DISP32 MOD_DIRECT
+    X86PFX_DATA16 X86PFX_REPNE X86PFX_REP
+    X86OP_LEA X86OP_XOR X86OP_ALU_imm8 X86OP_MOV X86OP_SAHF X86OP_CALL
+    X86OP_JMP X86OP_UD1 X86OP_MOVAPS
+    );
+
+use constant {
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
+    X86OP_MOVAPS   => {value => 0x0F28, len => 2},
+};
+
+sub rex_encode(%)
+{
+    my (%args) = @_;
+
+    $args{w} = 0 unless defined $args{w};
+    $args{r} = 0 unless defined $args{w};
+    $args{x} = 0 unless defined $args{w};
+    $args{b} = 0 unless defined $args{w};
+
+    return (value => 0x40
+            | (($args{w} ? 1 : 0) << 3)
+            | (($args{r} ? 1 : 0) << 2)
+            | (($args{x} ? 1 : 0) << 1)
+            | ($args{b} ? 1 : 0),
+            len => 1);
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


