Received: from eggs.gnu.org ([209.51.188.92]:43852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glt9p-0006ka-Fc
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glt9o-0004TF-84
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:19:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glt9n-0004Oa-S5
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:19:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so8190127wmd.1
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 02:19:47 -0800 (PST)
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-14-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e05b1d30-1a44-171a-02f7-d77e182ab90c@redhat.com>
Date: Tue, 22 Jan 2019 11:19:43 +0100
MIME-Version: 1.0
In-Reply-To: <20190117185628.21862-14-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 13/18] Boot Linux Console Test: add a test
 for mips64el + malta
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

Hi Cleber,

On 1/17/19 7:56 PM, Cleber Rosa wrote:
> Similar to the x86_64 + pc test, it boots a Linux kernel on a Malta
> board and verify the serial is working.
> 
> If mips64el is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:mips" tags.
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
>  tests/acceptance/boot_linux_console.py | 39 ++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 49f9016e6a..28648f7a61 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -187,7 +187,7 @@ matrix:
>  
>      # Acceptance (Functional) tests
>      - env:
> -        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu"
> +        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu"
>          - TEST_CMD="make check-acceptance"
>        addons:
>          apt:
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 0678ec91d2..20b845fce1 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -9,8 +9,11 @@
>  # later.  See the COPYING file in the top-level directory.
>  
>  import logging
> +import os
>  
>  from avocado_qemu import Test
> +from avocado.utils import process
> +from avocado.utils import archive
>  
>  
>  class BootLinuxConsole(Test):
> @@ -80,3 +83,39 @@ class BootLinuxConsole(Test):
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
> +        [1] https://kernel-team.pages.debian.net/kernel-handbook/ch-common-tasks.html#s-common-official
> +        [2] http://snapshot.debian.org/package/linux-2.6/2.6.32-48/#linux-source-2.6.32_2.6.32-48
> +
> +        :avocado: tags=arch:mips64el
> +        :avocado: tags=machine:malta
> +        """
> +        deb_url = ('http://snapshot.debian.org/archive/debian/20130217T032700Z/'
> +                   'pool/main/l/linux-2.6/'
> +                   'linux-image-2.6.32-5-5kc-malta_2.6.32-48_mipsel.deb')
> +        deb_hash = '1aaec92083bf22fda31e0d27fa8d9a388e5fc3d5'
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +

Can you refactor this code ...

> +        cwd = os.getcwd()
> +        os.chdir(self.workdir)
> +        process.run("ar x %s data.tar.gz" % deb_path)
> +        archive.extract("data.tar.gz", self.workdir)
> +        os.chdir(cwd)
> +        kernel_path = self.workdir + '/boot/vmlinux-2.6.32-5-5kc-malta'

... as an helper function?

Can be follow-up patch, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
