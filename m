Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E34EC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37829214D9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FStat188"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37829214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tRW-00031F-0h
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 12:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sDG-0006hR-EH
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sDB-0007Zr-Uk
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:38539)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sD8-0007Ya-7c
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:39 -0400
Received: by mail-wm1-x332.google.com with SMTP id o184so76744wme.3
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1loFgfoo8O+0OkFX8to4l4qCch6xvKAVs5sNReYGYME=;
 b=FStat188H8P1fmPqcsWuTamTvVXdP4cUgAU70kzo/CeXNHNVNFBawj7G8bkbYQmeEH
 +P01npwxW7Fa/UpD82h6sKKHVDcRgWwPZ7bW+2IbCChbZLhsnv49ouVB3dKzO+VDha3t
 zKrcsjZUYMAUv+i4Z4rE9PlSk1JVZJ4sZAQTHifFMOYZTjlxDMlOctfE7Tj+wwLgqcvZ
 oTo6zP31WEAiaJkjz48Ccdmvt9qj7bM/KSb7sn0Z/UpCC8Ng6KMHU3wCcqlE7/sQiyFp
 Y1ctlSpMg2w1xWbF6aSlfkJxdPGASWkwcZzFU4mPLy7kaZLtvjXjcSj9msD6EsZt8iOs
 SAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1loFgfoo8O+0OkFX8to4l4qCch6xvKAVs5sNReYGYME=;
 b=kNLWGOWzf7QOe0fJpsangAhNwQPk90aImgvMPph2voXdddGqnlMGJPczPVfnQZ626D
 SCsbemIkEk538J0YnCFX2QISf+2af8xMDVaHADe1PqD/ComiCJiRi+37BKdjXdcFDqQa
 j4HZAWTwl3u43EqN5gwk9+MDeERw3/FNo32+YQIIMhMx5ZJRASxBz2EMHarZD9d98tkt
 8kULAj0wXidRuC3quzKM02R8R2PrWCYB1XUcFYndJXHiJqHnDB7bod8Z0P9vJft3BpDg
 DqIDqUoNwYr6PPHKMcJcuTpApyyqRkXXM0qcDlKs1be459pjVVlQ9a5c27BYuYrdqb7X
 udiw==
X-Gm-Message-State: APjAAAX6puMXFUKKE6occA4Wknsf1QTJNEabm767zwDsV/aiuC9+AuZm
 N51rTderClVxIqX87bNwadKm2EdX
X-Google-Smtp-Source: APXvYqznLdHQCw9K8x7FP6jvb3zHmH/KpELDsX4qsgmgJHgwZhUQAeh7enumjNz8SBByXvcyxJ+rWA==
X-Received: by 2002:a7b:c391:: with SMTP id s17mr67373wmj.94.1568644956598;
 Mon, 16 Sep 2019 07:42:36 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:42:03 +0200
Message-Id: <1568644929-9124-24-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: [Qemu-devel] [PULL 23/29] hw/i386/pc: Let pc_build_smbios() take a
 FWCfgState argument
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
Message-Id: <20190818225414.22590-10-philmd@redhat.com>
---
 hw/i386/pc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8d2e600..612d676 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -894,7 +894,7 @@ static uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
     }
 }
 
-static void pc_build_smbios(PCMachineState *pcms)
+static void pc_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
 {
     uint8_t *smbios_tables, *smbios_anchor;
     size_t smbios_tables_len, smbios_anchor_len;
@@ -908,7 +908,7 @@ static void pc_build_smbios(PCMachineState *pcms)
 
     smbios_tables = smbios_get_table_legacy(ms, &smbios_tables_len);
     if (smbios_tables) {
-        fw_cfg_add_bytes(pcms->fw_cfg, FW_CFG_SMBIOS_ENTRIES,
+        fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
                          smbios_tables, smbios_tables_len);
     }
 
@@ -929,9 +929,9 @@ static void pc_build_smbios(PCMachineState *pcms)
     g_free(mem_array);
 
     if (smbios_anchor) {
-        fw_cfg_add_file(pcms->fw_cfg, "etc/smbios/smbios-tables",
+        fw_cfg_add_file(fw_cfg, "etc/smbios/smbios-tables",
                         smbios_tables, smbios_tables_len);
-        fw_cfg_add_file(pcms->fw_cfg, "etc/smbios/smbios-anchor",
+        fw_cfg_add_file(fw_cfg, "etc/smbios/smbios-anchor",
                         smbios_anchor, smbios_anchor_len);
     }
 }
@@ -1695,7 +1695,7 @@ void pc_machine_done(Notifier *notifier, void *data)
 
     acpi_setup();
     if (pcms->fw_cfg) {
-        pc_build_smbios(pcms);
+        pc_build_smbios(pcms, pcms->fw_cfg);
         pc_build_feature_control_file(pcms);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
         fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
-- 
1.8.3.1



