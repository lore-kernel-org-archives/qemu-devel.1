Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11CDC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA752176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isV44Mms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA752176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZAh-0005p6-P0
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:18:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl0-00018U-Rr
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykz-0008Fr-8q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:10 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:37843)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykx-00081e-Bk
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:08 -0500
Received: by mail-wm1-x32c.google.com with SMTP id a6so2848011wme.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pCVAqTHNc51R2WI1XllI7JCvWYkhYQ1ZbnDn52ZL6EY=;
 b=isV44Mmsq0PrbryhPr2aElASQXEO3ylZ5Ss7o1/Zgt6V9tuHybVg8ckM2kGb4bEsH8
 KPbLKwfFjwqj7zqd+VltbJw4elgPM5UFNAZe11O4q48FDIwXlgCDL51P/fuW4QJgX/YK
 nJBSt7vAvv9c0Ju41HvKybBcSQcXnRIonB78WDS6DKA0b+v3zPHxCUJ+Dyy5lSD59dBd
 aQ0qwqvAPO/+ta3a5nIZmKYnf2E0b7bk8UIFbVyO1KwkcghpAaW+H9yN6Z/7v2L9y4Ih
 lDjrr2QOVQeyK72zNL+bYDBzkUWVHynUO4vN2ypWXKCdbAu3f+09M0YyP33AqBxUXHov
 BkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pCVAqTHNc51R2WI1XllI7JCvWYkhYQ1ZbnDn52ZL6EY=;
 b=WPxigsUpLAg+I98Z58G+93vc+mWL3arWHfKAGn3aunXI62Qqt3OB701C8rZevm4AkA
 XxFhkzLPXLIQM8SOpbKFsfdjNk+RtwNCD1ZRKTnI7bvM6N90xqawEpTW7ToSoTbJWQgG
 0QaLg6TN4A+12yW3rdGQAM1mPaW2Aq2+1dqLp4jE90s28uLwxDJpyJ7cd097LmFNfRKI
 a2FhggdlT71d2+P4FPPeTW9H1xAVTVj4OIKwY8GDAyKeYRbu7xS5/3M3jLH+8Cmvxc+6
 B3ZZETsc3FNljUDJ8J/DsL+OYhj4uz6FiROoewq9NT+tEx277+qpDyyxM9gaInRe6ocN
 bo2g==
X-Gm-Message-State: APjAAAUu4EoPPhv5JtLiHdOi1R2rWU4CpNDl5aHNzVwMyuO4FCE+6FxX
 Ln42+XpOxuMy2G1nyDku9RVy2DHZ
X-Google-Smtp-Source: APXvYqzQEztQCV4pFUzUP0Y6Vw1ijNRpHS1gWpkuyFD+Lcz2gGprhuZ1ZkVa7ETK+guInNBEKalVtw==
X-Received: by 2002:a7b:c318:: with SMTP id k24mr5209418wmj.54.1582631513756; 
 Tue, 25 Feb 2020 03:51:53 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 051/136] mips/mips_fulong2e: drop RAM size fixup
Date: Tue, 25 Feb 2020 12:49:41 +0100
Message-Id: <1582631466-13880-51-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
continue running with max RAM size supported.
Also RAM is going to be allocated by generic code, so it won't be
possible for board to fix things up for user.

Make it error message and exit to force user fix CLI,
instead of accepting non-sense CLI values.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219160953.13771-52-imammedo@redhat.com>
---
 hw/mips/mips_fulong2e.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 2e043cb..cf00211 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -296,7 +296,6 @@ static void mips_fulong2e_init(MachineState *machine)
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *bios = g_new(MemoryRegion, 1);
-    ram_addr_t ram_size = machine->ram_size;
     long bios_size;
     uint8_t *spd_data;
     Error *err = NULL;
@@ -315,10 +314,14 @@ static void mips_fulong2e_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, cpu);
 
     /* TODO: support more than 256M RAM as highmem */
-    ram_size = 256 * MiB;
+    if (machine->ram_size != 256 * MiB) {
+        error_report("Invalid RAM size, should be 256MB");
+        exit(EXIT_FAILURE);
+    }
 
     /* allocate RAM */
-    memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram", ram_size);
+    memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram",
+                                         machine->ram_size);
     memory_region_init_ram(bios, NULL, "fulong2e.bios", BIOS_SIZE,
                            &error_fatal);
     memory_region_set_readonly(bios, true);
@@ -332,7 +335,7 @@ static void mips_fulong2e_init(MachineState *machine)
      */
 
     if (kernel_filename) {
-        loaderparams.ram_size = ram_size;
+        loaderparams.ram_size = machine->ram_size;
         loaderparams.kernel_filename = kernel_filename;
         loaderparams.kernel_cmdline = kernel_cmdline;
         loaderparams.initrd_filename = initrd_filename;
@@ -378,7 +381,7 @@ static void mips_fulong2e_init(MachineState *machine)
     }
 
     /* Populate SPD eeprom data */
-    spd_data = spd_data_generate(DDR, ram_size, &err);
+    spd_data = spd_data_generate(DDR, machine->ram_size, &err);
     if (err) {
         warn_report_err(err);
     }
-- 
1.8.3.1



