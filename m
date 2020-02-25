Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA78C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487E62084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVerVPsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487E62084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Z40-000150-Dy
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykb-0000jK-44
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkX-0006pT-4j
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:45 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:35412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkW-0006l9-Tw
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:41 -0500
Received: by mail-wm1-x329.google.com with SMTP id m3so2664173wmi.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WtQV3C8k1Qb8hG/eYTsxWB1Sv2dvZuX6RSL2EeTni/k=;
 b=FVerVPsMUmrhA5oU9EK1fXQrTjextvxCO3j56zzrbLQqCinb8Zh7i4DZlxZDtiJKW8
 FtUD04gcRnJeEAjooDRwrFr79fVbTxFE/ylWCeKfShPzM+Glka7OGh3FKLwokr2bH6B2
 BblixP2hsA2BI7TDu1vCckuMNdubZXCshRoEBYu1QYT+ewL3JrR+ZgCpj+h+rI+hqNMy
 J958J+unXAoS1+d3Wz1Cq8tvmeF9FqrUZMr55EZ+fEKag4ffWfRp97+81JMEivXdxYja
 Rj1ZlLQR8lIvR6+pf/+yJvRZTf2Zi5kGaRjkd6/W9BtI53p655MUR8CrCi+CrlPkIEq1
 OQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=WtQV3C8k1Qb8hG/eYTsxWB1Sv2dvZuX6RSL2EeTni/k=;
 b=p4DMu+y8QWs3E3PHk2jnVZTtd5wro88Bk4nRvmaHH29xhT02judoTQhUbOs8uvOHf+
 90hlRQ0lrYawigjHx6KDOE73lZ0xoFXQaD7LvAurY465OkbpkeRbh607vLlZL88Mfi41
 4Vso3yvydXg9oY9MUj2XFm9kpzIImhXJiTkqhbzVljowuixsr5eXQldrHTBnQTvqle0m
 Akrb+Lug7EiIb7xMSVHVgj3IgeY+sA2nJ3etp2NS0w0qkOEwew+8qew3tws/DDvLIxLv
 422XNEFbh87yoFdBZGS22ncuJ13TQrYO4DfBMf9CXX2csQMkFDIPM1YUS0R5G2r+sf5I
 L0cg==
X-Gm-Message-State: APjAAAU+2gQKXYQ7h6KUwMnuSEwQUhWxRXjPTa0wNCmwywKFHA7fH5+X
 CVn0igJ2290qzPu1ntuJyCiHvNXr
X-Google-Smtp-Source: APXvYqygu7wzCEb/dOKwhtCSNZEmlK02cyiythlJmdegZSa9toshqn/Kq39P4IrZTSW138GojTm4GQ==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr5244801wmi.152.1582631499393; 
 Tue, 25 Feb 2020 03:51:39 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 035/136] arm/xilinx_zynq: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:25 +0100
Message-Id: <1582631466-13880-35-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-36-imammedo@redhat.com>
---
 hw/arm/xilinx_zynq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index f548c44..3d439a4 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -160,7 +160,6 @@ static void zynq_init(MachineState *machine)
 {
     ARMCPU *cpu;
     MemoryRegion *address_space_mem = get_system_memory();
-    MemoryRegion *ext_ram = g_new(MemoryRegion, 1);
     MemoryRegion *ocm_ram = g_new(MemoryRegion, 1);
     DeviceState *dev;
     SysBusDevice *busdev;
@@ -190,9 +189,7 @@ static void zynq_init(MachineState *machine)
     object_property_set_bool(OBJECT(cpu), true, "realized", &error_fatal);
 
     /* DDR remapped to address zero.  */
-    memory_region_allocate_system_memory(ext_ram, NULL, "zynq.ext_ram",
-                                         machine->ram_size);
-    memory_region_add_subregion(address_space_mem, 0, ext_ram);
+    memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
     /* 256K of on-chip memory */
     memory_region_init_ram(ocm_ram, NULL, "zynq.ocm_ram", 256 * KiB,
@@ -318,6 +315,7 @@ static void zynq_machine_init(MachineClass *mc)
     mc->no_sdcard = 1;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
+    mc->default_ram_id = "zynq.ext_ram";
 }
 
 DEFINE_MACHINE("xilinx-zynq-a9", zynq_machine_init)
-- 
1.8.3.1



