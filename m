Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01662C2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 23:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F6D20692
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 23:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uy5Qpd3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F6D20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLbaJ-0001Hf-RR
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 19:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLbZT-0000n2-C2
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 19:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLbZR-0005Vv-3m
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 19:54:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLbZO-0005UT-4p
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 19:54:25 -0400
Received: by mail-wr1-x444.google.com with SMTP id g3so1758176wrx.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 16:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R34IvQ59WmZYOufinMiSA1+L9itPdN9/G4aCeSyFXAk=;
 b=uy5Qpd3v8o0Mc5WpPM+GtArMTjVmrmFJs7HjpzUf9AUaU2CY50+AWL4H+O6BKepO2p
 rQYvxCd9INO3R0o++rfRtOdveUeSw1OtwBMlhhqTT2V9YppbFJ1jVpIZpNqKn+i2XYB3
 WfufxmXJyPjssAsRf57rf7/LSQbO/ZNN0kAY98qXginVw3mRjDT1oO8XlwUdVSFa+5V3
 FryILhBvWuMg2J2we+DKrC58LKssVytxBWBNtSpZIjDPhGOY+zWog+UpFAA/O+wWMRwX
 pQ+SoqYlvjHEiNpjIvii/Pl/xmDfQA6ZNkactksGcztihkkuN/2Bjfgostzj5YJJWiF/
 kW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=R34IvQ59WmZYOufinMiSA1+L9itPdN9/G4aCeSyFXAk=;
 b=YIRfP+CU4krIhVRIqj+h5Taxxna5ao5e2Vura9xT8fXmPm/qXOSGN3qvhhBa03+tpd
 96pifS8qMpOShqvuqS1N1z9OWgsUaq1aQFM6ZyT9304LiUogmIGO2ubJfVXOaQmy/tL5
 6UP5EL8CXp3LJNa4uF9LcEVpCd8OfXm5RUJv8zN87Pwa4L4IYXRuyKa3/50hLHnQxF/E
 gvRoN57kL8e/yV5PJF7WRhqc6IK+CVktxtBcRwNGjGY/a+7eanCvWc5j6k0iLriFIajR
 hR2LBQ0yOC/2wXo3Df40N8fSVvwCzeqRwOpQcxPC32dWAsC2Rfp//6imRdUq71+b6vPE
 BNzw==
X-Gm-Message-State: AGi0PubOLHHQXiNdoj9nUDBmO1CtZeIzXLQYq91R78+rTolS/YH+2YC0
 SMsXxIn0Gpahgw3lfhfMzPmTs6YYbek=
X-Google-Smtp-Source: APiQypJOdoRWFfQAkX5GrzwAEUTeYVPs/p50/GxqY4eGqWTHv0NlZJzPw6BA5b7ecbHk+wOyvH4tEQ==
X-Received: by 2002:adf:aacf:: with SMTP id i15mr1720116wrc.31.1586217260807; 
 Mon, 06 Apr 2020 16:54:20 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id n124sm1506856wma.11.2020.04.06.16.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 16:54:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.0?] target/mips/translate: Report exception in delay
 slot as UNPREDICTABLE
Date: Tue,  7 Apr 2020 01:54:18 +0200
Message-Id: <20200406235418.18315-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 "Emilio G . Cota" <cota@braap.org>, Brian Campbell <bacam@z273.org.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using the BC1ANY4F instruction with a 24Kf core (MIPS32R2
& ASE_MIPS16) we get:

  $ echo -ne '\x03\x20\xf8\x09EEEE' > cop1x.bin
  $ qemu-system-mipsel -bios cop1x.bin
  unknown branch 0x13000
  Aborted (core dumped)

  (gdb) bt
  #0  0x00007fe2d38b1e35 in raise () at /lib64/libc.so.6
  #1  0x00007fe2d389c895 in abort () at /lib64/libc.so.6
  #2  0x000055aa9fe066e5 in gen_branch (ctx=0x7fe27bdfa590, insn_bytes=4) at target/mips/translate.c:13167
  #3  0x000055aa9fe2baf4 in mips_tr_translate_insn (dcbase=0x7fe27bdfa590, cs=0x55aaa0e2d530) at target/mips/translate.c:30928
  #4  0x000055aa9fd40138 in translator_loop (ops=0x55aaa05e94e0 <mips_tr_ops>, db=0x7fe27bdfa590, cpu=0x55aaa0e2d530, tb=0x7fe284000040 <code_gen_buffer+19>, max_insns=512) at accel/tcg/translator.c:102
  #5  0x000055aa9fe2bd21 in gen_intermediate_code (cs=0x55aaa0e2d530, tb=0x7fe284000040 <code_gen_buffer+19>, max_insns=512) at target/mips/translate.c:30999
  #6  0x000055aa9fd3e3d4 in tb_gen_code (cpu=0x55aaa0e2d530, pc=3217031168, cs_base=0, flags=268435600, cflags=-16252928) at accel/tcg/translate-all.c:1718
  #7  0x000055aa9fd3ac06 in tb_find (cpu=0x55aaa0e2d530, last_tb=0x0, tb_exit=0, cf_mask=524288) at accel/tcg/cpu-exec.c:407
  #8  0x000055aa9fd3b4d5 in cpu_exec (cpu=0x55aaa0e2d530) at accel/tcg/cpu-exec.c:731
  #9  0x000055aa9fcfe33a in tcg_cpu_exec (cpu=0x55aaa0e2d530) at cpus.c:1405
  #10 0x000055aa9fcfeb90 in qemu_tcg_cpu_thread_fn (arg=0x55aaa0e2d530) at cpus.c:1713
  #11 0x000055aaa02ea7d7 in qemu_thread_start (args=0x55aaa0e465f0) at util/qemu-thread-posix.c:519
  #12 0x00007fe2d3a484c0 in start_thread () at /lib64/libpthread.so.0
  #13 0x00007fe2d3976163 in clone () at /lib64/libc.so.6

This is because this COP1X instruction generates a Reserved
Instruction when used with this core, however we are in a delay
slot, and exceptions in delay slot are architecturally unpredictable.

Core dumps confunse users. Instead, report a friendlier error message:

  $ qemu-system-mipsel -bios cop1x.bin
  qemu-system-mipsel: Exception in delay slot is UNPREDICTABLE

Buglink: https://bugs.launchpad.net/qemu/+bug/1663287
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/translate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 25b595a17d..99e675b87a 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -30925,6 +30925,10 @@ static void mips_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
         }
     }
     if (is_slot) {
+        if (ctx->base.is_jmp == DISAS_NORETURN) {
+            error_report("Exception in delay slot is UNPREDICTABLE");
+            exit(1);
+        }
         gen_branch(ctx, insn_bytes);
     }
     ctx->base.pc_next += insn_bytes;
-- 
2.21.1


