Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A72EC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:54:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 156BE206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TN+br5if"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156BE206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tKh-00056X-Rh
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sDG-0006hS-EO
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sDC-0007a9-IS
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:45 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:53572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sDA-0007Z1-1O
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:42 -0400
Received: by mail-wm1-x333.google.com with SMTP id i16so68168wmd.3
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YSviaidB+9hmgagbX135i0HDFBWVdstIEmKCyx1ApvY=;
 b=TN+br5ifMyhqmGZSBEjFhLwaSpiY+Dw9CJyIa2K0yzjQ1c63nUSgNPdY7rN7pCa0ES
 GYK0f/F7WxASqMIA2p7Azwt72sRXq62qkmDI+mA2NqbNNR4Ft8jBTgUAAj3NjH1zdNy9
 pYPt/j7+6VV0kcXi8+mfyeoWdYu6Wf3DbVLU2m29CP7I/oxc+hluPA2qYuPjEKdmF1r3
 dFkt0XZCdsehaNvx3WNWDs3gKv3bcfj1l6UeAjbvXbnNj5ACyP07ujd4Q4rnAEYxsWTL
 sSfn6ZhPLcN00UyTbJfjgvwHlViSj13JL/5JYRMxgqmqcioRx782aHj28MHLMaTfEk3W
 mYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=YSviaidB+9hmgagbX135i0HDFBWVdstIEmKCyx1ApvY=;
 b=ouGmPpdlZAwJwQhqTdcMocOPpaYzDykoJ5AfijuX+0eQfetaQVOuoOW3Ubd7RMawaV
 HxA1LUsfvE0PQTpNj2JK6TY7RWeT9HkWi+nYvvK+VRF7Q+UqWnwWvioyrLXtVrv8QzYA
 3fNTl3fQwd4YSuRbfz7En9ZaeOsip0+xS97RaRWcVuhjhz//M4JBznSpCZpwIkO8sbwX
 gFEDaW/BJnwbz9+s08OemXHReOdQ19B0TEaX/eVPsbsbOt5YSUADlWwOYjFczdlnXy4h
 L9uqPEZWGyBgrhrQHFLqQnXVUHrS0/a3d6HRMBCWywa4wpA4wheExaJqAUGZ0+DdWnrY
 oxgA==
X-Gm-Message-State: APjAAAXuVI5a4aCjgczxAdIsBFLfh8bSEO05KDATS26ih4bdtXtIqVM6
 5s1VlTk+Dcb5ks9Dk/r5jxnA+jFF
X-Google-Smtp-Source: APXvYqwhpCo+VEgjc2M/Ea6j9c9p+mHF4AADKdUvxCHIdfMbLQ8wd7YIht3+5h8P1pBrUNM2sHr1eQ==
X-Received: by 2002:a1c:1bcf:: with SMTP id b198mr84536wmb.0.1568644958395;
 Mon, 16 Sep 2019 07:42:38 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:42:05 +0200
Message-Id: <1568644929-9124-26-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
Subject: [Qemu-devel] [PULL 25/29] hw/i386/pc: Rename pc_build_smbios() as
 generic fw_cfg_build_smbios()
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

Now that the pc_build_smbios() function has been refactored to not
depend of PC specific types, rename it to a more generic name.

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190818225414.22590-12-philmd@redhat.com>
---
 hw/i386/pc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 14ad611..8f611cb 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -894,7 +894,7 @@ static uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
     }
 }
 
-static void pc_build_smbios(MachineState *ms, FWCfgState *fw_cfg)
+static void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg)
 {
     uint8_t *smbios_tables, *smbios_anchor;
     size_t smbios_tables_len, smbios_anchor_len;
@@ -1694,7 +1694,7 @@ void pc_machine_done(Notifier *notifier, void *data)
 
     acpi_setup();
     if (pcms->fw_cfg) {
-        pc_build_smbios(MACHINE(pcms), pcms->fw_cfg);
+        fw_cfg_build_smbios(MACHINE(pcms), pcms->fw_cfg);
         pc_build_feature_control_file(pcms);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
         fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
-- 
1.8.3.1



