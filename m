Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A884C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F7B218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRk+bonr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F7B218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Zr7-00054G-Gb
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0F-0003bz-6J
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0B-0003W6-2q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:54 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:38768)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0A-0003VO-Rq
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:51 -0500
Received: by mail-wm1-x334.google.com with SMTP id a9so2896730wmj.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qqLnBWjSJgZ3n5u6pgS71lBorx6+mBOALgKCVorvE1o=;
 b=WRk+bonr0s6+1F0y6j4T0Yx6eHm+KQXCLbHOZHHeV4wCRYVAvrppPUbmZvXgdsKZWI
 sCmZEZHCKYuT9EQtavinyP9lAEZsjd6k/9D5fw7/R6ZnDyFYONO2LE5H1ej3i22XBtxt
 DR5mGewlkwjMrhJ2qYBqS0fJh3ZndMM4Yn4nmlvipQV2PCUrDSBuOWrudIReqtTSuOZt
 VxFzTZ6JJvPLXvsseoov4LF1hq8SW7oAVPNyM9jrzZ9D48CCTvda0t+iM6w7gfgGxL4Q
 cw1eyFfRbDyNEr1WFGE/lLVi3LuSd8mfmc0MIB5A7PW4dmEJK1LD7x3H2L+KdP4ExDck
 MYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qqLnBWjSJgZ3n5u6pgS71lBorx6+mBOALgKCVorvE1o=;
 b=J6hjB10+evAY8sVS9y9vGK0Zat1gfUzBpDR6NIX7TKFFGmVKmO9k/yHuc0RdEObIBg
 Y9H71CuxdeaHUJxvMdU/MOgsZsmCU6ZecBLd32kvRUvrLcLxfkzJE+l7BwQtN7eo4GBe
 jwtrGdl48fm1nB825EPaZ5Q+w7o0+V9bJwO5TXy16oAqA22ggGqLMw2u35nItfneYNTP
 LkyXXW82lnyFu3De0gTdZJWiDLQ/UP++IVkfbNEapIwWf40ke3rnJmukeO1NRpqQ01oF
 DVvPUekXPU1frO5ciZE0HbnUvljuuq4JP2miGpNy0+246aZ5mXUs8zvTEiy5au82Q7Hk
 o4Pw==
X-Gm-Message-State: APjAAAVoufFc4tiSVhfiOszmgPYTgziE0lC048dwV+n6+b+UpbQQl60t
 AD0ciSqeyU6TE2eOfidFsywJ/X4Q
X-Google-Smtp-Source: APXvYqxyfb7NXXm3bq2y3fzc478gYSSjv4yCoc2wgXchk7RtT1OHScNQ76JVeILNTjWUiBBFzMZQEw==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr4965078wma.5.1582632469591; 
 Tue, 25 Feb 2020 04:07:49 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.07.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:07:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 116/136] hw/i386/pc_sysfw: Simplify using
 memory_region_init_alias()
Date: Tue, 25 Feb 2020 13:07:14 +0100
Message-Id: <1582632454-16491-14-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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

The scripts/coccinelle/memory-region-housekeeping.cocci reported:
* TODO [[view:hw/i386/pc_sysfw.c::face=ovl-face1::linb=67::colb=4::cole=26][potential use of memory_region_init_rom*() in  hw/i386/pc_sysfw.c::67]]

pc_isa_bios_init() does a manual copy of a part of the BIOS,
from a read-only region. We can simplify by directly aliasing
the same part.

Before:

  (qemu) info mtree
  memory-region: system
    0000000000000000-ffffffffffffffff (prio 0, i/o): system
      0000000000000000-0000000007ffffff (prio 0, ram): alias ram-below-4g @pc.ram 0000000000000000-0000000007ffffff
      0000000000000000-ffffffffffffffff (prio -1, i/o): pci
        00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
        00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
        00000000000e0000-00000000000fffff (prio 1, rom): isa-bios
      ...
      00000000fff00000-00000000ffffffff (prio 0, romd): system.flash0

After:

  (qemu) info mtree
  memory-region: system
    0000000000000000-ffffffffffffffff (prio 0, i/o): system
      0000000000000000-0000000007ffffff (prio 0, ram): alias ram-below-4g @pc.ram 0000000000000000-0000000007ffffff
      0000000000000000-ffffffffffffffff (prio -1, i/o): pci
        00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
        00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
        00000000000e0000-00000000000fffff (prio 1, romd): alias isa-bios @system.flash0 00000000000e0000-00000000000fffff
      ...
      00000000fff00000-00000000ffffffff (prio 0, romd): system.flash0

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-19-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 hw/i386/pc_sysfw.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index f5f3f46..e864c09 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -54,31 +54,19 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
                              MemoryRegion *flash_mem,
                              int ram_size)
 {
-    int isa_bios_size;
-    MemoryRegion *isa_bios;
-    uint64_t flash_size;
-    void *flash_ptr, *isa_bios_ptr;
-
-    flash_size = memory_region_size(flash_mem);
+    uint64_t isa_bios_size;
+    MemoryRegion *isa_bios = g_new(MemoryRegion, 1);
+    uint64_t flash_size = memory_region_size(flash_mem);
 
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(flash_size, 128 * KiB);
-    isa_bios = g_malloc(sizeof(*isa_bios));
-    memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
-                           &error_fatal);
+    memory_region_init_alias(isa_bios, NULL, "isa-bios", flash_mem,
+                             flash_size - isa_bios_size,
+                             isa_bios_size);
     memory_region_add_subregion_overlap(rom_memory,
                                         0x100000 - isa_bios_size,
                                         isa_bios,
                                         1);
-
-    /* copy ISA rom image from top of flash memory */
-    flash_ptr = memory_region_get_ram_ptr(flash_mem);
-    isa_bios_ptr = memory_region_get_ram_ptr(isa_bios);
-    memcpy(isa_bios_ptr,
-           ((uint8_t*)flash_ptr) + (flash_size - isa_bios_size),
-           isa_bios_size);
-
-    memory_region_set_readonly(isa_bios, true);
 }
 
 static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
-- 
1.8.3.1



