Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADECACA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D9A205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cghkq5L8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D9A205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOzhC-0008Ix-UT
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 03:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOzbP-0007Bb-F4
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOzbN-0003W1-Vt
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:38:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27733
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOzbN-0003Vr-SO
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572248289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zsbiJ/WcQ2X2UkFEEiXAZWDMtDJsW1iUIUCVFVZXBM=;
 b=cghkq5L8CRGYh5F5NdPHlbnh02xyVTE60Gba9HT0NUAEdlxgsiLUsCiWG861b746835sVx
 UmVnB6Ovr2rWvBfwXaXcPE9k1+4F0wtMyBiuSEwxHxKZEnFpfwJiQ5dx2Ys8wIvByaS2zi
 v0T0kY0WMAk9oFbC8JUjNQ6XaZS28Bc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-8d2AE4--PXq2RV6gvLxeMw-1; Mon, 28 Oct 2019 03:38:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 599DB80183E;
 Mon, 28 Oct 2019 07:38:04 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-86.brq.redhat.com [10.40.204.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C1A419C69;
 Mon, 28 Oct 2019 07:37:45 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/26] tests/boot_linux_console: Add a test for the Raspberry
 Pi 2
Date: Mon, 28 Oct 2019 08:34:35 +0100
Message-Id: <20191028073441.6448-21-philmd@redhat.com>
In-Reply-To: <20191028073441.6448-1-philmd@redhat.com>
References: <20191028073441.6448-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 8d2AE4--PXq2RV6gvLxeMw-1
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

Similar to the x86_64/pc test, it boots a Linux kernel on a raspi2
board and verify the serial is working.

The kernel image and DeviceTree blob are built by the Raspbian
project (based on Debian):
https://www.raspbian.org/RaspbianImages
as recommended by the Raspberry Pi project:
https://www.raspberrypi.org/downloads/raspbian/

If ARM is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:arm" tags.

Alternatively, this test can be run using:

    $ avocado run -t arch:arm tests/acceptance
    $ avocado run -t machine:raspi2 tests/acceptance

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
v2: removed debug printf (Cleber)
    use serial_kernel_cmdline dict
---
 tests/acceptance/boot_linux_console.py | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index a689c09cfe..cc0c73b9c1 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -293,6 +293,42 @@ class BootLinuxConsole(MachineTest):
         self.vm.launch()
         self.wait_for_console_pattern('init started: BusyBox')
=20
+    def do_test_arm_raspi2(self, uart_id):
+        """
+        The kernel can be rebuilt using the kernel source referenced
+        and following the instructions on the on:
+        https://www.raspberrypi.org/documentation/linux/kernel/building.md
+        """
+        serial_kernel_cmdline =3D {
+            0: 'earlycon=3Dpl011,0x3f201000 console=3DttyAMA0',
+        }
+        deb_url =3D ('http://archive.raspberrypi.org/debian/'
+                   'pool/main/r/raspberrypi-firmware/'
+                   'raspberrypi-kernel_1.20190215-1_armhf.deb')
+        deb_hash =3D 'cd284220b32128c5084037553db3c482426f3972'
+        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
+        kernel_path =3D self.extract_from_deb(deb_path, '/boot/kernel7.img=
')
+        dtb_path =3D self.extract_from_deb(deb_path, '/boot/bcm2709-rpi-2-=
b.dtb')
+
+        self.vm.set_machine('raspi2')
+        self.vm.set_console()
+        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
+                               serial_kernel_cmdline[uart_id])
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern =3D 'Kernel command line: %s' % kernel_command_lin=
e
+        self.wait_for_console_pattern(console_pattern)
+
+    def test_arm_raspi2_uart0(self):
+        """
+        :avocado: tags=3Darch:arm
+        :avocado: tags=3Dmachine:raspi2
+        :avocado: tags=3Ddevice:pl011
+        """
+        self.do_test_arm_raspi2(0)
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=3Darch:s390x
--=20
2.21.0


