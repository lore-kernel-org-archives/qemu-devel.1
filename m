Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C800C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 22:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F5C22309
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 22:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBhkQEmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F5C22309
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWpZR-00050e-9h
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 17:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iWpVK-0001qe-Ld
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:28:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iWpVI-0006zw-JG
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:28:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20299
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iWpVG-0006zF-Gw
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574116094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s3cor6biQmpqn+tnJ2B55PoWtsVtFws5bfkkg9apAew=;
 b=PBhkQEmc1IV0DDh4fP0g4uXEfjvPQLB2aSwWzeTLbVZJpAHAQUOC+n7UWt+1HPav7GiSON
 T4eXjd+j3O1FNJb4ROOg7zfETLXcONJnwkGtM4z7COD6YLNYR2Z9OTzmZn7RDIUId/Lx7/
 XtdlbwhnImHW18KB3yikux6rnjw7jpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-FFQvbAFaNp2tf0DGhSjv0Q-1; Mon, 18 Nov 2019 17:28:10 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DBAA107ACC7;
 Mon, 18 Nov 2019 22:28:09 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB58A27067;
 Mon, 18 Nov 2019 22:28:05 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Eric Blake <eblake@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 2/2] hw/mips/gt64xxx: Remove dynamic field width from trace
 events
Date: Mon, 18 Nov 2019 23:27:46 +0100
Message-Id: <20191118222746.31467-3-philmd@redhat.com>
In-Reply-To: <20191118222746.31467-1-philmd@redhat.com>
References: <20191118222746.31467-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: FFQvbAFaNp2tf0DGhSjv0Q-1
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

We previously passed to the trace API 'width << 1' as the number
of hex characters to display (the dynamic field width). We don't
need this anymore. Instead, display the size of bytes accessed.

Fixes: ab6bff424f (gt64xxx_pci: Convert debug printf to trace events)
Reported-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1844817
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Do not update qemu_log_mask()
v3: display size (in byte)
v4: added Fixes/Reviewed-by
---
 hw/mips/gt64xxx_pci.c | 16 ++++++++--------
 hw/mips/trace-events  |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index 5cab9c1ee1..f1af840d8e 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -642,19 +642,19 @@ static void gt64120_writel(void *opaque, hwaddr addr,
         /* not really implemented */
         s->regs[saddr] =3D ~(~(s->regs[saddr]) | ~(val & 0xfffffffe));
         s->regs[saddr] |=3D !!(s->regs[saddr] & 0xfffffffe);
-        trace_gt64120_write("INTRCAUSE", size << 1, val);
+        trace_gt64120_write("INTRCAUSE", size, val);
         break;
     case GT_INTRMASK:
         s->regs[saddr] =3D val & 0x3c3ffffe;
-        trace_gt64120_write("INTRMASK", size << 1, val);
+        trace_gt64120_write("INTRMASK", size, val);
         break;
     case GT_PCI0_ICMASK:
         s->regs[saddr] =3D val & 0x03fffffe;
-        trace_gt64120_write("ICMASK", size << 1, val);
+        trace_gt64120_write("ICMASK", size, val);
         break;
     case GT_PCI0_SERR0MASK:
         s->regs[saddr] =3D val & 0x0000003f;
-        trace_gt64120_write("SERR0MASK", size << 1, val);
+        trace_gt64120_write("SERR0MASK", size, val);
         break;
=20
     /* Reserved when only PCI_0 is configured. */
@@ -930,19 +930,19 @@ static uint64_t gt64120_readl(void *opaque,
     /* Interrupts */
     case GT_INTRCAUSE:
         val =3D s->regs[saddr];
-        trace_gt64120_read("INTRCAUSE", size << 1, val);
+        trace_gt64120_read("INTRCAUSE", size, val);
         break;
     case GT_INTRMASK:
         val =3D s->regs[saddr];
-        trace_gt64120_read("INTRMASK", size << 1, val);
+        trace_gt64120_read("INTRMASK", size, val);
         break;
     case GT_PCI0_ICMASK:
         val =3D s->regs[saddr];
-        trace_gt64120_read("ICMASK", size << 1, val);
+        trace_gt64120_read("ICMASK", size, val);
         break;
     case GT_PCI0_SERR0MASK:
         val =3D s->regs[saddr];
-        trace_gt64120_read("SERR0MASK", size << 1, val);
+        trace_gt64120_read("SERR0MASK", size, val);
         break;
=20
     /* Reserved when only PCI_0 is configured. */
diff --git a/hw/mips/trace-events b/hw/mips/trace-events
index 75d4c73f2e..321933283f 100644
--- a/hw/mips/trace-events
+++ b/hw/mips/trace-events
@@ -1,4 +1,4 @@
 # gt64xxx.c
-gt64120_read(const char *regname, int width, uint64_t value) "gt64120 read=
 %s value:0x%0*" PRIx64
-gt64120_write(const char *regname, int width, uint64_t value) "gt64120 wri=
te %s value:0x%0*" PRIx64
+gt64120_read(const char *regname, unsigned size, uint64_t value) "gt64120 =
read %s size:%u value:0x%08" PRIx64
+gt64120_write(const char *regname, unsigned size, uint64_t value) "gt64120=
 write %s size:%u value:0x%08" PRIx64
 gt64120_isd_remap(uint64_t from_length, uint64_t from_addr, uint64_t to_le=
ngth, uint64_t to_addr) "ISD: 0x%08" PRIx64 "@0x%08" PRIx64 " -> 0x%08" PRI=
x64 "@0x%08" PRIx64
--=20
2.21.0


