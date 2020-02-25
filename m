Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C58C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51EED2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD5cDl+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EED2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6YvD-0002lt-Ex
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykd-0000lW-1l
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkV-0006jj-4c
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:45 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:35188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkU-0006hU-TG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:39 -0500
Received: by mail-wr1-x42a.google.com with SMTP id w12so14382420wrt.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lb5TZlU4ZCXBpq8odc+led57Pe1eLFUNpanG46JDR2Y=;
 b=ZD5cDl+Hdvr5Thmeoa6lHRQmbYSFwmqLQCxxUpFYgIy/KeYG1L5Rdn7Bx7hYRfqgXL
 FeAlOZZMaZN0dfOGn786KJIvE2sdZPt5dqwTQJTB8Kegmk0w18Wyg1zoNLhMWIXQSE4X
 FkJR+k+BABcZFIdzKuVl93OlkrMl2dyEqtCqcg3eVpav1w7767hpW48pHbpDATa7v5H7
 5fTcmfnK5SDWU43sJW/iPNUV9xWt2fOgd8NuWnU4K022ROvPMUCtOd61VQHf6ekXJK4k
 ScMxkTMf1HkD++YK/OpF61l16q+L0bEhccXFJWdSCItXL5ZCN9SOEFzHqJqNiARVB/zn
 S0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lb5TZlU4ZCXBpq8odc+led57Pe1eLFUNpanG46JDR2Y=;
 b=RZK3QypZKFzz3XRsrO7CfJSephmPq/DB9EgwM5S+NGgodaSO+/Mz4/iJSCx0FuYk7B
 qo2k4oai0N0Uf7ZTOmNPK8fnKK5upJqsjXEwZBjxXQnrqpzsfCmw0okNItr0twSTEaof
 MXv0gFeHOmJgmquMx3hIT610bu0kjZ6K9yp2DGRbm8lvGbzSOxWkh+ZYbE85aX3Pcdxb
 BVpFlcKtRlt/xOQ8op/w1xAW7yGkr8D0BYwIHYqyrsHs7Ar3QgS2DPeDLCsFhhw9bsWq
 jfDl3B8UYWofxTDARilRly+v0QWsSFK9xBKZF9Q4q9um0oNnWhVPHoZ2PFnwXwdSfE3q
 5gvg==
X-Gm-Message-State: APjAAAUPXT9+U902X5DGqFRefJ5/bPlLJ/nDdmH2e7vQ/l1GSTP9wcpC
 6YiSOAKamBjDfInRD3VRX4LLmtNb
X-Google-Smtp-Source: APXvYqzH3WFNcqhCkHusVQTLykDZfR6P68Xonrqt2fjFxDwT2ANwmVQ83bSfHA8JrEW7LlqmjAffjw==
X-Received: by 2002:a5d:5745:: with SMTP id q5mr16442031wrw.374.1582631497681; 
 Tue, 25 Feb 2020 03:51:37 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 033/136] arm/virt: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:23 +0100
Message-Id: <1582631466-13880-33-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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

memory_region_allocate_system_memory() API is going away,
so replace it with memdev allocated MemoryRegion.
The later is initialized by generic code, so board only
needs to opt in to memdev scheme by providing
  MachineClass::default_ram_id
and then map memory region provided by
  MachineState::ram_memdev

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-34-imammedo@redhat.com>
---
 hw/arm/virt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f788fe2..e591a12 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1512,7 +1512,6 @@ static void machvirt_init(MachineState *machine)
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *secure_sysmem = NULL;
     int n, virt_max_cpus;
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
     bool firmware_loaded;
     bool aarch64 = true;
     bool has_ged = !vmc->no_ged;
@@ -1706,9 +1705,8 @@ static void machvirt_init(MachineState *machine)
         }
     }
 
-    memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
-                                         machine->ram_size);
-    memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);
+    memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base,
+                                machine->ram);
     if (machine->device_memory) {
         memory_region_add_subregion(sysmem, machine->device_memory->base,
                                     &machine->device_memory->mr);
@@ -2058,6 +2056,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     hc->unplug_request = virt_machine_device_unplug_request_cb;
     mc->numa_mem_supported = true;
     mc->auto_enable_numa_with_memhp = true;
+    mc->default_ram_id = "mach-virt.ram";
 }
 
 static void virt_instance_init(Object *obj)
-- 
1.8.3.1



