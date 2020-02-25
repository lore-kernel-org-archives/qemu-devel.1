Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7022FC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA472176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWxtugka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA472176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6YvE-0002pQ-Cy
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:02:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkR-0000WY-CD
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkL-0006H6-UF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:34 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:52803)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkL-0006F9-NU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:29 -0500
Received: by mail-wm1-x330.google.com with SMTP id p9so2678989wmc.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bMgXI7ZaOveWx97I1116BFCMThPfPtHDwWeOZBBJ4bE=;
 b=BWxtugkavCux5gTgyFTdQJYMH1nwDsd0SFKftkpgoxTgCZY5b00QwMjjY3DAlUzWGM
 Qwljjnu4i6+7uxO8WBwyMtKBlytI649iYXE3I1Ek3+GKKVt7hh0z1LZqSXqE1eC8+GSZ
 CjjLXOCHOxq9UKlb6ZR6ojGpNGjJMNUQqIzSsmzU3RhnQiM0pYUBpGRvpN2igKoQjHRo
 lg+JyL+zLxu0idmZ4kqvBaue8HTnDMdyYMVSy+244mrTs7sUL5/cAF4qE1JAmid6BAQw
 KpAH8BI/aYyCC/1D1OR0nV/UPUHyu8vPC9J4haOtq6XGYnhRbqBweExRrm5J62XbjH7j
 k/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=bMgXI7ZaOveWx97I1116BFCMThPfPtHDwWeOZBBJ4bE=;
 b=seDTKismTQePCmY+66f82tYuGabLtMILSMJdYWz1pWMiXZa9+fowpxn3tXjDapnTt/
 Amv6ur+KISaXuzqFZ1VftKuG8NyOFetdE+1M89IbaIx85c2Y+omF3gU2LdEBdLEAGh8s
 i5vN2aYIcLp9t7O/oTRDqSuEI/KmHZu6tpACZDhiug+b+1kTe+yiga+D2ymVoX0+TuTl
 hLibZatQf7/YqrIWiVFWCAsYspDmt3oVpbUZCsmHhSHfYaf2aJPjnuGGBpAJePAPhSfy
 acTMY3KAwJOFb+QZlc8iqG0VmN3r1VUj4ZHIqe3XXgwBM8U4RwnA6T2GQtA7N1f/F3yx
 hwYA==
X-Gm-Message-State: APjAAAX6FxNPHqe4uTDN3Bc4046XSVrmledv7ErHDyOGlH0xFnWkePXP
 edR0SZRIVdrVCFPN7v4TpPJey2ty
X-Google-Smtp-Source: APXvYqzhLKxcIX27HvSIqcC2TasUdIYKosaaYhg7xfjnewvFOPnSW8s7tcNfIrScfIxx8aQj2K2O0g==
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr4861859wma.24.1582631487476; 
 Tue, 25 Feb 2020 03:51:27 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 022/136] arm/mps2-tz: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:12 +0100
Message-Id: <1582631466-13880-22-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
 while at it add check for user supplied RAM size and error
 out if it mismatches board expected value.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219160953.13771-23-imammedo@redhat.com>
---
 hw/arm/mps2-tz.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index f8b620b..a8dea7d 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -39,6 +39,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
@@ -79,7 +80,6 @@ typedef struct {
     MachineState parent;
 
     ARMSSE iotkit;
-    MemoryRegion psram;
     MemoryRegion ssram[3];
     MemoryRegion ssram1_m;
     MPS2SCC scc;
@@ -388,6 +388,13 @@ static void mps2tz_common_init(MachineState *machine)
         exit(1);
     }
 
+    if (machine->ram_size != mc->default_ram_size) {
+        char *sz = size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
     sysbus_init_child_obj(OBJECT(machine), "iotkit", &mms->iotkit,
                           sizeof(mms->iotkit), mmc->armsse_type);
     iotkitdev = DEVICE(&mms->iotkit);
@@ -458,9 +465,7 @@ static void mps2tz_common_init(MachineState *machine)
      * tradeoffs. For QEMU they're all just RAM, though. We arbitrarily
      * call the 16MB our "system memory", as it's the largest lump.
      */
-    memory_region_allocate_system_memory(&mms->psram,
-                                         NULL, "mps.ram", 16 * MiB);
-    memory_region_add_subregion(system_memory, 0x80000000, &mms->psram);
+    memory_region_add_subregion(system_memory, 0x80000000, machine->ram);
 
     /* The overflow IRQs for all UARTs are ORed together.
      * Tx, Rx and "combined" IRQs are sent to the NVIC separately.
@@ -642,6 +647,8 @@ static void mps2tz_class_init(ObjectClass *oc, void *data)
 
     mc->init = mps2tz_common_init;
     iic->check = mps2_tz_idau_check;
+    mc->default_ram_size = 16 * MiB;
+    mc->default_ram_id = "mps.ram";
 }
 
 static void mps2tz_an505_class_init(ObjectClass *oc, void *data)
-- 
1.8.3.1



