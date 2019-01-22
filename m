Received: from eggs.gnu.org ([209.51.188.92]:42939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glt6u-0004OE-UO
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glt6s-00027c-TV
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:16:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glt6s-00022l-Li
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:16:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so26641532wrp.3
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 02:16:35 -0800 (PST)
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-13-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f53472e7-84a6-894f-6694-8729bdc1b284@redhat.com>
Date: Tue, 22 Jan 2019 11:16:32 +0100
MIME-Version: 1.0
In-Reply-To: <20190117185628.21862-13-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 12/18] Boot Linux Console Test: add a test
 for mips + malta
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

Hi Cleber,

On 1/17/19 7:56 PM, Cleber Rosa wrote:
> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Similar to the x86_64 + pc test, it boots a Linux kernel on a Malta
> board and verify the serial is working.  Also, it relies on the serial
> device set by the machine itself.
> 
> If mips is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:mips" tags.
> 
> Alternatively, this test can be run using:
> 
>     $ avocado run -t arch:mips tests/acceptance
>     $ avocado run -t machine:malta tests/acceptance
>     $ avocado run -t endian:big tests/acceptance
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  .travis.yml                            |  2 +-
>  scripts/qemu.py                        |  1 -
>  tests/acceptance/boot_linux_console.py | 20 ++++++++++++++++++++
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 844d514afa..49f9016e6a 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -187,7 +187,7 @@ matrix:
>  
>      # Acceptance (Functional) tests
>      - env:
> -        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu"
> +        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu"
>          - TEST_CMD="make check-acceptance"
>        addons:
>          apt:
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 88e1608b42..ef84b0f843 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -35,7 +35,6 @@ def kvm_available(target_arch=None):
>  #: Maps machine types to the preferred console device types
>  CONSOLE_DEV_TYPES = {
>      r'^clipper$': 'isa-serial',
> -    r'^malta': 'isa-serial',
>      r'^(pc.*|q35.*|isapc)$': 'isa-serial',
>      r'^(40p|powernv|prep)$': 'isa-serial',
>      r'^pseries.*': 'spapr-vty',
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 278bb2be3d..0678ec91d2 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -60,3 +60,23 @@ class BootLinuxConsole(Test):
>          self.vm.launch()
>          console_pattern = 'Kernel command line: %s' % kernel_command_line
>          self.wait_for_console_pattern(console_pattern)
> +
> +    def test_mips_malta(self):
> +        """
> +        :avocado: tags=arch:mips
> +        :avocado: tags=machine:malta
> +        :avocado: tags=endian:big
> +        """
> +        kernel_url = ('http://people.debian.org/~aurel32/qemu/mips/'
> +                      'vmlinux-3.2.0-4-4kc-malta')
> +        kernel_hash = '592e384a4edc16dade52a6cd5c785c637bcbc9ad'
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)

Alex was concerned about using this "not-so-easily-reproducible" binary:
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08441.html

So I sent another patch using a reproducible one, which you reviewed:
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02747.html

Do you mind base this series on it?

Thanks,

Phil.

> +
> +        self.vm.set_machine('malta')
> +        self.vm.set_console()
> +        kernel_command_line = 'console=ttyS0 printk.time=0'
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        console_pattern = 'Kernel command line: %s' % kernel_command_line
> +        self.wait_for_console_pattern(console_pattern)
> 
