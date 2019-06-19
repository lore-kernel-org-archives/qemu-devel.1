Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4BEC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DABA208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsBXxwS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DABA208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35194 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdSs5-0002BL-FH
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 01:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34470)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hdSmZ-0003zK-AJ
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hdSmT-0001gG-Md
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:13 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:36158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hdSmT-0001eC-8N
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:09 -0400
Received: by mail-yb1-xb42.google.com with SMTP id w6so5406838ybo.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 22:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=apzfomw1VjtA9D2dSS+kh7pjyf0WWPI5EmgQzsdtCSA=;
 b=fsBXxwS5dG0WEWXBErwYpfFFEH6FcetgUzPrtuRHl9aM6jQbD5m9CFv6YCiAU9OdIL
 aUKtENARHTQhWIxh00b8O5uaO7o8GlVIDjlewrdY6loIahHlY45bntAWZEucxDBqHCVE
 OJji7oz8RHdoB/hW5vm3esfP7CWCGijdiUGYGR0mltXpZVK4ByGnvfHIAdl0XhblDmkL
 Dyhea7W/Gll6KLFVhNj6DUVTlXXUllV7zsidrDebwSB7PQUpFytpV6tr1a+mcm7kCuN/
 xECVoaxa8m2QDPEva3FExA+jW85bBkkrm3nDXMECIr0pkaXspt/D3YogxKQyW8lDLeVu
 ek5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=apzfomw1VjtA9D2dSS+kh7pjyf0WWPI5EmgQzsdtCSA=;
 b=hexsV6NnNlrTs82C/0aYoyq3qqNJcaeFat4+uiKS9XJyYFisNVOCy4aOQuv4RBksOW
 8m/asLp2BLGCmoUYkKicSpCc+ZUhK0YP+vE17+y2uopvkKm5PLR0VEMtJGDcBg0SOFDY
 vxbZTBCQg9gx962QZnuAu2AMmRRGr2OwMjaTPyCI6O1BUg2TYu2VdenABAD39si8f9Yk
 nM0Lqi4l/9KUIMIpKsoMWEpkU/j2KMj9ZJl1cqwG4rW6rYtNwJNngfigC0ksKhR8Ym5h
 Mn4qDAds/ugceznAPMPTdp42NLgES/wn6XfKS/awmmtSezdUY3Popn6UHFnpV0ptnT9s
 i4yw==
X-Gm-Message-State: APjAAAXk7Cf5VEA/DxKuN3Oo/fMhY59eMCF1ZIz0ggCnDYxiE8tOC7Ik
 yOcFVwwLdI3YsG9Jdy23kiHhasxr
X-Google-Smtp-Source: APXvYqzZPHPMyiRFH4YJz31wYpmmDYNfEdgArRUnS9v3xeAw5g0NibNDViqxDIBzTSwfoO442lg6cg==
X-Received: by 2002:a25:2e02:: with SMTP id u2mr59672832ybu.27.1560920705861; 
 Tue, 18 Jun 2019 22:05:05 -0700 (PDT)
Received: from localhost.localdomain (67-9-99-67.biz.bhn.net. [67.9.99.67])
 by smtp.gmail.com with ESMTPSA id e12sm1714426ywe.85.2019.06.18.22.05.04
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 18 Jun 2019 22:05:05 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 01:04:44 -0400
Message-Id: <20190619050447.22201-5-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619050447.22201-1-jan.bobek@gmail.com>
References: <20190619050447.22201-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RISU RFC PATCH v1 4/7] risugen_x86: add module
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

The risugen_x86.pm module contains most of the code specific to Intel
i386 and x86_64 architectures. This commit also adds --x86_64 option,
which enables emission of 64-bit (rather than 32-bit) assembly.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risugen        |   6 +-
 risugen_x86.pm | 455 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 460 insertions(+), 1 deletion(-)
 create mode 100644 risugen_x86.pm

diff --git a/risugen b/risugen
index fe3d00e..09a702a 100755
--- a/risugen
+++ b/risugen
@@ -310,6 +310,7 @@ Valid options:
                    Useful to test before support for FP is available.
     --sve        : enable sve floating point
     --be         : generate instructions in Big-Endian byte order (ppc64 only).
+    --x86_64     : generate 64-bit (rather than 32-bit) x86 code.
     --help       : print this message
 EOT
 }
@@ -322,6 +323,7 @@ sub main()
     my $fp_enabled = 1;
     my $sve_enabled = 0;
     my $big_endian = 0;
+    my $is_x86_64 = 0;
     my ($infile, $outfile);
 
     GetOptions( "help" => sub { usage(); exit(0); },
@@ -338,6 +340,7 @@ sub main()
                 },
                 "be" => sub { $big_endian = 1; },
                 "no-fp" => sub { $fp_enabled = 0; },
+                "x86_64" => sub { $is_x86_64 = 1; },
                 "sve" => sub { $sve_enabled = 1; },
         ) or return 1;
     # allow "--pattern re,re" and "--pattern re --pattern re"
@@ -372,7 +375,8 @@ sub main()
         'keys' => \@insn_keys,
         'arch' => $full_arch[0],
         'subarch' => $full_arch[1] || '',
-        'bigendian' => $big_endian
+        'bigendian' => $big_endian,
+        'x86_64' => $is_x86_64
     );
 
     write_test_code(\%params);
diff --git a/risugen_x86.pm b/risugen_x86.pm
new file mode 100644
index 0000000..879d6e1
--- /dev/null
+++ b/risugen_x86.pm
@@ -0,0 +1,455 @@
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
+# risugen_x86 -- risugen module for Intel i386/x86_64 architectures
+package risugen_x86;
+
+use strict;
+use warnings;
+
+use risugen_common;
+use risugen_x86_asm;
+use risugen_x86_emit;
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
+sub write_risuop($)
+{
+    my ($op) = @_;
+
+    write_insn(opcode => X86OP_UD1,
+               modrm => {mod => MOD_DIRECT,
+                         reg => REG_EAX,
+                         rm => $op});
+}
+
+sub write_mov_rr($$)
+{
+    my ($r1, $r2) = @_;
+
+    my %insn = (opcode => X86OP_MOV,
+                modrm => {mod => MOD_DIRECT,
+                          reg => ($r1 & 0x7),
+                          rm => ($r2 & 0x7)});
+
+    $insn{rex}{w} = 1 if $is_x86_64;
+    $insn{rex}{r} = 1 if $r1 >= 8;
+    $insn{rex}{b} = 1 if $r2 >= 8;
+
+    write_insn(%insn);
+}
+
+sub write_mov_reg_imm($$)
+{
+    my ($reg, $imm) = @_;
+
+    my %insn = (opcode => {value => 0xB8 | ($reg & 0x7), len => 1},
+                imm => {value => $imm, len => $is_x86_64 ? 8 : 4});
+
+    $insn{rex}{w} = 1 if $is_x86_64;
+    $insn{rex}{b} = 1 if $reg >= 8;
+
+    write_insn(%insn);
+}
+
+sub write_random_regdata()
+{
+    my $reg_cnt = $is_x86_64 ? 16 : 8;
+    my $bitlen = $is_x86_64 ? 64 : 32;
+
+    # initialize flags register
+    write_insn(opcode => X86OP_XOR,
+               modrm => {mod => MOD_DIRECT,
+                         reg => REG_EAX,
+                         rm => REG_EAX});
+    write_insn(opcode => X86OP_SAHF);
+
+    # general purpose registers
+    for (my $reg = 0; $reg < $reg_cnt; $reg++) {
+        if ($reg != REG_ESP) {
+            my $imm = randint_constr(bitlen => $bitlen, signed => 1);
+            write_mov_reg_imm($reg, $imm);
+        }
+    }
+}
+
+sub write_random_datablock($)
+{
+    my ($datalen) = @_;
+
+    # Write a block of random data, $datalen bytes long, aligned
+    # according to MAXALIGN, and load its address into EAX/RAX.
+
+    $datalen += MAXALIGN - 1;
+
+    # First, load current EIP/RIP into EAX/RAX. Easy to do on x86_64
+    # thanks to RIP-relative addressing, but on i386 we need to play
+    # some well-known tricks with CALL instruction.
+    if ($is_x86_64) {
+        # 4-byte AND + 5-byte JMP
+        my $disp32 = 4 + 5 + (MAXALIGN - 1);
+        my $reg = REG_EAX;
+
+        write_insn(rex => {w => 1},
+                   opcode => X86OP_LEA,
+                   modrm => {mod => MOD_INDIRECT,
+                             reg => $reg, rm => REG_EBP},
+                   disp => {value => $disp32, len => 4});
+
+        write_insn(rex => {w => 1},
+                   opcode => X86OP_ALU_imm8,
+                   modrm => {mod => MOD_DIRECT,
+                             reg => 4, rm => $reg},
+                   imm => {value => ~(MAXALIGN - 1),
+                           len => 1});
+
+    } else {
+        # 1-byte POP + 3-byte ADD + 3-byte AND + 5-byte JMP
+        my $imm8 = 1 + 3 + 3 + 5 + (MAXALIGN - 1);
+        my $reg = REG_EAX;
+
+        # displacement = next instruction
+        write_insn(opcode => X86OP_CALL,
+                   imm => {value => 0x00000000, len => 4});
+
+        write_insn(opcode => {value => 0x58 | ($reg & 0x7),
+                              len => 1});
+
+        write_insn(opcode => X86OP_ALU_imm8,
+                   modrm => {mod => MOD_DIRECT,
+                             reg => 0, rm => $reg},
+                   imm => {value => $imm8, len => 1});
+
+        write_insn(opcode => X86OP_ALU_imm8,
+                   modrm => {mod => MOD_DIRECT,
+                             reg => 4, rm => $reg},
+                   imm => {value => ~(MAXALIGN - 1),
+                           len => 1});
+    }
+
+    # JMP over the data blob.
+    write_insn(opcode => X86OP_JMP,
+               imm => {value => $datalen, len => 4});
+
+    # Generate the random data
+    for (my $w = 8; 0 < $w; $w /= 2) {
+        for (; $w <= $datalen; $datalen -= $w) {
+            insnv(%{rand_insn_imm(size => $w)});
+        }
+    }
+}
+
+sub write_random_xmmdata()
+{
+    my $xmm_cnt = $is_x86_64 ? 16 : 8;
+    my $xmm_len = 16;
+    my $datalen = $xmm_cnt * $xmm_len;
+
+    # Generate random data blob
+    write_random_datablock($datalen);
+
+    # Load the random data into XMM regs.
+    for (my $xmm_reg = 0; $xmm_reg < $xmm_cnt; $xmm_reg++) {
+        my %insn = (opcode => X86OP_MOVAPS,
+                    modrm => {mod => MOD_INDIRECT_DISP32,
+                              reg => ($xmm_reg & 0x7),
+                              rm => REG_EAX},
+                    disp => {value => $xmm_reg * $xmm_len,
+                             len => 4});
+
+        $insn{rex}{r} = 1 if $xmm_reg >= 8;
+
+        write_insn(%insn);
+    }
+}
+
+sub write_memblock_setup()
+{
+    # Generate random data blob
+    write_random_datablock(MEMBLOCK_LEN);
+    # Pointer is in EAX/RAX; set the memblock
+    write_risuop(RISUOP_SETMEMBLOCK);
+}
+
+sub write_random_register_data()
+{
+    write_random_xmmdata();
+    write_random_regdata();
+    write_risuop(RISUOP_COMPARE);
+}
+
+sub rand_insn_imm(%)
+{
+    my (%args) = @_;
+
+    return {
+        value => randint_constr(bitlen => ($args{size} * 8), signed => 1),
+        len => $args{size}
+    };
+}
+
+sub rand_insn_opcode($)
+{
+    # Given an instruction-details array, generate an instruction
+    my ($rec) = @_;
+    my $insnname = $rec->{name};
+    my $insnwidth = $rec->{width};
+
+    my $constraintfailures = 0;
+
+    INSN: while(1) {
+        my $opcode = randint_constr(bitlen => 32,
+                                    fixedbits => $rec->{fixedbits},
+                                    fixedbitmask => $rec->{fixedbitmask});
+
+        my $constraint = $rec->{blocks}{"constraints"};
+        if (defined $constraint) {
+            # user-specified constraint: evaluate in an environment
+            # with variables set corresponding to the variable fields.
+            my $v = eval_with_fields($insnname, $opcode, $rec, "constraints", $constraint);
+            if (!$v) {
+                $constraintfailures++;
+                if ($constraintfailures > 10000) {
+                    print "10000 consecutive constraint failures for $insnname constraints string:\n$constraint\n";
+                    exit (1);
+                }
+                next INSN;
+            }
+        }
+
+        # OK, we got a good one
+        $constraintfailures = 0;
+
+        return {
+            value => $opcode >> (32 - $insnwidth),
+            len => $insnwidth / 8
+        };
+    }
+}
+
+sub rand_insn_modrm($$)
+{
+    my ($opts, $insn) = @_;
+    my $modrm;
+
+    while (1) {
+        $modrm = rand_fill({mod => {bitlen => 2},
+                            reg => {bitlen => 3},
+                            rm => {bitlen => 3}},
+                           $opts);
+
+        if ($modrm->{mod} != MOD_DIRECT) {
+            # Displacement only; we cannot use this since we
+            # don't know absolute address of the memblock.
+            next if $modrm->{mod} == MOD_INDIRECT && $modrm->{rm} == REG_EBP;
+
+            if ($modrm->{rm} == REG_ESP) {
+                # SIB byte present
+                my $sib = rand_fill({ss => {bitlen => 2},
+                                     index => {bitlen => 3},
+                                     base => {bitlen => 3}}, {});
+
+                # We cannot modify ESP/RSP during the tests
+                next if $sib->{base} == REG_ESP;
+
+                # When base and index register are the same,
+                # computing the correct memblock addresses and
+                # offsets gets way too complicated...
+                next if $sib->{base} == $sib->{index};
+
+                # No base register
+                next if $modrm->{mod} == MOD_INDIRECT && $sib->{base} == REG_EBP;
+
+                $insn->{sib} = $sib;
+            }
+
+            $insn->{disp} = rand_insn_imm(size => 1)
+                if $modrm->{mod} == MOD_INDIRECT_DISP8;
+
+            $insn->{disp} = rand_insn_imm(size => 4)
+                if $modrm->{mod} == MOD_INDIRECT_DISP32;
+        }
+
+        $insn->{modrm} = $modrm;
+        last;
+    }
+}
+
+sub rand_insn_rex($$)
+{
+    my ($opts, $insn) = @_;
+
+    $opts->{w} = 0 unless defined $opts->{w};
+    $opts->{x} = 0 unless defined $opts->{x} || defined $insn->{sib};
+
+    my $rex = rand_fill({w => {bitlen => 1},
+                         r => {bitlen => 1},
+                         b => {bitlen => 1},
+                         x => {bitlen => 1}},
+                        $opts);
+
+    $insn->{rex} = $rex
+        if $rex->{w} || $rex->{r} || $rex->{b} || $rex->{x};
+}
+
+sub write_mem_getoffset($$)
+{
+    my ($opts, $insn) = @_;
+    my $offset, my $index;
+
+    $opts->{size}  = 0 unless defined $opts->{size};
+    $opts->{align} = 1 unless defined $opts->{align};
+
+    if (!defined $opts->{base}
+        && defined $insn->{modrm}
+        && $insn->{modrm}{mod} != MOD_DIRECT) {
+
+        $opts->{base} = (defined $insn->{sib}
+                         ? $insn->{sib}{base}
+                         : $insn->{modrm}{rm});
+
+        if ($insn->{modrm}{mod} == MOD_INDIRECT && $opts->{base} == REG_EBP) {
+            delete $opts->{base}; # No base register
+        } else {
+            $opts->{base} |= $insn->{rex}{b} << 3 if defined $insn->{rex};
+            $opts->{base} |= (!$insn->{vex}{b}) << 3 if defined $insn->{vex};
+        }
+    }
+
+    if (!defined $opts->{index} && defined $insn->{sib}) {
+        $opts->{index} = $insn->{sib}{index};
+        $opts->{index} |= $insn->{rex}{x} << 3 if defined $insn->{rex};
+        $opts->{index} |= (!$insn->{vex}{x}) << 3 if defined $insn->{vex};
+        delete $opts->{index} if $opts->{index} == REG_ESP; # ESP means "none"
+    }
+
+    $opts->{ss} = $insn->{sib}{ss} if !defined $opts->{ss} && defined $insn->{sib};
+    $opts->{disp} = $insn->{disp} if !defined $opts->{disp} && defined $insn->{disp};
+
+    $offset = int(rand(MEMBLOCK_LEN - $opts->{size}));
+    $offset &= ~($opts->{align} - 1);
+
+    $offset -= $opts->{disp}{value} if defined $opts->{disp};
+
+    if (defined $opts->{index}) {
+        $index = randint_constr(bitlen => 32, signed => 1);
+        $offset -= $index * (1 << $opts->{ss});
+    }
+
+    if (defined $opts->{base} && defined $offset) {
+        write_mov_reg_imm(REG_EAX, $offset);
+        write_risuop(RISUOP_GETMEMBLOCK);
+        write_mov_rr($opts->{base}, REG_EAX);
+    }
+    if (defined $opts->{index} && defined $index) {
+        write_mov_reg_imm($opts->{index}, $index);
+    }
+}
+
+sub gen_one_insn($)
+{
+    my ($rec) = @_;
+    my $insn;
+
+    $insn->{opcode} = rand_insn_opcode($rec);
+    my $opts = parse_emitblock($rec, $insn);
+
+    # Operation with a ModR/M byte can potentially use a memory
+    # operand
+    $opts->{mem} = {}
+        unless defined $opts->{mem} || !defined $opts->{modrm};
+
+    # If none of REX/VEX/EVEX are specified, default to REX
+    $opts->{rex} = {}
+        unless defined $opts->{rex} || defined $opts->{vex} || defined $opts->{evex};
+
+    # REX requires x86_64
+    delete $opts->{rex}
+        unless $is_x86_64;
+
+    $insn->{rep}    = $opts->{rep}    if defined $opts->{rep};
+    $insn->{repne}  = $opts->{repne}  if defined $opts->{repne};
+    $insn->{data16} = $opts->{data16} if defined $opts->{data16};
+
+    rand_insn_modrm($opts->{modrm}, $insn) if defined $opts->{modrm};
+
+    # TODO rand_insn_vex($opts->{vex}, $insn) if defined $opts->{vex};
+    # TODO rand_insn_evex($opts->{evex}, $insn) if defined $opts->{evex};
+    rand_insn_rex($opts->{rex}, $insn) if defined $opts->{rex};
+
+    $insn->{imm} = rand_insn_imm(%{$opts->{imm}}) if defined $opts->{imm};
+
+    write_mem_getoffset($opts->{mem}, $insn);
+    write_insn(%{$insn});
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
+    write_random_register_data();
+
+    for my $i (1..$numinsns) {
+        my $insn_enc = $keys[int rand (@keys)];
+        # my $forcecond = (rand() < $condprob) ? 1 : 0;
+        gen_one_insn($insn_details{$insn_enc});
+        write_risuop(RISUOP_COMPARE);
+        # Rewrite the registers periodically. This avoids the tendency
+        # for the VFP registers to decay to NaNs and zeroes.
+        if ($periodic_reg_random && ($i % 100) == 0) {
+            write_random_register_data();
+        }
+        progress_update($i);
+    }
+    write_risuop(RISUOP_TESTEND);
+    progress_end();
+    close_bin();
+}
+
+1;
-- 
2.20.1


