Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030CFC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E7520CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxnSizaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E7520CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZOM-0008Oe-VZ
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl4-0001Ip-EB
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykz-0008Ik-JD
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:14 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:41099)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykz-0008Ez-7m
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:09 -0500
Received: by mail-wr1-x42f.google.com with SMTP id v4so1507383wrs.8
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0GeSPUd+mKg9D1za+RBzaJqkiW6pHjAlr8xTe40NNV0=;
 b=FxnSizaDoNaD0hVWAR5gAEUIKgtITDVWMU15YFsycy2iDdwyD7s0XOgyMuuJFNo08J
 oQ+MUiIgxhht69HB07oxLtdnzdkK3lMBTJDbmgACEtBqyxGYm14Qo5Zpufq21ByIbZ7V
 1yguG3S6kMCE2R8Cr7wLFGHmUZ2l5zF2yaea2FBIA+ZGSEnBhIuVHkd9i0LLgdHZY+12
 RUpLmMNeruUoGD8e8e/qjo567KmkkWhqki1abzgtzdolO0fS+wwiDPuL4V/v8FV2Aql8
 3USoIal77xYrdYettIa3tU3nVOCQuugMpgbGMhX7aYTZEH9Gz/DhUE0yc40jZ1I0ghwO
 UI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0GeSPUd+mKg9D1za+RBzaJqkiW6pHjAlr8xTe40NNV0=;
 b=GFfP1Vjfdc1fS/Zl7PD4G6oxUGdo+k3xERorad/iFsF3aVDi6Ytm2XPZfiA2Hvglss
 nVNXwb7uSajThIKjFqMBY++O1pNnc2xbGJgj3tRlkenwNWozrmcRpSamSDOTQwe8oW5I
 fXsDr0KuvGguWE1ytACUE/nQYGCkjYnLbWQces5cryWuajIyUAMFLSQEVxV6FjbE+kis
 q9fk2FUdutmsGBo0sj0ZpKlih9Aj4fQYhrYRLKUV3Q7T2NyE4MjXjghpFwJvgS0lQBBH
 qDG0a3i5eFhDKOxIgVRWkeyijDNpNphCtmlwtrYaiIXpWvTnEUmf6TEbXmjc82uK+y32
 97xA==
X-Gm-Message-State: APjAAAUMNhJ+FaUf7SBAiWNR/Y868OtU9PTbH+lS7U0rLPqAq63Lcbz5
 M2yNx5gKk+tnFJv0cEU10rKdkPN2
X-Google-Smtp-Source: APXvYqzChQ/oJ6neqRqJNcE1nR780F6lp9cpX4kPybYxqxhCDRaEO2objemPsGtLY3plUCAMH2V+dQ==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr71539552wrj.261.1582631527937; 
 Tue, 25 Feb 2020 03:52:07 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 067/136] ppc/spapr: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:57 +0100
Message-Id: <1582631466-13880-67-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219160953.13771-68-imammedo@redhat.com>
---
 hw/ppc/spapr.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c9b2e0a..4d90f99 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2634,7 +2634,6 @@ static void spapr_machine_init(MachineState *machine)
     PCIHostState *phb;
     int i;
     MemoryRegion *sysmem = get_system_memory();
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
     hwaddr node0_size = spapr_node0_size(machine);
     long load_limit, fw_size;
     char *filename;
@@ -2813,10 +2812,8 @@ static void spapr_machine_init(MachineState *machine)
         kvmppc_enable_h_page_init();
     }
 
-    /* allocate RAM */
-    memory_region_allocate_system_memory(ram, NULL, "ppc_spapr.ram",
-                                         machine->ram_size);
-    memory_region_add_subregion(sysmem, 0, ram);
+    /* map RAM */
+    memory_region_add_subregion(sysmem, 0, machine->ram);
 
     /* always allocate the device memory information */
     machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
@@ -4400,6 +4397,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->no_parallel = 1;
     mc->default_boot_order = "";
     mc->default_ram_size = 512 * MiB;
+    mc->default_ram_id = "ppc_spapr.ram";
     mc->default_display = "std";
     mc->kvm_type = spapr_kvm_type;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SPAPR_PCI_HOST_BRIDGE);
-- 
1.8.3.1



