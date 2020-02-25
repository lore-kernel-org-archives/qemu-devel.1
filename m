Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE7AC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0746F21556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWoQjtjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0746F21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZTu-0002gC-7K
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:38:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0F-0003cO-QR
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0C-0003Wi-UD
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:55 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:40836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0B-0003WA-O4
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:52 -0500
Received: by mail-wm1-x334.google.com with SMTP id t14so2884244wmi.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vopJ1RElYQTHSOSPZiWwIU+j4EOww4ShekravujsCHQ=;
 b=FWoQjtjvzJON5xVqL4Rfva9wuw4lu6YyH8l0P+ljRn9Z3cZ8/PacZ3HDd43TQP6Zsj
 TZNJQ5Lp0Sxj1q0cphce55l5kilJocNfETI3Ro2CW3Q3MKXzmCptsqBaimxgrEna9QF0
 AyUsRQxH5YpohbnaBGDs6aAem67rLREcJlsesrn0/k+s7OAgwck2/7GsMaUf1HxtKHI9
 jYZ9L91990eJ0yOWAJPiP2IvmVpSTnOeEJ0SonyYIdWydq43xBAcUZYg7EGGNJNvoNnh
 l8MZpc6h2GD9SHlOrNRmq+UQ4yzZwWI3RTKPtiVFG1QW0lLC4pJRhyfzZhTi0mIXNPWR
 zT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vopJ1RElYQTHSOSPZiWwIU+j4EOww4ShekravujsCHQ=;
 b=bSpT0+SNSfaMVTrx8P3dEvnhhENSIQ1jMpS4uFm+PKt7nyYbZMsAbR+/dNHqTIDQyO
 qdj72wnBgLD/57YaKswJTdU4dwJ/0MSHXslc2FzPTsVNB2RkFF7yDLFSE++08Z7sKbR1
 xN/x1EvqPWPrZHEk1+iI8zd+r8iVYM3qG99s3BqzqmS4cZKvdr1MR9U+GE8RyhmRJwsN
 yCiQw+NtHQMJ1Y3aDngbiUOhqlEqofqEU7FHD2lsyS6WekY04WRuTyVmFLaDzaOkH/Np
 wrK0r312FLyDbmSzSNVxTa25s51ppV38+/oX0XUySyi4yrUAQAxo6j+BIM51ZuuPQRX3
 WEJQ==
X-Gm-Message-State: APjAAAWEIaLc1jyhGl6YPHRosWc62+4FKMJ1JiVnywowIgco4LRbRAFN
 oxwF5UflGjV56b6UopTc1Njz+7kw
X-Google-Smtp-Source: APXvYqzLwiCUx2pqIDF+3wk57DNb58A4f4xLEt3vY19HoK6ZQjAz/Qxsn3hUItI6GdpH5G+4+0IRDg==
X-Received: by 2002:a05:600c:2c06:: with SMTP id
 q6mr5283745wmg.154.1582632470524; 
 Tue, 25 Feb 2020 04:07:50 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.07.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:07:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 117/136] hw/i386/pc_sysfw: Remove unused 'ram_size' argument
Date: Tue, 25 Feb 2020 13:07:15 +0100
Message-Id: <1582632454-16491-15-git-send-email-pbonzini@redhat.com>
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

While named 'ram_size', this argument holds the size of the
flash. Since it is unused, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-20-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 hw/i386/pc_sysfw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index e864c09..07b35ee 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -51,8 +51,7 @@
 #define FLASH_SECTOR_SIZE 4096
 
 static void pc_isa_bios_init(MemoryRegion *rom_memory,
-                             MemoryRegion *flash_mem,
-                             int ram_size)
+                             MemoryRegion *flash_mem)
 {
     uint64_t isa_bios_size;
     MemoryRegion *isa_bios = g_new(MemoryRegion, 1);
@@ -182,7 +181,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
 
         if (i == 0) {
             flash_mem = pflash_cfi01_get_memory(system_flash);
-            pc_isa_bios_init(rom_memory, flash_mem, size);
+            pc_isa_bios_init(rom_memory, flash_mem);
 
             /* Encrypt the pflash boot ROM */
             if (kvm_memcrypt_enabled()) {
-- 
1.8.3.1



