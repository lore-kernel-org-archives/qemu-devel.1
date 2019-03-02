Received: from eggs.gnu.org ([209.51.188.92]:58195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0CML-0007JG-LO
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 16:39:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0CMK-0000sX-0L
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 16:39:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0CMJ-0000nc-No
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 16:39:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so1469389wrw.0
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 13:39:51 -0800 (PST)
References: <20190221005753.27955-1-crosa@redhat.com>
	<20190221005753.27955-16-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <79cdbc7f-0e8e-d9be-fb15-afd2e94d382c@redhat.com>
Date: Sat, 2 Mar 2019 22:39:47 +0100
MIME-Version: 1.0
In-Reply-To: <20190221005753.27955-16-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 15/20] Boot Linux Console Test: add a
 test for mips64el + malta
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 2/21/19 1:57 AM, Cleber Rosa wrote:
> Similar to the x86_64 + pc test, it boots a Linux kernel on a Malta
> board and verify the serial is working.
> 
> If mips64el is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:mips64el"
> tags.
> 
> Alternatively, this test can be run using:
> 
>     $ avocado run -t arch:mips64el tests/acceptance
>     $ avocado run -t machine:malta tests/acceptance
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  .travis.yml                            |  2 +-
>  tests/acceptance/boot_linux_console.py | 34 ++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 0a5e0613be..0260263bb8 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -198,7 +198,7 @@ matrix:
>  
>      # Acceptance (Functional) tests
>      - env:
> -        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu"
> +        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu"
>          - TEST_CMD="make check-acceptance"
>        addons:
>          apt:
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 05e43360b8..899c27a9ec 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -10,6 +10,7 @@
>  
>  import os
>  import logging
> +import os

One import is enough :P

>  
>  from avocado_qemu import Test
>  from avocado.utils import process
> @@ -103,3 +104,36 @@ class BootLinuxConsole(Test):
>          self.vm.launch()
>          console_pattern = 'Kernel command line: %s' % kernel_command_line
>          self.wait_for_console_pattern(console_pattern)
> +
> +    def test_mips64el_malta(self):
> +        """
> +        This test requires the ar tool to extract "data.tar.gz" from
> +        the Debian package.
> +
> +        The kernel can be rebuilt using this Debian kernel source [1] and
> +        following the instructions on [2].
> +
> +        [1] http://snapshot.debian.org/package/linux-2.6/2.6.32-48/
> +            #linux-source-2.6.32_2.6.32-48
> +        [2] https://kernel-team.pages.debian.net/kernel-handbook/
> +            ch-common-tasks.html#s-common-official
> +
> +        :avocado: tags=arch:mips64el
> +        :avocado: tags=machine:malta
> +        """
> +        deb_url = ('http://snapshot.debian.org/archive/debian/'
> +                   '20130217T032700Z/pool/main/l/linux-2.6/'
> +                   'linux-image-2.6.32-5-5kc-malta_2.6.32-48_mipsel.deb')
> +        deb_hash = '1aaec92083bf22fda31e0d27fa8d9a388e5fc3d5'
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        kernel_path = self.extract_from_deb(deb_path,
> +                                            '/boot/vmlinux-2.6.32-5-5kc-malta')
> +
> +        self.vm.set_machine('malta')
> +        self.vm.set_console()
> +        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        console_pattern = 'Kernel command line: %s' % kernel_command_line
> +        self.wait_for_console_pattern(console_pattern)
> 
