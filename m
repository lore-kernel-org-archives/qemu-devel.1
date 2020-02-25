Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFDAC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47CD720CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMv7FR9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CD720CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZE4-0004G1-En
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl3-0001Fu-F0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykz-0008GC-7i
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:13 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:55322)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykx-00085Y-Cj
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:08 -0500
Received: by mail-wm1-x32b.google.com with SMTP id q9so2666788wmj.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vqmrNOvjCGW7erTAY2E+vByuvai3gyKtXKdjs6y5w2c=;
 b=cMv7FR9pW7mht8pIRvMsFJ0cn2NpGbjHERqfx1V5v7/AHJaUjq2UYeyYO/3zmlEywO
 VAx8wQGBuva/d08YdnmUUIJKoX6tAqABVgrciJO8eu5h93RxRtFqgIadzNc8S05/mqEE
 UaxbHJ0aRx4ABCXrm/gNsmrWXjuOsaQmtSBU2dw37hp4BXvi7VUw3vYzWhu4VS1VBT6U
 z6ekANer9EXIIYplPanf2RXc2lTkF3g/IjMqDImSSxUMkn6lWIeK6WGkmDngESEbgdz/
 IG1GQGRVIeMuGIctKs5kV8egyVdxChKrP+Z2eFMEq6u1gFGyL7LKTU0O+E9JWXExZxCJ
 9/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vqmrNOvjCGW7erTAY2E+vByuvai3gyKtXKdjs6y5w2c=;
 b=kEyqm7FDUCZ3N6PWpdqKlXkwOKS6mKz+2p4rjrEVBm8UQwXw5N9csp3aJyo0UkYU5r
 PRV3yLX+5/VGiQmK/mJyB/gfQ76SGtxfJI50+vJd9u2mWRNl6RTDgr+WYQvcwShe5wbt
 Ye8wIIxQBIzbffjsE4m2ATizga08JItYg3Ap4j2daF0SLAFqYquVnUF3OWvzTJAFD9j2
 jCz4+9mVeh0hI5TTxNWh3KYlhZZWphg+AWiUk696OOion+6TTBk+EW3xVG9JJF3Z5mdM
 msEvlrnyYe4aTrUVEws5KgoI94hoMlsSSTNIfpzVPJnoY+SzHMk/5QLMITUbMc4ZkIGH
 rwyQ==
X-Gm-Message-State: APjAAAUngTYk322I2LvZZ5UXxpxF0x8a+AXv2yxLiMck7/oyA5Rvx4B8
 NtX/tu5XDlXTqSfg96Y5qk/0HiYH
X-Google-Smtp-Source: APXvYqxZQOzSg/NvUEV/vtSWfYiWfYxp76+Oz4XEMW9edJTs1CW8fWOKkjGhWSeAoQYadjrPR8rG7g==
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr4824393wmg.169.1582631522918; 
 Tue, 25 Feb 2020 03:52:02 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 062/136] ppc/pnv: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:52 +0100
Message-Id: <1582631466-13880-62-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-63-imammedo@redhat.com>
---
 hw/ppc/pnv.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 139c857..ea20a1d 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -690,7 +690,6 @@ static void pnv_init(MachineState *machine)
 {
     PnvMachineState *pnv = PNV_MACHINE(machine);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
-    MemoryRegion *ram;
     char *fw_filename;
     long fw_size;
     int i;
@@ -702,11 +701,7 @@ static void pnv_init(MachineState *machine)
     if (machine->ram_size < (1 * GiB)) {
         warn_report("skiboot may not work with < 1GB of RAM");
     }
-
-    ram = g_new(MemoryRegion, 1);
-    memory_region_allocate_system_memory(ram, NULL, "pnv.ram",
-                                         machine->ram_size);
-    memory_region_add_subregion(get_system_memory(), 0, ram);
+    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
 
     /*
      * Create our simple PNOR device
@@ -1976,6 +1971,7 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
      * enough to fit the maximum initrd size at it's load address
      */
     mc->default_ram_size = INITRD_LOAD_ADDR + INITRD_MAX_SIZE;
+    mc->default_ram_id = "pnv.ram";
     ispc->print_info = pnv_pic_print_info;
 
     object_class_property_add_bool(oc, "hb-mode",
-- 
1.8.3.1



