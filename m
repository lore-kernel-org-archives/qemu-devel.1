Received: from eggs.gnu.org ([209.51.188.92]:59216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0CR4-0001iz-1z
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 16:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0CR2-0005d5-0s
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 16:44:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0CR1-0005ZZ-P9
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 16:44:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id w2so1452630wrt.11
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 13:44:43 -0800 (PST)
References: <20190221005753.27955-1-crosa@redhat.com>
	<20190221005753.27955-15-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <110a1e39-22de-5071-5061-e08b402fb5d3@redhat.com>
Date: Sat, 2 Mar 2019 22:44:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190221005753.27955-15-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 14/20] Boot Linux Console Test: add a
 test for mips + malta
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
>  tests/acceptance/boot_linux_console.py | 41 ++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 42971484ab..0a5e0613be 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -198,7 +198,7 @@ matrix:
>  
>      # Acceptance (Functional) tests
>      - env:
> -        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu"
> +        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu"
>          - TEST_CMD="make check-acceptance"
>        addons:
>          apt:
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index e2ef43e7ce..05e43360b8 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -8,9 +8,12 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>  
> +import os
>  import logging
>  
>  from avocado_qemu import Test
> +from avocado.utils import process
> +from avocado.utils import archive
>  
>  
>  class BootLinuxConsole(Test):
> @@ -44,6 +47,21 @@ class BootLinuxConsole(Test):
>                  fail = 'Failure message found in console: %s' % failure_message
>                  self.fail(fail)
>  
> +    def extract_from_deb(self, deb, path):
> +        """
> +        Extracts a file from a deb package into the test workdir
> +
> +        :param deb: path to the deb archive
> +        :param file: path within the deb archive of the file to be extracted
> +        :returns: path of the extracted file
> +        """
> +        cwd = os.getcwd()
> +        os.chdir(self.workdir)
> +        process.run("ar x %s data.tar.gz" % deb)
> +        archive.extract("data.tar.gz", self.workdir)
> +        os.chdir(cwd)
> +        return self.workdir + path

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +
>      def test_x86_64_pc(self):
>          """
>          :avocado: tags=arch:x86_64
> @@ -62,3 +80,26 @@ class BootLinuxConsole(Test):
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
> +        deb_url = ('http://snapshot.debian.org/archive/debian/'
> +                   '20130217T032700Z/pool/main/l/linux-2.6/'
> +                   'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb')
> +        deb_hash = 'a8cfc28ad8f45f54811fc6cf74fc43ffcfe0ba04'
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        kernel_path = self.extract_from_deb(deb_path,
> +                                            '/boot/vmlinux-2.6.32-5-4kc-malta')
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
