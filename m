Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E92C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 139C3206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGjvEq0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139C3206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9svV-00024u-IM
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sDM-0006kR-RK
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sDK-0007d9-HL
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:52 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:52194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sDI-0007Zj-Cf
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id 7so82382wme.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mdgTMF9pl4BjaOz4xSpG8Yfpg0WV/SHiKJbxxng3th0=;
 b=bGjvEq0fIQbsy2sfwAJ38MHa0kjeqt0MqVurmKvKLIDhOX9c7Baf+TF1V2A/w6vHof
 lmB2QDEP38D1RdHpUHjyuQ5CALyNHh7od+JaTiDPYmrYgzDl2y+dXw8PH9WCLKsFAfIZ
 9a1CUhGGCxiaSATyKPKgjGL4UCh1SN0FreaaNnfFPghyGqTbHD2bOQx/lT+a7HuEBeUz
 R26qa/QId5OF2hfuDruahcAIRf2UV9lFgHTpQ8VR3Ja2PZIR1MOUD32rgHDBvEw7VTe2
 0aOdk+15fg+F+yWcfiSZ46dSk2S2Q5a6a1I5ouJtIMlDXvCoMrlijDeIndADivx5F4jK
 BhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mdgTMF9pl4BjaOz4xSpG8Yfpg0WV/SHiKJbxxng3th0=;
 b=bBH6RZhXCTxhM+9S7DwwwswM2VwX9X3GiOusJXiSVr5qVv0ZvbVf1HpUX3xiC8WVLK
 ygNtyBT0U3PydOCsFewoVzEEMegK2GqKg9pR6QT1bIIJMZLY62z588dQr7p9gR6C1mtc
 hbiUYSLa94l6VRr/PC32ao2UhEtOZorsPmdYQgB0AAvtIwZBwEuFFlS/B0pP271/P6s5
 A6A4KWaxbRReI1eGQoVDlSKR0aP3hA5OKFlKw8F2CHUNQDzu5koF0Gq/c0BjCVjpTZS2
 fQXZxX44ehy58ZcvK/jg94BUx8qcR2RhrupN3e+PZjp6LzYRIx8duEsWEKslT9uzA9HM
 xCnw==
X-Gm-Message-State: APjAAAVIswBOJOswqwy6AUMVPABFlCYzKVvoYGVNQIz9V7QvXoHhozrs
 TZgRcsmbYnIQ2D0uNQVY3+iNlINX
X-Google-Smtp-Source: APXvYqzhScHIb98OgpihoxXz0kz93TBQ5O1zs+RrzLh4pTGcVmpOmZCKdJ0lTqMlmo/MEc9CITHdjQ==
X-Received: by 2002:a7b:c10c:: with SMTP id w12mr83372wmi.26.1568644960522;
 Mon, 16 Sep 2019 07:42:40 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:42:07 +0200
Message-Id: <1568644929-9124-28-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
Subject: [Qemu-devel] [PULL 27/29] hw/i386/pc: Let
 pc_build_feature_control() take a MachineState argument
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

Let the pc_build_feature_control_file() function take a generic MachineState
argument.

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190818225414.22590-14-philmd@redhat.com>
---
 hw/i386/pc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7213853..438c485 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1623,10 +1623,9 @@ void pc_cpus_init(PCMachineState *pcms)
     }
 }
 
-static void pc_build_feature_control_file(PCMachineState *pcms,
+static void pc_build_feature_control_file(MachineState *ms,
                                           FWCfgState *fw_cfg)
 {
-    MachineState *ms = MACHINE(pcms);
     X86CPU *cpu = X86_CPU(ms->possible_cpus->cpus[0].cpu);
     CPUX86State *env = &cpu->env;
     uint32_t unused, ecx, edx;
@@ -1696,7 +1695,7 @@ void pc_machine_done(Notifier *notifier, void *data)
     acpi_setup();
     if (pcms->fw_cfg) {
         fw_cfg_build_smbios(MACHINE(pcms), pcms->fw_cfg);
-        pc_build_feature_control_file(pcms, pcms->fw_cfg);
+        pc_build_feature_control_file(MACHINE(pcms), pcms->fw_cfg);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
         fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
     }
-- 
1.8.3.1



