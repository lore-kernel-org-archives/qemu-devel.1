Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CE3C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 17:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB7520866
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 17:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8fqxt+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB7520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in3yE-000383-6K
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 12:09:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1in3xU-0002FY-K2
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 12:08:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1in3xR-0002ep-2c
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 12:08:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26226
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1in3xQ-0002eK-PF
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 12:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577984903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=55lGJUu751q8PjcjXkJcLnA0xfV4M+hq/Y7ps262oT4=;
 b=P8fqxt+urFNNvtvHc6SSttQvbJ/Ag2vvQoldCQrhNV4jlmUe1fLN0S/Sn5NmW5eCRaJB7B
 0W0zVwLsRe2faIGz8Sp0y4psOY/pbfrhk5fSzkC0GUoLOtvwFVNJ+wVVnpTQ3jRpi5WfSy
 UlDnZvrSsCUCjYhzq4rWxVd9ikg5UHE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-7G_dqcqCPiy2T9Xk8VoWsg-1; Thu, 02 Jan 2020 12:08:22 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28F9E1801243;
 Thu,  2 Jan 2020 17:08:21 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5CE763BCA;
 Thu,  2 Jan 2020 17:08:17 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hppa: allow max ram size upto 4Gb
Date: Thu,  2 Jan 2020 18:08:37 +0100
Message-Id: <1577984917-143579-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-44-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-44-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 7G_dqcqCPiy2T9Xk8VoWsg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: deller@gmx.de, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Previous patch drops silent ram_size fixup and makes
QEMU error out with:

 "RAM size more than 3840m is not supported"

when user specified -m X more than supported value.

User shouldn't be bothered with starting QEMU with valid CLI,
so for the sake of user convenience to allow using -m 4G vs -m 3840M.

Requested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
I dislike it but if you feel it's really necessary feel free to ack it.

should be applied on top of:
  "hppa: drop RAM size fixup"
---
 hw/hppa/machine.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index ebbf44f..7f8c92f 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -54,6 +54,7 @@ static uint64_t cpu_hppa_to_phys(void *opaque, uint64_t a=
ddr)
=20
 static HPPACPU *cpu[HPPA_MAX_CPUS];
 static uint64_t firmware_entry;
+static ram_addr_t clamped_ram_size;
=20
 static void machine_hppa_init(MachineState *machine)
 {
@@ -74,8 +75,6 @@ static void machine_hppa_init(MachineState *machine)
     long i;
     unsigned int smp_cpus =3D machine->smp.cpus;
=20
-    ram_size =3D machine->ram_size;
-
     /* Create CPUs.  */
     for (i =3D 0; i < smp_cpus; i++) {
         char *name =3D g_strdup_printf("cpu%ld-io-eir", i);
@@ -90,10 +89,12 @@ static void machine_hppa_init(MachineState *machine)
     }
=20
     /* Limit main memory. */
-    if (ram_size > FIRMWARE_START) {
-        error_report("RAM size more than %d is not supported", FIRMWARE_ST=
ART);
+    if (machine->ram_size > 4 * GiB) {
+        error_report("RAM size more than 4Gb is not supported");
         exit(EXIT_FAILURE);
     }
+    clamped_ram_size =3D machine->ram_size > FIRMWARE_START ?
+        FIRMWARE_START : machine->ram_size;
=20
     memory_region_add_subregion(addr_space, 0, machine->ram);
=20
@@ -151,7 +152,7 @@ static void machine_hppa_init(MachineState *machine)
     qemu_log_mask(CPU_LOG_PAGE, "Firmware loaded at 0x%08" PRIx64
                   "-0x%08" PRIx64 ", entry at 0x%08" PRIx64 ".\n",
                   firmware_low, firmware_high, firmware_entry);
-    if (firmware_low < ram_size || firmware_high >=3D FIRMWARE_END) {
+    if (firmware_low < clamped_ram_size || firmware_high >=3D FIRMWARE_END=
) {
         error_report("Firmware overlaps with memory or IO space");
         exit(1);
     }
@@ -160,7 +161,8 @@ static void machine_hppa_init(MachineState *machine)
     rom_region =3D g_new(MemoryRegion, 1);
     memory_region_init_ram(rom_region, NULL, "firmware",
                            (FIRMWARE_END - FIRMWARE_START), &error_fatal);
-    memory_region_add_subregion(addr_space, FIRMWARE_START, rom_region);
+    memory_region_add_subregion_overlap(addr_space, FIRMWARE_START, rom_re=
gion,
+                                        1);
=20
     /* Load kernel */
     if (kernel_filename) {
@@ -204,7 +206,7 @@ static void machine_hppa_init(MachineState *machine)
                (1) Due to sign-extension problems and PDC,
                put the initrd no higher than 1G.
                (2) Reserve 64k for stack.  */
-            initrd_base =3D MIN(ram_size, 1 * GiB);
+            initrd_base =3D MIN(clamped_ram_size, 1 * GiB);
             initrd_base =3D initrd_base - 64 * KiB;
             initrd_base =3D (initrd_base - initrd_size) & TARGET_PAGE_MASK=
;
=20
@@ -232,7 +234,7 @@ static void machine_hppa_init(MachineState *machine)
      * various parameters in registers. After firmware initialization,
      * firmware will start the Linux kernel with ramdisk and cmdline.
      */
-    cpu[0]->env.gr[26] =3D ram_size;
+    cpu[0]->env.gr[26] =3D clamped_ram_size;
     cpu[0]->env.gr[25] =3D kernel_entry;
=20
     /* tell firmware how many SMP CPUs to present in inventory table */
@@ -255,11 +257,11 @@ static void hppa_machine_reset(MachineState *ms)
     }
=20
     /* already initialized by machine_hppa_init()? */
-    if (cpu[0]->env.gr[26] =3D=3D ram_size) {
+    if (cpu[0]->env.gr[26] =3D=3D clamped_ram_size) {
         return;
     }
=20
-    cpu[0]->env.gr[26] =3D ram_size;
+    cpu[0]->env.gr[26] =3D clamped_ram_size;
     cpu[0]->env.gr[25] =3D 0; /* no firmware boot menu */
     cpu[0]->env.gr[24] =3D 'c';
     /* gr22/gr23 unused, no initrd while reboot. */
--=20
2.7.4


