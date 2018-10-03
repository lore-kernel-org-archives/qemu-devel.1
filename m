Received: from eggs.gnu.org ([2001:4830:134:3::10]:34285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7m12-0006eL-7q
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7lvg-0000tx-4b
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:31:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7lve-0000mU-7K
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:31:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B53E85550
	for <qemu-devel@nongnu.org>; Wed,  3 Oct 2018 18:31:04 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed,  3 Oct 2018 20:30:35 +0200
Message-Id: <20181003183036.6716-3-philmd@redhat.com>
In-Reply-To: <20181003183036.6716-1-philmd@redhat.com>
References: <20181003183036.6716-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 2/3] acceptance tests: Add EDK2 OVMF
 boot and debug console checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Laszlo Ersek <lersek@redhat.com>

This test boots OVMF and check the debug console (I/O port on the ISA bus=
)
report enough information on the initialized devices.

$ avocado --show=3Dapp,debugcon run tests/acceptance/boot_firmware.py
 (1/1) tests/acceptance/boot_firmware.py:BootFirmware.test_ovmf_pc:
debugcon: SecCoreStartupWithStack(0xFFFCC000, 0x820000)
debugcon: SEC: Normal boot
...
debugcon: [Bds]Booting EFI Internal Shell
PASS (5.27 s)
JOB TIME   : 5.60 s

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/boot_firmware.py | 49 +++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tests/acceptance/boot_firmware.py b/tests/acceptance/boot_fi=
rmware.py
index 669e4849f6..2053b1a4b6 100644
--- a/tests/acceptance/boot_firmware.py
+++ b/tests/acceptance/boot_firmware.py
@@ -72,3 +72,52 @@ class BootFirmware(Test):
                 debugcon_logger.debug(line.strip())
             for exp in expected:
                 self.assertIn(exp + '\n', content)
+
+    def test_ovmf_pc(self):
+        """
+        Boots OVMF on the default PC machine, checks the debug console
+
+        :avocado: tags=3Darch:x86_64
+        :avocado: tags=3Dmaxtime:10s
+        """
+        debugcon_path =3D os.path.join(self.workdir, 'debugconsole.log')
+        serial_logger =3D logging.getLogger('serial')
+        debugcon_logger =3D logging.getLogger('debugcon')
+
+        self.vm.set_machine('pc')
+        self.vm.set_console()
+        self.vm.add_args('-nographic',
+                         '-net', 'none',
+                         '-global', 'isa-debugcon.iobase=3D0x402',
+                         '-debugcon', 'file:%s' % debugcon_path,
+                         '--bios', '/usr/share/OVMF/OVMF_CODE.fd')
+        self.vm.launch()
+        console =3D self.vm.console_socket.makefile()
+
+        # serial console checks
+        if not wait_for(read_console_for_string, timeout=3D10, step=3D0,
+                        args=3D(console, 'EDK II', serial_logger)):
+            self.fail("OVMF failed to boot")
+
+        # debug console checks
+        expected =3D [
+            'SEC: Normal boot',
+            'S3 support was detected on QEMU',
+            'Platform PEI Firmware Volume Initialization',
+            'DXE IPL Entry',
+            'Installing FVB for EMU Variable support',
+            'SmbiosCreateTable: Initialize 32-bit entry point structure'=
,
+            'PlatformBootManagerBeforeConsole',
+            'OnRootBridgesConnected: root bridges have been connected, '
+                'installing ACPI tables',
+            'Found LPC Bridge device',
+            'PlatformBootManagerAfterConsole',
+            'EfiBootManagerConnectAll',
+            '[Bds]Booting EFI Internal Shell',
+        ]
+        with open(debugcon_path) as debugcon:
+            content =3D debugcon.readlines()
+            for line in content: # TODO use FDDrainer
+                debugcon_logger.debug(line.strip())
+            for exp in expected:
+                self.assertIn(exp + '\r\n', content)
--=20
2.17.1
