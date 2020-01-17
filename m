Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892A4C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:00:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A4D2072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzfTLJ3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A4D2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isUyn-0001j5-4Y
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 12:00:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isUx2-0008FF-Nl
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isUwz-0007IC-3y
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:58:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41212
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isUwz-0007Hh-0d
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579280304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DR0w/zADhVqXf1WL7QQBc9ZUnFILA0c+2wzRWZv9rMo=;
 b=EzfTLJ3/32G/VP4IKgxvWpARraxtwG9LAUbQPkRuOolsR4C9524fmcHAOuxnTcws4SnOHU
 3Ygd6vFuXkj3FPx2dIBqbU/w1Ra+zOT+PTonZhz/eeB5ewL5CBIIiVt1HbVCQRGUpndxhC
 0N/DuZXJ7e90iuqmfh0FLkPA0vTVZXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-NoYFqi05NsSTlAt-ga-LAg-1; Fri, 17 Jan 2020 11:58:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DF68800D41;
 Fri, 17 Jan 2020 16:58:22 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-206-6.brq.redhat.com [10.40.206.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A3E25D9CD;
 Fri, 17 Jan 2020 16:58:19 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
Subject: [PATCH v3 2/2] hw/timer/m48t59: Convert debug printf()s to trace
 events
Date: Fri, 17 Jan 2020 17:58:09 +0100
Message-Id: <20200117165809.31067-3-philmd@redhat.com>
In-Reply-To: <20200117165809.31067-1-philmd@redhat.com>
References: <20200117165809.31067-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: NoYFqi05NsSTlAt-ga-LAg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org,
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
2.21.1


