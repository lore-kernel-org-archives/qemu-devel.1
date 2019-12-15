Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534FFC43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 07:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDD721D7E
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 07:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5HRpmE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDD721D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igOGE-0002c9-9z
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 02:24:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igODC-0008Nz-OW
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 02:21:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igODB-0006gv-Dv
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 02:21:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42935
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igODB-0006gA-8o
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 02:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576394464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0pGfJm/TGowlztGp6XpdBVnICvwvarC3xa5cFuIdSIg=;
 b=Y5HRpmE7sWlzfMjT1b0Uut0I3uCnuwML3nZs6eh1gFN8P1DcWwPDBEw/sOMqUQJBQ5VEsd
 QSh9rGCzJVJ7u+urJVYsibDtUDatcFBHJltyT2Awr+99Kti5OuQEpaQNBB3blHFYxZLEV+
 YtnamzqrDzNvHNM/HPPGHDvkNalBSfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-zuxFDwmoNIGGY4ZeH5Zraw-1; Sun, 15 Dec 2019 02:21:01 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C1851005502;
 Sun, 15 Dec 2019 07:20:59 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E0922384;
 Sun, 15 Dec 2019 07:20:56 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
Subject: [PATCH v2 2/2] hw/timer/m48t59: Convert debug printf()s to trace
 events
Date: Sun, 15 Dec 2019 08:20:45 +0100
Message-Id: <20191215072045.7198-3-philmd@redhat.com>
In-Reply-To: <20191215072045.7198-1-philmd@redhat.com>
References: <20191215072045.7198-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: zuxFDwmoNIGGY4ZeH5Zraw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/rtc/m48t59-internal.h |  5 -----
 hw/rtc/m48t59.c          | 11 +++++------
 hw/rtc/trace-events      |  6 ++++++
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/rtc/m48t59-internal.h b/hw/rtc/m48t59-internal.h
index 4d4f2a6fed..cd648241e9 100644
--- a/hw/rtc/m48t59-internal.h
+++ b/hw/rtc/m48t59-internal.h
@@ -26,11 +26,6 @@
 #ifndef HW_M48T59_INTERNAL_H
 #define HW_M48T59_INTERNAL_H
=20
-#define M48T59_DEBUG 0
-
-#define NVRAM_PRINTF(fmt, ...) do { \
-    if (M48T59_DEBUG) { printf(fmt , ## __VA_ARGS__); } } while (0)
-
 /*
  * The M48T02, M48T08 and M48T59 chips are very similar. The newer '59 has
  * alarm and a watchdog timer and related control registers. In the
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index fc592b9fb1..ecc92ca476 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -35,6 +35,7 @@
 #include "exec/address-spaces.h"
 #include "qemu/bcd.h"
 #include "qemu/module.h"
+#include "trace.h"
=20
 #include "m48t59-internal.h"
 #include "migration/vmstate.h"
@@ -192,8 +193,7 @@ void m48t59_write(M48t59State *NVRAM, uint32_t addr, ui=
nt32_t val)
     struct tm tm;
     int tmp;
=20
-    if (addr > 0x1FF8 && addr < 0x2000)
-=09NVRAM_PRINTF("%s: 0x%08x =3D> 0x%08x\n", __func__, addr, val);
+    trace_m48txx_nvram_mem_write(addr, val);
=20
     /* check for NVRAM access */
     if ((NVRAM->model =3D=3D 2 && addr < 0x7f8) ||
@@ -450,8 +450,7 @@ uint32_t m48t59_read(M48t59State *NVRAM, uint32_t addr)
 =09}
         break;
     }
-    if (addr > 0x1FF9 && addr < 0x2000)
-       NVRAM_PRINTF("%s: 0x%08x <=3D 0x%08x\n", __func__, addr, retval);
+    trace_m48txx_nvram_mem_read(addr, retval);
=20
     return retval;
 }
@@ -462,7 +461,7 @@ static void NVRAM_writeb(void *opaque, hwaddr addr, uin=
t64_t val,
 {
     M48t59State *NVRAM =3D opaque;
=20
-    NVRAM_PRINTF("%s: 0x%"HWADDR_PRIx" =3D> 0x%"PRIx64"\n", __func__, addr=
, val);
+    trace_m48txx_nvram_io_write(addr, val);
     switch (addr) {
     case 0:
         NVRAM->addr &=3D ~0x00FF;
@@ -494,7 +493,7 @@ static uint64_t NVRAM_readb(void *opaque, hwaddr addr, =
unsigned size)
         retval =3D -1;
         break;
     }
-    NVRAM_PRINTF("%s: 0x%"HWADDR_PRIx" <=3D 0x%08x\n", __func__, addr, ret=
val);
+    trace_m48txx_nvram_io_read(addr, retval);
=20
     return retval;
 }
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
index d6749f4616..52c1566198 100644
--- a/hw/rtc/trace-events
+++ b/hw/rtc/trace-events
@@ -17,3 +17,9 @@ pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
 # aspeed-rtc.c
 aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value=
 0x%08" PRIx64
 aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " valu=
e 0x%08" PRIx64
+
+# m48t59.c
+m48txx_nvram_io_read(uint64_t addr, uint64_t value) "io read addr:0x%04" P=
RIx64 " value:0x%02" PRIx64
+m48txx_nvram_io_write(uint64_t addr, uint64_t value) "io write addr:0x%04"=
 PRIx64 " value:0x%02" PRIx64
+m48txx_nvram_mem_read(uint32_t addr, uint32_t value) "mem read addr:0x%04x=
 value:0x%02x"
+m48txx_nvram_mem_write(uint32_t addr, uint32_t value) "mem write addr:0x%0=
4x value:0x%02x"
--=20
2.21.0


