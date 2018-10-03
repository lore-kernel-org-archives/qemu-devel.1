Received: from eggs.gnu.org ([2001:4830:134:3::10]:34685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7m12-0006nB-Qm
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7lve-0000tE-63
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:31:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7lvc-0000rH-7L
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:31:20 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed,  3 Oct 2018 20:30:36 +0200
Message-Id: <20181003183036.6716-4-philmd@redhat.com>
In-Reply-To: <20181003183036.6716-1-philmd@redhat.com>
References: <20181003183036.6716-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 3/3] acceptance tests: Add EDK2
 ArmVirtQemu boot and console checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

This test boots EDK2 ArmVirtQemu and check the debug console (PL011) repo=
rts enough
information on the initialized devices.

$ avocado run -p qemu_bin=3Daarch64-softmmu/qemu-system-aarch64 tests/acc=
eptance/boot_firmware.py
JOB ID     : cb1c5bd9e0312483eabeffbb37885a5273ef23bf
JOB LOG    : /home/phil/avocado/job-results/job-2018-10-03T19.39-cb1c5bd/=
job.log
 (1/1) tests/acceptance/boot_firmware.py:BootFirmware.test_ovmf_virt: PAS=
S (5.02 s)
RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | =
CANCEL 0
JOB TIME   : 5.30 s

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
The '-p' option requires Avocado >=3D 65.0
---
 tests/acceptance/boot_firmware.py | 36 +++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tests/acceptance/boot_firmware.py b/tests/acceptance/boot_fi=
rmware.py
index 2053b1a4b6..42f0672963 100644
--- a/tests/acceptance/boot_firmware.py
+++ b/tests/acceptance/boot_firmware.py
@@ -121,3 +121,39 @@ class BootFirmware(Test):
                 debugcon_logger.debug(line.strip())
             for exp in expected:
                 self.assertIn(exp + '\r\n', content)
+
+    def test_ovmf_virt(self):
+        """
+        Boots OVMF on the default virt machine, checks the debug console
+
+        :avocado: tags=3Darch:aarch64
+        :avocado: tags=3Dmaxtime:20s
+        """
+        image_url =3D ('http://snapshots.linaro.org/components/kernel/'
+                    'leg-virt-tianocore-edk2-upstream/latest/'
+                    'QEMU-AARCH64/DEBUG_GCC5/QEMU_EFI.img.gz')
+        image_path_gz =3D self.fetch_asset(image_url)
+        image_path =3D os.path.join(self.workdir, 'flash.img')
+
+        # kludge until Avocado support gzip files
+        import gzip, shutil
+        with gzip.open(image_path_gz) as gz, open(image_path, 'wb') as i=
mg:
+            shutil.copyfileobj(gz, img)
+
+        serial_path =3D os.path.join(self.workdir, 'serial.log')
+        self.vm.set_machine('virt')
+        self.vm.add_args('-nographic',
+                         '-cpu', 'cortex-a57',
+                         '-m', '1G', # 1GB min to boot fw?
+                         '-drive', 'file=3D%s,format=3Draw,if=3Dpflash' =
% image_path,
+                         '-chardev', 'file,path=3D%s,id=3Dconsole' % ser=
ial_path,
+                         '-serial', 'chardev:console')
+        self.vm.launch()
+        serial_logger =3D logging.getLogger('serial')
+
+        # serial console checks
+        if not wait_for(read_console_for_string, timeout=3D15, step=3D0,
+                        args=3D(open(serial_path),
+                              'Start PXE over IPv4',
+                              serial_logger)):
+            self.fail("OVMF failed to boot")
--=20
2.17.1
