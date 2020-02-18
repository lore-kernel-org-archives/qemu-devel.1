Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC46C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCFAC2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrE7jppo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCFAC2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j451q-000358-3f
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 10:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4513-0001mw-0M
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:42:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4511-0002aQ-Ue
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:42:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38160
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4511-0002ZS-Qn
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582040547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1c2yqFgFbp4i9xhV4kKPq25gSYtbT55JAm+pKumo/54=;
 b=JrE7jppokjofY1AhKWjdvjcEOIjMBFESTE/P44rxz7xEWFagPWYOUj4CYu14ADIOTHeZfE
 66NzkTBXLI8J3G4ZyB9Vna4PYolrqd4XfqKOQ3eti8u/rx+CNLcztoRNkCPriz0TghDvs7
 MehlBc2LPBeF3YsBCEPnpHG2KTw/VXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-yyQiOxsxO8e8B28dYMG0AQ-1; Tue, 18 Feb 2020 10:42:24 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9DA38010F3;
 Tue, 18 Feb 2020 15:42:23 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7083F100EBC2;
 Tue, 18 Feb 2020 15:42:22 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 15/79] arm/imx25_pdk: drop RAM size fixup
Date: Tue, 18 Feb 2020 10:42:21 -0500
Message-Id: <20200218154221.9595-1-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-16-imammedo@redhat.com>
References: <20200217173452.15243-16-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: yyQiOxsxO8e8B28dYMG0AQ-1
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
Cc: pbonzini@redhat.com, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If user provided non-sense RAM size, board will complain and
continue running with max RAM size supported.
Also RAM is going to be allocated by generic code, so it won't be
possible for board to fix things up for user.

Make it error message and exit to force user fix CLI,
instead of accepting non-sense CLI values.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v6:
 - use size_to_str() to print size
    (Richard Henderson <richard.henderson@linaro.org>)

CC: richard.henderson@linaro.org
---
 hw/arm/imx25_pdk.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index c76fc2bd94..c7c51d6cbc 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -32,6 +32,7 @@
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
 #include "hw/i2c/i2c.h"
+#include "qemu/cutils.h"
=20
 /* Memory map for PDK Emulation Baseboard:
  * 0x00000000-0x7fffffff See i.MX25 SOC fr support
@@ -66,6 +67,7 @@ static struct arm_boot_info imx25_pdk_binfo;
=20
 static void imx25_pdk_init(MachineState *machine)
 {
+    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     IMX25PDK *s =3D g_new0(IMX25PDK, 1);
     unsigned int ram_size;
     unsigned int alias_offset;
@@ -78,10 +80,10 @@ static void imx25_pdk_init(MachineState *machine)
=20
     /* We need to initialize our memory */
     if (machine->ram_size > (FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE=
)) {
-        warn_report("RAM size " RAM_ADDR_FMT " above max supported, "
-                    "reduced to %x", machine->ram_size,
-                    FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE);
-        machine->ram_size =3D FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZ=
E;
+        char *sz =3D size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
     }
=20
     memory_region_allocate_system_memory(&s->ram, NULL, "imx25.ram",
--=20
2.18.1


