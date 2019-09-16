Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C953C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:21:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264B4206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vOq8cJ1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264B4206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9soU-0002L7-HG
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sDI-0006hu-Ac
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sDG-0007b0-8K
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:48 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:40405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sDC-0007ZG-3M
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:42 -0400
Received: by mail-wm1-x330.google.com with SMTP id b24so61672wmj.5
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TOBUM8vB9k+Xxdjqza7KhK358ltTbzzQWCOfZA+EL9g=;
 b=vOq8cJ1+/vvNyrqblKpU0CsxLBsbHix4FR2atiu4osWKWIjYj4I+CNs1lPyMmETDyo
 YiCuxzYQc1jY3KW/d17JD6kDQYuKA4gWGeaToexDtpeWFCTznQ20RxONaj0VgP/y1Pcn
 Jk6QiFvBYNQSYwj6pp67C/HVJ7ifK5GkflXWtR4p0upr0lk2fhJgiWD+01AEZjQ45blV
 RqPsjzc2YL5vn1r9f0W68zbL/HDkAQFSrNNdq07rmzLYiiTeu8aVRGU3hLeWBKyT5pz6
 VsV0HiR50ajHU3uX7lJl9lJOhY9IC+Zmpawdf6zd2w6oY/ABzVY7fx1alreh7RZ3MoVf
 yvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=TOBUM8vB9k+Xxdjqza7KhK358ltTbzzQWCOfZA+EL9g=;
 b=WyfSZbQ26KqAGTPUH641LlwVbz8qOL3y3mvKWH2rUpTSye3xBDnJ/hpujeYKVW5dD5
 kAPSLftxd+pA0k++0vDpK03k7KPu6LVDl+04lGukYXegClLSn7Ta7IIu20rOfgxim73R
 zd18oyV6Ne1gllImOms7R2zaZO5WaP0dsYevx9/SIHG4lbdzif4j7fwomaiVNZuR9iH4
 3tHDR5kSMyJmPAtdZ1AEED1/AnWFMpir6mzCY9mV2/YxJL9MjtdnCdOwMKiIO+yaX8RP
 s9ETH0hQtRJEVpDvRwWMLHEBfG+7PLH+VDYGawoUz1UmU0JO2qNBxiXR6/7sTheJjyEm
 gTyg==
X-Gm-Message-State: APjAAAXuFSO9FZJbAj0Y/UAR8nrYC1wFkxDU24ZRqt3uiLsLGiUnLbpd
 UKTDoXif5+H1p1BuC8w476bFci3+
X-Google-Smtp-Source: APXvYqzvaw9ywozwnIrtfvf0l3w9DhGApC5qiW7Qgno+l/4Vphq2ggd7kZfNIrCf/GSi+USjPDDTzw==
X-Received: by 2002:a1c:f10d:: with SMTP id p13mr66799wmh.56.1568644959319;
 Mon, 16 Sep 2019 07:42:39 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:42:06 +0200
Message-Id: <1568644929-9124-27-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: [Qemu-devel] [PULL 26/29] hw/i386/pc: Let
 pc_build_feature_control() take a FWCfgState argument
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

Pass the FWCfgState object by argument, this will
allow us to remove the PCMachineState argument later.

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190818225414.22590-13-philmd@redhat.com>
---
 hw/i386/pc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8f611cb..7213853 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1623,7 +1623,8 @@ void pc_cpus_init(PCMachineState *pcms)
     }
 }
 
-static void pc_build_feature_control_file(PCMachineState *pcms)
+static void pc_build_feature_control_file(PCMachineState *pcms,
+                                          FWCfgState *fw_cfg)
 {
     MachineState *ms = MACHINE(pcms);
     X86CPU *cpu = X86_CPU(ms->possible_cpus->cpus[0].cpu);
@@ -1649,7 +1650,7 @@ static void pc_build_feature_control_file(PCMachineState *pcms)
 
     val = g_malloc(sizeof(*val));
     *val = cpu_to_le64(feature_control_bits | FEATURE_CONTROL_LOCKED);
-    fw_cfg_add_file(pcms->fw_cfg, "etc/msr_feature_control", val, sizeof(*val));
+    fw_cfg_add_file(fw_cfg, "etc/msr_feature_control", val, sizeof(*val));
 }
 
 static void rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count)
@@ -1695,7 +1696,7 @@ void pc_machine_done(Notifier *notifier, void *data)
     acpi_setup();
     if (pcms->fw_cfg) {
         fw_cfg_build_smbios(MACHINE(pcms), pcms->fw_cfg);
-        pc_build_feature_control_file(pcms);
+        pc_build_feature_control_file(pcms, pcms->fw_cfg);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
         fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
     }
-- 
1.8.3.1



