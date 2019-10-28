Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894F3CA9EC0
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 00:13:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F052208C0
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 00:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3XuamgJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F052208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPF8S-0005CI-IS
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 20:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iPEn7-0003B7-0E
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iPEn5-0004IQ-C0
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:51:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50808
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iPEn5-0004I5-8l
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572306674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9pYC7CtQixoJGGxvjzcGsmm20Vm5UjTwJbg9lGaG3sk=;
 b=G3XuamgJnGotElOfxFWys+5D3XdXHqNXtXQZoYTWTnrt0gt9zTjMNv1qnze7vRtCWdMyE6
 U9hqe6pJ879MEezdsOE7AA/7m6TkxWfzZKV6e5FSx3vD9Tf1QY2KzY/uPlVoOFUBU9OszO
 OdiUO/7giy5+yXSkAJOMqU3LrBwIvqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-QZ55_FsLONGBqtlpLZ5R4A-1; Mon, 28 Oct 2019 19:51:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37F4E476;
 Mon, 28 Oct 2019 23:51:09 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 048CB5C1B2;
 Mon, 28 Oct 2019 23:51:06 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PULL 16/16] tests/boot_linux_console: Run BusyBox on 5KEc 64-bit cpu
Date: Mon, 28 Oct 2019 19:50:02 -0400
Message-Id: <20191028235002.17691-17-crosa@redhat.com>
In-Reply-To: <20191028235002.17691-1-crosa@redhat.com>
References: <20191028235002.17691-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: QZ55_FsLONGBqtlpLZ5R4A-1
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
Cc: Fam Zheng <fam@euphon.net>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
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

This tests boots a Linux kernel on a Malta machine up to a
busybox shell on the serial console. Few commands are executed
before halting the machine (via reboot).

We use the Fedora 24 kernel extracted from the image at:
https://fedoraproject.org/wiki/Architectures/MIPS
and the initrd cpio image from the kerneltests project:
https://kerneltests.org/

If MIPS is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:mips" tags.

Alternatively, this test can be run using:

  $ AVOCADO_ALLOW_UNTRUSTED_CODE=3Dyes \
    avocado --show=3Dconsole run -t arch:mips64el \
      tests/acceptance/boot_linux_console.py
  console: [    0.000000] Linux version 3.19.3.mtoman.20150408 (mtoman@debi=
an-co3-1) (gcc version 5.0.0 20150316 (Red Hat 5.0.0-0.20) (GCC) ) #3 Wed A=
pr 8 14:32:50 UTC 2015
  console: [    0.000000] Early serial console at I/O port 0x3f8 (options '=
38400n8')
  console: [    0.000000] bootconsole [uart0] enabled
  console: [    0.000000] CPU0 revision is: 00018900 (MIPS 5KE)
  console: [    0.000000] Checking for the multiply/shift bug... no.
  console: [    0.000000] Checking for the daddiu bug... no.
  [...]
  console: Boot successful.
  console: cat /proc/cpuinfo
  console: / # cat /proc/cpuinfo
  console: system type            : MIPS Malta
  console: machine                        : Unknown
  console: processor              : 0
  console: cpu model              : MIPS 5KE V0.0
  console: : 1616.89
  console: wait instruction       : nouname -a
  console: microsecond timers     : yes
  console: tlb_entries            : 32
  console: extra interrupt vector : yes
  console: hardware watchpoint    : yes, count: 1, address/irw mask: [0x0ff=
8]
  console: isa                    : mips1 mips2 mips3 mips4 mips5 mips32r1 =
mips32r2 mips64r1 mips64r2
  console: ASEs implemented       :
  console: shadow register sets   : 1
  console: kscratch registers     : 0
  console: package                        : 0
  console: core                   : 0
  console: VCED exceptions                : not available
  console: VCEI exceptions                : not available
  console: / #
  console: / # uname -a
  console: Linux buildroot 3.19.3.mtoman.20150408 #3 Wed Apr 8 14:32:50 UTC=
 2015 mips64 GNU/Linux
  console: reboot
  console: / #
  console: / # reboot
  console: / #
  console: / # reboot: Restarting system
  PASS (7.04 s)
  JOB TIME   : 7.20 s

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20191028073441.6448-27-philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 42 ++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index dab21b37c4..9fd65e1ccf 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -13,6 +13,7 @@ import lzma
 import gzip
 import shutil
=20
+from avocado import skipUnless
 from avocado_qemu import Test
 from avocado_qemu import exec_command_and_wait_for_pattern
 from avocado_qemu import wait_for_console_pattern
@@ -166,6 +167,47 @@ class BootLinuxConsole(Test):
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system=
')
=20
+    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code=
')
+    def test_mips64el_malta_5KEc_cpio(self):
+        """
+        :avocado: tags=3Darch:mips64el
+        :avocado: tags=3Dmachine:malta
+        :avocado: tags=3Dendian:little
+        """
+        kernel_url =3D ('https://github.com/philmd/qemu-testing-blob/'
+                      'raw/9ad2df38/mips/malta/mips64el/'
+                      'vmlinux-3.19.3.mtoman.20150408')
+        kernel_hash =3D '00d1d268fb9f7d8beda1de6bebcc46e884d71754'
+        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel_h=
ash)
+        initrd_url =3D ('https://github.com/groeck/linux-build-test/'
+                      'raw/8584a59e/rootfs/'
+                      'mipsel64/rootfs.mipsel64r1.cpio.gz')
+        initrd_hash =3D '1dbb8a396e916847325284dbe2151167'
+        initrd_path_gz =3D self.fetch_asset(initrd_url, algorithm=3D'md5',
+                                          asset_hash=3Dinitrd_hash)
+        initrd_path =3D self.workdir + "rootfs.cpio"
+        archive.gzip_uncompress(initrd_path_gz, initrd_path)
+
+        self.vm.set_machine('malta')
+        self.vm.set_console()
+        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'console=3DttyS0 console=3Dtty '
+                               + 'rdinit=3D/sbin/init noreboot')
+        self.vm.add_args('-cpu', '5KEc',
+                         '-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Boot successful.')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'MIPS 5KE')
+        exec_command_and_wait_for_pattern(self, 'uname -a',
+                                                '3.19.3.mtoman.20150408')
+        exec_command_and_wait_for_pattern(self, 'reboot',
+                                                'reboot: Restarting system=
')
+
     def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):
         kernel_path_xz =3D self.fetch_asset(kernel_url, asset_hash=3Dkerne=
l_hash)
         kernel_path =3D self.workdir + "kernel"
--=20
2.21.0


