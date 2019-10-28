Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9DFCA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:06:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 109F520862
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+jR5qSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109F520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP02q-0002nN-DO
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 04:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOzba-0007Rr-1I
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOzbY-0003a6-Pl
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:38:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39674
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOzbY-0003Zo-MK
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572248300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wtyVhPrMDClfaWp/tnoq600EcuRYbAk2G8WCARC2TA0=;
 b=V+jR5qSKCyCabaVB6Nv+6vjByuRT/JWTQ/0z2FHIIPU8A2HD3UfCk2wUuDR7Gn/z+ew4Q8
 U34zsVhSI7kJJnW2zRTkRzqfw+cQ3FyeFkG90Q5r3XQsUemuEnCGctQltpowU5DVmLHg0B
 /IUHxPmmlzzRPJTzithtnLuyLLIwNh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-epZOA5yEPHu0YBpzAuv5NA-1; Mon, 28 Oct 2019 03:38:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A46F1800D7E;
 Mon, 28 Oct 2019 07:38:10 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-86.brq.redhat.com [10.40.204.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1731F19C69;
 Mon, 28 Oct 2019 07:38:04 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/26] tests/boot_linux_console: Test the raspi2 UART1 (16550
 based)
Date: Mon, 28 Oct 2019 08:34:36 +0100
Message-Id: <20191028073441.6448-22-philmd@redhat.com>
In-Reply-To: <20191028073441.6448-1-philmd@redhat.com>
References: <20191028073441.6448-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: epZOA5yEPHu0YBpzAuv5NA-1
X-Mimecast-Spam-Score: 0
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
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

The current do_test_arm_raspi2() case tests the PL011 UART0.
Our model also supports the AUX UART (16550 based).
We can very simply test the UART1 with Linux, modifying the
kernel command line.

Add few lines to expand our previous test and cover the AUX
UART.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index cc0c73b9c1..1c9ff2bda3 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -301,6 +301,7 @@ class BootLinuxConsole(MachineTest):
         """
         serial_kernel_cmdline =3D {
             0: 'earlycon=3Dpl011,0x3f201000 console=3DttyAMA0',
+            1: 'earlycon=3Duart8250,mmio32,0x3f215040 console=3DttyS1,1152=
00'
         }
         deb_url =3D ('http://archive.raspberrypi.org/debian/'
                    'pool/main/r/raspberrypi-firmware/'
@@ -311,7 +312,7 @@ class BootLinuxConsole(MachineTest):
         dtb_path =3D self.extract_from_deb(deb_path, '/boot/bcm2709-rpi-2-=
b.dtb')
=20
         self.vm.set_machine('raspi2')
-        self.vm.set_console()
+        self.vm.set_console(console_index=3Duart_id)
         kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
                                serial_kernel_cmdline[uart_id])
         self.vm.add_args('-kernel', kernel_path,
@@ -329,6 +330,14 @@ class BootLinuxConsole(MachineTest):
         """
         self.do_test_arm_raspi2(0)
=20
+    def test_arm_raspi2_uart1(self):
+        """
+        :avocado: tags=3Darch:arm
+        :avocado: tags=3Dmachine:raspi2
+        :avocado: tags=3Ddevice:bcm2835_aux
+        """
+        self.do_test_arm_raspi2(1)
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=3Darch:s390x
--=20
2.21.0


