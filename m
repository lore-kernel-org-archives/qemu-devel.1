Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD8CC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD832470B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RcbMMt05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD832470B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is8xg-0000zv-Vl
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 12:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1is8wh-0000PT-0n
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1is8wc-00055d-UO
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:28:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50486
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1is8wc-00054u-R4
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579195713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8r6vKouu1XQ5cUrQGHdc87L4Vg/2yU0zGmekPp7zaw4=;
 b=RcbMMt05WjmFBe7DllHa38vPqvJivvanjMfceNbT5QVb8EWlkfkFwCn9hjtcixRXxBDIS4
 cTEk7S6p9OtLAWMPpsIiPPkkhI22n556HwdhYxkG8X4QIBmpVEYOwH3HXTv9UGaaYk1lwl
 QIGNl8wQC9QnNHAfsBLLP0d7Le1jBBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-g4e7CGdqOu2r6nw8Zze9QQ-1; Thu, 16 Jan 2020 12:28:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2486D8017CC;
 Thu, 16 Jan 2020 17:28:28 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C603A7DB4F;
 Thu, 16 Jan 2020 17:28:26 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/86] arm:kzm: drop RAM size fixup
Date: Thu, 16 Jan 2020 18:26:04 +0100
Message-Id: <1579195564-95459-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <87sgkgv6dh.wl-Peter.Chubb@data61.csiro.au>
References: <87sgkgv6dh.wl-Peter.Chubb@data61.csiro.au>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: g4e7CGdqOu2r6nw8Zze9QQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Peter.Chubb@data61.csiro.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 peter.chubb@nicta.com.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the user provided too large a RAM size, the code used to
complain and trim it to the max size.  Now tht RAM is allocated by
generic code, that's no longer possible, so generate an error and
exit instead.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v3:
 * rephrase commit message in nicer way
   ("Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au>)
 * reword error message and use size_to_str() to pretty print suggested siz=
e
   ("Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au>)

CC: peter.chubb@nicta.com.au
CC: peter.maydell@linaro.org
CC: qemu-arm@nongnu.org
---
 hw/arm/kzm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 1d5ef28..94cbac1 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -25,6 +25,7 @@
 #include "hw/char/serial.h"
 #include "sysemu/qtest.h"
 #include "sysemu/sysemu.h"
+#include "qemu/cutils.h"
=20
 /* Memory map for Kzm Emulation Baseboard:
  * 0x00000000-0x7fffffff See i.MX31 SOC for support
@@ -78,10 +79,10 @@ static void kzm_init(MachineState *machine)
=20
     /* Check the amount of memory is compatible with the SOC */
     if (machine->ram_size > (FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZE=
)) {
-        warn_report("RAM size " RAM_ADDR_FMT " above max supported, "
-                    "reduced to %x", machine->ram_size,
-                    FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZE);
-        machine->ram_size =3D FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZ=
E;
+        char *sz =3D size_to_str(FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_=
SIZE);
+        error_report("RAM size more than %s is not supported", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
     }
=20
     memory_region_allocate_system_memory(&s->ram, NULL, "kzm.ram",
--=20
2.7.4


