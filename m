Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21831C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:04:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C19222C2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTDhAuio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C19222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Yx9-0005z6-2d
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkL-0000N9-4V
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkG-000623-8S
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:28 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:40400)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkF-00060t-Vh
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:24 -0500
Received: by mail-wr1-x42c.google.com with SMTP id t3so14350418wru.7
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xPvp/civ3UQYVCHGQRfWgUWR6R23Sx/HnqApowuv7qA=;
 b=sTDhAuioHWES41MBR7Bm1WBKgZUEUZNOGMraQMlr0hM2rsNgDy7mkzGTXgHnhcmYb9
 bbsAqoRyPfFXCSU8OmGYODALx+3fffgCrfm5KUTSKltXOSrupwYqz5fdweXUjU0okZwU
 fXbCEKUxQJBUFGiCOD/JHZI25DFYgTonyPqd9K/l7RAytZS78uTyBuEE5P0BdRHQBuuK
 0Adwbvk2odkXbljFHQ28scfuB6bXTCrwn0NEprTq0ytHtDIBMU/aLNR1O7YxCj8N9my4
 OKAtzyllLXvv7qsFNblQ7J/GVA5M010ICvWcmGgeFbtm5nhEoRP84qY6EOL2uRdcH4Cl
 k5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xPvp/civ3UQYVCHGQRfWgUWR6R23Sx/HnqApowuv7qA=;
 b=ISxfQtpCZQ5V8YnZF83DX8MtaSH2f2GFFWxnY0o3zz/B7Dhsj+m2pNF/JkaeAO0oYF
 0gxYDbxWFLtWP7nNQ3cS3nYOMOHTPd8N6vwkNJE3TKT4ZU8f5TfQR8erusYOgEH6reDN
 tBviZk/B3RsAYx+zZo62AapXd/2HbrGnOvE8dyyUo/BBii19/8uHLx5jDQfnPdOV8ocI
 UWdpYmK/HeIHuPY23Y9LB7U8Z5GO+HzR2HGJHTl4/snIzAa+RQldKn2Uj0Yx8sAYz/8Q
 DLC05agDh4WxTPNV0hq9I2QXr9gO64qK/FHmn2zz4dCabEidkHTZlpgy1XiHhg3/Z4yq
 wl2A==
X-Gm-Message-State: APjAAAXoY7goRW85kuY6YpHX9wRe0/VHYVnkKx7epatg1mcC9vpTqo9I
 mCmUWYBRMoDMTXB/HBhk/tIGGocA
X-Google-Smtp-Source: APXvYqzvocLEAJSsYQoYn1FhGpNdH+itC7vrRxE3cZYApH/3+JhfKjFTmUx5cSKyKA8+smgr2Fhgtw==
X-Received: by 2002:a5d:678f:: with SMTP id v15mr74282741wru.27.1582631480614; 
 Tue, 25 Feb 2020 03:51:20 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 015/136] arm/imx25_pdk: drop RAM size fixup
Date: Tue, 25 Feb 2020 12:49:05 +0100
Message-Id: <1582631466-13880-15-git-send-email-pbonzini@redhat.com>
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

If user provided non-sense RAM size, board will complain and
continue running with max RAM size supported.
Also RAM is going to be allocated by generic code, so it won't be
possible for board to fix things up for user.

Make it error message and exit to force user fix CLI,
instead of accepting non-sense CLI values.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219160953.13771-16-imammedo@redhat.com>
---
 hw/arm/imx25_pdk.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index c76fc2b..c7c51d6 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -32,6 +32,7 @@
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
 #include "hw/i2c/i2c.h"
+#include "qemu/cutils.h"
 
 /* Memory map for PDK Emulation Baseboard:
  * 0x00000000-0x7fffffff See i.MX25 SOC fr support
@@ -66,6 +67,7 @@ static struct arm_boot_info imx25_pdk_binfo;
 
 static void imx25_pdk_init(MachineState *machine)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     IMX25PDK *s = g_new0(IMX25PDK, 1);
     unsigned int ram_size;
     unsigned int alias_offset;
@@ -78,10 +80,10 @@ static void imx25_pdk_init(MachineState *machine)
 
     /* We need to initialize our memory */
     if (machine->ram_size > (FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE)) {
-        warn_report("RAM size " RAM_ADDR_FMT " above max supported, "
-                    "reduced to %x", machine->ram_size,
-                    FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE);
-        machine->ram_size = FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE;
+        char *sz = size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
     }
 
     memory_region_allocate_system_memory(&s->ram, NULL, "imx25.ram",
-- 
1.8.3.1



