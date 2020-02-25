Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B84C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB6E02176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9Xqu/el"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6E02176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6a6o-0006NF-Rz
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z01-0003H0-6K
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z00-0003OU-0J
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:41 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:33201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yzz-0003Mw-Po
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:39 -0500
Received: by mail-wr1-x42f.google.com with SMTP id u6so14466968wrt.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Cu74x2chVafI6RI3Ym4jTZd4oi7oGabzyHqjT1LUeAk=;
 b=u9Xqu/elj/DOny4F5ZjHfolAxH7SoO/FxE/l4neLFWC9yIVk+Yam+k65dk96MxTh7d
 WGUnLtcOFZOTGP0Pqr5zJX+c2a4aX84GmUMIxMOwvX/n6F+Uk9u6bGbpPWUleA6VvArV
 H3cWdd+A56/CXt1MKkLX6WeiHZRwHaDAoWqVhZ/5QSrKbw2kQGirO4XIJAkFC1yxEc/M
 yPYSvhtDxwzoYQucNFQU97X8r6KTEJZy55QRXczjyXqxiMohGcT9jlKiKuTguTd+OWx7
 ek2M8QL+BnHKN23i/MtMQA1lzQHCmsYDMgDcCeyAIxenwH+FHzvebAHv5mrsLMYJkILE
 0jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Cu74x2chVafI6RI3Ym4jTZd4oi7oGabzyHqjT1LUeAk=;
 b=IhUtn3te8aww3ydvpbCw7Azxi/+nZZpcY4dL4s5JjN8epNISVoNUZ+LD0X+d7ebjqV
 AvuBdjJ/qb62d+7g1A6OuROr7SrpQC2A0LmXDRFJJ0vTvain7OzPocXJFOlzq3/0HDUj
 Fro6XLNkHvUQf4s6IIZo0sfhxzOY6YC/SGjno59CdcjRQ45kr6PdTkFK5e0q+YLubfBe
 hP6APzxm18JARwC2UEDmzMvMM1GEXjBfGp1+V5bDtjhRZk8nvPrM+XBhlwaU6aQnIjbB
 opw9BFgso8UM+Fhqhqoe+232Kjd1/A0yFv8EzvSThdZ7AFpT1Ie4GjVgphXf3tlDs2tV
 USJQ==
X-Gm-Message-State: APjAAAXSaByhNDmFBpLs4WlPo+bO/iU/CCpK4HoziV7bTaI/nLX8RbOi
 NHZir2kJYGHy0iYxK606ubHbb3Dh
X-Google-Smtp-Source: APXvYqxcJUoELYZLEOuIFwMp8o3u0al5w947xBUSQP1HjOoUyoQR9D3j6Mwg1NIfsHfsST+cRdTTBw==
X-Received: by 2002:adf:df0f:: with SMTP id y15mr71518535wrl.26.1582632458489; 
 Tue, 25 Feb 2020 04:07:38 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.07.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:07:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 105/136] hw/mips: Use memory_region_init_rom() with read-only
 regions
Date: Tue, 25 Feb 2020 13:07:03 +0100
Message-Id: <1582632454-16491-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-8-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 hw/mips/mips_fulong2e.c | 3 +--
 hw/mips/mips_jazz.c     | 6 ++----
 hw/mips/mips_mipssim.c  | 3 +--
 hw/mips/mips_r4k.c      | 3 +--
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 2e043cb..547a7d3 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -319,9 +319,8 @@ static void mips_fulong2e_init(MachineState *machine)
 
     /* allocate RAM */
     memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram", ram_size);
-    memory_region_init_ram(bios, NULL, "fulong2e.bios", BIOS_SIZE,
+    memory_region_init_rom(bios, NULL, "fulong2e.bios", BIOS_SIZE,
                            &error_fatal);
-    memory_region_set_readonly(bios, true);
 
     memory_region_add_subregion(address_space_mem, 0, ram);
     memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 66fd4d8..cf47335 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -195,9 +195,8 @@ static void mips_jazz_init(MachineState *machine,
                                          machine->ram_size);
     memory_region_add_subregion(address_space, 0, ram);
 
-    memory_region_init_ram(bios, NULL, "mips_jazz.bios", MAGNUM_BIOS_SIZE,
+    memory_region_init_rom(bios, NULL, "mips_jazz.bios", MAGNUM_BIOS_SIZE,
                            &error_fatal);
-    memory_region_set_readonly(bios, true);
     memory_region_init_alias(bios2, NULL, "mips_jazz.bios", bios,
                              0, MAGNUM_BIOS_SIZE);
     memory_region_add_subregion(address_space, 0x1fc00000LL, bios);
@@ -263,9 +262,8 @@ static void mips_jazz_init(MachineState *machine,
         {
             /* Simple ROM, so user doesn't have to provide one */
             MemoryRegion *rom_mr = g_new(MemoryRegion, 1);
-            memory_region_init_ram(rom_mr, NULL, "g364fb.rom", 0x80000,
+            memory_region_init_rom(rom_mr, NULL, "g364fb.rom", 0x80000,
                                    &error_fatal);
-            memory_region_set_readonly(rom_mr, true);
             uint8_t *rom = memory_region_get_ram_ptr(rom_mr);
             memory_region_add_subregion(address_space, 0x60000000, rom_mr);
             rom[0] = 0x10; /* Mips G364 */
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index b934ca9..3fdbb21 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -169,9 +169,8 @@ mips_mipssim_init(MachineState *machine)
     /* Allocate RAM. */
     memory_region_allocate_system_memory(ram, NULL, "mips_mipssim.ram",
                                          ram_size);
-    memory_region_init_ram(bios, NULL, "mips_mipssim.bios", BIOS_SIZE,
+    memory_region_init_rom(bios, NULL, "mips_mipssim.bios", BIOS_SIZE,
                            &error_fatal);
-    memory_region_set_readonly(bios, true);
 
     memory_region_add_subregion(address_space_mem, 0, ram);
 
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index b2aec43..54b286c 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -241,9 +241,8 @@ void mips_r4k_init(MachineState *machine)
     dinfo = drive_get(IF_PFLASH, 0, 0);
     if ((bios_size > 0) && (bios_size <= BIOS_SIZE)) {
         bios = g_new(MemoryRegion, 1);
-        memory_region_init_ram(bios, NULL, "mips_r4k.bios", BIOS_SIZE,
+        memory_region_init_rom(bios, NULL, "mips_r4k.bios", BIOS_SIZE,
                                &error_fatal);
-        memory_region_set_readonly(bios, true);
         memory_region_add_subregion(get_system_memory(), 0x1fc00000, bios);
 
         load_image_targphys(filename, 0x1fc00000, BIOS_SIZE);
-- 
1.8.3.1



