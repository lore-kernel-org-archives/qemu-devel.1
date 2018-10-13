Received: from eggs.gnu.org ([2001:4830:134:3::10]:33967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBMHU-0007U5-QR
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:56:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBMHR-0000ne-II
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:56:44 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBMHR-0000nF-7j
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:56:41 -0400
Received: by mail-wr1-x444.google.com with SMTP id n1-v6so16503860wrt.10
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 08:56:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20181013151545.3731-1-f4bug@amsat.org>
	<20181013151545.3731-6-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ad5c71eb-4860-003a-d23b-a30888525c0b@amsat.org>
Date: Sat, 13 Oct 2018 17:56:37 +0200
MIME-Version: 1.0
In-Reply-To: <20181013151545.3731-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 5/6] tests/acceptance: Add test_sh4_r2d
 in BootLinuxConsole
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, Magnus Damm <magnus.damm@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>

On 10/13/18 5:15 PM, Philippe Mathieu-Daudé wrote:
> Similar to the test_x86_64_pc test, this boots a Linux kernel on a
> R2D board (SH4 little-endian) and verify the serial is working.
> 
> This test requires the dpkg-deb tool (apt/dnf install dpkg) to
> extract the kernel from the Debian package.
> 
> Note, due to a problem with the serial on this machine, this test
> is currently disabled.

Reading [1] "SH7751R has both SCI and SCIF ports. ttySC1 is the second
(SCIF) port." and [2] I could figure the correct kernel arguments and
the -serial argument out.

[1] http://lists.busybox.net/pipermail/buildroot/2011-October/047070.html
[2] http://lists.busybox.net/pipermail/buildroot/2011-October/047070.html

With the following patch:

-- >8 --
@@ -13,5 +13,4 @@ import logging
 import subprocess

-from avocado import skip
 from avocado_qemu import Test
 from avocado.utils.wait import wait_for
@@ -151,5 +150,4 @@ class BootLinuxConsole(Test):
                 self.fail("Kernel panic reached")

-    @skip("console not working on r2d machine")
     def test_sh4_r2d(self):
         """
@@ -182,6 +180,8 @@ class BootLinuxConsole(Test):
         self.vm.set_machine('r2d')
         self.vm.set_console("") # XXX
-        kernel_command_line = 'console=ttyS0 printk.time=0 noiotrap'
-        self.vm.add_args('-serial', "chardev:console",
+        kernel_command_line = 'console=ttySC0 printk.time=0 noiotrap'
+        self.vm.add_args('-serial', 'null',
+                         '-serial', "chardev:console",
+                         '-display', 'none',
                          '-kernel', kernel_path,
                          '-append', kernel_command_line)
---

I finally get:

 (1/4)
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:
CANCEL: Currently specific to the x86_64 target arch (0.00 s)
 (2/4)
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mips_4kc_malta:
CANCEL: Currently specific to the sh4 target arch (0.00 s)
 (3/4)
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mipsel_5kc_malta:
CANCEL: Currently specific to the sh4 target arch (0.00 s)
 (4/4)
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_sh4_r2d: /
console: [    0.000000] Initializing cgroup subsys cpuset
console: [    0.000000] Initializing cgroup subsys cpu
console: [    0.000000] Linux version 2.6.32-5-sh7751r (Debian
2.6.32-30) (ben@decadent.org.uk) (gcc version 4.3.5 (Debian 4.3.5-4) )
#1 Thu Jan 13 08:23:18 UTC 2011
console: [    0.000000] Boot params:
console: [    0.000000] ... MOUNT_ROOT_RDONLY - 00000000
console: [    0.000000] ... RAMDISK_FLAGS     - 00000000
console: [    0.000000] ... ORIG_ROOT_DEV     - 00000000
console: [    0.000000] ... LOADER_TYPE       - 00000000
console: [    0.000000] ... INITRD_START      - 00000000
console: [    0.000000] ... INITRD_SIZE       - 00000000
console: [    0.000000] Booting machvec: RTS7751R2D
console: [    0.000000] Renesas Technology Sales RTS7751R2D support.
console: [    0.000000] FPGA version:1 (revision:0)
console: [    0.000000] Node 0: start_pfn = 0xc000, low = 0x10000
console: [    0.000000] Zone PFN ranges:
console: [    0.000000]   Normal   0x0000c000 -> 0x00010000
console: [    0.000000] Movable zone start PFN for each node
console: [    0.000000] early_node_map[1] active PFN ranges
console: [    0.000000]     0: 0x0000c000 -> 0x00010000
console: [    0.000000] Built 1 zonelists in Zone order, mobility
grouping on.  Total pages: 16256
console: [    0.000000] Kernel command line: console=ttySC0
printk.time=0 noiotrap
PASS (1.92 s)

> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 48 ++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index e4a60297bf..8f99cc0d7c 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -11,6 +11,7 @@
>  import logging
>  import subprocess
>  
> +from avocado import skip
>  from avocado_qemu import Test
>  
>  
> @@ -137,3 +138,50 @@ class BootLinuxConsole(Test):
>                  break
>              if 'Kernel panic - not syncing' in msg:
>                  self.fail("Kernel panic reached")
> +
> +    @skip("console not working on r2d machine")
> +    def test_sh4_r2d(self):
> +        """
> +        This test requires the dpkg-deb tool (apt/dnf install dpkg) to extract
> +        the kernel from the Debian package.
> +        This test also requires the QEMU binary to be compiled with:
> +
> +          $ configure ... --enable-trace-backends=log
> +
> +        The kernel can be rebuilt using this Debian kernel source [1] and
> +        following the instructions on [2].
> +
> +        [1] https://kernel-team.pages.debian.net/kernel-handbook/ch-common-tasks.html#s-common-official
> +        [2] http://snapshot.debian.org/package/linux-2.6/2.6.32-30/#linux-source-2.6.32_2.6.32-30
> +
> +        :avocado: tags=arch:sh4
> +        """
> +        if self.arch != 'sh4':
> +            self.cancel('Currently specific to the %s target arch' % self.arch)
> +
> +        deb_url = ('http://snapshot.debian.org/archive/'
> +                   'debian-ports/20110116T065852Z/pool-sh4/main/l/'
> +                   'linux-2.6/linux-image-2.6.32-5-sh7751r_2.6.32-30_sh4.deb')
> +        deb_hash = '8025e503319dc8ad786756e3afaa8eb868e9ef59'
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        subprocess.check_call(['dpkg-deb', '--extract', deb_path, self.workdir])
> +        kernel_path = self.workdir + '/boot/vmlinuz-2.6.32-5-sh7751r'
> +
> +        self.vm.set_arch(self.arch)
> +        self.vm.set_machine('r2d')
> +        self.vm.set_console("") # XXX
> +        kernel_command_line = 'console=ttyS0 printk.time=0 noiotrap'
> +        self.vm.add_args('-serial', "chardev:console",
> +                         '-kernel', kernel_path,
> +                         '-append', kernel_command_line)
> +
> +        self.vm.launch()
> +        console = self.vm.console_socket.makefile()
> +        console_logger = logging.getLogger('console')
> +        while True:
> +            msg = console.readline()
> +            console_logger.debug(msg.strip())
> +            if 'Kernel command line: %s' % kernel_command_line in msg:
> +                break
> +            if 'Kernel panic - not syncing' in msg:
> +                self.fail("Kernel panic reached")
> 
