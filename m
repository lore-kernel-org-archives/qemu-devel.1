Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C999C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EEF22082F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEF22082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42636 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNJ8c-0003Cl-Fk
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 11:33:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNJ4W-0008OU-P2
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNJ4V-0003SZ-UG
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:29:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hNJ4V-0003S4-P9; Sun, 05 May 2019 11:28:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA0F4356DB;
	Sun,  5 May 2019 15:28:58 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-35.brq.redhat.com [10.40.204.35])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E38A60C18;
	Sun,  5 May 2019 15:28:55 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Artyom Tarasenko <atar4qemu@gmail.com>, qemu-devel@nongnu.org,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun,  5 May 2019 17:28:38 +0200
Message-Id: <20190505152839.18650-3-philmd@redhat.com>
In-Reply-To: <20190505152839.18650-1-philmd@redhat.com>
References: <20190505152839.18650-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Sun, 05 May 2019 15:28:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/3] hw/ppc/40p: Move the MC146818 RTC to the
 board where it belongs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505152838.AfaJo0w-u2VeN0ByBZhA7wMPRaRZpi7pNekihOOroXE@z>

The MC146818 RTC was incorrectly added to the i82378 chipset in
commit a04ff940974a. In the next commit (506b7ddf8893) the PReP
machine use the i82378.
Since the MC146818 is specific to the PReP machine, move its use
there.

Fixes: a04ff940974a
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/isa/i82378.c | 4 ----
 hw/ppc/prep.c   | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index a5d67bc6d7a..c08970b24a2 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -21,7 +21,6 @@
 #include "hw/pci/pci.h"
 #include "hw/i386/pc.h"
 #include "hw/timer/i8254.h"
-#include "hw/timer/mc146818rtc.h"
 #include "hw/audio/pcspk.h"
=20
 #define TYPE_I82378 "i82378"
@@ -105,9 +104,6 @@ static void i82378_realize(PCIDevice *pci, Error **er=
rp)
=20
     /* 2 82C37 (dma) */
     isa =3D isa_create_simple(isabus, "i82374");
-
-    /* timer */
-    isa_create_simple(isabus, TYPE_MC146818_RTC);
 }
=20
 static void i82378_init(Object *obj)
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index ebee3211480..7a0d311d43c 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -675,6 +675,9 @@ static void ibm_40p_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "ram-size", machine->ram_size);
     qdev_init_nofail(dev);
=20
+    /* RTC */
+    isa_create_simple(isa_bus, TYPE_MC146818_RTC);
+
     /* initialize CMOS checksums */
     cmos_checksum =3D 0x6aa9;
     qbus_walk_children(BUS(isa_bus), prep_set_cmos_checksum, NULL, NULL,=
 NULL,
--=20
2.20.1


