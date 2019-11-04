Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2C3CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 15:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7417120663
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 15:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0BR262F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7417120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRe7g-00072h-7j
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 10:18:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iRe3D-0002ck-HC
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:13:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iRe3A-0002dr-HW
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:13:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32874
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iRe3A-0002db-DJ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572880428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U1KgXQKbwr7ucEwjAJxhI3h/QxWjnNGb1JhqtU35VJM=;
 b=J0BR262FIrzNaqUH13OP6LiSZPSzrv266FQc1+O3keyk8kkjzPY+vx4nGozs2QKS3TIZt5
 StEBKv7b6kJdX328QFp3PDvs2VlWiygFJRx5DVExFKW5IoPvJRFMXxFxRX1O6TRVhxSIg+
 hzJnSqK93TDlyupa+p3naUnmkT+ImJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-rCGuzjkKNqKib9gMMvkQVw-1; Mon, 04 Nov 2019 10:13:44 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A360C2AD;
 Mon,  4 Nov 2019 15:13:42 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D1A695D6C5;
 Mon,  4 Nov 2019 15:13:40 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 3/8] Acceptance tests: use avocado tags for machine type
Date: Mon,  4 Nov 2019 10:13:18 -0500
Message-Id: <20191104151323.9883-4-crosa@redhat.com>
In-Reply-To: <20191104151323.9883-1-crosa@redhat.com>
References: <20191104151323.9883-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: rCGuzjkKNqKib9gMMvkQVw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Beraldo Leal <bleal@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The same way the arch tag is being used as a fallback for the arch
parameter, let's do the same for QEMU's machine and avoid some boiler
plate code.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 docs/devel/testing.rst                     | 18 ++++++++
 tests/acceptance/avocado_qemu/__init__.py  |  5 ++
 tests/acceptance/boot_linux_console.py     | 19 +-------
 tests/acceptance/cpu_queries.py            |  2 +-
 tests/acceptance/linux_initrd.py           |  2 +-
 tests/acceptance/linux_ssh_mips_malta.py   |  5 --
 tests/acceptance/machine_m68k_nextcube.py  | 21 ++-------
 tests/acceptance/machine_sparc_leon3.py    |  3 +-
 tests/acceptance/ppc_prep_40p.py           |  3 --
 tests/acceptance/x86_cpu_model_versions.py | 53 ++++++++++++++++------
 10 files changed, 72 insertions(+), 59 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 8e981e062d..27f286858a 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -746,6 +746,17 @@ name.  If one is not given explicitly, it will either =
be set to
 ``None``, or, if the test is tagged with one (and only one)
 ``:avocado: tags=3Darch:VALUE`` tag, it will be set to ``VALUE``.
=20
+machine
+~~~~~~~
+
+The machine type that will be set to all QEMUMachine instances created
+by the test.
+
+The ``machine`` attribute will be set to the test parameter of the same
+name.  If one is not given explicitly, it will either be set to
+``None``, or, if the test is tagged with one (and only one)
+``:avocado: tags=3Dmachine:VALUE`` tag, it will be set to ``VALUE``.
+
 qemu_bin
 ~~~~~~~~
=20
@@ -781,6 +792,13 @@ architecture of a kernel or disk image to boot a VM wi=
th.
 This parameter has a direct relation with the ``arch`` attribute.  If
 not given, it will default to None.
=20
+machine
+~~~~~~~
+
+The machine type that will be set to all QEMUMachine instances created
+by the test.
+
+
 qemu_bin
 ~~~~~~~~
=20
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/a=
vocado_qemu/__init__.py
index e676d9c4e7..6618ea67c1 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -115,6 +115,9 @@ class Test(avocado.Test):
         self.arch =3D self.params.get('arch',
                                     default=3Dself._get_unique_tag_val('ar=
ch'))
=20
+        self.machine =3D self.params.get('machine',
+                                       default=3Dself._get_unique_tag_val(=
'machine'))
+
         default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
         self.qemu_bin =3D self.params.get('qemu_bin',
                                         default=3Ddefault_qemu_bin)
@@ -136,6 +139,8 @@ class Test(avocado.Test):
             name =3D str(uuid.uuid4())
         if self._vms.get(name) is None:
             self._vms[name] =3D self._new_vm(*args)
+            if self.machine is not None:
+                self._vms[name].set_machine(self.machine)
         return self._vms[name]
=20
     def tearDown(self):
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index 7e41cebd47..6732cc59ca 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -62,7 +62,6 @@ class BootLinuxConsole(Test):
         kernel_hash =3D '23bebd2680757891cf7adedb033532163a792495'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel_h=
ash)
=20
-        self.vm.set_machine('pc')
         self.vm.set_console()
         kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'console=
=3DttyS0'
         self.vm.add_args('-kernel', kernel_path,
@@ -85,7 +84,6 @@ class BootLinuxConsole(Test):
         kernel_path =3D self.extract_from_deb(deb_path,
                                             '/boot/vmlinux-2.6.32-5-4kc-ma=
lta')
=20
-        self.vm.set_machine('malta')
         self.vm.set_console()
         kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'console=
=3DttyS0'
         self.vm.add_args('-kernel', kernel_path,
@@ -118,7 +116,6 @@ class BootLinuxConsole(Test):
         kernel_path =3D self.extract_from_deb(deb_path,
                                             '/boot/vmlinux-2.6.32-5-5kc-ma=
lta')
=20
-        self.vm.set_machine('malta')
         self.vm.set_console()
         kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'console=
=3DttyS0'
         self.vm.add_args('-kernel', kernel_path,
@@ -148,7 +145,6 @@ class BootLinuxConsole(Test):
         initrd_path =3D self.workdir + "rootfs.cpio"
         archive.gzip_uncompress(initrd_path_gz, initrd_path)
=20
-        self.vm.set_machine('malta')
         self.vm.set_console()
         kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE
                                + 'console=3DttyS0 console=3Dtty '
@@ -188,7 +184,6 @@ class BootLinuxConsole(Test):
         initrd_path =3D self.workdir + "rootfs.cpio"
         archive.gzip_uncompress(initrd_path_gz, initrd_path)
=20
-        self.vm.set_machine('malta')
         self.vm.set_console()
         kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE
                                + 'console=3DttyS0 console=3Dtty '
@@ -215,7 +210,6 @@ class BootLinuxConsole(Test):
             with open(kernel_path, 'wb') as f_out:
                 shutil.copyfileobj(f_in, f_out)
=20
-        self.vm.set_machine('malta')
         self.vm.set_console()
         kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE
                                + 'mem=3D256m@@0x0 '
@@ -275,7 +269,6 @@ class BootLinuxConsole(Test):
         kernel_hash =3D '8c73e469fc6ea06a58dc83a628fc695b693b8493'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel_h=
ash)
=20
-        self.vm.set_machine('virt')
         self.vm.set_console()
         kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=3DttyAMA0')
@@ -297,7 +290,6 @@ class BootLinuxConsole(Test):
         kernel_hash =3D 'e9826d741b4fb04cadba8d4824d1ed3b7fb8b4d4'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel_h=
ash)
=20
-        self.vm.set_machine('virt')
         self.vm.set_console()
         kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=3DttyAMA0')
@@ -310,7 +302,7 @@ class BootLinuxConsole(Test):
     def test_arm_emcraft_sf2(self):
         """
         :avocado: tags=3Darch:arm
-        :avocado: tags=3Dmachine:emcraft_sf2
+        :avocado: tags=3Dmachine:emcraft-sf2
         :avocado: tags=3Dendian:little
         """
         uboot_url =3D ('https://raw.githubusercontent.com/'
@@ -324,7 +316,6 @@ class BootLinuxConsole(Test):
         spi_hash =3D '85f698329d38de63aea6e884a86fbde70890a78a'
         spi_path =3D self.fetch_asset(spi_url, asset_hash=3Dspi_hash)
=20
-        self.vm.set_machine('emcraft-sf2')
         self.vm.set_console()
         kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE
         self.vm.add_args('-kernel', uboot_path,
@@ -351,7 +342,6 @@ class BootLinuxConsole(Test):
         kernel_path =3D self.extract_from_deb(deb_path, '/boot/kernel7.img=
')
         dtb_path =3D self.extract_from_deb(deb_path, '/boot/bcm2709-rpi-2-=
b.dtb')
=20
-        self.vm.set_machine('raspi2')
         self.vm.set_console()
         kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
                                serial_kernel_cmdline[uart_id])
@@ -393,7 +383,6 @@ class BootLinuxConsole(Test):
         initrd_path =3D os.path.join(self.workdir, 'rootfs.cpio')
         archive.gzip_uncompress(initrd_path_gz, initrd_path)
=20
-        self.vm.set_machine('smdkc210')
         self.vm.set_console()
         kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
                                'earlycon=3Dexynos4210,0x13800000 earlyprin=
tk ' +
@@ -414,7 +403,7 @@ class BootLinuxConsole(Test):
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=3Darch:s390x
-        :avocado: tags=3Dmachine:s390_ccw_virtio
+        :avocado: tags=3Dmachine:s390-ccw-virtio
         """
         kernel_url =3D ('https://archives.fedoraproject.org/pub/archive'
                       '/fedora-secondary/releases/29/Everything/s390x/os/i=
mages'
@@ -422,7 +411,6 @@ class BootLinuxConsole(Test):
         kernel_hash =3D 'e8e8439103ef8053418ef062644ffd46a7919313'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel_h=
ash)
=20
-        self.vm.set_machine('s390-ccw-virtio')
         self.vm.set_console()
         kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'console=
=3Dsclp0'
         self.vm.add_args('-nodefaults',
@@ -444,7 +432,6 @@ class BootLinuxConsole(Test):
=20
         uncompressed_kernel =3D archive.uncompress(kernel_path, self.workd=
ir)
=20
-        self.vm.set_machine('clipper')
         self.vm.set_console()
         kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'console=
=3DttyS0'
         self.vm.add_args('-vga', 'std',
@@ -465,7 +452,6 @@ class BootLinuxConsole(Test):
         kernel_hash =3D '3fe04abfc852b66653b8c3c897a59a689270bc77'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel_h=
ash)
=20
-        self.vm.set_machine('pseries')
         self.vm.set_console()
         kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'console=
=3Dhvc0'
         self.vm.add_args('-kernel', kernel_path,
@@ -489,7 +475,6 @@ class BootLinuxConsole(Test):
         kernel_path =3D self.extract_from_deb(deb_path,
                                             '/boot/vmlinux-5.3.0-1-m68k')
=20
-        self.vm.set_machine('q800')
         self.vm.set_console()
         kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=3DttyS0 vga=3Doff')
diff --git a/tests/acceptance/cpu_queries.py b/tests/acceptance/cpu_queries=
.py
index af47d2795a..293dccb89a 100644
--- a/tests/acceptance/cpu_queries.py
+++ b/tests/acceptance/cpu_queries.py
@@ -20,8 +20,8 @@ class QueryCPUModelExpansion(Test):
     def test(self):
         """
         :avocado: tags=3Darch:x86_64
+        :avocado: tags=3Dmachine:none
         """
-        self.vm.set_machine('none')
         self.vm.add_args('-S')
         self.vm.launch()
=20
diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_init=
rd.py
index c61d9826a4..3a0ff7b098 100644
--- a/tests/acceptance/linux_initrd.py
+++ b/tests/acceptance/linux_initrd.py
@@ -20,6 +20,7 @@ class LinuxInitrd(Test):
     Checks QEMU evaluates correctly the initrd file passed as -initrd opti=
on.
=20
     :avocado: tags=3Darch:x86_64
+    :avocado: tags=3Dmachine:pc
     """
=20
     timeout =3D 300
@@ -66,7 +67,6 @@ class LinuxInitrd(Test):
             initrd.write(b'\0')
             initrd.flush()
=20
-            self.vm.set_machine('pc')
             self.vm.set_console()
             kernel_command_line =3D 'console=3DttyS0'
             self.vm.add_args('-kernel', kernel_path,
diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/li=
nux_ssh_mips_malta.py
index fc13f9e4d4..1d570deb00 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -111,7 +111,6 @@ class LinuxSSH(Test):
         image_url, image_hash =3D self.get_image_info(endianess)
         image_path =3D self.fetch_asset(image_url, asset_hash=3Dimage_hash=
)
=20
-        self.vm.set_machine('malta')
         self.vm.set_console()
         kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE
                                + 'console=3DttyS0 root=3D/dev/sda1')
@@ -215,7 +214,6 @@ class LinuxSSH(Test):
     def test_mips_malta32eb_kernel3_2_0(self):
         """
         :avocado: tags=3Darch:mips
-        :avocado: tags=3Dmachine:malta
         :avocado: tags=3Dendian:big
         :avocado: tags=3Ddevice:pcnet32
         """
@@ -224,7 +222,6 @@ class LinuxSSH(Test):
     def test_mips_malta32el_kernel3_2_0(self):
         """
         :avocado: tags=3Darch:mipsel
-        :avocado: tags=3Dmachine:malta
         :avocado: tags=3Dendian:little
         :avocado: tags=3Ddevice:pcnet32
         """
@@ -233,7 +230,6 @@ class LinuxSSH(Test):
     def test_mips_malta64eb_kernel3_2_0(self):
         """
         :avocado: tags=3Darch:mips64
-        :avocado: tags=3Dmachine:malta
         :avocado: tags=3Dendian:big
         :avocado: tags=3Ddevice:pcnet32
         """
@@ -242,7 +238,6 @@ class LinuxSSH(Test):
     def test_mips_malta64el_kernel3_2_0(self):
         """
         :avocado: tags=3Darch:mips64el
-        :avocado: tags=3Dmachine:malta
         :avocado: tags=3Dendian:little
         :avocado: tags=3Ddevice:pcnet32
         """
diff --git a/tests/acceptance/machine_m68k_nextcube.py b/tests/acceptance/m=
achine_m68k_nextcube.py
index fcd2c58ee7..32cf571f94 100644
--- a/tests/acceptance/machine_m68k_nextcube.py
+++ b/tests/acceptance/machine_m68k_nextcube.py
@@ -43,6 +43,11 @@ def tesseract_available(expected_version):
=20
=20
 class NextCubeMachine(Test):
+    """
+    :avocado: tags=3Darch:m68k
+    :avocado: tags=3Dmachine:next-cube
+    :avocado: tags=3Ddevice:framebuffer
+    """
=20
     timeout =3D 15
=20
@@ -52,7 +57,6 @@ class NextCubeMachine(Test):
         rom_hash =3D 'b3534796abae238a0111299fc406a9349f7fee24'
         rom_path =3D self.fetch_asset(rom_url, asset_hash=3Drom_hash)
=20
-        self.vm.set_machine('next-cube')
         self.vm.add_args('-bios', rom_path)
         self.vm.launch()
=20
@@ -66,11 +70,6 @@ class NextCubeMachine(Test):
=20
     @skipUnless(PIL_AVAILABLE, 'Python PIL not installed')
     def test_bootrom_framebuffer_size(self):
-        """
-        :avocado: tags=3Darch:m68k
-        :avocado: tags=3Dmachine:next_cube
-        :avocado: tags=3Ddevice:framebuffer
-        """
         screenshot_path =3D os.path.join(self.workdir, "dump.png")
         self.check_bootrom_framebuffer(screenshot_path)
=20
@@ -80,11 +79,6 @@ class NextCubeMachine(Test):
=20
     @skipUnless(tesseract_available(3), 'tesseract v3 OCR tool not availab=
le')
     def test_bootrom_framebuffer_ocr_with_tesseract_v3(self):
-        """
-        :avocado: tags=3Darch:m68k
-        :avocado: tags=3Dmachine:next_cube
-        :avocado: tags=3Ddevice:framebuffer
-        """
         screenshot_path =3D os.path.join(self.workdir, "dump.png")
         self.check_bootrom_framebuffer(screenshot_path)
=20
@@ -101,11 +95,6 @@ class NextCubeMachine(Test):
     # that it is still alpha-level software.
     @skipUnless(tesseract_available(4), 'tesseract v4 OCR tool not availab=
le')
     def test_bootrom_framebuffer_ocr_with_tesseract_v4(self):
-        """
-        :avocado: tags=3Darch:m68k
-        :avocado: tags=3Dmachine:next_cube
-        :avocado: tags=3Ddevice:framebuffer
-        """
         screenshot_path =3D os.path.join(self.workdir, "dump.png")
         self.check_bootrom_framebuffer(screenshot_path)
=20
diff --git a/tests/acceptance/machine_sparc_leon3.py b/tests/acceptance/mac=
hine_sparc_leon3.py
index 298f1e25e6..f77e210ccb 100644
--- a/tests/acceptance/machine_sparc_leon3.py
+++ b/tests/acceptance/machine_sparc_leon3.py
@@ -16,7 +16,7 @@ class Leon3Machine(Test):
     def test_leon3_helenos_uimage(self):
         """
         :avocado: tags=3Darch:sparc
-        :avocado: tags=3Dmachine:leon3
+        :avocado: tags=3Dmachine:leon3_generic
         :avocado: tags=3Dbinfmt:uimage
         """
         kernel_url =3D ('http://www.helenos.org/releases/'
@@ -24,7 +24,6 @@ class Leon3Machine(Test):
         kernel_hash =3D 'a88c9cfdb8430c66650e5290a08765f9bf049a30'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel_h=
ash)
=20
-        self.vm.set_machine('leon3_generic')
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_path)
=20
diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_4=
0p.py
index 6f507fb0a6..b27572f212 100644
--- a/tests/acceptance/ppc_prep_40p.py
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -39,7 +39,6 @@ class IbmPrep40pMachine(Test):
         drive_hash =3D 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
         drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddrive_hash=
)
=20
-        self.vm.set_machine('40p')
         self.vm.set_console()
         self.vm.add_args('-bios', bios_path,
                          '-fda', drive_path)
@@ -53,7 +52,6 @@ class IbmPrep40pMachine(Test):
         :avocado: tags=3Darch:ppc
         :avocado: tags=3Dmachine:40p
         """
-        self.vm.set_machine('40p')
         self.vm.set_console()
         self.vm.add_args('-m', '192') # test fw_cfg
=20
@@ -73,7 +71,6 @@ class IbmPrep40pMachine(Test):
         drive_hash =3D 'ac6fa2707d888b36d6fa64de6e7fe48e'
         drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddrive_hash=
,
                                       algorithm=3D'md5')
-        self.vm.set_machine('40p')
         self.vm.set_console()
         self.vm.add_args('-cdrom', drive_path,
                          '-boot', 'd')
diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptance/=
x86_cpu_model_versions.py
index 6eb977954d..90558d9a71 100644
--- a/tests/acceptance/x86_cpu_model_versions.py
+++ b/tests/acceptance/x86_cpu_model_versions.py
@@ -75,12 +75,15 @@ class X86CPUModelAliases(avocado_qemu.Test):
                          "EPYC-IBPB shouldn't be versioned")
=20
     def test_4_0_alias_compatibility(self):
-        """Check if pc-*-4.0 unversioned CPU model won't be reported as al=
iases"""
+        """
+        Check if pc-*-4.0 unversioned CPU model won't be reported as alias=
es
+
+        :avocado: tags=3Dmachine:pc-i440fx-4.0
+        """
         # pc-*-4.0 won't expose non-versioned CPU models as aliases
         # We do this to help management software to keep compatibility
         # with older QEMU versions that didn't have the versioned CPU mode=
l
         self.vm.add_args('-S')
-        self.vm.set_machine('pc-i440fx-4.0')
         self.vm.launch()
         cpus =3D dict((m['name'], m) for m in self.vm.command('query-cpu-d=
efinitions'))
=20
@@ -105,9 +108,12 @@ class X86CPUModelAliases(avocado_qemu.Test):
             self.assertNotIn('alias-of', c, "%s shouldn't be an alias" % (=
name))
=20
     def test_4_1_alias(self):
-        """Check if unversioned CPU model is an alias pointing to right ve=
rsion"""
+        """
+        Check if unversioned CPU model is an alias pointing to right versi=
on
+
+        :avocado: tags=3Dmachine:pc-i440fx-4.1
+        """
         self.vm.add_args('-S')
-        self.vm.set_machine('pc-i440fx-4.1')
         self.vm.launch()
=20
         cpus =3D dict((m['name'], m) for m in self.vm.command('query-cpu-d=
efinitions'))
@@ -207,9 +213,12 @@ class X86CPUModelAliases(avocado_qemu.Test):
         self.validate_aliases(cpus)
=20
     def test_none_alias(self):
-        """Check if unversioned CPU model is an alias pointing to some ver=
sion"""
+        """
+        Check if unversioned CPU model is an alias pointing to some versio=
n
+
+        :avocado: tags=3Dmachine:none
+        """
         self.vm.add_args('-S')
-        self.vm.set_machine('none')
         self.vm.launch()
=20
         cpus =3D dict((m['name'], m) for m in self.vm.command('query-cpu-d=
efinitions'))
@@ -242,68 +251,84 @@ class CascadelakeArchCapabilities(avocado_qemu.Test):
         return self.vm.command('qom-get', path=3Dcpu_path, property=3Dprop=
)
=20
     def test_4_1(self):
+        """
+        :avocado: tags=3Dmachine:pc-i440fx-4.1
+        """
         # machine-type only:
         self.vm.add_args('-S')
-        self.vm.set_machine('pc-i440fx-4.1')
         self.vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don=
,check=3Doff,enforce=3Doff')
         self.vm.launch()
         self.assertFalse(self.get_cpu_prop('arch-capabilities'),
                          'pc-i440fx-4.1 + Cascadelake-Server should not ha=
ve arch-capabilities')
=20
     def test_4_0(self):
+        """
+        :avocado: tags=3Dmachine:pc-i440fx-4.0
+        """
         self.vm.add_args('-S')
-        self.vm.set_machine('pc-i440fx-4.0')
         self.vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don=
,check=3Doff,enforce=3Doff')
         self.vm.launch()
         self.assertFalse(self.get_cpu_prop('arch-capabilities'),
                          'pc-i440fx-4.0 + Cascadelake-Server should not ha=
ve arch-capabilities')
=20
     def test_set_4_0(self):
+        """
+        :avocado: tags=3Dmachine:pc-i440fx-4.0
+        """
         # command line must override machine-type if CPU model is not vers=
ioned:
         self.vm.add_args('-S')
-        self.vm.set_machine('pc-i440fx-4.0')
         self.vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don=
,check=3Doff,enforce=3Doff,+arch-capabilities')
         self.vm.launch()
         self.assertTrue(self.get_cpu_prop('arch-capabilities'),
                         'pc-i440fx-4.0 + Cascadelake-Server,+arch-capabili=
ties should have arch-capabilities')
=20
     def test_unset_4_1(self):
+        """
+        :avocado: tags=3Dmachine:pc-i440fx-4.1
+        """
         self.vm.add_args('-S')
-        self.vm.set_machine('pc-i440fx-4.1')
         self.vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don=
,check=3Doff,enforce=3Doff,-arch-capabilities')
         self.vm.launch()
         self.assertFalse(self.get_cpu_prop('arch-capabilities'),
                          'pc-i440fx-4.1 + Cascadelake-Server,-arch-capabil=
ities should not have arch-capabilities')
=20
     def test_v1_4_0(self):
+        """
+        :avocado: tags=3Dmachine:pc-i440fx-4.0
+        """
         # versioned CPU model overrides machine-type:
         self.vm.add_args('-S')
-        self.vm.set_machine('pc-i440fx-4.0')
         self.vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-features=
=3Don,check=3Doff,enforce=3Doff')
         self.vm.launch()
         self.assertFalse(self.get_cpu_prop('arch-capabilities'),
                          'pc-i440fx-4.0 + Cascadelake-Server-v1 should not=
 have arch-capabilities')
=20
     def test_v2_4_0(self):
+        """
+        :avocado: tags=3Dmachine:pc-i440fx-4.0
+        """
         self.vm.add_args('-S')
-        self.vm.set_machine('pc-i440fx-4.0')
         self.vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=
=3Don,check=3Doff,enforce=3Doff')
         self.vm.launch()
         self.assertTrue(self.get_cpu_prop('arch-capabilities'),
                         'pc-i440fx-4.0 + Cascadelake-Server-v2 should have=
 arch-capabilities')
=20
     def test_v1_set_4_0(self):
+        """
+        :avocado: tags=3Dmachine:pc-i440fx-4.0
+        """
         # command line must override machine-type and versioned CPU model:
         self.vm.add_args('-S')
-        self.vm.set_machine('pc-i440fx-4.0')
         self.vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-features=
=3Don,check=3Doff,enforce=3Doff,+arch-capabilities')
         self.vm.launch()
         self.assertTrue(self.get_cpu_prop('arch-capabilities'),
                         'pc-i440fx-4.0 + Cascadelake-Server-v1,+arch-capab=
ilities should have arch-capabilities')
=20
     def test_v2_unset_4_1(self):
+        """
+        :avocado: tags=3Dmachine:pc-i440fx-4.1
+        """
         self.vm.add_args('-S')
-        self.vm.set_machine('pc-i440fx-4.1')
         self.vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=
=3Don,check=3Doff,enforce=3Doff,-arch-capabilities')
         self.vm.launch()
         self.assertFalse(self.get_cpu_prop('arch-capabilities'),
--=20
2.21.0


