Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF1CC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7825D206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfBTBu4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7825D206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3evs-00067k-Le
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 06:51:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqP-0006Ys-4y
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:45:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqN-0002Qi-LJ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:45:45 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34753)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqN-0002Q7-Em; Mon, 17 Feb 2020 06:45:43 -0500
Received: by mail-wr1-x444.google.com with SMTP id n10so17385980wrm.1;
 Mon, 17 Feb 2020 03:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3UiEjEXttuM7t0xfD+phHvJNwF4QMG2Y+xuMq2THqy8=;
 b=nfBTBu4k1ml1skKW92aonJI6EY7SGTutu+amIEpRNTWBW//lrsFj6chx1hinP7lqF0
 /GoTEjoFWL6oxduseO7xScOUdgmId/IT+3+w7BBlYKJq0R2X6xoxDkctXDaXAOjVrpD3
 RV7dBXOgF5w26vN/U49JEctKqpDOscxw0jqLiRUbSqgsEcm2CqSRsaiZXtztIS69W8OK
 Agf58/JmUseO3wiagTFFC/GCiOhyDFpkyTDrxH2MdUaDlk0Jbl49n2ZaJTQ5T2OZdMoh
 0ZutvSapnWRqhgPBHhBIWmXxjE+5s6zGxSXNsMb/gC8iFD1+kr3P83ng3V8KtDNk9itx
 CurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3UiEjEXttuM7t0xfD+phHvJNwF4QMG2Y+xuMq2THqy8=;
 b=G2k5Tscb7vGd0obc1MnL3/q47ZQFtOhJMp0BVtveHq4sxIPB+YJcZL9n6pJ5RxJUwk
 qpust/pUVfk245ic02pJclvKpFNYbnhQCxdrr8DZA5B/wmk6mKMPFvS8J2+VOQHwUjrk
 u2d0QLZKPmAc2YAITRJxT7yC4aQIgy+/t0H+S3JyY46t5J8E3e6f7jVgE51p59QzTsjH
 ucmuinicGTWyBApVUmPdD5CP9p+9OxZoMl2YIktZnEQkUa6KCK33TE3E/j0gz1rFRb+e
 qsYBgTfgxGTecFw2XqgTWIb7Mw82eRYCWtGNBIWdf9FDc5JTpb71sGVp0um3kNZXu4wQ
 jWOA==
X-Gm-Message-State: APjAAAX75CTcjARpVo4/v8E59Ce9fjfIS88Hc2MHy2pWOVJmj+ZLhWjM
 LOzDm0es1gpbRAZq1htPsRiQ1g71L1s=
X-Google-Smtp-Source: APXvYqyFMIrWOCv1C8DrCglln7p6Nn242A1A3D5jYBLPffCQphODihEENkETGoWIwbOKA0F5QOVhgA==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr21712664wru.173.1581939942103; 
 Mon, 17 Feb 2020 03:45:42 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id i2sm268149wmb.28.2020.02.17.03.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 03:45:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/13] hw/arm/raspi: Remove use of the 'version' value in
 the board code
Date: Mon, 17 Feb 2020 12:45:25 +0100
Message-Id: <20200217114533.17779-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200217114533.17779-1-f4bug@amsat.org>
References: <20200217114533.17779-1-f4bug@amsat.org>
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We expected the 'version' ID to match the board processor ID,
but this is not always true (for example boards with revision
id 0xa02042/0xa22042 are Raspberry Pi 2 with a BCM2837 SoC).
This was not important because we were not modelling them, but
since the recent refactor now allow to model these boards, it
is safer to check the processor id directly. Remove the version
check.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index b628dadf34..fff501affb 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -98,11 +98,6 @@ static RaspiProcessorId board_processor_id(uint32_t board_rev)
     return proc_id;
 }
 
-static int board_version(uint32_t board_rev)
-{
-    return board_processor_id(board_rev) + 1;
-}
-
 static const char *board_soc_type(uint32_t board_rev)
 {
     return soc_property[board_processor_id(board_rev)].type;
@@ -201,7 +196,8 @@ static void reset_secondary(ARMCPU *cpu, const struct arm_boot_info *info)
     cpu_set_pc(cs, info->smp_loader_start);
 }
 
-static void setup_boot(MachineState *machine, int version, size_t ram_size)
+static void setup_boot(MachineState *machine, RaspiProcessorId processor_id,
+                       size_t ram_size)
 {
     static struct arm_boot_info binfo;
     int r;
@@ -210,12 +206,13 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
     binfo.ram_size = ram_size;
     binfo.nb_cpus = machine->smp.cpus;
 
-    if (version <= 2) {
-        /* The rpi1 and 2 require some custom setup code to run in Secure
-         * mode before booting a kernel (to set up the SMC vectors so
-         * that we get a no-op SMC; this is used by Linux to call the
+    if (processor_id <= PROCESSOR_ID_BCM2836) {
+        /*
+         * The BCM2835 and BCM2836 require some custom setup code to run
+         * in Secure mode before booting a kernel (to set up the SMC vectors
+         * so that we get a no-op SMC; this is used by Linux to call the
          * firmware for some cache maintenance operations.
-         * The rpi3 doesn't need this.
+         * The BCM2837 doesn't need this.
          */
         binfo.board_setup_addr = BOARDSETUP_ADDR;
         binfo.write_board_setup = write_board_setup;
@@ -223,10 +220,10 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
         binfo.secure_boot = true;
     }
 
-    /* Pi2 and Pi3 requires SMP setup */
-    if (version >= 2) {
+    /* BCM2836 and BCM2837 requires SMP setup */
+    if (processor_id >= PROCESSOR_ID_BCM2836) {
         binfo.smp_loader_start = SMPBOOT_ADDR;
-        if (version == 2) {
+        if (processor_id == PROCESSOR_ID_BCM2836) {
             binfo.write_secondary_boot = write_smpboot;
         } else {
             binfo.write_secondary_boot = write_smpboot64;
@@ -238,7 +235,13 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
      * the normal Linux boot process
      */
     if (machine->firmware) {
-        hwaddr firmware_addr = version == 3 ? FIRMWARE_ADDR_3 : FIRMWARE_ADDR_2;
+        hwaddr firmware_addr;
+
+        if (processor_id == PROCESSOR_ID_BCM2837) {
+            firmware_addr = FIRMWARE_ADDR_3;
+        } else {
+            firmware_addr = FIRMWARE_ADDR_2;
+        }
         /* load the firmware image (typically kernel.img) */
         r = load_image_targphys(machine->firmware, firmware_addr,
                                 ram_size - firmware_addr);
@@ -259,7 +262,6 @@ static void raspi_machine_init(MachineState *machine)
     RaspiMachineClass *mc = RASPI_MACHINE_GET_CLASS(machine);
     RaspiMachineState *s = RASPI_MACHINE(machine);
     uint32_t board_rev = mc->board_rev;
-    int version = board_version(board_rev);
     uint64_t ram_size = board_ram_size(board_rev);
     uint32_t vcram_size;
     DriveInfo *di;
@@ -303,7 +305,8 @@ static void raspi_machine_init(MachineState *machine)
 
     vcram_size = object_property_get_uint(OBJECT(&s->soc), "vcram-size",
                                           &error_abort);
-    setup_boot(machine, version, machine->ram_size - vcram_size);
+    setup_boot(machine, board_processor_id(mc->board_rev),
+               machine->ram_size - vcram_size);
 }
 
 static void raspi_machine_class_common_init(MachineClass *mc,
-- 
2.21.1


