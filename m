Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD09FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9710820650
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doBfJ8Y9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9710820650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOzni-0004kO-E7
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 03:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOzas-0006S3-3n
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOzap-0003I0-Mq
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:37:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58471
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOzao-0003HM-SL
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572248253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mJPQXyGl6Ya7h9sBpf4cXWNZv/7Y4tvaUZn79QTHw0Y=;
 b=doBfJ8Y9v+QikkIODhbgJRniyKSkZmcub5717GssakIhWNNVD8TCRB+wW6tr/DlbiKbgJd
 xojFv08w6p4QWIQIGKPcBsq16Q2W/PQUaHQJe1PKhZYyUop2zBcRok2IlV92KsC3vRjtpT
 RJEP2FNbzhMcUvj7SmNu2SLRc+31cx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-hpWPtCz9Mhe36yasWO02YQ-1; Mon, 28 Oct 2019 03:37:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24733476;
 Mon, 28 Oct 2019 07:37:29 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-86.brq.redhat.com [10.40.204.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3480219481;
 Mon, 28 Oct 2019 07:37:22 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/26] tests/boot_console: Test booting HP-UX firmware upgrade
Date: Mon, 28 Oct 2019 08:34:33 +0100
Message-Id: <20191028073441.6448-19-philmd@redhat.com>
In-Reply-To: <20191028073441.6448-1-philmd@redhat.com>
References: <20191028073441.6448-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: hpWPtCz9Mhe36yasWO02YQ-1
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
 Sven Schnelle <svens@stackframe.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Add a test which boots a HP-UX firmware upgrade CD-ROM.
It exercise the PCI LSI53C895A SCSI controller.

The ISO image comes from:
https://web.archive.org/web/20101204061612/http://ftp.parisc-linux.org/kern=
els/712/PF_C7120023

This test is very quick, less than 3s:

  $ AVOCADO_ALLOW_UNTRUSTED_CODE=3Dyes \
    avocado --show=3Dapp,console run -t arch:hppa \
      tests/acceptance/boot_linux_console.py
  console: Firmware Version 6.1
  console: Duplex Console IO Dependent Code (IODC) revision 1
  console: Memory Test/Initialization Completed
  console: ----------------------------------------------------------------=
--------------
  console: (c) Copyright 2017-2018 Helge Deller <deller@gmx.de> and SeaBIOS=
 developers.
  console: ----------------------------------------------------------------=
--------------
  console: Processor   Speed            State           Coprocessor State  =
Cache Size
  console: ---------  --------   ---------------------  -----------------  =
----------
  console: 0      250 MHz    Active                 Functional            0=
 KB
  console: Available memory:     512 MB
  console: Good memory required: 16 MB
  console: Primary boot path:    FWSCSI.0.0
  console: Alternate boot path:  FWSCSI.2.0
  console: Console path:         SERIAL_1.9600.8.none
  console: Keyboard path:        PS2
  console: Available boot devices:
  console: 1. DVD/CD [lsi 00:00.0 2:0 Drive QEMU QEMU CD-ROM 2.5+]
  console: Booting from DVD/CD [lsi 00:00.0 2:0 Drive QEMU QEMU CD-ROM 2.5+=
]
  console: Booting...
  console: Boot IO Dependent Code (IODC) revision 153
  console: HARD Booted.
  console: ISL Revision A.00.25 November 18, 1992
  console: ISL booting  ODE UPDATE ; stable off ; RUN
  console: Loading...
  console: ****************************************************************=
***********
  console: ******                                                          =
     ******
  console: ******             Offline Diagnostic Environment               =
     ******
  console: ******                                                          =
     ******
  console: ******      (C) Copyright Hewlett-Packard Co 1993               =
     ******
  console: ******                    All Rights Reserved                   =
     ******
  console: ******                                                          =
     ******
  console: ******  HP shall not be liable for any damages resulting from th=
e    ******
  console: ******  use of this program.                                    =
     ******
  console: ******                                                          =
     ******
  console: ******                TC  Version A.00.15                       =
     ******
  console: ******                SysLib Version A.00.44                    =
     ******
  console: ******                                                          =
     ******
  console: ****************************************************************=
***********
  console: Type HELP for command information.
  console: ISL_CMD> UPDATE ; stable off ; RUN
  console: ****************************************************************=
***********
  console: ******                                                          =
     ******
  console: ******                           PDC UPDATER                    =
     ******
  console: ******                                                          =
     ******
  console: ******    Copyright (C) 1993, 1994, 1995 by Hewlett-Packard Comp=
any  ******
  console: ******                         Version A.00.19                  =
     ******
  console: ******                                                          =
     ******
  console: ****************************************************************=
***********
  console: Type HELP for command information.
  console: Stable Storage will NOT be updated
  console: STARTING EXECUTION OF UPDATE
  console: Unrecognized MODEL TYPE =3D 502
  console: ERROR 0001
  console: UPDATE PAUSED> exit
  console: UPDATE>
  console: UPDATE> ls
  console: Modules on this boot media are:
  console: filename    type    size     created   description
  console: ----------------------------------------------------------------=
-------------
  console: DAGGER      DATA    118      96/02/15  ?
  console: IMAGE1A     DATA    512      96/02/15  ?
  console: IMAGE1B     DATA    388      96/02/15  ?
  console: UPDATE> exit
  console: THIS UTILITY WILL NOW RESET THE SYSTEM.....
  PASS (2.39 s)
  JOB TIME   : 2.54 s

Suggested-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
v2:
- check getenv(AVOCADO_ALLOW_UNTRUSTED_CODE) (pm215)

I know this is not a 'Linux' test, but all our console functions
reside in this file and I don't want to duplicate again.
Maybe we could rename this file as 'boot_console_tests.py' or
extract the console related functions.
---
 tests/acceptance/boot_linux_console.py | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index f94dc4bbca..67b396169b 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -13,6 +13,7 @@ import lzma
 import gzip
 import shutil
=20
+from avocado import skipUnless
 from avocado_qemu import MachineTest
 from avocado_qemu import exec_command_and_wait_for_pattern
 from avocado_qemu import wait_for_console_pattern
@@ -357,3 +358,29 @@ class BootLinuxConsole(MachineTest):
         self.vm.launch()
         console_pattern =3D 'Kernel command line: %s' % kernel_command_lin=
e
         self.wait_for_console_pattern(console_pattern)
+
+    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code=
')
+    def test_hppa_fwupdate(self):
+        """
+        :avocado: tags=3Darch:hppa
+        :avocado: tags=3Ddevice:lsi53c895a
+        """
+        cdrom_url =3D ('https://github.com/philmd/qemu-testing-blob/raw/ec=
1b741/'
+                     'hppa/hp9000/712/C7120023.frm')
+        cdrom_hash =3D '17944dee46f768791953009bcda551be5ab9fac9'
+        cdrom_path =3D self.fetch_asset(cdrom_url, asset_hash=3Dcdrom_hash=
)
+
+        self.vm.set_console()
+        self.vm.add_args('-cdrom', cdrom_path,
+                         '-boot', 'd',
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('Unrecognized MODEL TYPE =3D 502')
+
+        exec_command_and_wait_for_pattern(self, 'exit',
+                                                'UPDATE>')
+        exec_command_and_wait_for_pattern(self, 'ls',
+                                                'IMAGE1B')
+        exec_command_and_wait_for_pattern(self, 'exit',
+                                                'THIS UTILITY WILL NOW '
+                                                'RESET THE SYSTEM.....')
--=20
2.21.0


