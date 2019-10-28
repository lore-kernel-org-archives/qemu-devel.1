Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5751CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4B720862
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvEQDASu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4B720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP051-0000lQ-Jb
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 04:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOzcA-00082c-2P
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOzc8-0003sh-GM
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:38:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50646
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOzc8-0003s8-7X
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572248335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TV/dzQWg9sTmKE1T0I+o1dz563MfWvQQek1xQ2H4w3s=;
 b=VvEQDASuyn7A541rQ44Edoi/xmfFyWy/7TudwXG0cvgRAoqihSHVEUk3/cmZauV6vvn8Wx
 x657yjWEI4lxIFbKn0hMzpDeQ+rS07U9kvDaJQirJq4UDwcdrCNmiBrGMRgLkEEmwqymG9
 IKL/1pbfdfuHuTZPumiQH6UjHmyTRbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-W049WbT0OgKYa7yiMp9PNA-1; Mon, 28 Oct 2019 03:38:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86CE680183E;
 Mon, 28 Oct 2019 07:38:50 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-86.brq.redhat.com [10.40.204.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30FD919C69;
 Mon, 28 Oct 2019 07:38:44 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/26] tests/boot_linux_console: Add sdcard test for the
 Exynos4210
Date: Mon, 28 Oct 2019 08:34:40 +0100
Message-Id: <20191028073441.6448-26-philmd@redhat.com>
In-Reply-To: <20191028073441.6448-1-philmd@redhat.com>
References: <20191028073441.6448-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: W049WbT0OgKYa7yiMp9PNA-1
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
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

Since this test is not reliable due to clock timing issues,
it is disabled with the 'skip' property.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
v2:
- use archive.gzip_uncompress (Cleber)
- check getenv(AVOCADO_ALLOW_UNTRUSTED_CODE) (pm215)
---
 tests/acceptance/boot_linux_console.py | 47 ++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index cbb8cddf47..489df4862c 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -13,6 +13,7 @@ import lzma
 import gzip
 import shutil
=20
+from avocado import skip
 from avocado import skipUnless
 from avocado_qemu import MachineTest
 from avocado_qemu import exec_command_and_wait_for_pattern
@@ -474,6 +475,52 @@ class BootLinuxConsole(MachineTest):
         self.wait_for_console_pattern('Boot successful.')
         # TODO user command, for now the uart is stuck
=20
+    @skip("unstable clock timings")
+    def test_arm_exynos4210_sdcard(self):
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
+        rootfs_url =3D ('https://github.com/groeck/linux-build-test/raw/'
+                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
+                      'arm/rootfs-armv5.ext2.gz')
+        rootfs_hash =3D '093e89d2b4d982234bf528bc9fb2f2f17a9d1f93'
+        rootfs_path_gz =3D self.fetch_asset(rootfs_url, asset_hash=3Drootf=
s_hash)
+        rootfs_path =3D os.path.join(self.workdir, 'rootfs.ext2')
+        archive.gzip_uncompress(rootfs_path_gz, rootfs_path)
+
+        self.vm.set_machine('smdkc210')
+        self.vm.set_console(console_index=3D1)
+        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=3Dexynos4210,0x13810000 earlyprin=
tk ' +
+                               'console=3DttySAC1,115200n8 ' +
+                               'random.trust_cpu=3Doff cryptomgr.notests '=
 +
+                               'root=3D/dev/mmcblk0 rootwait rw ' +
+                               'cpuidle.off=3D1 panic=3D-1 noreboot')
+
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-append', kernel_command_line,
+                         # The external MMC is on the 3rd slot
+                         '-drive', 'if=3Dsd,driver=3Dnull-co',
+                         '-drive', 'if=3Dsd,driver=3Dnull-co',
+                         '-drive', 'if=3Dsd,file=3D' + rootfs_path + ',for=
mat=3Draw',
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


