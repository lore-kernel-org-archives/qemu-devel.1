Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63516CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 23:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F1F217D6
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 23:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTPbpn8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F1F217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPEuw-0004aL-RK
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 19:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iPEn5-00037V-UX
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iPEn3-0004FT-1V
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:51:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35348
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iPEn2-0004F8-U7
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572306672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8lYqhnpDphjhwvhSATzYj5m2+OPTg3mWCbrjVjqlZtA=;
 b=LTPbpn8juGIe9ux/wGyPEL7bj+et0ajPt1oE+5pqZaBOVtBoKzNHv2tohYmJdD5JVupaJr
 F35+Em6QFE9FvAQCVmFmRnsykj2xvVH4uGi2LiHlrZHlIJCiE2wQtJxH8+u7+Qxi0mCDM1
 +WaGLxljH+QPeimwIEfFMVulq44YLH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-d7glGpJCPWi6T4ILWJ5OyA-1; Mon, 28 Oct 2019 19:51:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C87748017DD;
 Mon, 28 Oct 2019 23:51:06 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 334195C1B2;
 Mon, 28 Oct 2019 23:51:02 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PULL 15/16] tests/boot_linux_console: Add initrd test for the
 Exynos4210
Date: Mon, 28 Oct 2019 19:50:01 -0400
Message-Id: <20191028235002.17691-16-crosa@redhat.com>
In-Reply-To: <20191028235002.17691-1-crosa@redhat.com>
References: <20191028235002.17691-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: d7glGpJCPWi6T4ILWJ5OyA-1
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
Cc: Fam Zheng <fam@euphon.net>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

This test boots a Linux kernel on a smdkc210 board and verify
the serial output is working.

The cpio image used comes from the linux-build-test project:
https://github.com/groeck/linux-build-test

If ARM is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:arm" tags.

This test can be run using:

  $ IGNORE_AVOCADO_CONSOLE_BUG=3Dyes \
    avocado --show=3Dapp,console run -t machine:smdkc210 \
      tests/acceptance/boot_linux_console.py
  console: Booting Linux on physical CPU 0x900
  console: Linux version 4.19.0-6-armmp (debian-kernel@lists.debian.org) (g=
cc version 8.3.0 (Debian 8.3.0-6)) #1 SMP Debian 4.19.67-2+deb10u1 (2019-09=
-20)
  console: CPU: ARMv7 Processor [410fc090] revision 0 (ARMv7), cr=3D10c5387=
d
  console: CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instru=
ction cache
  console: OF: fdt: Machine model: Samsung smdkv310 evaluation board based =
on Exynos4210
  [...]
  console: Samsung CPU ID: 0x43210211
  console: random: get_random_bytes called from start_kernel+0xa0/0x504 wit=
h crng_init=3D0
  console: percpu: Embedded 17 pages/cpu s39756 r8192 d21684 u69632
  console: Built 1 zonelists, mobility grouping on.  Total pages: 249152
  console: Kernel command line: printk.time=3D0 console=3DttySAC0,115200n8 =
earlyprintk random.trust_cpu=3Doff cryptomgr.notests cpuidle.off=3D1 panic=
=3D-1 noreboot
  [...]
  console: L2C: platform modifies aux control register: 0x02020000 -> 0x3e4=
20001
  console: L2C: platform provided aux values permit register corruption.
  console: L2C: DT/platform modifies aux control register: 0x02020000 -> 0x=
3e420001
  console: L2C-310 erratum 769419 enabled
  console: L2C-310 enabling early BRESP for Cortex-A9
  console: L2C-310: enabling full line of zeros but not enabled in Cortex-A=
9
  console: L2C-310 ID prefetch enabled, offset 1 lines
  console: L2C-310 dynamic clock gating disabled, standby mode disabled
  console: L2C-310 cache controller enabled, 8 ways, 128 kB
  console: L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x7e420001
  console: Exynos4210 clocks: sclk_apll =3D 12000000, sclk_mpll =3D 1200000=
0
  console: sclk_epll =3D 12000000, sclk_vpll =3D 12000000, arm_clk =3D 1200=
0000
  [...]
  console: s3c-i2c 13860000.i2c: slave address 0x00
  console: s3c-i2c 13860000.i2c: bus frequency set to 93 KHz
  console: s3c-i2c 13860000.i2c: i2c-0: S3C I2C adapter
  [...]
  console: dma-pl330 12680000.pdma: Loaded driver for PL330 DMAC-241330
  console: dma-pl330 12680000.pdma:       DBUFF-256x8bytes Num_Chans-8 Num_=
Peri-32 Num_Events-16
  console: dma-pl330 12690000.pdma: Loaded driver for PL330 DMAC-241330
  console: dma-pl330 12690000.pdma:       DBUFF-256x8bytes Num_Chans-8 Num_=
Peri-32 Num_Events-16
  console: dma-pl330 12850000.mdma: Loaded driver for PL330 DMAC-241330
  console: dma-pl330 12850000.mdma:       DBUFF-256x8bytes Num_Chans-8 Num_=
Peri-1 Num_Events-16
  console: dma-pl330 12850000.mdma: PM domain LCD0 will not be powered off
  console: Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
  console: Serial: AMBA driver
  console: 13800000.serial: ttySAC0 at MMIO 0x13800000 (irq =3D 40, base_ba=
ud =3D 0) is a S3C6400/10
  console: console [ttySAC0] enabled
  console: 13810000.serial: ttySAC1 at MMIO 0x13810000 (irq =3D 41, base_ba=
ud =3D 0) is a S3C6400/10
  console: 13820000.serial: ttySAC2 at MMIO 0x13820000 (irq =3D 42, base_ba=
ud =3D 0) is a S3C6400/10
  console: 13830000.serial: ttySAC3 at MMIO 0x13830000 (irq =3D 43, base_ba=
ud =3D 0) is a S3C6400/10
  [...]
  console: Freeing unused kernel memory: 2048K
  console: Run /init as init process
  console: mount: mounting devtmpfs on /dev failed: Device or resource busy
  console: Starting logging: OK
  console: Initializing random number generator... random: dd: uninitialize=
d urandom read (512 bytes read)
  console: done.
  console: Starting network: OK
  console: Found console ttySAC0
  console: Linux version 4.19.0-6-armmp (debian-kernel@lists.debian.org) (g=
cc version 8.3.0 (Debian 8.3.0-6)) #1 SMP Debian 4.19.67-2+deb10u1 (2019-09=
-20)
  console: Boot successful.
  PASS (37.98 s)

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20191028073441.6448-25-philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
[Cleber: removed conditional to skip test]
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index a4fa31b411..dab21b37c4 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -328,6 +328,47 @@ class BootLinuxConsole(Test):
         """
         self.do_test_arm_raspi2(0)
=20
+    def test_arm_exynos4210_initrd(self):
+        """
+        :avocado: tags=3Darch:arm
+        :avocado: tags=3Dmachine:smdkc210
+        """
+        deb_url =3D ('https://snapshot.debian.org/archive/debian/'
+                   '20190928T224601Z/pool/main/l/linux/'
+                   'linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb=
')
+        deb_hash =3D 'fa9df4a0d38936cb50084838f2cb933f570d7d82'
+        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
+        kernel_path =3D self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-4.19.0-6-armmp'=
)
+        dtb_path =3D '/usr/lib/linux-image-4.19.0-6-armmp/exynos4210-smdkv=
310.dtb'
+        dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
+
+        initrd_url =3D ('https://github.com/groeck/linux-build-test/raw/'
+                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
+                      'arm/rootfs-armv5.cpio.gz')
+        initrd_hash =3D '2b50f1873e113523967806f4da2afe385462ff9b'
+        initrd_path_gz =3D self.fetch_asset(initrd_url, asset_hash=3Dinitr=
d_hash)
+        initrd_path =3D os.path.join(self.workdir, 'rootfs.cpio')
+        archive.gzip_uncompress(initrd_path_gz, initrd_path)
+
+        self.vm.set_machine('smdkc210')
+        self.vm.set_console()
+        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=3Dexynos4210,0x13800000 earlyprin=
tk ' +
+                               'console=3DttySAC0,115200n8 ' +
+                               'random.trust_cpu=3Doff cryptomgr.notests '=
 +
+                               'cpuidle.off=3D1 panic=3D-1 noreboot')
+
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Boot successful.')
+        # TODO user command, for now the uart is stuck
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=3Darch:s390x
--=20
2.21.0


