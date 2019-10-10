Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FF7ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8D5208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8D5208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIZcI-0001Aq-2y
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 10:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iIZWC-0000ps-Og
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iIZWB-00018x-Kw
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:34:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55798)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iIZWB-00018Y-FP
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:34:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AA145C058CB8;
 Thu, 10 Oct 2019 14:34:14 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA4F260BE1;
 Thu, 10 Oct 2019 14:34:11 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 04/15] hw/i386/pc: replace use of strtol with qemu_strtol
 in x86_load_linux()
Date: Thu, 10 Oct 2019 16:31:14 +0200
Message-Id: <20191010143125.67246-5-slp@redhat.com>
In-Reply-To: <20191010143125.67246-1-slp@redhat.com>
References: <20191010143125.67246-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 10 Oct 2019 14:34:14 +0000 (UTC)
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
Cc: ehabkost@redhat.com, Sergio Lopez <slp@redhat.com>, mst@redhat.com,
 lersek@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Follow checkpatch.pl recommendation and replace the use of strtol with
qemu_strtol in x86_load_linux().

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 hw/i386/pc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 77e86bfc3d..e6bcc3ff42 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -68,6 +68,7 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
+#include "qemu/cutils.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/cpu_hotplug.h"
 #include "hw/boards.h"
@@ -1201,7 +1202,8 @@ static void x86_load_linux(PCMachineState *pcms,
     /* handle vga=3D parameter */
     vmode =3D strstr(kernel_cmdline, "vga=3D");
     if (vmode) {
-        unsigned int video_mode;
+        long video_mode;
+        int ret;
         /* skip "vga=3D" */
         vmode +=3D 4;
         if (!strncmp(vmode, "normal", 6)) {
@@ -1211,7 +1213,12 @@ static void x86_load_linux(PCMachineState *pcms,
         } else if (!strncmp(vmode, "ask", 3)) {
             video_mode =3D 0xfffd;
         } else {
-            video_mode =3D strtol(vmode, NULL, 0);
+            ret =3D qemu_strtol(vmode, NULL, 0, &video_mode);
+            if (ret !=3D 0) {
+                fprintf(stderr, "qemu: can't parse 'vga' parameter: %s\n=
",
+                        strerror(-ret));
+                exit(1);
+            }
         }
         stw_p(header + 0x1fa, video_mode);
     }
--=20
2.21.0


