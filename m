Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2DAC004E6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2C92075E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2C92075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgbCK-0003mb-C9
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 16:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45307)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hgb0C-0001AW-9V
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hgb0A-0007dT-D0
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:28:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56224)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hgb03-0007ML-Ld; Thu, 27 Jun 2019 16:28:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D877E3082A28;
 Thu, 27 Jun 2019 20:27:55 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-69.brq.redhat.com [10.40.204.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D735600CC;
 Thu, 27 Jun 2019 20:27:41 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 22:26:53 +0200
Message-Id: <20190627202719.17739-3-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-1-philmd@redhat.com>
References: <20190627202719.17739-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 27 Jun 2019 20:27:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 02/28] hw/block/pflash: Simplify
 trace_pflash_io_read/write()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Walle <michael@walle.cc>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Call the read() trace function after the value is set, so we can
log the returned value.
Rename the I/O trace functions with '_io_' in their name.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi01.c | 5 +++--
 hw/block/pflash_cfi02.c | 6 ++----
 hw/block/trace-events   | 4 ++--
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 35080d915f..74fc1bc2da 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -288,7 +288,6 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr =
offset,
     uint32_t ret;
=20
     ret =3D -1;
-    trace_pflash_read(offset, pfl->cmd, width, pfl->wcycle);
     switch (pfl->cmd) {
     default:
         /* This should never happen : reset state & treat it as a read *=
/
@@ -391,6 +390,8 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr =
offset,
=20
         break;
     }
+    trace_pflash_io_read(offset, width, width << 1, ret, pfl->cmd, pfl->=
wcycle);
+
     return ret;
 }
=20
@@ -453,7 +454,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
=20
     cmd =3D value;
=20
-    trace_pflash_write(offset, value, width, pfl->wcycle);
+    trace_pflash_io_write(offset, width, width << 1, value, pfl->wcycle)=
;
     if (!pfl->wcycle) {
         /* Set the device in I/O access mode */
         memory_region_rom_device_set_romd(&pfl->mem, false);
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index eb106f4996..f05cd507b3 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -145,7 +145,6 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr =
offset,
     uint8_t *p;
=20
     ret =3D -1;
-    trace_pflash_read(offset, pfl->cmd, width, pfl->wcycle);
     /* Lazy reset to ROMD mode after a certain amount of read accesses *=
/
     if (!pfl->rom_mode && pfl->wcycle =3D=3D 0 &&
         ++pfl->read_counter > PFLASH_LAZY_ROMD_THRESHOLD) {
@@ -241,6 +240,7 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr =
offset,
         }
         break;
     }
+    trace_pflash_io_read(offset, width, width << 1, ret, pfl->cmd, pfl->=
wcycle);
=20
     return ret;
 }
@@ -267,6 +267,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr off=
set,
     uint8_t *p;
     uint8_t cmd;
=20
+    trace_pflash_io_write(offset, width, width << 1, value, pfl->wcycle)=
;
     cmd =3D value;
     if (pfl->cmd !=3D 0xA0 && cmd =3D=3D 0xF0) {
 #if 0
@@ -275,11 +276,8 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr of=
fset,
 #endif
         goto reset_flash;
     }
-    trace_pflash_write(offset, value, width, pfl->wcycle);
     offset &=3D pfl->chip_len - 1;
=20
-    DPRINTF("%s: offset " TARGET_FMT_plx " %08x %d\n", __func__,
-            offset, value, width);
     boff =3D offset & (pfl->sector_len - 1);
     if (pfl->width =3D=3D 2)
         boff =3D boff >> 1;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 97a17838ed..f637fe918e 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -7,9 +7,9 @@ fdc_ioport_write(uint8_t reg, uint8_t value) "write reg 0=
x%02x val 0x%02x"
 # pflash_cfi02.c
 # pflash_cfi01.c
 pflash_reset(void) "reset"
-pflash_read(uint64_t offset, uint8_t cmd, int width, uint8_t wcycle) "of=
fset:0x%04"PRIx64" cmd:0x%02x width:%d wcycle:%u"
-pflash_write(uint64_t offset, uint32_t value, int width, uint8_t wcycle)=
 "offset:0x%04"PRIx64" value:0x%03x width:%d wcycle:%u"
 pflash_timer_expired(uint8_t cmd) "command 0x%02x done"
+pflash_io_read(uint64_t offset, int width, int fmt_width, uint32_t value=
, uint8_t cmd, uint8_t wcycle) "offset:0x%04"PRIx64" width:%d value:0x%0*=
x cmd:0x%02x wcycle:%u"
+pflash_io_write(uint64_t offset, int width, int fmt_width, uint32_t valu=
e, uint8_t wcycle) "offset:0x%04"PRIx64" width:%d value:0x%0*x wcycle:%u"
 pflash_data_read8(uint64_t offset, uint32_t value) "data offset:0x%04"PR=
Ix64" value:0x%02x"
 pflash_data_read16(uint64_t offset, uint32_t value) "data offset:0x%04"P=
RIx64" value:0x%04x"
 pflash_data_read32(uint64_t offset, uint32_t value) "data offset:0x%04"P=
RIx64" value:0x%08x"
--=20
2.20.1


