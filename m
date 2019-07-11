Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C16C742A1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B89D620872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5F9oOXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89D620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlheN-00063M-K7
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 18:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40448)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdJ-0001l2-5e
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdE-00043m-J0
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:43 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:40665)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlhd5-0003ek-Uf
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:37 -0400
Received: by mail-yb1-xb44.google.com with SMTP id i14so3194020ybp.7
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 15:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B/9ak8o8VhmXZsAeWLe+xR8AkOtaBvxJ+j0gYAHd5PM=;
 b=Q5F9oOXeNUupQ8Qvny2hcpWNO1bZarqIS5uyLsvWSNo0QrfssZgwhG7e9rOTiuZyQG
 EU6ZzN13UAK9US7t/LiCkdGV24UzcqPWLVgHRGqVvIJroASxG22xnm4bUiiLttXZ+ItX
 8hPbCo4Oat50R9ZF49sZIsAKmFU68Cht+zgCX4DpaF1qxmJ2tLopaB+gr+s7kfHoIGaK
 5RHjrzsNkVdpps6Iu7OC1bO97/UlGdmrztXTG6L4wzu5nM/WJT5BMX7NF95HkUo8TyKq
 JPOekVW1u5vluWFKDxb3KQiDwBrUgn4ze45y68DR17IbYSBX+vuzwqw3QbhE2k0vBwM0
 UnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B/9ak8o8VhmXZsAeWLe+xR8AkOtaBvxJ+j0gYAHd5PM=;
 b=a8bjudsL1s8nFMgfm+yxcQpeoqdTB8wHbzwr5guG1IMkVscrU2iIJs9YiYvOtjN3YS
 gIRzjQYXBIV+zFQD/feA9t/37dsktlbB7wDbL6vwOBd4oSmhSCA9FJx+7q/2x4t/rzf2
 SyY0ktkq1lFlVNypiw6jJA+TEd636ynPoem0q0t0ltxP/AkHSDTOV+LI9ahK/OwhZ0pG
 vw4huuygNR/6RNHqCP8jvQAPNfwTZ5pS3hlYPJP4hTZw3KwpVxFxFNOQ8MZa0MAmdDoN
 xansR/s4moLTIs+QQzeBa+c+vKmk0WSok+3eQoeuu2IjqupyWSSNeLYS9ujPpwdhZKMk
 1yBQ==
X-Gm-Message-State: APjAAAXuUGrSG4Y6IQmQcZEJdyd7eLQiuWsWQMLp/ODtxvk34osVbA4S
 9190IjXPAPr8sVLCGL4Wjbz4zQTi
X-Google-Smtp-Source: APXvYqyvb9aQ0tspvdRb0hh7HuxoTBm8zu9HwS79EGsSek5rZJO7DnbGIFmGx2BW9ksfZMcDynQxUw==
X-Received: by 2002:a05:6902:4e7:: with SMTP id
 w7mr3927734ybs.389.1562884396900; 
 Thu, 11 Jul 2019 15:33:16 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id z191sm1676728ywa.31.2019.07.11.15.33.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 15:33:16 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 18:32:48 -0400
Message-Id: <20190711223300.6061-7-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711223300.6061-1-jan.bobek@gmail.com>
References: <20190711223300.6061-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RISU PATCH v3 06/18] risugen_x86: add module
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

risugen_x86.pm is the main backend module for Intel i386 and x86_64
architectures; it orchestrates generation of the test code with
support from the rest of risugen_x86_* modules.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risugen_x86.pm | 518 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 518 insertions(+)
 create mode 100644 risugen_x86.pm

diff --git a/risugen_x86.pm b/risugen_x86.pm
new file mode 100644
index 0000000..ae11843
--- /dev/null
+++ b/risugen_x86.pm
@@ -0,0 +1,518 @@
+#!/usr/bin/perl -w
+###############################################################################
+# Copyright (c) 2019 Jan Bobek
+# All rights reserved. This program and the accompanying materials
+# are made available under the terms of the Eclipse Public License v1.0
+# which accompanies this distribution, and is available at
+# http://www.eclipse.org/legal/epl-v10.html
+#
+# Contributors:
+#     Jan Bobek - initial implementation
+###############################################################################
+
+# risugen_x86 -- risugen module for Intel i386/x86_64 architectures
+package risugen_x86;
+
+use strict;
+use warnings;
+
+use risugen_common;
+use risugen_x86_asm;
+use risugen_x86_constraints;
+use risugen_x86_memory;
+
+require Exporter;
+
+our @ISA    = qw(Exporter);
+our @EXPORT = qw(write_test_code);
+
+use constant {
+    RISUOP_COMPARE     => 0,        # compare registers
+    RISUOP_TESTEND     => 1,        # end of test, stop
+    RISUOP_SETMEMBLOCK => 2,        # eax is address of memory block (8192 bytes)
+    RISUOP_GETMEMBLOCK => 3,        # add the address of memory block to eax
+    RISUOP_COMPAREMEM  => 4,        # compare memory block
+
+    # Maximum alignment restriction permitted for a memory op.
+    MAXALIGN => 64,
+    MEMBLOCK_LEN => 8192,
+};
+
+my $periodic_reg_random = 1;
+my $is_x86_64 = 0;
+
+sub wrap_int32($)
+{
+    my ($x) = @_;
+    my $r = 1 << 31;
+    return ($x + $r) % (2 * $r) - $r;
+}
+
+sub asm_insn_risuop($)
+{
+    my ($op) = @_;
+    asm_insn_ud1(reg => REG_RAX, reg2 => $op);
+}
+
+sub asm_insn_movT(%)
+{
+    my (%args) = @_;
+
+    if ($is_x86_64) {
+        asm_insn_mov64(%args);
+    } else {
+        asm_insn_mov(%args);
+    }
+}
+
+sub asm_insn_movT_imm(%)
+{
+    my (%args) = @_;
+    my $imm = $args{imm}; delete $args{imm};
+
+    my $is_sint32 = (-0x80000000 <= $imm && $imm <= 0x7fffffff);
+    my $is_uint32 = (0 <= $imm && $imm <= 0xffffffff);
+
+    $args{$is_sint32 || $is_uint32 ? 'imm32' : 'imm64'} = $imm;
+    asm_insn_movT(%args);
+}
+
+sub asm_insn_addT(%)
+{
+    my (%args) = @_;
+
+    if ($is_x86_64) {
+        asm_insn_add64(%args);
+    } else {
+        asm_insn_add(%args);
+    }
+}
+
+sub asm_insn_negT(%)
+{
+    my (%args) = @_;
+
+    if ($is_x86_64) {
+        asm_insn_neg64(%args);
+    } else {
+        asm_insn_neg(%args);
+    }
+}
+
+sub asm_insn_xchgT(%)
+{
+    my (%args) = @_;
+
+    if ($is_x86_64) {
+        asm_insn_xchg64(%args);
+    } else {
+        asm_insn_xchg(%args);
+    }
+}
+
+sub write_random_regdata()
+{
+    my $reg_cnt = $is_x86_64 ? 16 : 8;
+    my $reg_width = $is_x86_64 ? 64 : 32;
+
+    # initialize flags register
+    asm_insn_xor(reg => REG_RAX, reg2 => REG_RAX);
+    asm_insn_sahf();
+
+    # general purpose registers
+    for (my $reg = 0; $reg < $reg_cnt; $reg++) {
+        if ($reg != REG_RSP) {
+            my $imm = randint(width => $reg_width, signed => 1);
+            asm_insn_movT_imm(reg => $reg, imm => $imm);
+        }
+    }
+}
+
+# At the end of this function, we can emit $datalen data-bytes which
+# will be skipped over at runtime, but whose address will be present
+# in EAX and optionally aligned.
+sub prepare_datablock(%)
+{
+    my (%args) = @_;
+    $args{align} = 0 unless defined $args{align} && $args{align} > 1;
+
+    # First, load current EIP/RIP into EAX/RAX. Easy to do on x86_64
+    # thanks to RIP-relative addressing, but on i386 we need to play
+    # some well-known tricks with the CALL instruction. Then, AND the
+    # EAX/RAX register with correct mask to obtain the aligned
+    # address.
+    my $reg = REG_RAX;
+
+    if ($is_x86_64) {
+        my $disp32 = 5;         # 5-byte JMP
+        $disp32 += 4 + ($args{align} - 1) if $args{align}; # 4-byte AND
+
+        asm_insn_lea64(reg => $reg, disp32 => $disp32);
+        asm_insn_and64(reg2 => $reg, imm8 => ~($args{align} - 1))
+            if $args{align};
+    } else {
+        my $imm8 = 1 + 3 + 5;   # 1-byte POP + 3-byte ADD + 5-byte JMP
+        $imm8 += 3 + ($args{align} - 1) if $args{align}; # 3-byte AND
+
+        # displacement = next instruction
+        asm_insn_call(imm32 => 0x00000000);
+        asm_insn_pop(reg => $reg);
+        asm_insn_add(reg2 => $reg, imm8 => $imm8);
+        asm_insn_and(reg2 => $reg, imm8 => ~($args{align} - 1))
+            if $args{align};
+    }
+
+    # JMP over the data blob.
+    asm_insn_jmp(imm32 => $args{datalen});
+}
+
+# Write a block of random data, $datalen bytes long, optionally
+# aligned, and load its address into EAX/RAX.
+sub write_random_datablock(%)
+{
+    my (%args) = @_;
+    prepare_datablock(%args);
+
+    # Generate the random data
+    my $datalen = $args{datalen};
+    for (my $w = 8; 0 < $w; $w /= 2) {
+        for (; $w <= $datalen; $datalen -= $w) {
+            my $value = randint(width => 8 * $w);
+            insnv(value => $value, width => 8 * $w);
+        }
+    }
+}
+
+sub write_random_vregdata(%)
+{
+    my (%args) = @_;
+    $args{ymm} = 0          unless defined $args{ymm};
+    $args{xmm} = $args{ymm} unless defined $args{xmm};
+    $args{mm}  = 0          unless defined $args{mm};
+
+    die "cannot initialize YMM registers only\n"
+        if $args{ymm} && !$args{xmm};
+
+    my $datalen = 0;
+
+    my $mmreg_count = 8;
+    my $mmreg_size  = 8;
+    $datalen += $mmreg_count * $mmreg_size if $args{mm};
+
+    my $xmmreg_count = $is_x86_64 ? 16 : 8;
+    my $xmmreg_size  = 16;
+    $datalen += $xmmreg_count * $xmmreg_size if $args{xmm};
+
+    my $ymmreg_count = $xmmreg_count;
+    my $ymmreg_size  = 32 - $xmmreg_size;
+    $datalen += $ymmreg_count * $ymmreg_size if $args{ymm};
+
+    return unless $datalen > 0;
+
+    # Generate random data blob
+    write_random_datablock(datalen => $datalen + MAXALIGN - 1,
+                           align => MAXALIGN);
+
+    # Load the random data into vector regs.
+    my $offset = 0;
+
+    if ($args{mm}) {
+        for (my $mmreg = 0; $mmreg < $mmreg_count; $mmreg += 1) {
+            asm_insn_movq(reg => $mmreg,
+                          base => REG_RAX,
+                          disp32 => $offset);
+            $offset += $mmreg_size;
+        }
+    }
+    if ($args{ymm}) {
+        for (my $ymmreg = 0; $ymmreg < $ymmreg_count; $ymmreg += 1) {
+            asm_insn_vmovaps(l => ($xmmreg_size + $ymmreg_size) * 8,
+                             reg => $ymmreg,
+                             base => REG_RAX,
+                             disp32 => $offset);
+            $offset += $xmmreg_size + $ymmreg_size;
+        }
+    } elsif ($args{xmm}) {
+        for (my $xmmreg = 0; $xmmreg < $xmmreg_count; $xmmreg += 1) {
+            asm_insn_movaps(reg => $xmmreg,
+                            base => REG_RAX,
+                            disp32 => $offset);
+            $offset += $xmmreg_size;
+        }
+    }
+}
+
+sub write_memblock_setup()
+{
+    # Generate random data blob
+    write_random_datablock(datalen => MEMBLOCK_LEN + MAXALIGN - 1,
+                           align => MAXALIGN);
+
+    # Pointer is in EAX/RAX; set the memblock
+    asm_insn_risuop(RISUOP_SETMEMBLOCK);
+}
+
+sub write_random_register_data(%)
+{
+    my (%args) = @_;
+    write_random_vregdata(%{$args{vregs}}) if defined $args{vregs};
+    write_random_regdata();
+    asm_insn_risuop(RISUOP_COMPARE);
+}
+
+sub write_mem_getoffset(%)
+{
+    my (%args) = @_;
+
+    my @tokens;
+    push @tokens, "BASE"   if defined $args{base};
+    push @tokens, "INDEX"  if defined $args{index};
+    push @tokens, "VINDEX" if defined $args{vindex};
+    push @tokens, "END";
+
+    # (BASE (INDEX | VINDEX)?)? END
+    my $token = shift @tokens;
+
+    if ($token eq "BASE") {
+        $token = shift @tokens;
+        # We must not modify RSP during tests, therefore it cannot be a
+        # base register.
+        return 0 if $args{base} == REG_RSP;
+
+        if ($token eq "VINDEX") {
+            $token = shift @tokens;
+
+            die "VSIB requested, but addrw undefined"
+                unless defined $args{addrw};
+            die "VSIB requested, but count undefined"
+                unless defined $args{count};
+
+            write_mem_getoffset_base_vindex(%args);
+        } elsif ($token eq "INDEX") {
+            $token = shift @tokens;
+            # RSP cannot be used as an index in regular SIB... And we may
+            # not modify it anyway.
+            return 0 if $args{index} == REG_RSP;
+            # If index and base registers are the same, we may not be able
+            # to honor the alignment requirements.
+            return 0 if $args{index} == $args{base};
+
+            write_mem_getoffset_base_index(%args);
+        } else {
+            write_mem_getoffset_base(%args);
+        }
+    }
+
+    die "unexpected junk at the end of getoffset tokens: $token @tokens\n"
+        unless $token eq "END";
+}
+
+sub write_mem_getoffset_base(%)
+{
+    my (%args) = @_;
+
+    if ($args{mask}) {
+        die "size $args{size} is too large for masking"
+            unless $args{size} <= 8;
+        die "simultaneous alignment and masking not supported"
+            if $args{align} > 1;
+
+        prepare_datablock(datalen => $args{size});
+
+        my $width = $args{size} * 8;
+        my $value = randint(width => $width);
+        $value = ($value & ~$args{mask}) | ($args{value} & $args{mask});
+        insnv(value => $value, width => $width, bigendian => 0);
+
+        my $offset = -$args{disp};
+        $offset = wrap_int32($offset) if !$is_x86_64;
+
+        asm_insn_movT_imm(reg => REG_RDX, imm => $offset);
+        asm_insn_addT(reg2 => REG_RAX, reg => REG_RDX);
+    } else {
+        my $offset = int(rand(MEMBLOCK_LEN - $args{size}));
+        $offset &= ~($args{align} - 1);
+
+        $offset -= $args{disp};
+        $offset = wrap_int32($offset) if !$is_x86_64;
+
+        asm_insn_movT_imm(reg => REG_RAX, imm => $offset);
+        asm_insn_risuop(RISUOP_GETMEMBLOCK);
+    }
+
+    asm_insn_xchgT(reg => $args{base}, reg2 => REG_RAX)
+        unless $args{base} == REG_RAX;
+}
+
+sub write_mem_getoffset_base_index(%)
+{
+    my (%args) = @_;
+
+    my $addrw = ($is_x86_64 ? 64 : 32) - $args{ss} - 1;
+    my $index = randint(width => $addrw, signed => 1);
+    $args{disp} += $index * (1 << $args{ss});
+
+    write_mem_getoffset_base(%args);
+    asm_insn_movT_imm(reg => $args{index}, imm => $index);
+}
+
+sub write_mem_getoffset_base_vindex(%)
+{
+    my (%args) = @_;
+
+    my $addrw = $args{addrw} - $args{ss} - 1;
+    my $base = randint(width => $addrw, signed => 1);
+    $args{disp} += $base * (1 << $args{ss});
+
+    my $datalen = $args{addrw} * $args{count} / 8;
+    prepare_datablock(datalen => $datalen);
+
+    for(my $i = 0; $i < $args{count}; ++$i) {
+        my $index = int(rand(MEMBLOCK_LEN - $args{size}));
+        $index &= ~($args{align} - 1);
+        $index >>= $args{ss};
+
+        insnv(value => $base + $index,
+              width => $args{addrw},
+              bigendian => 0);
+    }
+
+    asm_insn_vmovdqu(l => $args{addrw} * $args{count},
+                     reg => $args{vindex},
+                     base => REG_RAX);
+
+    write_mem_getoffset_base(%args, size => MEMBLOCK_LEN);
+}
+
+sub write_mem_getoffset_rollback(%)
+{
+    my (%args) = @_;
+
+    # The base register contains an address of the form &memblock +
+    # offset. We need to turn it into just offset, otherwise we may
+    # get value mismatches since the memory layout can be different.
+    asm_insn_xchgT(reg => $args{base}, reg2 => REG_RAX)
+        unless $args{base} == REG_RAX;
+    asm_insn_negT(reg2 => REG_RAX);
+    asm_insn_risuop(RISUOP_GETMEMBLOCK);
+
+    # I didn't originally think this was neccessary, but there were
+    # random sign-flag mismatch failures on 32-bit, probably due to
+    # the absolute address being randomly in the positive/negative
+    # range of int32 -- the first NEG would then pollute the EFLAGS
+    # register with this information. Using another NEG is a neat
+    # way of overwriting all this information with consistent values.
+    asm_insn_negT(reg2 => REG_RAX);
+}
+
+sub gen_one_insn($)
+{
+    # Given an instruction-details array, generate an instruction
+    my ($rec) = @_;
+    my $insnname = $rec->{name};
+    my $insnwidth = $rec->{width};
+
+    my $constraintfailures = 0;
+
+    my %insn;
+    my %memopts;
+    INSN: while(1) {
+        my $opcode = randint(width => 32);
+        $opcode &= ~$rec->{fixedbitmask};
+        $opcode |= $rec->{fixedbits};
+
+        # This is not 100 % correct, since $opcode is still padded to
+        # 32-bit width. This is necessary so that extract_fields in
+        # eval_constraints_block and eval_memory_block works
+        # correctly, but we need to fix it up before calling asm_insn.
+        %insn                = ();
+        $insn{opcode}{value} = $opcode;
+        $insn{opcode}{width} = $insnwidth;
+
+        my $v = eval_constraints_block(rec => $rec, insn => \%insn,
+                                       is_x86_64 => $is_x86_64);
+        if ($v && !$is_x86_64 && defined $insn{rex}) {
+            # REX.W is part of the opcode; we will never be able to
+            # generate this instruction in 32-bit mode.
+            return 0 if defined $insn{rex}{w} && $insn{rex}{w};
+            $v = 0;
+        }
+        if ($v) {
+            %memopts = eval_memory_block(rec => $rec, insn => \%insn);
+            $v = write_mem_getoffset(%memopts);
+        }
+        if (!$v) {
+            $constraintfailures++;
+            if ($constraintfailures > 10000) {
+                print "10000 consecutive constraint failures for $insnname constraints\n";
+                exit (1);
+            }
+            next INSN;
+        }
+
+        # OK, we got a good one
+        $constraintfailures = 0;
+
+        # Get rid of the extra padding before calling asm_insn; see
+        # above for details.
+        $insn{opcode}{value} >>= 32 - $insnwidth;
+
+        asm_insn(%insn);
+        write_mem_getoffset_rollback(%memopts) if $memopts{rollback};
+        asm_insn_risuop(RISUOP_COMPAREMEM)     if $memopts{is_write};
+        asm_insn_risuop(RISUOP_COMPARE);
+
+        return 1;
+    }
+}
+
+sub write_test_code($)
+{
+    my ($params) = @_;
+
+    my $numinsns = $params->{ 'numinsns' };
+    my $outfile = $params->{ 'outfile' };
+
+    my %insn_details = %{ $params->{ 'details' } };
+    my @keys = @{ $params->{ 'keys' } };
+
+    $is_x86_64 = $params->{ 'x86_64' };
+    my $xfeatures = $params->{ 'xfeatures' };
+
+    my %vregs   = ();
+    $vregs{ymm} = $xfeatures eq 'avx';
+    $vregs{xmm} = $vregs{ymm} || $xfeatures eq 'sse';
+    $vregs{mm}  = $vregs{xmm} || $xfeatures eq 'mmx';
+
+    open_bin($outfile);
+
+    # TODO better random number generator?
+    srand(0);
+
+    print "Generating code using patterns: @keys...\n";
+    progress_start(78, $numinsns);
+
+    write_memblock_setup();
+
+    # memblock setup doesn't clean its registers, so this must come afterwards.
+    write_random_register_data(vregs => \%vregs);
+
+    for (my $i = 0; $i < $numinsns;) {
+        my $insn_enc = $keys[int rand (@keys)];
+
+        next if !gen_one_insn($insn_details{$insn_enc});
+        $i += 1;
+
+        # Rewrite the registers periodically. This avoids the tendency
+        # for the VFP registers to decay to NaNs and zeroes.
+        if ($periodic_reg_random && ($i % 100) == 0) {
+            write_random_register_data(vregs => \%vregs);
+        }
+        progress_update($i);
+    }
+    asm_insn_risuop(RISUOP_TESTEND);
+    progress_end();
+    close_bin();
+}
+
+1;
-- 
2.20.1


