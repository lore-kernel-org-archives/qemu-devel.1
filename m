Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A691BC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 23:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 338372086A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 23:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338372086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGASV-0005aw-4h
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 19:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGAAg-0001SN-Vc
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGAAc-0006WH-Q2
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:06:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46402)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1iGAAV-0006Qs-PG; Thu, 03 Oct 2019 19:05:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F0AAF20F7;
 Thu,  3 Oct 2019 23:05:52 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6050810013A7;
 Thu,  3 Oct 2019 23:05:44 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/14] hw: Move TWL92230 device from hw/timer/ to hw/rtc/
 subdirectory
Date: Fri,  4 Oct 2019 01:03:57 +0200
Message-Id: <20191003230404.19384-8-philmd@redhat.com>
In-Reply-To: <20191003230404.19384-1-philmd@redhat.com>
References: <20191003230404.19384-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Thu, 03 Oct 2019 23:05:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The TWL92230 is an "energy management device" companion with
a RTC. Since we mostly model the RTC, move it under the hw/rtc/
subdirectory.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS                  | 2 +-
 hw/rtc/Kconfig               | 4 ++++
 hw/rtc/Makefile.objs         | 1 +
 hw/{timer =3D> rtc}/twl92230.c | 0
 hw/timer/Kconfig             | 4 ----
 hw/timer/Makefile.objs       | 1 -
 6 files changed, 6 insertions(+), 6 deletions(-)
 rename hw/{timer =3D> rtc}/twl92230.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 31e4fbf579..daa92cbff0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -663,7 +663,7 @@ F: hw/display/blizzard.c
 F: hw/input/lm832x.c
 F: hw/input/tsc2005.c
 F: hw/misc/cbus.c
-F: hw/timer/twl92230.c
+F: hw/rtc/twl92230.c
 F: include/hw/display/blizzard.h
 F: include/hw/input/tsc2xxx.h
 F: include/hw/misc/cbus.h
diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index cc7fead764..dff9d60946 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -8,6 +8,10 @@ config M48T59
 config PL031
     bool
=20
+config TWL92230
+    bool
+    depends on I2C
+
 config MC146818RTC
     bool
=20
diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
index 4621b37bc2..810a38ee7b 100644
--- a/hw/rtc/Makefile.objs
+++ b/hw/rtc/Makefile.objs
@@ -4,5 +4,6 @@ ifeq ($(CONFIG_ISA_BUS),y)
 common-obj-$(CONFIG_M48T59) +=3D m48t59-isa.o
 endif
 common-obj-$(CONFIG_PL031) +=3D pl031.o
+common-obj-$(CONFIG_TWL92230) +=3D twl92230.o
 obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
 common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
diff --git a/hw/timer/twl92230.c b/hw/rtc/twl92230.c
similarity index 100%
rename from hw/timer/twl92230.c
rename to hw/rtc/twl92230.c
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index b04c928136..9357875f28 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -20,10 +20,6 @@ config HPET
 config I8254
     bool
=20
-config TWL92230
-    bool
-    depends on I2C
-
 config ALTERA_TIMER
     bool
     select PTIMER
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 034bd30255..23be70b71d 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -7,7 +7,6 @@ common-obj-$(CONFIG_DS1338) +=3D ds1338.o
 common-obj-$(CONFIG_HPET) +=3D hpet.o
 common-obj-$(CONFIG_I8254) +=3D i8254_common.o i8254.o
 common-obj-$(CONFIG_PUV3) +=3D puv3_ost.o
-common-obj-$(CONFIG_TWL92230) +=3D twl92230.o
 common-obj-$(CONFIG_XILINX) +=3D xilinx_timer.o
 common-obj-$(CONFIG_SLAVIO) +=3D slavio_timer.o
 common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_timer.o
--=20
2.20.1


