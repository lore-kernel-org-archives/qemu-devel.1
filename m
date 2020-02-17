Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B483DC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8037A20725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FczoTESs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8037A20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kPo-0000D2-Kz
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kIq-0001XN-E7
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kIp-0001uM-3t
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51929
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kIo-0001u2-Ve
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Dfb85aPgfwwJ+mWybY0PsNk3IWDbp0ixvgCs4MJYxk=;
 b=FczoTESsrfYCa5DmoKio+GZcVM1/OLmfx+Jvl/HlpXdajK9PIP2Xoqfb0rUfCpglPEiX0l
 YQtdmF/IeVhYAqRsodDWj4hIaLWfhSSVQueyzFuT15yU2tujGtSCcXYdJijjybPqzbY9aR
 gwZjitWG0dFK/ROZ8saf34jT28uzvjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-4AlLvmDzPg2nncy68GtrNQ-1; Mon, 17 Feb 2020 12:35:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2569B18FE862
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 17:35:22 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 722A59051D;
 Mon, 17 Feb 2020 17:35:21 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 18/79] arm/kzm: drop RAM size fixup
Date: Mon, 17 Feb 2020 12:33:51 -0500
Message-Id: <20200217173452.15243-19-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 4AlLvmDzPg2nncy68GtrNQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the user provided too large a RAM size, the code used to
complain and trim it to the max size.  Now that RAM is allocated by
generic code, that's no longer possible, so generate an error and
exit instead.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Peter Chubb <peter.chubb@data61.csiro.au>
---
v3:
 * rephrase commit message in nicer way
   ("Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au>)
 * reword error message and use size_to_str() to pretty print suggested siz=
e
   ("Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au>)
---
 hw/arm/kzm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 1d5ef289d5..94cbac11de 100644
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
2.18.1


