Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC5CFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8165214DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVEEH0xw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8165214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5I0-0004Hx-8R
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 09:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iT5F0-0000Ac-Na
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:28:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iT5Ez-0000b2-2K
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:27:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35378
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iT5Ey-0000aX-UV
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573223276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3+LGeTEi1/ybmzvAWogQzi1swRDkl4lqqo1txwkGk8A=;
 b=FVEEH0xwxOgf472metfw998ze/Lq25xwlH8uK/Gh8l8y+X8NXatLEf9haGHBe4nSacGuzA
 VS/M1P/+Na6jp0euTG03043yPUs3hpXoG17JM6jikgiYkvmS5IAXIJU/30WLO7rR9P9cR4
 eXVMoZebZICBl9pYe3rFS6NczhE7+RM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-liEGjmKnOZmJABZ5k_ffgQ-1; Fri, 08 Nov 2019 09:27:52 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77B76477;
 Fri,  8 Nov 2019 14:27:51 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 28CE710027B0;
 Fri,  8 Nov 2019 14:27:17 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Eric Blake <eblake@redhat.com>
Subject: [PATCH 2/3] hw/mips/gt64xxx: Remove dynamic field width from trace
 event
Date: Fri,  8 Nov 2019 15:26:12 +0100
Message-Id: <20191108142613.26649-3-philmd@redhat.com>
In-Reply-To: <20191108142613.26649-1-philmd@redhat.com>
References: <20191108142613.26649-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: liEGjmKnOZmJABZ5k_ffgQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since not all trace backends support dynamic field width in
format (dtrace via stap does not), replace by a static field
width instead.

Reported-by: Eric Blake <eblake@redhat.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1844817
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/mips/gt64xxx_pci.c | 34 +++++++++++++++++-----------------
 hw/mips/trace-events  |  4 ++--
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index 5cab9c1ee1..f427793360 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -464,7 +464,7 @@ static void gt64120_writel(void *opaque, hwaddr addr,
         qemu_log_mask(LOG_GUEST_ERROR,
                       "gt64120: Read-only register write "
                       "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
-                      saddr << 2, size, size << 1, val);
+                      saddr << 2, size, size << 3, val);
         break;
=20
     /* CPU Sync Barrier */
@@ -474,7 +474,7 @@ static void gt64120_writel(void *opaque, hwaddr addr,
         qemu_log_mask(LOG_GUEST_ERROR,
                       "gt64120: Read-only register write "
                       "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
-                      saddr << 2, size, size << 1, val);
+                      saddr << 2, size, size << 3, val);
         break;
=20
     /* SDRAM and Device Address Decode */
@@ -516,7 +516,7 @@ static void gt64120_writel(void *opaque, hwaddr addr,
         qemu_log_mask(LOG_UNIMP,
                       "gt64120: Unimplemented device register write "
                       "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
-                      saddr << 2, size, size << 1, val);
+                      saddr << 2, size, size << 3, val);
         break;
=20
     /* ECC */
@@ -529,7 +529,7 @@ static void gt64120_writel(void *opaque, hwaddr addr,
         qemu_log_mask(LOG_GUEST_ERROR,
                       "gt64120: Read-only register write "
                       "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
-                      saddr << 2, size, size << 1, val);
+                      saddr << 2, size, size << 3, val);
         break;
=20
     /* DMA Record */
@@ -566,7 +566,7 @@ static void gt64120_writel(void *opaque, hwaddr addr,
         qemu_log_mask(LOG_UNIMP,
                       "gt64120: Unimplemented DMA register write "
                       "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
-                      saddr << 2, size, size << 1, val);
+                      saddr << 2, size, size << 3, val);
         break;
=20
     /* Timer/Counter */
@@ -579,7 +579,7 @@ static void gt64120_writel(void *opaque, hwaddr addr,
         qemu_log_mask(LOG_UNIMP,
                       "gt64120: Unimplemented timer register write "
                       "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
-                      saddr << 2, size, size << 1, val);
+                      saddr << 2, size, size << 3, val);
         break;
=20
     /* PCI Internal */
@@ -623,7 +623,7 @@ static void gt64120_writel(void *opaque, hwaddr addr,
         qemu_log_mask(LOG_UNIMP,
                       "gt64120: Unimplemented timer register write "
                       "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
-                      saddr << 2, size, size << 1, val);
+                      saddr << 2, size, size << 3, val);
         break;
     case GT_PCI0_CFGADDR:
         phb->config_reg =3D val & 0x80fffffc;
@@ -642,19 +642,19 @@ static void gt64120_writel(void *opaque, hwaddr addr,
         /* not really implemented */
         s->regs[saddr] =3D ~(~(s->regs[saddr]) | ~(val & 0xfffffffe));
         s->regs[saddr] |=3D !!(s->regs[saddr] & 0xfffffffe);
-        trace_gt64120_write("INTRCAUSE", size << 1, val);
+        trace_gt64120_write("INTRCAUSE", size << 3, val);
         break;
     case GT_INTRMASK:
         s->regs[saddr] =3D val & 0x3c3ffffe;
-        trace_gt64120_write("INTRMASK", size << 1, val);
+        trace_gt64120_write("INTRMASK", size << 3, val);
         break;
     case GT_PCI0_ICMASK:
         s->regs[saddr] =3D val & 0x03fffffe;
-        trace_gt64120_write("ICMASK", size << 1, val);
+        trace_gt64120_write("ICMASK", size << 3, val);
         break;
     case GT_PCI0_SERR0MASK:
         s->regs[saddr] =3D val & 0x0000003f;
-        trace_gt64120_write("SERR0MASK", size << 1, val);
+        trace_gt64120_write("SERR0MASK", size << 3, val);
         break;
=20
     /* Reserved when only PCI_0 is configured. */
@@ -683,7 +683,7 @@ static void gt64120_writel(void *opaque, hwaddr addr,
         qemu_log_mask(LOG_GUEST_ERROR,
                       "gt64120: Illegal register write "
                       "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
-                      saddr << 2, size, size << 1, val);
+                      saddr << 2, size, size << 3, val);
         break;
     }
 }
@@ -930,19 +930,19 @@ static uint64_t gt64120_readl(void *opaque,
     /* Interrupts */
     case GT_INTRCAUSE:
         val =3D s->regs[saddr];
-        trace_gt64120_read("INTRCAUSE", size << 1, val);
+        trace_gt64120_read("INTRCAUSE", size << 3, val);
         break;
     case GT_INTRMASK:
         val =3D s->regs[saddr];
-        trace_gt64120_read("INTRMASK", size << 1, val);
+        trace_gt64120_read("INTRMASK", size << 3, val);
         break;
     case GT_PCI0_ICMASK:
         val =3D s->regs[saddr];
-        trace_gt64120_read("ICMASK", size << 1, val);
+        trace_gt64120_read("ICMASK", size << 3, val);
         break;
     case GT_PCI0_SERR0MASK:
         val =3D s->regs[saddr];
-        trace_gt64120_read("SERR0MASK", size << 1, val);
+        trace_gt64120_read("SERR0MASK", size << 3, val);
         break;
=20
     /* Reserved when only PCI_0 is configured. */
@@ -960,7 +960,7 @@ static uint64_t gt64120_readl(void *opaque,
         qemu_log_mask(LOG_GUEST_ERROR,
                       "gt64120: Illegal register read "
                       "reg:0x03%x size:%u value:0x%0*x\n",
-                      saddr << 2, size, size << 1, val);
+                      saddr << 2, size, size << 3, val);
         break;
     }
=20
diff --git a/hw/mips/trace-events b/hw/mips/trace-events
index 75d4c73f2e..86a0213c77 100644
--- a/hw/mips/trace-events
+++ b/hw/mips/trace-events
@@ -1,4 +1,4 @@
 # gt64xxx.c
-gt64120_read(const char *regname, int width, uint64_t value) "gt64120 read=
 %s value:0x%0*" PRIx64
-gt64120_write(const char *regname, int width, uint64_t value) "gt64120 wri=
te %s value:0x%0*" PRIx64
+gt64120_read(const char *regname, int width, uint64_t value) "gt64120 read=
 %s width:%d value:0x%08" PRIx64
+gt64120_write(const char *regname, int width, uint64_t value) "gt64120 wri=
te %s width:%d value:0x%08" PRIx64
 gt64120_isd_remap(uint64_t from_length, uint64_t from_addr, uint64_t to_le=
ngth, uint64_t to_addr) "ISD: 0x%08" PRIx64 "@0x%08" PRIx64 " -> 0x%08" PRI=
x64 "@0x%08" PRIx64
--=20
2.21.0


