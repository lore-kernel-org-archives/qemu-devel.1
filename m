Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5FAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:05:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6C221569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YW9/5RAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6C221569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iubES-0007xw-Aj
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 07:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuarx-0005em-3g
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:41:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuaru-0004IX-UG
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:41:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39027
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuaru-0004IJ-RI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579779710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JWpejJMudZ11uDHhWPVse/ceQeCeQV/apVGLS1grbKs=;
 b=YW9/5RAcDJObUgyT9Q891wIwQW5qjikQyp954X7ks3ctvQ+Rk7MHi1Xv6ImarX10Vs6wMs
 pAjG9grsSACVpbpASNssERIhBSgWi2nLvGzxJvnKopmrU3a/HG44pA/9SE8xBuvwLUJGhf
 lrwU5LzPxPi8T5LShI41Z1AnDVYBQ18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-GruhQUU3PimWAmkY8ngS1g-1; Thu, 23 Jan 2020 06:41:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F075E1005512;
 Thu, 23 Jan 2020 11:41:45 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E6DF10016EB;
 Thu, 23 Jan 2020 11:41:42 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH REPOST v3 21/80] arm/mps2: use memdev for RAM
Date: Thu, 23 Jan 2020 12:37:46 +0100
Message-Id: <1579779525-20065-22-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: GruhQUU3PimWAmkY8ngS1g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
v2:
  * fix format string causing build failure on 32-bit host
    (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)

CC: drjones@redhat.com
CC: peter.maydell@linaro.org
CC: qemu-arm@nongnu.org
---
 hw/arm/mps2.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index d002b12..f246213 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
@@ -55,7 +56,6 @@ typedef struct {
     MachineState parent;
=20
     ARMv7MState armv7m;
-    MemoryRegion psram;
     MemoryRegion ssram1;
     MemoryRegion ssram1_m;
     MemoryRegion ssram23;
@@ -118,6 +118,13 @@ static void mps2_common_init(MachineState *machine)
         exit(1);
     }
=20
+    if (machine->ram_size !=3D mc->default_ram_size) {
+        char *sz =3D size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
     /* The FPGA images have an odd combination of different RAMs,
      * because in hardware they are different implementations and
      * connected to different buses, giving varying performance/size
@@ -146,9 +153,7 @@ static void mps2_common_init(MachineState *machine)
      * This is of no use for QEMU so we don't implement it (as if
      * zbt_boot_ctrl is always zero).
      */
-    memory_region_allocate_system_memory(&mms->psram,
-                                         NULL, "mps.ram", 16 * MiB);
-    memory_region_add_subregion(system_memory, 0x21000000, &mms->psram);
+    memory_region_add_subregion(system_memory, 0x21000000, machine->ram);
=20
     switch (mmc->fpga_type) {
     case FPGA_AN385:
@@ -338,6 +343,8 @@ static void mps2_class_init(ObjectClass *oc, void *data=
)
=20
     mc->init =3D mps2_common_init;
     mc->max_cpus =3D 1;
+    mc->default_ram_size =3D 16 * MiB;
+    mc->default_ram_id =3D "mps.ram";
 }
=20
 static void mps2_an385_class_init(ObjectClass *oc, void *data)
--=20
2.7.4


