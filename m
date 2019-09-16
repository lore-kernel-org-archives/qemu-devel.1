Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7445DC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:15:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4310C2053B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3rAubFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4310C2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9sjJ-0006g2-UN
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sD8-0006fR-3b
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sD5-0007Xm-CU
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:37 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:54517)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sD5-0007XC-28
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:35 -0400
Received: by mail-wm1-x333.google.com with SMTP id p7so60499wmp.4
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=36OSTNyRUV4b/XNoOmWOxSWxIOvrUZW6VSBB/hBkj2A=;
 b=M3rAubFDI/++9ySeVt2ZAUzAsMAL5TKSLbUuhWfRVVPl6NJ74EqrQFkQFZdmxQU8Cj
 KZ+nHHysyoP2sIT/u15ohpfUNInSVV7tGTMFDcmNpvjhsGF0V/ACRkkaZy36lAfX96qA
 EkUtYQEm/srjrP59vGU3oMSUbugFyG0jGYzazOYerIOB+Prj2loj9bhf9nrO7hekixIx
 L9mKGd18Jiq1WjNP1OtN5D9fIlFY8bqEpF+OxJnSlKxjPF3LhMCmKM++k2R2cFXkXakf
 xDhGvZ4xu7su21m5tbpfKPRwzs3Al+Ko3MeTl+i0FvkSVGtIQyxwYZOZEYy5Iw/d+Xzg
 a33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=36OSTNyRUV4b/XNoOmWOxSWxIOvrUZW6VSBB/hBkj2A=;
 b=fkHUfeZQOyRurZRaNID5ukXDc51HrWtXBBfPRbBea5/bnwFwyLWLBz6XJGlhMrHrNZ
 fEl7oZKzS/UA407+gQ8LLSOgiKuxFLMEJ4GW0tRi7tItexDzdPKzM/zpwQzJdlnHnFkr
 4lvwUOeCN+LrJblE5N3PZN29JB2XuhyU9XVKZZBIhUd4YlZyI7obZkLEgms7/TIJXujl
 3LeYxgmSZ+QjVG0EiHObRK+oKSD2nSekDSklZ2qpFGEAduJ/yxJS5qFVkWe490oSyzGx
 pPZ9YK+o3kyvUrNEtHZzeP4RWOpo2s+Lcq8fHg3dDBy7JBKhbwhJbWCitR/Lsz058g+U
 9RCw==
X-Gm-Message-State: APjAAAXESvsMpEt7KouszKTV8omgfDWvnb4+0GKk+sAvmMucCNUQzzzj
 ZqUOMMcs5cRwkpH8I5HxdnG9YN2s
X-Google-Smtp-Source: APXvYqwjI+TZOsg90wzejZQpQ3EWrzz3d/Q+dflbV0YleaElngDBYZsZIOc+kHeDIMYRobbSa/NtxA==
X-Received: by 2002:a1c:c789:: with SMTP id x131mr79907wmf.20.1568644953459;
 Mon, 16 Sep 2019 07:42:33 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:42:00 +0200
Message-Id: <1568644929-9124-21-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
Subject: [Qemu-devel] [PULL 20/29] hw/i386/pc: Pass the apic_id_limit value
 by argument
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

Pass the apic_id_limit value by argument, this will
allow us to remove the PCMachineState argument later.

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190818225414.22590-7-philmd@redhat.com>
---
 hw/i386/pc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index dc2ae6d..c0e9d83 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -937,7 +937,8 @@ static void pc_build_smbios(PCMachineState *pcms)
 }
 
 static FWCfgState *fw_cfg_arch_create(PCMachineState *pcms,
-                                      uint16_t boot_cpus)
+                                      uint16_t boot_cpus,
+                                      uint16_t apic_id_limit)
 {
     FWCfgState *fw_cfg;
     uint64_t *numa_fw_cfg;
@@ -1870,7 +1871,7 @@ void pc_memory_init(PCMachineState *pcms,
                                         option_rom_mr,
                                         1);
 
-    fw_cfg = fw_cfg_arch_create(pcms, pcms->boot_cpus);
+    fw_cfg = fw_cfg_arch_create(pcms, pcms->boot_cpus, pcms->apic_id_limit);
 
     rom_set_fw(fw_cfg);
 
-- 
1.8.3.1



