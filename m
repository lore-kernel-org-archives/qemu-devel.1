Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25284C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E33BA21569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sjhr0hkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33BA21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iubAx-0003eC-W2
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 07:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuart-0005ZC-5b
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:41:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuarr-0004GY-Uc
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:41:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22256
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuarr-0004GP-Ru
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579779707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MrbAHNDp1Kp3NvQXCAH+L04X9w/Fm09aqfx5l9uGx3s=;
 b=Sjhr0hkwf0f7GbaixOg0pFMO6O3Za5oiMfKwIUP/2kG6q2UQ2Yi5QZ8VPFwx1Yf/oQmIrh
 agOSJ4BgkHbngjK36mQIJMLUneiY72dzTyrs25FBk9MdWDg+sxZ7cvewOukT2qrx2YPb3D
 iRCix8Oxh04QU8yZyrJLp+LvVeaJKF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-lYYUeoV5OdiVVSM47WW9jg-1; Thu, 23 Jan 2020 06:41:43 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBCAC107ACC9;
 Thu, 23 Jan 2020 11:41:42 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7B4B10016EB;
 Thu, 23 Jan 2020 11:41:41 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH REPOST v3 20/80] arm/mps2-tz: use memdev for RAM
Date: Thu, 23 Jan 2020 12:37:45 +0100
Message-Id: <1579779525-20065-21-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: lYYUeoV5OdiVVSM47WW9jg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
 hw/arm/mps2-tz.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index f8b620b..06dacf6 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -39,6 +39,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
@@ -79,7 +80,6 @@ typedef struct {
     MachineState parent;
=20
     ARMSSE iotkit;
-    MemoryRegion psram;
     MemoryRegion ssram[3];
     MemoryRegion ssram1_m;
     MPS2SCC scc;
@@ -388,6 +388,13 @@ static void mps2tz_common_init(MachineState *machine)
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
     sysbus_init_child_obj(OBJECT(machine), "iotkit", &mms->iotkit,
                           sizeof(mms->iotkit), mmc->armsse_type);
     iotkitdev =3D DEVICE(&mms->iotkit);
@@ -458,9 +465,7 @@ static void mps2tz_common_init(MachineState *machine)
      * tradeoffs. For QEMU they're all just RAM, though. We arbitrarily
      * call the 16MB our "system memory", as it's the largest lump.
      */
-    memory_region_allocate_system_memory(&mms->psram,
-                                         NULL, "mps.ram", 16 * MiB);
-    memory_region_add_subregion(system_memory, 0x80000000, &mms->psram);
+    memory_region_add_subregion(system_memory, 0x80000000, machine->ram);
=20
     /* The overflow IRQs for all UARTs are ORed together.
      * Tx, Rx and "combined" IRQs are sent to the NVIC separately.
@@ -642,6 +647,7 @@ static void mps2tz_class_init(ObjectClass *oc, void *da=
ta)
=20
     mc->init =3D mps2tz_common_init;
     iic->check =3D mps2_tz_idau_check;
+    mc->default_ram_id =3D "mps.ram";
 }
=20
 static void mps2tz_an505_class_init(ObjectClass *oc, void *data)
@@ -657,6 +663,7 @@ static void mps2tz_an505_class_init(ObjectClass *oc, vo=
id *data)
     mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-m33");
     mmc->scc_id =3D 0x41045050;
     mmc->armsse_type =3D TYPE_IOTKIT;
+    mc->default_ram_size =3D 16 * MiB;
 }
=20
 static void mps2tz_an521_class_init(ObjectClass *oc, void *data)
--=20
2.7.4


