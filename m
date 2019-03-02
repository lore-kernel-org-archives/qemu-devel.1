Received: from eggs.gnu.org ([209.51.188.92]:42465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0B10-0007qx-6g
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 15:13:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0B0z-0000G1-0Z
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 15:13:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0B0y-0000EP-MK
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 15:13:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id w6so1352884wrs.4
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 12:13:44 -0800 (PST)
References: <20190221005753.27955-1-crosa@redhat.com>
	<20190221005753.27955-19-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cbb3cc85-11da-1e17-4ec5-f820444542c2@redhat.com>
Date: Sat, 2 Mar 2019 21:13:40 +0100
MIME-Version: 1.0
In-Reply-To: <20190221005753.27955-19-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 18/20] Boot Linux Console Test: add a
 test for arm + virt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Hi Cleber,

On 2/21/19 1:57 AM, Cleber Rosa wrote:
> Just like the previous tests, boots a Linux kernel on an arm target
> using the virt machine.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Reviewed-by: Caio Carrara <ccarrara@redhat.com>
> ---
>  .travis.yml                            |  2 +-
>  tests/acceptance/boot_linux_console.py | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 60a4bc00b8..f34bd8dc2b 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -198,7 +198,7 @@ matrix:
>  
>      # Acceptance (Functional) tests
>      - env:
> -        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,ppc64-softmmu,aarch64-softmmu"
> +        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,ppc64-softmmu,aarch64-softmmu,arm-softmmu"
>          - TEST_CMD="make check-acceptance"
>        addons:
>          apt:
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 1f2dfa3654..311f6fbb96 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -177,3 +177,23 @@ class BootLinuxConsole(Test):
>          self.vm.launch()
>          console_pattern = 'Kernel command line: %s' % kernel_command_line
>          self.wait_for_console_pattern(console_pattern)
> +
> +    def test_arm_virt(self):
> +        """
> +        :avocado: tags=arch:arm
> +        :avocado: tags=machine:virt
> +        """
> +        kernel_url = ('https://sjc.edge.kernel.org/fedora-buffet/fedora/linux/'
> +                      'releases/29/Server/armhfp/os/images/pxeboot/vmlinuz')
> +        kernel_hash = 'e9826d741b4fb04cadba8d4824d1ed3b7fb8b4d4'
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +
> +        self.vm.set_machine('virt')
> +        self.vm.set_console()
> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'console=ttyAMA0')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        console_pattern = 'Kernel command line: %s' % kernel_command_line
> +        self.wait_for_console_pattern(console_pattern)
> 

This one sometime hangs:

$ make check-acceptance AVOCADO_SHOW=app,console
  AVOCADO tests/acceptance
JOB ID     : 9e363f10363c90882716d6be254f07eb5f355172
JOB LOG    :
/source/qemu/build/gcc/tests/results/job-2019-03-02T21.00-9e363f1/job.log
...
 (06/16)
/source/qemu/tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_virt:
/console: Booting Linux on physical CPU 0x0
console: Linux version 4.18.16-300.fc29.armv7hl
(mockbuild@buildvm-armv7-06.arm.fedoraproject.org) (gcc version 8.2.1
20180801 (Red Hat 8.2.1-2) (GCC)) #1 SMP Sun Oct 21 00:56:28 UTC 2018
console: CPU: ARMv7 Processor [412fc0f1] revision 1 (ARMv7), cr=10c5387d
console: CPU: div instructions available: patching division code
console: CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
console: OF: fdt: Machine model: linux,dummy-virt
console: Memory policy: Data cache writealloc
console: efi: Getting EFI parameters from FDT:
console: efi: UEFI not found.
console: cma: Failed to reserve 64 MiB
console: psci: probing for conduit method from DT.
console: psci: PSCIv0.2 detected in firmware.
console: psci: Using standard PSCI v0.2 function IDs
console: psci: Trusted OS migration not required
console: percpu: Embedded 16 pages/cpu @(ptrval) s34956 r8192 d22388 u65536
console: Built 1 zonelists, mobility grouping on.  Total pages: 32480
console: Kernel command line: printk.time=0 console=ttyAMA0
INTERRUPTED: Runner error occurred: Timeout reached\nOriginal status:
PASS\n{'name':
'06-/source/qemu/tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_virt',
'logdir':
'/source/qemu/build/gcc/tests/results/job-2019-03-02T21.00-df1a431...
(90.60 s)
...
RESULTS    : PASS 9 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 1 |
CANCEL 6
JOB TIME   : 105.35 s
make: *** [/source/qemu/tests/Makefile.include:1116: check-acceptance]
Error 8

$ uname -rom
4.20.11-200.fc29.x86_64 x86_64 GNU/Linux

The string is here, so I wonder if something is wrong in
wait_for_console_pattern().

The debug log isn't helpful:

2019-03-02 21:10:27,062 test             L0602 INFO | START
06-/source/qemu/tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_virt
2019-03-02 21:10:27,062 test             L0298 DEBUG| DATA
(filename=output.expected) => NOT FOUND (data sources: variant, test, file)
2019-03-02 21:10:27,063 parameters       L0146 DEBUG| PARAMS (key=arch,
path=*, default=arm) => 'arm'
2019-03-02 21:10:27,063 parameters       L0146 DEBUG| PARAMS
(key=qemu_bin, path=*, default=arm-softmmu/qemu-system-arm) =>
'arm-softmmu/qemu-system-arm'
2019-03-02 21:10:27,070 qemu             L0323 DEBUG| VM launch command:
'arm-softmmu/qemu-system-arm -chardev
socket,id=mon,path=/var/tmp/tmpv_rh95rv/qemu-25227-monitor.sock -mon
chardev=mon,mode=control -display none -vga none -machine virt -chardev
socket,id=console,path=/var/tmp/tmpv_rh95rv/qemu-25227-console.sock,server,nowait
-serial chardev:console -kernel
/avocado/data/cache/by_location/096923daa6943c0c1287e76b52cdd56a882fef8a/vmlinuz
-append printk.time=0 console=ttyAMA0'
2019-03-02 21:10:27,157 qmp              L0167 DEBUG| >>> {'execute':
'qmp_capabilities'}
2019-03-02 21:10:27,176 qmp              L0175 DEBUG| <<< {'return': {}}
2019-03-02 21:10:28,446 qmp              L0167 DEBUG| >>> {'execute':
'quit'}
2019-03-02 21:11:57,654 qemu             L0363 WARNI| qemu received
signal 9: arm-softmmu/qemu-system-arm -chardev
socket,id=mon,path=/var/tmp/tmpv_rh95rv/qemu-25227-monitor.sock -mon
chardev=mon,mode=control -display none -vga none -machine virt -chardev
socket,id=console,path=/var/tmp/tmpv_rh95rv/qemu-25227-console.sock,server,nowait
-serial chardev:console -kernel
/avocado/data/cache/by_location/096923daa6943c0c1287e76b52cdd56a882fef8a/vmlinuz
-append printk.time=0 console=ttyAMA0
2019-03-02 21:11:57,655 test             L0298 DEBUG| DATA
(filename=output.expected) => NOT FOUND (data sources: variant, test, file)
2019-03-02 21:11:57,655 test             L0298 DEBUG| DATA
(filename=stdout.expected) => NOT FOUND (data sources: variant, test, file)
2019-03-02 21:11:57,655 test             L0298 DEBUG| DATA
(filename=stderr.expected) => NOT FOUND (data sources: variant, test, file)
2019-03-02 21:11:57,682 sysinfo          L0355 DEBUG| Not logging
/var/log/messages (lack of permissions)
2019-03-02 21:11:57,682 test             L1013 INFO | PASS
06-/source/qemu/tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_virt
2019-03-02 21:11:57,682 test             L0996 INFO |
2019-03-02 21:11:57,690 runner           L0061 ERROR| Runner error
occurred: Timeout reached

Regards,

Phil.
