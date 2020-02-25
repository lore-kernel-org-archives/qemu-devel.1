Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADACFC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E57C2084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLa7DAif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E57C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Yyx-00012A-K4
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkL-0000NB-6G
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkH-00067v-BX
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:29 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:51564)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkH-00063Y-4W
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:25 -0500
Received: by mail-wm1-x330.google.com with SMTP id t23so2678889wmi.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JV/pewMOjtG2IMzaeMCldZM456DYQUEk4bB02ESDacE=;
 b=bLa7DAifrIOB51ibI2mxJhD+T3IjyFEMHYsZV+drCjEIX5FRK3Z1p7h9Cw114UgTAg
 fd4G8QTALRy5/ba5eB5SfBxtwTZRh8ch3Vc953oGhdyGl+pGaYUIy9Zq1/K0sY2xEVH4
 xpzwmsDYQhUAeWvU39yfMtNZn2sUmbMDFWpSLWvdBN0jTLfOjamrUb4tOwZsuq4FDUMv
 oUvJ/SEk7EHs7b91XNf7/hyXURWnkDYbOER7tbbXjqPPZd7hihA65cWLJtGUP0SFMrei
 5FJCv6ldl84JbM8gtma1mEX9xOVZjBVqOoGjBnLLNMoexikAeWPuMzWBFc5R28fSGb+F
 48Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JV/pewMOjtG2IMzaeMCldZM456DYQUEk4bB02ESDacE=;
 b=DcEIrAnEfFZLDglexUZdfJ7tZbThF+fcWwl8VuiTgHUZ/81KS8MynjMhovR3gVhDae
 Rm6TStZuFXCcoeR178wroDGvlbNAqbsnKAlgqSegfsrJiu4OaXq4lu7SrSqGa8m3n7mh
 zmtlmLdGrLHXdhyxVQzQ4dNz6FcHiATh6hIFRmM/hO5156jWFWBUGPfc1bjP3WBz3+Tj
 CTxVcRYez7MIC7yFyHhQUpznhKXxGd57usDoISyF68z8sxlFXrpmowAnm2XeHa+phUBM
 ejJDzsKzl8O8Yhrpw+K2szNxv7qJ8khbL7lWHfFMiZJ44rlUGSCDh4ZBoLxy6n819BYJ
 xmEw==
X-Gm-Message-State: APjAAAWKAsQpjN+SuBc0iFQXmboN1Y5l3A9CbmRwKt9HnKhur3NA1B/o
 8EkpKtWsqgFdSrDEdCacgCOhBqSL
X-Google-Smtp-Source: APXvYqydxiSs6vDKs2MVdLFzLX9SIdc1X/bXF1/OPsKLGsg5/mNrDq9Ny/HUdPK5LBNtWyB5vr4yqg==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr4842363wme.94.1582631481634; 
 Tue, 25 Feb 2020 03:51:21 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 016/136] arm/imx25_pdk: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:06 +0100
Message-Id: <1582631466-13880-16-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-17-imammedo@redhat.com>
---
 hw/arm/imx25_pdk.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index c7c51d6..26713d9 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -59,7 +59,6 @@
 
 typedef struct IMX25PDK {
     FslIMX25State soc;
-    MemoryRegion ram;
     MemoryRegion ram_alias;
 } IMX25PDK;
 
@@ -86,10 +85,8 @@ static void imx25_pdk_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    memory_region_allocate_system_memory(&s->ram, NULL, "imx25.ram",
-                                         machine->ram_size);
     memory_region_add_subregion(get_system_memory(), FSL_IMX25_SDRAM0_ADDR,
-                                &s->ram);
+                                machine->ram);
 
     /* initialize the alias memory if any */
     for (i = 0, ram_size = machine->ram_size, alias_offset = 0;
@@ -109,7 +106,8 @@ static void imx25_pdk_init(MachineState *machine)
 
         if (size < ram[i].size) {
             memory_region_init_alias(&s->ram_alias, NULL, "ram.alias",
-                                     &s->ram, alias_offset, ram[i].size - size);
+                                     machine->ram,
+                                     alias_offset, ram[i].size - size);
             memory_region_add_subregion(get_system_memory(),
                                         ram[i].addr + size, &s->ram_alias);
         }
@@ -137,6 +135,7 @@ static void imx25_pdk_machine_init(MachineClass *mc)
     mc->desc = "ARM i.MX25 PDK board (ARM926)";
     mc->init = imx25_pdk_init;
     mc->ignore_memory_transaction_failures = true;
+    mc->default_ram_id = "imx25.ram";
 }
 
 DEFINE_MACHINE("imx25-pdk", imx25_pdk_machine_init)
-- 
1.8.3.1



