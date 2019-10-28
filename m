Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65674CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3078D20650
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONt2lHON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3078D20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOzqT-000273-5z
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 03:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOzbs-0007wX-K8
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOzbq-0003j7-UW
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:38:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54348
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOzbq-0003ii-Pm
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572248318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wtUZK07zgF143OudfE3/tQ5adZlIP+D9GXmgqk/9gR4=;
 b=ONt2lHONdBx7jovZrsVP3uTWBWbCF3bgjGkXOvsOfij7M1Z7BPtL1sxOuoUIFCtGONo/Mz
 9u/9qvutRUG2z3752QQgW7nqPu2wK8MVBN633TH5hFgc92gsGVEp9AXZ32O4t+66Tu6FNy
 1ZY7UpbIuMvhAnVO39reykjsct3CTdA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-Rnrybw3IOzKAQwTbSGK1dg-1; Mon, 28 Oct 2019 03:38:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BF6A800D41;
 Mon, 28 Oct 2019 07:38:33 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-86.brq.redhat.com [10.40.204.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2352319C69;
 Mon, 28 Oct 2019 07:38:24 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/26] tests/boot_linux_console: Test SDHCI and termal sensor
 on raspi3
Date: Mon, 28 Oct 2019 08:34:38 +0100
Message-Id: <20191028073441.6448-24-philmd@redhat.com>
In-Reply-To: <20191028073441.6448-1-philmd@redhat.com>
References: <20191028073441.6448-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Rnrybw3IOzKAQwTbSGK1dg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

Add a test which loads the root filesystem on a SD card.
Use a kernel recent enough to also test the thermal sensor.

The kernel image comes from:
https://github.com/sakaki-/bcmrpi3-kernel#description

The cpio image used comes from the linux-build-test project:
https://github.com/groeck/linux-build-test

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
v2: Use archive.gzip_uncompress (Cleber)
---
 tests/acceptance/boot_linux_console.py | 46 ++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index dc27d79199..44a046bd64 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -386,6 +386,52 @@ class BootLinuxConsole(MachineTest):
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system=
')
=20
+    def test_arm_raspi3_initrd_sd_temp(self):
+        """
+        :avocado: tags=3Darch:aarch64
+        :avocado: tags=3Dmachine:raspi3
+        """
+        tarball_url =3D ('https://github.com/sakaki-/bcmrpi3-kernel/releas=
es/'
+                       'download/4.19.71.20190910/'
+                       'bcmrpi3-kernel-4.19.71.20190910.tar.xz')
+        tarball_hash =3D '844f117a1a6de0532ba92d2a7bceb5b2acfbb298'
+        tarball_path =3D self.fetch_asset(tarball_url, asset_hash=3Dtarbal=
l_hash)
+        archive.extract(tarball_path, self.workdir)
+        dtb_path    =3D self.workdir + "/boot/bcm2837-rpi-3-b.dtb"
+        kernel_path =3D self.workdir + "/boot/kernel8.img"
+
+        rootfs_url =3D ('https://github.com/groeck/linux-build-test/raw/'
+                      '9b6b392ea7bc15f0d6632328d429d31c9c6273da/rootfs/'
+                      'arm64/rootfs.ext2.gz')
+        rootfs_hash =3D 'dbe4136f0b4a0d2180b93fd2a3b9a784f9951d10'
+        rootfs_path_gz =3D self.fetch_asset(rootfs_url, asset_hash=3Drootf=
s_hash)
+        rootfs_path =3D self.workdir + "rootfs.ext2"
+        archive.gzip_uncompress(rootfs_path_gz, rootfs_path)
+
+        self.vm.set_machine('raspi3')
+        self.vm.set_console()
+        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=3Dpl011,0x3f201000 console=3DttyA=
MA0 ' +
+                               'root=3D/dev/mmcblk0 rootwait rw ' +
+                               'panic=3D-1 noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-append', kernel_command_line,
+                         '-drive', 'file=3D' + rootfs_path + ',if=3Dsd,for=
mat=3Draw',
+                         '-no-reboot')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Boot successful.',
+                                      failure_message=3D'-----[ cut here ]=
-----')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'Raspberry Pi 3 Model B')
+        exec_command_and_wait_for_pattern(self, ('cat /sys/devices/virtual=
/'
+                                                 'thermal/thermal_zone0/te=
mp'),
+                                                '25178')
+        exec_command_and_wait_for_pattern(self, 'reboot',
+                                                'reboot: Restarting system=
')
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=3Darch:s390x
--=20
2.21.0


