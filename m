Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC1AC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C7920CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+9OLVgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C7920CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZHe-0002eF-P7
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl4-0001Hw-4n
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykz-0008G8-7d
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:13 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:46195)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykx-00087m-Bi
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:08 -0500
Received: by mail-wr1-x42f.google.com with SMTP id j7so1846097wrp.13
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Wy/hTC4M53RG4GlPKERaNnkC2pTRYgWJEWTsrSUSxck=;
 b=Z+9OLVghDkpvvdM0t9+uMSrKXuYjdRZk/DL3ds5LwqaDRUl4zCJLcUtmpGkIgFr4tm
 Aob9DnqkuLd3DrWwukuOn8+puhzc+Sww6rxvjAhP1qZPMwdi0IG4xPrFJs/GNdYlAK9Z
 kW12KM6irqLlC9C/Bl7mN5QcAvhsn/yh1l9MxfqaZrHYFJCoxD/DjleQx9KbmK382a7P
 TwIZMxoGkkK+boHDuSGoGeXwU9t8dwFxQM5gsBN+4xnr8DWVZCjgxYGfO6RD0d2N8mj5
 lw1IR+4eXi7JXFi0isUPXw2by7a+Bqu7OpRuR3Opl8cjiFcI1DQs3NqR/UEI/SKZerlF
 Hv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Wy/hTC4M53RG4GlPKERaNnkC2pTRYgWJEWTsrSUSxck=;
 b=qDeSiRlrmawDxYlu7sOJigniQsgbhArzhzv1+pI20GI3emmiTNpgAxFs07+cXvhOLt
 F4RCZVRlhxeq6l8t0bNm/pGOkLEnAXBFvL+EvRzmFc/2VJFHFYRpR9XX/1ZvoAAqU47J
 Fb+1GuHpVPqdJdt993bAgQYzIIhx7C+NILzM9So3LetoBngo3UvCDYFDGz1GaFyKFO+4
 fozyj/99vhsTdg3MU97vGlYlUgTdK4Y4ZVe0EZRRcsb+QXunKZX26zLgU+eQf07pqyt2
 hbxpttXUgVPc5kG/ewhq0rwNdXClrC8wu9Dk2BvqSbJn2PAsaNCJ2f7KQUoSKsNyvrct
 lqyQ==
X-Gm-Message-State: APjAAAXxjE0z4NMUy/szswlkgwBfm7cfSqDB9nOynhtmn/tKmAw6gb9L
 zA/N/GCBkSgscGSGIOBccvg9t25o
X-Google-Smtp-Source: APXvYqyDJYBE4Xlo0dpWYSzhRGfa/ledJf5xwhUW3Z2+0ndgRsa6msEzoZSlAO5Nbz9ax7Sij0kpTg==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr70255021wrq.176.1582631525819; 
 Tue, 25 Feb 2020 03:52:05 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 065/136] ppc/{ppc440_bamboo, sam460ex}: drop RAM size fixup
Date: Tue, 25 Feb 2020 12:49:55 +0100
Message-Id: <1582631466-13880-65-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

If user provided non-sense RAM size, board will complain and
continue running with max RAM size supported or sometimes
crash like this:
  %QEMU -M bamboo -m 1
    exec.c:1926: find_ram_offset: Assertion `size != 0' failed.
    Aborted (core dumped)
Also RAM is going to be allocated by generic code, so it won't be
possible for board to fix things up for user.

Make it error message and exit to force user fix CLI,
instead of accepting non-sense CLI values.
That also fixes crash issue, since wrongly calculated size
isn't used to allocate RAM

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20200219160953.13771-66-imammedo@redhat.com>
---
 hw/ppc/ppc440_bamboo.c  | 11 ++++-----
 hw/ppc/ppc4xx_devs.c    | 60 ++++++++++++++++++++++++++-----------------------
 hw/ppc/sam460ex.c       |  5 ++---
 include/hw/ppc/ppc4xx.h |  9 ++++----
 4 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index da777ef..7e3bc0e 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -158,7 +158,6 @@ static void main_cpu_reset(void *opaque)
 
 static void bamboo_init(MachineState *machine)
 {
-    ram_addr_t ram_size = machine->ram_size;
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
@@ -203,10 +202,8 @@ static void bamboo_init(MachineState *machine)
     /* SDRAM controller */
     memset(ram_bases, 0, sizeof(ram_bases));
     memset(ram_sizes, 0, sizeof(ram_sizes));
-    ram_size = ppc4xx_sdram_adjust(ram_size, PPC440EP_SDRAM_NR_BANKS,
-                                   ram_memories,
-                                   ram_bases, ram_sizes,
-                                   ppc440ep_sdram_bank_sizes);
+    ppc4xx_sdram_banks(machine->ram_size, PPC440EP_SDRAM_NR_BANKS, ram_memories,
+                       ram_bases, ram_sizes, ppc440ep_sdram_bank_sizes);
     /* XXX 440EP's ECC interrupts are on UIC1, but we've only created UIC0. */
     ppc4xx_sdram_init(env, pic[14], PPC440EP_SDRAM_NR_BANKS, ram_memories,
                       ram_bases, ram_sizes, 1);
@@ -268,7 +265,7 @@ static void bamboo_init(MachineState *machine)
     /* Load initrd. */
     if (initrd_filename) {
         initrd_size = load_image_targphys(initrd_filename, RAMDISK_ADDR,
-                                          ram_size - RAMDISK_ADDR);
+                                          machine->ram_size - RAMDISK_ADDR);
 
         if (initrd_size < 0) {
             error_report("could not load ram disk '%s' at %x",
@@ -279,7 +276,7 @@ static void bamboo_init(MachineState *machine)
 
     /* If we're loading a kernel directly, we must load the device tree too. */
     if (kernel_filename) {
-        if (bamboo_load_device_tree(FDT_ADDR, ram_size, RAMDISK_ADDR,
+        if (bamboo_load_device_tree(FDT_ADDR, machine->ram_size, RAMDISK_ADDR,
                                     initrd_size, kernel_cmdline) < 0) {
             error_report("couldn't load device tree");
             exit(1);
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index c2e5013..d89008a 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -668,21 +668,22 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
 
 /* Fill in consecutive SDRAM banks with 'ram_size' bytes of memory.
  *
- * sdram_bank_sizes[] must be 0-terminated.
+ * sdram_bank_sizes[] must be in descending order, that is sizes[i] > sizes[i+1]
+ * and must be 0-terminated.
  *
  * The 4xx SDRAM controller supports a small number of banks, and each bank
  * must be one of a small set of sizes. The number of banks and the supported
  * sizes varies by SoC. */
-ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
-                               MemoryRegion ram_memories[],
-                               hwaddr ram_bases[],
-                               hwaddr ram_sizes[],
-                               const ram_addr_t sdram_bank_sizes[])
+void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
+                        MemoryRegion ram_memories[],
+                        hwaddr ram_bases[], hwaddr ram_sizes[],
+                        const ram_addr_t sdram_bank_sizes[])
 {
     MemoryRegion *ram = g_malloc0(sizeof(*ram));
     ram_addr_t size_left = ram_size;
     ram_addr_t base = 0;
     ram_addr_t bank_size;
+    int last_bank = 0;
     int i;
     int j;
 
@@ -690,7 +691,12 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
         for (j = 0; sdram_bank_sizes[j] != 0; j++) {
             bank_size = sdram_bank_sizes[j];
             if (bank_size <= size_left) {
+                ram_bases[i] = base;
+                ram_sizes[i] = bank_size;
+                base += bank_size;
                 size_left -= bank_size;
+                last_bank = i;
+                break;
             }
         }
         if (!size_left) {
@@ -699,34 +705,32 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
         }
     }
 
-    ram_size -= size_left;
     if (size_left) {
-        error_report("Truncating memory to %" PRId64 " MiB to fit SDRAM"
-                     " controller limits", ram_size / MiB);
+        ram_addr_t used_size = ram_size - size_left;
+        GString *s = g_string_new(NULL);
+
+        for (i = 0; sdram_bank_sizes[i]; i++) {
+            g_string_append_printf(s, "%" PRIi64 "%s",
+                                   sdram_bank_sizes[i] / MiB,
+                                   sdram_bank_sizes[i + 1] ? " ," : "");
+        }
+        error_report("Max %d banks of %s MB DIMM/bank supported",
+            nr_banks, s->str);
+        error_report("Possible valid RAM size: %" PRIi64,
+            used_size ? used_size / MiB : sdram_bank_sizes[i - 1] / MiB);
+
+        g_string_free(s, true);
+        exit(EXIT_FAILURE);
     }
 
     memory_region_allocate_system_memory(ram, NULL, "ppc4xx.sdram", ram_size);
 
-    size_left = ram_size;
-    for (i = 0; i < nr_banks && size_left; i++) {
-        for (j = 0; sdram_bank_sizes[j] != 0; j++) {
-            bank_size = sdram_bank_sizes[j];
-
-            if (bank_size <= size_left) {
-                char name[32];
-                snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
-                memory_region_init_alias(&ram_memories[i], NULL, name, ram,
-                                         base, bank_size);
-                ram_bases[i] = base;
-                ram_sizes[i] = bank_size;
-                base += bank_size;
-                size_left -= bank_size;
-                break;
-            }
-        }
+    for (i = 0; i <= last_bank; i++) {
+        char name[32];
+        snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
+        memory_region_init_alias(&ram_memories[i], NULL, name, ram,
+                                 ram_bases[i], ram_sizes[i]);
     }
-
-    return ram_size;
 }
 
 /*****************************************************************************/
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 89bc70e..17d40bd 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -324,9 +324,8 @@ static void sam460ex_init(MachineState *machine)
     /* SDRAM controller */
     /* put all RAM on first bank because board has one slot
      * and firmware only checks that */
-    machine->ram_size = ppc4xx_sdram_adjust(machine->ram_size, 1,
-                                   ram_memories, ram_bases, ram_sizes,
-                                   ppc460ex_sdram_bank_sizes);
+    ppc4xx_sdram_banks(machine->ram_size, 1, ram_memories, ram_bases, ram_sizes,
+                       ppc460ex_sdram_bank_sizes);
 
     /* FIXME: does 460EX have ECC interrupts? */
     ppc440_sdram_init(env, SDRAM_NR_BANKS, ram_memories,
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index 7d82259..b8c8f32 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -42,11 +42,10 @@ enum {
 qemu_irq *ppcuic_init (CPUPPCState *env, qemu_irq *irqs,
                        uint32_t dcr_base, int has_ssr, int has_vr);
 
-ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
-                               MemoryRegion ram_memories[],
-                               hwaddr ram_bases[],
-                               hwaddr ram_sizes[],
-                               const ram_addr_t sdram_bank_sizes[]);
+void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
+                        MemoryRegion ram_memories[],
+                        hwaddr ram_bases[], hwaddr ram_sizes[],
+                        const ram_addr_t sdram_bank_sizes[]);
 
 void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
                         MemoryRegion ram_memories[],
-- 
1.8.3.1



