Received: from eggs.gnu.org ([209.51.188.92]:53986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gltfy-0002UF-Nv
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:53:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gltfx-0007gq-31
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:53:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gltfw-0007eE-T4
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:53:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so26774245wra.6
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 02:52:59 -0800 (PST)
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-19-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f0426dd5-fd7a-daf0-9c0d-bd48bb36d8a7@redhat.com>
Date: Tue, 22 Jan 2019 11:52:56 +0100
MIME-Version: 1.0
In-Reply-To: <20190117185628.21862-19-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 18/18] Boot Linux Console Test: add a test
 for alpha + clipper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 1/17/19 7:56 PM, Cleber Rosa wrote:
> Similar to the x86_64 + pc test, it boots a Linux kernel on a Malta
> board and verify the serial is working.  One extra command added to
> the QEMU command line is '-vga std', because the kernel used is
> known to crash without it.
> 
> If alpha is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:alpha" tags.
> 
> Alternatively, this test can be run using:
> 
>     $ avocado run -t arch:alpha tests/acceptance
>     $ avocado run -t machine:clipper tests/acceptance
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  .travis.yml                            |  2 +-
>  scripts/qemu.py                        |  1 -
>  tests/acceptance/boot_linux_console.py | 22 ++++++++++++++++++++++
>  3 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 0d5a4b104b..73a113af87 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -187,7 +187,7 @@ matrix:
>  
>      # Acceptance (Functional) tests
>      - env:
> -        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,ppc64-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu"
> +        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,ppc64-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
>          - TEST_CMD="make check-acceptance"
>        addons:
>          apt:
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 1531e28fc1..a704da418a 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -34,7 +34,6 @@ def kvm_available(target_arch=None):
>  
>  #: Maps machine types to the preferred console device types
>  CONSOLE_DEV_TYPES = {
> -    r'^clipper$': 'isa-serial',

Why this change?

>      r'^(pc.*|q35.*|isapc)$': 'isa-serial',
>      r'^(40p|powernv|prep)$': 'isa-serial',
>      r'^s390-ccw-virtio.*': 'sclpconsole',
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index c4d5477d45..a8028a39d4 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -197,3 +197,25 @@ class BootLinuxConsole(Test):
>          self.vm.launch()
>          console_pattern = 'Kernel command line: %s' % kernel_command_line
>          self.wait_for_console_pattern(console_pattern)
> +
> +    def test_alpha_clipper(self):
> +        """
> +        :avocado: tags=arch:alpha
> +        :avocado: tags=machine:clipper
> +        """
> +        kernel_url = ('http://archive.debian.org/debian/dists/lenny/main/'
> +                      'installer-alpha/current/images/cdrom/vmlinuz')
> +        kernel_hash = '3a943149335529e2ed3e74d0d787b85fb5671ba3'
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +
> +        uncompressed_kernel = archive.uncompress(kernel_path, self.workdir)
> +
> +        self.vm.set_machine('clipper')
> +        self.vm.set_console()
> +        kernel_command_line = 'console=ttyS0 printk.time=0'
> +        self.vm.add_args('-vga', 'std',
> +                         '-kernel', uncompressed_kernel,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        console_pattern = 'Kernel command line: %s' % kernel_command_line
> +        self.wait_for_console_pattern(console_pattern)
> 
