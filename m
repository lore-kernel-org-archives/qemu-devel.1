Received: from eggs.gnu.org ([2001:4830:134:3::10]:54104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLe7-0006Uo-Cs
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLe6-0004Um-6j
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:16:03 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:45980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLe5-0004Tq-UU
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:16:02 -0400
Received: by mail-wr1-x42e.google.com with SMTP id q5-v6so16446547wrw.12
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 08:16:01 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Oct 2018 17:15:45 +0200
Message-Id: <20181013151545.3731-7-f4bug@amsat.org>
In-Reply-To: <20181013151545.3731-1-f4bug@amsat.org>
References: <20181013151545.3731-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v3 6/6] tests/acceptance: Add test_sh4_r2d
 in BootLinuxTracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, Magnus Damm <magnus.damm@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>

Similar to the test_x86_64_pc test, this boots a Linux kernel on a
R2D board (SH4 little-endian) and verify the usb is working by looking
at the usb trace events. Thus this test requires the QEMU binary to be
compiled with:

  $ configure ... --enable-trace-backends=log

This test also requires the dpkg-deb tool (apt/dnf install dpkg) to
extract the kernel from the Debian package.

  $ avocado --show=app,trace run -p arch=sh4 tests/acceptance/boot_linux_console.py
  JOB ID     : dc45be27f5d1edb8289a1ede139e107bbc55b045
  JOB LOG    : /home/phil/avocado/job-results/job-2018-10-13T14.46-dc45be2/job.log
   (1/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc: CANCEL: Currently specific to the x86_64 target arch (0.00 s)
   (2/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mips_4kc_malta: CANCEL: Currently specific to the sh4 target arch (0.00 s)
   (3/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mipsel_5kc_malta: CANCEL: Currently specific to the sh4 target arch (0.00 s)
   (4/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_sh4_r2d: SKIP: console not working on r2d machine
   (5/5) tests/acceptance/boot_linux_console.py:BootLinuxTracing.test_sh4_r2d:  /
  trace: 22770@1539434809.450006:usb_ohci_init_time usb_bit_time=1000000 usb_frame_time=83
  trace: 22770@1539434809.453017:usb_ohci_port_attach port #0
  trace: 22770@1539434809.454827:usb_ohci_reset sysbus-ohci
  trace: 22770@1539434809.454833:usb_ohci_stop sysbus-ohci: USB Suspended
  trace: 22770@1539434809.454835:usb_ohci_stop sysbus-ohci: USB Suspended
  trace: 22770@1539434809.454837:usb_ohci_port_detach port #0
  trace: 22770@1539434809.454839:usb_ohci_port_attach port #0
  trace: 22770@1539434811.588702:usb_ohci_reset sysbus-ohci
  trace: 22770@1539434811.588711:usb_ohci_stop sysbus-ohci: USB Suspended
  trace: 22770@1539434811.589062:usb_ohci_set_ctl sysbus-ohci: new state 0x80
  trace: 22770@1539434811.589067:usb_ohci_start sysbus-ohci: USB Operational
  trace: 22770@1539434811.589253:usb_ohci_hub_power_up powered up all ports
  PASS (2.43 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 3
  JOB TIME   : 2.67 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 64 ++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 8f99cc0d7c..e11993bf98 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -8,11 +8,22 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import os
 import logging
 import subprocess
 
 from avocado import skip
 from avocado_qemu import Test
+from avocado.utils.wait import wait_for
+
+
+def read_stream_for_string(stream, expected_string, logger=None):
+    msg = stream.readline()
+    if len(msg) == 0:
+        return False
+    if logger:
+        logger.debug(msg.strip())
+    return expected_string in msg
 
 
 class BootLinuxConsole(Test):
@@ -185,3 +196,56 @@ class BootLinuxConsole(Test):
                 break
             if 'Kernel panic - not syncing' in msg:
                 self.fail("Kernel panic reached")
+
+class BootLinuxTracing(Test):
+    """
+    Boots a Linux kernel and checks that via the Tracing framework that
+    a specific trace events occured, demostrating the kernel is operational.
+
+    :avocado: enable
+    """
+
+    timeout = 60
+
+    def test_sh4_r2d(self):
+        """
+        This test requires the dpkg-deb tool (apt/dnf install dpkg) to extract
+        the kernel from the Debian package.
+        This test also requires the QEMU binary to be compiled with:
+
+          $ configure ... --enable-trace-backends=log
+
+        The kernel can be rebuilt using this Debian kernel source [1] and
+        following the instructions on [2].
+
+        [1] https://kernel-team.pages.debian.net/kernel-handbook/ch-common-tasks.html#s-common-official
+        [2] http://snapshot.debian.org/package/linux-2.6/2.6.32-30/#linux-source-2.6.32_2.6.32-30
+
+        :avocado: tags=arch:sh4
+        """
+        if self.arch != 'sh4':
+            self.cancel('Currently specific to the %s target arch' % self.arch)
+
+        deb_url = ('http://snapshot.debian.org/archive/'
+                   'debian-ports/20110116T065852Z/pool-sh4/main/l/'
+                   'linux-2.6/linux-image-2.6.32-5-sh7751r_2.6.32-30_sh4.deb')
+        deb_hash = '8025e503319dc8ad786756e3afaa8eb868e9ef59'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        subprocess.check_call(['dpkg-deb', '--extract', deb_path, self.workdir])
+        kernel_path = self.workdir + '/boot/vmlinuz-2.6.32-5-sh7751r'
+        trace_path = os.path.join(self.workdir, 'trace.log')
+        trace_logger = logging.getLogger('trace')
+
+        self.vm.set_arch(self.arch)
+        self.vm.set_machine('r2d')
+        kernel_command_line = 'noiotrap'
+        self.vm.add_args('-trace', "enable=usb_ohci_*,file=" + trace_path,
+                         '-kernel', kernel_path,
+                         '-append', kernel_command_line)
+
+        self.vm.launch()
+        if not wait_for(read_stream_for_string, timeout=15, step=0,
+                        args=(open(trace_path),
+                              'usb_ohci_hub_power_up powered up all ports',
+                              trace_logger)):
+            self.fail("Machine failed to boot")
-- 
2.19.1
