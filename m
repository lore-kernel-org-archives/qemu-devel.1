Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCEFCA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C98208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMe9cw7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C98208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOzl8-0007YX-8Y
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 03:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOza8-0004h9-Jw
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOza7-00031x-1w
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:36:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29936
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOza6-00031o-UP
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572248210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5dtam7LsuEC11Y8Z4sevAkS9bZM5hjwODNcwtjj8ytA=;
 b=XMe9cw7JZycW3LPn0OPpTBL62OZlVD3tYJWRA5FjirHIn5wgDLkHkOxnUNr1NL7l8pUHX5
 pNNIMCc1KAqcTzsjcNwPkooe5tgO6Xy4uP4oLidFtgfpdw1c0cdLDa47qVg2LjUAiK5YT9
 pfW3l0rATWwP1mFjNyeGjE5cA4lp/6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-yW2DBGpROri6M4C3SUEzNA-1; Mon, 28 Oct 2019 03:36:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EE76476;
 Mon, 28 Oct 2019 07:36:44 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-86.brq.redhat.com [10.40.204.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7937919C69;
 Mon, 28 Oct 2019 07:36:32 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/26] tests/acceptance: Add test that runs NetBSD 4.0
 installer on PRep/40p
Date: Mon, 28 Oct 2019 08:34:28 +0100
Message-Id: <20191028073441.6448-14-philmd@redhat.com>
In-Reply-To: <20191028073441.6448-1-philmd@redhat.com>
References: <20191028073441.6448-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: yW2DBGpROri6M4C3SUEzNA-1
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

As of this commit, NetBSD 4.0 is very old. However it is enough to
test the PRep/40p machine.

User case from:
http://mail-index.netbsd.org/port-prep/2017/04/11/msg000112.html

Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
Installers after 4.0 doesn't work anymore, not sure if this is a
problem from the QEMU model or from NetBSD.

v3:
- use avocado_qemu.wait_for_console_pattern (Cleber)
- check getenv(AVOCADO_ALLOW_UNTRUSTED_CODE) (pm215)
---
 MAINTAINERS                      |  1 +
 tests/acceptance/ppc_prep_40p.py | 50 ++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 tests/acceptance/ppc_prep_40p.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 17ff741c63..91746b87f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1068,6 +1068,7 @@ F: hw/rtc/m48t59-isa.c
 F: include/hw/isa/pc87312.h
 F: include/hw/rtc/m48t59.h
 F: pc-bios/ppc_rom.bin
+F: tests/acceptance/machine_ppc_prep_40p.py
=20
 sPAPR
 M: David Gibson <david@gibson.dropbear.id.au>
diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_4=
0p.py
new file mode 100644
index 0000000000..7dd90bb2bb
--- /dev/null
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -0,0 +1,50 @@
+# Functional test that boots a PReP/40p machine and checks its serial cons=
ole.
+#
+# Copyright (c) Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later. See the COPYING file in the top-level directory.
+
+import os
+import logging
+
+from avocado import skipIf
+from avocado import skipUnless
+from avocado_qemu import MachineTest
+from avocado_qemu import wait_for_console_pattern
+
+
+class IbmPrep40pMachine(MachineTest):
+
+    timeout =3D 60
+
+    # 12H0455 PPS Firmware Licensed Materials
+    # Property of IBM (C) Copyright IBM Corp. 1994.
+    # All rights reserved.
+    # U.S. Government Users Restricted Rights - Use, duplication or disclo=
sure
+    # restricted by GSA ADP Schedule Contract with IBM Corp.
+    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
+    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code=
')
+    def test_factory_firmware_and_netbsd(self):
+        """
+        :avocado: tags=3Darch:ppc
+        :avocado: tags=3Dmachine:40p
+        :avocado: tags=3Dslowness:high
+        """
+        bios_url =3D ('ftp://ftp.boulder.ibm.com/rs6000/firmware/'
+                    '7020-40p/P12H0456.IMG')
+        bios_hash =3D '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
+        bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_hash)
+        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/NetBSD-archive/'
+                     'NetBSD-4.0/prep/installation/floppy/generic_com0.fs'=
)
+        drive_hash =3D 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
+        drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddrive_hash=
)
+
+        self.vm.set_machine('40p')
+        self.vm.set_console()
+        self.vm.add_args('-bios', bios_path,
+                         '-fda', drive_path)
+        self.vm.launch()
+        os_banner =3D 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 PST 20=
07'
+        wait_for_console_pattern(self, os_banner)
+        wait_for_console_pattern(self, 'Model: IBM PPS Model 6015')
--=20
2.21.0


