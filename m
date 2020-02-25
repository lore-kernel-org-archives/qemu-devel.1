Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EEDC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C142084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7YbSzmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C142084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Z1E-0004ux-VU
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:08:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykh-0000q6-AP
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykd-0007QN-Cc
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:51 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:37504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykd-0007IF-48
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:47 -0500
Received: by mail-wr1-x42c.google.com with SMTP id l5so10127380wrx.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nYheH1M1FZDgO9rIttffb0yGCNjxEvlOTqwWzEb9bFU=;
 b=g7YbSzmS4EcJTeVypOFvY7+wIyOCOZtVynZB7ZXTEGHJ9uJu8H3s1rUmENFnGTtHvz
 pceS5U3j4st4r1x+vpV8NfRLekEt0AIiPyy4tr4+ImA3I2Xsb2TBJyFZcI+Lr68xgnOF
 z37BH2TCV8PkHzbYqsb92CdMlcZfpNi1m9IauagrLXzOoD8vT/x0bfLuxEr9EBiFirtu
 +e7UiBxGC0uDYhmgObKv+2bIWWWDkuRIazPrItkLGFGYISjSgw0Bj0KtCNASS7g6UGQl
 xHFxMMho4QimswgWpKMce5QxWhlOVve8KJvZmFocC89bFHp3gqe1B7vId8z5h6j3quqb
 +5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nYheH1M1FZDgO9rIttffb0yGCNjxEvlOTqwWzEb9bFU=;
 b=WP/JW3LvnpehAKJRYEw+s/y2+MM6OpGCUcpIjKFX+gy1IQ0rZfPyPCU3345SgUcSSB
 AiBc/CQSeVSvMIDV7XExwcEJ8MMyMPyI2hGg3AT26AKmv+UE9sVp5jmra023KqLqSU4h
 Hj4aJQAVQ4DFVP7nU1yzplYxL2ekaO5r0F/DID2xnhwNINhMyWy+ayXiPeZtc75rhXL8
 rMBTOmzZffMYfG+bddro8XXjTNEkBgLt+hvDJati9ygcjaySJ1NrpwIUnKK8YqzXI6sN
 03ZXNd6xLFvYjvwLAVg5XWAgn8mwg/dl7ZlcyWd96Q5LJBNLUleinhFip4qWOXU/Gi9n
 6Z4w==
X-Gm-Message-State: APjAAAXEikQpEDMqySS4/Zxbk94tARF6nu2VetwZocxgvCh1MTKlt1Cr
 ZsWCqQZClAEQ/JDOoYKtNAr6qN62
X-Google-Smtp-Source: APXvYqzWxlV3B6uJFrx5lIxry0Oin176Yx68CeIWn7EJMtMdA8f9N5/hNynNo2VNmK3O8PYsozbWYw==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr74403594wrp.54.1582631505640; 
 Tue, 25 Feb 2020 03:51:45 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 042/136] x86/microvm: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:32 +0100
Message-Id: <1582631466-13880-42-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219160953.13771-43-imammedo@redhat.com>
---
 hw/i386/microvm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index d234851..38d8e51 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -167,7 +167,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
 {
     MachineState *machine = MACHINE(mms);
     X86MachineState *x86ms = X86_MACHINE(mms);
-    MemoryRegion *ram, *ram_below_4g, *ram_above_4g;
+    MemoryRegion *ram_below_4g, *ram_above_4g;
     MemoryRegion *system_memory = get_system_memory();
     FWCfgState *fw_cfg;
     ram_addr_t lowmem;
@@ -214,12 +214,8 @@ static void microvm_memory_init(MicrovmMachineState *mms)
         x86ms->below_4g_mem_size = machine->ram_size;
     }
 
-    ram = g_malloc(sizeof(*ram));
-    memory_region_allocate_system_memory(ram, NULL, "microvm.ram",
-                                         machine->ram_size);
-
     ram_below_4g = g_malloc(sizeof(*ram_below_4g));
-    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", ram,
+    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", machine->ram,
                              0, x86ms->below_4g_mem_size);
     memory_region_add_subregion(system_memory, 0, ram_below_4g);
 
@@ -227,7 +223,8 @@ static void microvm_memory_init(MicrovmMachineState *mms)
 
     if (x86ms->above_4g_mem_size > 0) {
         ram_above_4g = g_malloc(sizeof(*ram_above_4g));
-        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g", ram,
+        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g",
+                                 machine->ram,
                                  x86ms->below_4g_mem_size,
                                  x86ms->above_4g_mem_size);
         memory_region_add_subregion(system_memory, 0x100000000ULL,
@@ -502,6 +499,7 @@ static void microvm_class_init(ObjectClass *oc, void *data)
     mc->auto_enable_numa_with_memhp = false;
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
     mc->nvdimm_supported = false;
+    mc->default_ram_id = "microvm.ram";
 
     /* Avoid relying too much on kernel components */
     mc->default_kernel_irqchip_split = true;
-- 
1.8.3.1



