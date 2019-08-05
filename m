Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5ACC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7601A20651
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp/kUjLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7601A20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufbV-0002gI-PQ
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58800)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufQ7-0000qb-1h
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufQ3-0003Dh-Oo
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:01:10 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufPw-00036u-AL; Mon, 05 Aug 2019 12:01:00 -0400
Received: by mail-pg1-x542.google.com with SMTP id l21so39966185pgm.3;
 Mon, 05 Aug 2019 09:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=3znpOFTOy6Kkt1wbPk8UVozOUH2PfLQX/0nXNxPTFuk=;
 b=Vp/kUjLSZGRbtumHU2Te6bluzcEycsjCyazOFCpKtwEkKblZnME/PczMWMjC7EjS99
 7fxcGTuqOTIHZdAd0r9URuQK0OndhQZColaDDbYUIDUes/P+UNv2GUAXY+XEWsaYNezI
 P3EOFQBG1FIamNxhbSbYxNyrafbhQhhzOIvorKqKo12rJbPTZ6d3URHUK1BF23Nae55j
 +ev9h1g5tttP2DOIf3bQ3BVR44ZD19ZuoxE1qEEdDgs27nRpeV9LZgpJtwhvKCijPlqy
 8tDVDo8e7HHXiI9ZyUCBPJPcYNlDtqP/oSRbke4ou0Ot8jYQQxodo1VC3Hk+8kSuVUVP
 jeyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=3znpOFTOy6Kkt1wbPk8UVozOUH2PfLQX/0nXNxPTFuk=;
 b=ZEBqKtNbjrrzD1D9rzZ/gDVeqiC5bUsDAWin1pIbNLsQa0AvZXw/bKnrBHS3foRl8/
 myY844kcRR+JkiYlAyaYMt2cW/atpleqoML1vfK3z+Fb6leYpwvoxlG1oojJms4CCyYL
 gwckUtSdipFiv3x6MLwA1t8ssqJ3JMJvyM1Y+OWRDsQESt7QqCKKRrPzKR/abYj0h12C
 bPyaPS8bTRlnerZE1pqFg1eqXeTSmmdmhnWvjqoOqx44k8JR4tHKBcaA8Da5uSbARZFo
 UOqFD3QfGk8b6PCqhLy6U9LowUcMPGriYy8kBsU1CdHqHcjktxOQH6iEK5gavOU05Y0h
 x5uQ==
X-Gm-Message-State: APjAAAUvqYfnrzAWvIFbqBoI+Z6wcUD6HCxtCe2EwINm8g7sNB2Y9CDU
 geuRGcZAay4QIzjqIFOeeWk=
X-Google-Smtp-Source: APXvYqwcWASYWZL7YclMvHJCaVeSezv0jeWNcrLNQkefaUoLKnlkzAxNkI9L+g+gDoOPH+2OLedYGg==
X-Received: by 2002:a62:ac11:: with SMTP id v17mr73833687pfe.236.1565020857409; 
 Mon, 05 Aug 2019 09:00:57 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d18sm47728793pgi.40.2019.08.05.09.00.56
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 05 Aug 2019 09:00:56 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Mon,  5 Aug 2019 09:00:22 -0700
Message-Id: <1565020823-24223-28-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH 27/28] riscv: virt: Change create_fdt() to
 return void
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no need to return fdt at the end of create_fdt() because
it's already saved in s->fdt. Other machines (sifive_u, spike)
don't do it neither.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/virt.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index f662100..5935ac8 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -112,7 +112,7 @@ static void create_pcie_irq_map(void *fdt, char *nodename,
                            0x1800, 0, 0, 0x7);
 }
 
-static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
+static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     uint64_t mem_size, const char *cmdline)
 {
     void *fdt;
@@ -316,8 +316,6 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
         qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
     }
     g_free(nodename);
-
-    return fdt;
 }
 
 
@@ -373,7 +371,6 @@ static void riscv_virt_board_init(MachineState *machine)
     size_t plic_hart_config_len;
     int i;
     unsigned int smp_cpus = machine->smp.cpus;
-    void *fdt;
 
     /* Initialize SOC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
@@ -392,7 +389,7 @@ static void riscv_virt_board_init(MachineState *machine)
         main_mem);
 
     /* create device tree */
-    fdt = create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
+    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
     /* boot rom */
     memory_region_init_rom(mask_rom, NULL, "riscv_virt_board.mrom",
@@ -411,9 +408,9 @@ static void riscv_virt_board_init(MachineState *machine)
             hwaddr end = riscv_load_initrd(machine->initrd_filename,
                                            machine->ram_size, kernel_entry,
                                            &start);
-            qemu_fdt_setprop_cell(fdt, "/chosen",
+            qemu_fdt_setprop_cell(s->fdt, "/chosen",
                                   "linux,initrd-start", start);
-            qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
+            qemu_fdt_setprop_cell(s->fdt, "/chosen", "linux,initrd-end",
                                   end);
         }
     }
-- 
2.7.4


