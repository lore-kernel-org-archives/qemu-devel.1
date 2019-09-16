Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425FAC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FFF2186A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qr5cUvRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FFF2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tOw-0000qr-OO
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sDI-0006hs-Ah
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sDG-0007av-8c
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:48 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sDA-0007Yk-0b
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:42 -0400
Received: by mail-wr1-x441.google.com with SMTP id l3so16457524wru.7
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k6PPn4Z/g3X9dRln047WPkkVlkbax9eyN7khSHdwCWQ=;
 b=qr5cUvRaDoKcm3sIix8djNM03JLDvHvrhTiY5UUdPyPGAAFysct2KR0SSan11eAjaI
 SECPiZz44c8KqH6J2xgU77Kqnr2neMpTIF1iNyA+PgkmdYVmstHR9ktmmZQDeV7joTPB
 lc77VFY56SpMnGx0Acup3W3Iz1ubSSZOQNXrMd6xTzhki/d/1qt8b+jcsFPciocZbJFK
 I0I60dDQa2Z8XndScwuGlQHTzCRvD7lTCVkuHOMKPKya2rJqRK6OvLf/UAhRDFzfOXx2
 KdNZX9ngIxAbwpId/gZvCm7BjivCPoMLMgdPQygrR6VK59NGeClgzXDCOD5Fz4Y/tdZd
 2Pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=k6PPn4Z/g3X9dRln047WPkkVlkbax9eyN7khSHdwCWQ=;
 b=E9nr3ED5qnie4CupXIT+5kHpjYP8vg5upI8fIz7XAMIaV5hzLA7dMjOlQg6uEOGif9
 WlkO7IdqvHybsXnIHSvjxmHoztUeD5vizk1h/LF9Nl/gm9dBj9nDqWh1yTNL6fNqjBYO
 JN+hAeqct8yC0PFzpBjb4vOJ+C8+lYepXxIxk9aHdjHXXExt06kRKQ9nKdWeRGPYq1OQ
 GjAyrVo37pO+Zhhz3U3NHT9oschaYxKD0yjwEqCLQwzSFNXJ0DVm9tbko2nHN7nkewks
 yhhXU0CSl0QUbQmi6qc4RqHoARDyhQzc1QeSOF4fnW2symTzuZXjI+Ssb8yDvVy9+tQZ
 jLsw==
X-Gm-Message-State: APjAAAWI7OscwXnwksA2SUDKPBpkfJ0EPTsU8giRy1F4xQwBoOwqy15J
 6Tj30L529T9QK+YUGkFhYMcTfcA2
X-Google-Smtp-Source: APXvYqwE6g+Sdn7KASl5yFlmOKPBHWVTqeWe6XD42f7dFltiGXcBHhDLw+ybGY2XM3taHrcFCJ3mNg==
X-Received: by 2002:adf:dc91:: with SMTP id r17mr143728wrj.22.1568644957405;
 Mon, 16 Sep 2019 07:42:37 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:42:04 +0200
Message-Id: <1568644929-9124-25-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 24/29] hw/i386/pc: Let pc_build_smbios() take a
 generic MachineState argument
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

Let the pc_build_smbios() function take a generic MachineState
argument.

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190818225414.22590-11-philmd@redhat.com>
---
 hw/i386/pc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 612d676..14ad611 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -894,13 +894,12 @@ static uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
     }
 }
 
-static void pc_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
+static void pc_build_smbios(MachineState *ms, FWCfgState *fw_cfg)
 {
     uint8_t *smbios_tables, *smbios_anchor;
     size_t smbios_tables_len, smbios_anchor_len;
     struct smbios_phys_mem_area *mem_array;
     unsigned i, array_count;
-    MachineState *ms = MACHINE(pcms);
     X86CPU *cpu = X86_CPU(ms->possible_cpus->cpus[0].cpu);
 
     /* tell smbios about cpuid version and features */
@@ -1695,7 +1694,7 @@ void pc_machine_done(Notifier *notifier, void *data)
 
     acpi_setup();
     if (pcms->fw_cfg) {
-        pc_build_smbios(pcms, pcms->fw_cfg);
+        pc_build_smbios(MACHINE(pcms), pcms->fw_cfg);
         pc_build_feature_control_file(pcms);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
         fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
-- 
1.8.3.1



