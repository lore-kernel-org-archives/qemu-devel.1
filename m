Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E046C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0281820719
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6uBhmX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0281820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDut2-0007fI-2y
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDuqE-00023H-7K
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDuqD-0001sl-58
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58691)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDuqD-0001kg-02
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lJlVMKZax5qIb1MJWYEp8Y1G4BH96heGWQHiGeb4Cus=;
 b=d6uBhmX+eIBxky7rrZS+RJ6LuTaGoJAxzDZForx91YIdFHKvozP/QAFC2QrSWi5maSc4VY
 icS8YBYSiyHYwv4vgobaT2XcS6SFqSZ1Se6OGQVcTTaey0Khk6tW4wIXRhNgHJTPg/Tk9O
 CQdwk2lYUNfs7xrtQnXdVzlBnvKNdAA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-pBxvc8JoNDWHfgysu8SpwA-1; Mon, 16 Mar 2020 14:51:53 -0400
X-MC-Unique: pBxvc8JoNDWHfgysu8SpwA-1
Received: by mail-wr1-f71.google.com with SMTP id t10so3163488wrp.15
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NlR0W1rwyt02Ypkn/GIhl77Q2tixa1X5gZqoTZJ3XAc=;
 b=UyQtJDLwhobI2HmOF+hf5vEp9SrnAs+TvY/Xuzf8r4686rwWiHkU5S7N+19setDryw
 8WFvej56pHvh3YHTsZ0rpf4c85JSb9tpboqCfX9IKa6awkxoQoNPyVYMSgQ6ypzxt7xY
 zWSxy3w11sWLjzPCDd2SfChE0TTaQROn5k/VajquymV53Ufb9THZLZi/C1fLi0gZ+ztr
 g3jx53+b9NLPl3jPlpowhFBpveXQK31DkvauB1rLFC1Q8I8sd9DqkuFSRrNUnA+fbSxw
 htRZem0ra1NbpAAxFSb/cZes94BNrtJsI0kPiPWp7ZDogbzPQowC2eWNXBiQtLvpfqYj
 GGQA==
X-Gm-Message-State: ANhLgQ049SC1O6NJS17zhVawDPMC1/QcgmGu9cZQG4NmXzqq7hrq2yQL
 Ox7MXL0a2Zjy06v9YJ/jgPUOx2Bx2rQKlwEJRrFB3442wQWVSgadAWQ816OmZAqWS+spyQlDBm4
 EkAZE+jO/uvkqGkM=
X-Received: by 2002:a05:600c:204:: with SMTP id 4mr486838wmi.112.1584384712298; 
 Mon, 16 Mar 2020 11:51:52 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsfokMzXIaYUKe+yPU0VT7cajBV5qDQv0gD5seZGtXEytA4OUpypM+GVgF/rry1m1L7lSzfVQ==
X-Received: by 2002:a05:600c:204:: with SMTP id 4mr486823wmi.112.1584384712123; 
 Mon, 16 Mar 2020 11:51:52 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id l18sm1082013wrr.17.2020.03.16.11.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:51:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 20/25] hw/riscv: Let devices own the MemoryRegion they
 create
Date: Mon, 16 Mar 2020 19:50:01 +0100
Message-Id: <20200316185006.576-21-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316185006.576-1-philmd@redhat.com>
References: <20200316185006.576-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid orphan memory regions being added in the /unattached QOM
container.

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/riscv/sifive_e.c | 6 +++---
 hw/riscv/sifive_u.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index a1974ef7be..646553a7c3 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -145,8 +145,8 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev=
, Error **errp)
                             &error_abort);
=20
     /* Mask ROM */
-    memory_region_init_rom(&s->mask_rom, NULL, "riscv.sifive.e.mrom",
-        memmap[SIFIVE_E_MROM].size, &error_fatal);
+    memory_region_init_rom(&s->mask_rom, OBJECT(dev), "riscv.sifive.e.mrom=
",
+                           memmap[SIFIVE_E_MROM].size, &error_fatal);
     memory_region_add_subregion(sys_mem,
         memmap[SIFIVE_E_MROM].base, &s->mask_rom);
=20
@@ -208,7 +208,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev=
, Error **errp)
         memmap[SIFIVE_E_PWM2].base, memmap[SIFIVE_E_PWM2].size);
=20
     /* Flash memory */
-    memory_region_init_rom(&s->xip_mem, NULL, "riscv.sifive.e.xip",
+    memory_region_init_rom(&s->xip_mem, OBJECT(dev), "riscv.sifive.e.xip",
                            memmap[SIFIVE_E_XIP].size, &error_fatal);
     memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_XIP].base,
         &s->xip_mem);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 156a003642..662d42a5a7 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -497,7 +497,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev=
, Error **errp)
                              &error_abort);
=20
     /* boot rom */
-    memory_region_init_rom(mask_rom, NULL, "riscv.sifive.u.mrom",
+    memory_region_init_rom(mask_rom, OBJECT(dev), "riscv.sifive.u.mrom",
                            memmap[SIFIVE_U_MROM].size, &error_fatal);
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
                                 mask_rom);
--=20
2.21.1


