Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E14C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F59E21927
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWA6/pSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F59E21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6YsX-0007Si-67
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:59:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkF-0000Ep-7W
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkB-0005jH-Cy
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:23 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:37956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkB-0005eH-3P
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:19 -0500
Received: by mail-wr1-x434.google.com with SMTP id e8so14376063wrm.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZDras4bJE0jrJh+tI0g3t+yqgoZLyLXZGVhvwozi+Bk=;
 b=kWA6/pSsQU7C5tbUYE9Eg4N59QPm5yK92MsMmD86qBbhRBEr/gYefTcHNqr2tg598M
 aTragnOc+GfOk0jdXU12mh8XqhndWb1b7oPz9R4UD80SfUVPRvkMEe4p7xDuPyZkwxHd
 dEI1gKyS54/NIwDjzSKqQWDaJ7s1EaB9iln2TiBoTpivF/MxutNIpVUym+OjbPxuZ5dU
 MgK2t94/i8BpH8vm7SIC1UaoI0jGdZSrfyc5h6zuNYlQc/QD5WyxlMcrampNHqfWBnnO
 ZSLLM1nodE2l/L2iUWmicZ1vKe10uvjvlCNzECRaEoJz81gQCkkSZXWVoJQ0WB1jWsri
 0wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=ZDras4bJE0jrJh+tI0g3t+yqgoZLyLXZGVhvwozi+Bk=;
 b=bvjiQ9ftRMlJ5saGMil9OApUeQIUwJJ4UcbLfGwNvShyDc3M3HFxtEONg4orUz8ukY
 a97h+q+kMdQq/SlV6WRlMejDQ3TdOe5IpB0EGxJ3FTkBX7SaqFtd1rGaqn2kUTpPAtX/
 ofaYq/CLeVJ+53JENvORz8UQxXTZMxr4vJZrC94sialpBt95dH2rBm6UgDO7LopvABwi
 6w5+iMBlUuuhPWuhXr3OPphl0CMZnkCSQQlysphuMg0ixJriuuuCm0bZxRU6NFLMdPna
 T52ZmtMuZVIseioUPv6nxoSxV/qYG7NhmLJCbJ+nVLSU8f/+u3tQXx0K3eMvdWuaCy9Y
 fPCA==
X-Gm-Message-State: APjAAAUxoO9+BILuHHPJJlYLFdagsiUErGS9Y7H1avkcm4FSYJcWC4si
 qg7QCE/us1oYQDHXI/amrhuI+HJO
X-Google-Smtp-Source: APXvYqxPc+0yz4LFNwFukNZWtTV7Try/Cd+gdeqfhD6RrRENecZZQKPT94difPHhBMgUP83A/0wAPA==
X-Received: by 2002:a5d:5745:: with SMTP id q5mr16440084wrw.374.1582631477877; 
 Tue, 25 Feb 2020 03:51:17 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 012/136] arm/cubieboard: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:02 +0100
Message-Id: <1582631466-13880-12-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

PS:
While at it, get rid of no longer needed CubieBoardState wrapper.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-13-imammedo@redhat.com>
---
 hw/arm/cubieboard.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 6dc2f1d..089f9a3 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -28,52 +28,42 @@ static struct arm_boot_info cubieboard_binfo = {
     .board_id = 0x1008,
 };
 
-typedef struct CubieBoardState {
-    AwA10State *a10;
-    MemoryRegion sdram;
-} CubieBoardState;
-
 static void cubieboard_init(MachineState *machine)
 {
-    CubieBoardState *s = g_new(CubieBoardState, 1);
+    AwA10State *a10 = AW_A10(object_new(TYPE_AW_A10));
     Error *err = NULL;
 
-    s->a10 = AW_A10(object_new(TYPE_AW_A10));
-
-    object_property_set_int(OBJECT(&s->a10->emac), 1, "phy-addr", &err);
+    object_property_set_int(OBJECT(&a10->emac), 1, "phy-addr", &err);
     if (err != NULL) {
         error_reportf_err(err, "Couldn't set phy address: ");
         exit(1);
     }
 
-    object_property_set_int(OBJECT(&s->a10->timer), 32768, "clk0-freq", &err);
+    object_property_set_int(OBJECT(&a10->timer), 32768, "clk0-freq", &err);
     if (err != NULL) {
         error_reportf_err(err, "Couldn't set clk0 frequency: ");
         exit(1);
     }
 
-    object_property_set_int(OBJECT(&s->a10->timer), 24000000, "clk1-freq",
-                            &err);
+    object_property_set_int(OBJECT(&a10->timer), 24000000, "clk1-freq", &err);
     if (err != NULL) {
         error_reportf_err(err, "Couldn't set clk1 frequency: ");
         exit(1);
     }
 
-    object_property_set_bool(OBJECT(s->a10), true, "realized", &err);
+    object_property_set_bool(OBJECT(a10), true, "realized", &err);
     if (err != NULL) {
         error_reportf_err(err, "Couldn't realize Allwinner A10: ");
         exit(1);
     }
 
-    memory_region_allocate_system_memory(&s->sdram, NULL, "cubieboard.ram",
-                                         machine->ram_size);
     memory_region_add_subregion(get_system_memory(), AW_A10_SDRAM_BASE,
-                                &s->sdram);
+                                machine->ram);
 
     /* TODO create and connect IDE devices for ide_drive_get() */
 
     cubieboard_binfo.ram_size = machine->ram_size;
-    arm_load_kernel(&s->a10->cpu, machine, &cubieboard_binfo);
+    arm_load_kernel(&a10->cpu, machine, &cubieboard_binfo);
 }
 
 static void cubieboard_machine_init(MachineClass *mc)
@@ -84,6 +74,7 @@ static void cubieboard_machine_init(MachineClass *mc)
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
     mc->ignore_memory_transaction_failures = true;
+    mc->default_ram_id = "cubieboard.ram";
 }
 
 DEFINE_MACHINE("cubieboard", cubieboard_machine_init)
-- 
1.8.3.1



