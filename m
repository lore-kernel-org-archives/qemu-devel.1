Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654D6C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3386D2084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbtYxlCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3386D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Z6p-00077U-Bt
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykf-0000pF-6F
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykb-00079Y-CS
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:49 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:32872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykb-00071y-2v
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:45 -0500
Received: by mail-wm1-x335.google.com with SMTP id m10so2052467wmc.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JmXcr0W52fcISG0AOHtfcuEq+w+rjA6FgdcBQj6UTa4=;
 b=hbtYxlCn2YcTbLb+w+Ktom9yXnN9t7kFLoQj2zryuohemD8Z2Ileo9Wmg9Rt7kDKNH
 4fo22fmnQ8rl99DuCEE6cbflcFmaizhGYSfKKSrDZgayaKrZIpkmCohcVYZzm5auzD8z
 McSk/SK7aLlRqRZWbrproN/m4VKw5b6afMVNG95Sl/U93t09xti1DiHMpr+o1JjfkoRk
 +7d5F2NSj2YZNyRQ+VEgYPMjsk2CkZJMbT+V4VbN8Nk2q7kV7fA0ZLKvYCnmdTdxwYwF
 VNjEdYy0SLBHVz/8Mb0h+AchXYahw/YFByjNSpAinKaP+5y13eaIQEKpj5//+Nb1fqPG
 aowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JmXcr0W52fcISG0AOHtfcuEq+w+rjA6FgdcBQj6UTa4=;
 b=Nre2PEzTrjyCXCrCbyNliMbzrGauvlsn+g3QVX1larsdyjty1I8KTlBPBVKS15Ips+
 /stW+vFdGHl4Ci3sE8140ULM63KhKQ3FrKZwLL8issEFooidwv4lqbtAIAGcUsME9frc
 7nKXKFnwKgpJBSlt7ux2otKym/gpapBk0/p8Ec/97W9Khx4kz7yRzWAhdsNGajLc8FkN
 oZqzVcXk/dtBH+MMCkYj2Gew5ZZAQXc8M7KmTq/k1r/SRuFCuFQdz7TdXb/32PPqPq/t
 UKlv7yvqsy/7u8N7EWxnqEpBxElizDtIFmm1Pp6x4hPjoOItaFsJzbKlZf0a8TAX6TFv
 ix5w==
X-Gm-Message-State: APjAAAUsvU2wRtO21ZZH0clBwpFkowuYa9P8aAo7l9fJNqbiLH6TQ3dz
 l9oKI33LCXTg/enFIoqiGdk97p7V
X-Google-Smtp-Source: APXvYqwHfsG9TK82hodsLn7h8fd8QCQD+uH8nh2a1eqHwPiiLDTWf703uNsebZkRiKTUvGcFTzlPhQ==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr5070173wmi.116.1582631502941; 
 Tue, 25 Feb 2020 03:51:42 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 039/136] null-machine: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:29 +0100
Message-Id: <1582631466-13880-39-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Message-Id: <20200219160953.13771-40-imammedo@redhat.com>
---
 hw/core/null-machine.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 1aa0a9a..cb47d9d 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -32,11 +32,8 @@ static void machine_none_init(MachineState *mch)
     }
 
     /* RAM at address zero */
-    if (mch->ram_size) {
-        MemoryRegion *ram = g_new(MemoryRegion, 1);
-
-        memory_region_allocate_system_memory(ram, NULL, "ram", mch->ram_size);
-        memory_region_add_subregion(get_system_memory(), 0, ram);
+    if (mch->ram) {
+        memory_region_add_subregion(get_system_memory(), 0, mch->ram);
     }
 
     if (mch->kernel_filename) {
@@ -52,6 +49,7 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->init = machine_none_init;
     mc->max_cpus = 1;
     mc->default_ram_size = 0;
+    mc->default_ram_id = "ram";
 }
 
 DEFINE_MACHINE("none", machine_none_machine_init)
-- 
1.8.3.1



