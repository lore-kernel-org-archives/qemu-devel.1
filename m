Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA849C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895D4206F8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAFhqfNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895D4206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLVzM-00017A-Lq
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVr5-00021d-OS
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVr4-0002oc-HU
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37329)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVr3-0002mY-45; Mon, 06 Apr 2020 13:48:14 -0400
Received: by mail-wr1-x444.google.com with SMTP id w10so514751wrm.4;
 Mon, 06 Apr 2020 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=anzYFovrf/fQYvmPVuqZgz1Z6ltPtlVuwPCGWfaH9jY=;
 b=mAFhqfNNg59X7mdoE03bX7DAKyePJqDA0krRHJG80hkUw/stGjMxe3Dy202es0RyMh
 uzazu14ygaIPIAJi9Z13WQ39AN/4IgdONGpIaS1kLFMyyhVkAs80M66DB+VWi+eFoFMh
 879PFXH/cqPkOqEV2q47EpTcVfSOItFOtRO/71tcxEVetAXCz+klIeqi9lCziiK8LEb+
 /nroYsoY0/jp1y8kSyZI7zsIxY8fb6GPnBssV3CZLItPLgmUiJSVwYQD551feT66DHzH
 xzq7aoJthGwra+5OAEyr3ypzy9K/HL3IDCHzOfKmyDjK0uiF2ZKX4kQpWbaMJz1KK6M4
 2FmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=anzYFovrf/fQYvmPVuqZgz1Z6ltPtlVuwPCGWfaH9jY=;
 b=ZuqRhs05YNohpKma0CK7HgVW6CpJ+GOH+85Sv7mJpkIyWz+WF4Av8Bo6F9G4Mj2rrj
 Q8f5h88hY6azq/Z0p9mHy+Zzcqa7EwFIrhHSoknsK69OTUiTOYjYXpp8fy1wyPC17T3J
 YL6mtvrzSioNtVLnp6rZRm4arAZL3ue3yGNP2z8f/prrRL5mgvwwAdUy4l6W7fJjKHSi
 jbFKe6n41D6cFBk1Le3u0aUX7fP27xcUsPBDCJ4i0rWUUhaWE+he1NiKMeTDQCsoqV5t
 GNDv3IKWUZjsNcdkYZSKOVcpJ8f8hPp6wbUCEWVeu/QY5yQPnjgszsqFJRgX3L3VufZv
 rqkA==
X-Gm-Message-State: AGi0PuatAwz3s8CiesDVAwXOXQspLvMgOPq/CLE65AwJOEZ/aKTIGjwi
 AjYqbrRbBvWFtWJPeAjaYrq/dR0qfC4=
X-Google-Smtp-Source: APiQypKi6aG6bA6P3T7tqfAqg6zAQLsvDDeNtIERo6QTnyEUERNCOMOzsQy4rkF3X972/WXhrsG4bw==
X-Received: by 2002:a5d:4e03:: with SMTP id p3mr347886wrt.408.1586195291974;
 Mon, 06 Apr 2020 10:48:11 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 19/54] hw/riscv/sifive_e: Move some code from
 realize() to init()
Date: Mon,  6 Apr 2020 19:47:08 +0200
Message-Id: <20200406174743.16956-20-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coccinelle reported:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: ./hw/riscv/sifive_e.c
  >>> possible moves from riscv_sifive_e_soc_init() to riscv_sifive_e_soc_realize() in ./hw/riscv/sifive_e.c:135

Move the calls using &error_fatal which don't depend of input
updated before realize() to init().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/riscv/sifive_e.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 646553a7c3..0be8b52147 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -118,7 +118,9 @@ static void riscv_sifive_e_init(MachineState *machine)
 static void riscv_sifive_e_soc_init(Object *obj)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
+    const struct MemmapEntry *memmap = sifive_e_memmap;
     SiFiveESoCState *s = RISCV_E_SOC(obj);
+    MemoryRegion *sys_mem = get_system_memory();
 
     object_initialize_child(obj, "cpus", &s->cpus,
                             sizeof(s->cpus), TYPE_RISCV_HART_ARRAY,
@@ -130,6 +132,18 @@ static void riscv_sifive_e_soc_init(Object *obj)
     sysbus_init_child_obj(obj, "riscv.sifive.e.gpio0",
                           &s->gpio, sizeof(s->gpio),
                           TYPE_SIFIVE_GPIO);
+
+    /* Mask ROM */
+    memory_region_init_rom(&s->mask_rom, obj, "riscv.sifive.e.mrom",
+                           memmap[SIFIVE_E_MROM].size, &error_fatal);
+    memory_region_add_subregion(sys_mem,
+        memmap[SIFIVE_E_MROM].base, &s->mask_rom);
+
+    /* Flash memory */
+    memory_region_init_rom(&s->xip_mem, obj, "riscv.sifive.e.xip",
+                           memmap[SIFIVE_E_XIP].size, &error_fatal);
+    memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_XIP].base,
+        &s->xip_mem);
 }
 
 static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
@@ -144,12 +158,6 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_bool(OBJECT(&s->cpus), true, "realized",
                             &error_abort);
 
-    /* Mask ROM */
-    memory_region_init_rom(&s->mask_rom, OBJECT(dev), "riscv.sifive.e.mrom",
-                           memmap[SIFIVE_E_MROM].size, &error_fatal);
-    memory_region_add_subregion(sys_mem,
-        memmap[SIFIVE_E_MROM].base, &s->mask_rom);
-
     /* MMIO */
     s->plic = sifive_plic_create(memmap[SIFIVE_E_PLIC].base,
         (char *)SIFIVE_E_PLIC_HART_CONFIG,
@@ -206,12 +214,6 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_E_QSPI2].base, memmap[SIFIVE_E_QSPI2].size);
     create_unimplemented_device("riscv.sifive.e.pwm2",
         memmap[SIFIVE_E_PWM2].base, memmap[SIFIVE_E_PWM2].size);
-
-    /* Flash memory */
-    memory_region_init_rom(&s->xip_mem, OBJECT(dev), "riscv.sifive.e.xip",
-                           memmap[SIFIVE_E_XIP].size, &error_fatal);
-    memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_XIP].base,
-        &s->xip_mem);
 }
 
 static void riscv_sifive_e_machine_init(MachineClass *mc)
-- 
2.21.1


