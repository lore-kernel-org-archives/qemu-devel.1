Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11815FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA887214DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrD+06cT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA887214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5Sp-0008Ge-0W
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 09:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iT5Rf-00071Z-46
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:41:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iT5Rd-0000Gu-PD
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:41:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39037
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iT5Rd-0000Gg-LJ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573224061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DLdcMzwKVKMzWdEWKT7kbvCzmSIWSHjOb+HgDuf8Mso=;
 b=XrD+06cTgxa48NtA8J6yHO9aGaHs4TodBE8Qh9tqOpw2OYuVfTagL0drDhFoUFg0NqEjW5
 BlVHEB60DPa/H1VQKrcrl2YzJP2vY2arUqurlqSVlFhPFuB8uXE+/rT0S+mcWVJHGyr1Yw
 aBxFDY+q+/zt00rLzgufPbGZcPEhEx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-zRsWpSgGOTWX6QPEN0-MaA-1; Fri, 08 Nov 2019 09:40:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 989CE107ACC4;
 Fri,  8 Nov 2019 14:40:58 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B73E5D6AE;
 Fri,  8 Nov 2019 14:40:54 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Eric Blake <eblake@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] hw/mips/gt64xxx: Remove dynamic field width from trace
 events
Date: Fri,  8 Nov 2019 15:40:41 +0100
Message-Id: <20191108144042.30245-3-philmd@redhat.com>
In-Reply-To: <20191108144042.30245-1-philmd@redhat.com>
References: <20191108144042.30245-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: zRsWpSgGOTWX6QPEN0-MaA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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
v2: Do not update qemu_log_mask()
---
 hw/mips/gt64xxx_pci.c | 16 ++++++++--------
 hw/mips/trace-events  |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index 5cab9c1ee1..6743e7c929 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
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


