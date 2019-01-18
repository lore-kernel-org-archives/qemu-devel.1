Received: from eggs.gnu.org ([209.51.188.92]:59710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkPz1-0002od-7o
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 03:58:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkPyy-0002GW-Fk
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 03:58:34 -0500
Date: Fri, 18 Jan 2019 09:58:00 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190118095800.6d9bc2e1.cohuck@redhat.com>
In-Reply-To: <20190117185628.21862-18-crosa@redhat.com>
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-18-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/18] Boot Linux Console Test: add a test
 for s390x + s390-ccw-virtio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

On Thu, 17 Jan 2019 13:56:27 -0500
Cleber Rosa <crosa@redhat.com> wrote:

> Just like the previous tests, boots a Linux kernel on a s390x target
> using the s390-ccw-virtio machine.
> 
> Because it's not possible to have multiple VT220 consoles,
> '-nodefaults' is used, so that the one set with set_console() works
> correctly.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  .travis.yml                            |  2 +-
>  tests/acceptance/boot_linux_console.py | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index ea7c9828ac..0d5a4b104b 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -187,7 +187,7 @@ matrix:
>  
>      # Acceptance (Functional) tests
>      - env:
> -        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,ppc64-softmmu,aarch64-softmmu,arm-softmmu"
> +        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,ppc64-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu"
>          - TEST_CMD="make check-acceptance"
>        addons:
>          apt:
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 00aee3114e..c4d5477d45 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -177,3 +177,23 @@ class BootLinuxConsole(Test):
>          self.vm.launch()
>          console_pattern = 'Kernel command line: %s' % kernel_command_line
>          self.wait_for_console_pattern(console_pattern)
> +
> +    def test_s390x_s390_ccw_virtio(self):
> +        """
> +        :avocado: tags=arch:s390x
> +        :avocado: tags=machine:s390_ccw_virtio
> +        """
> +        kernel_url = ('http://mirrors.rit.edu/fedora/fedora-secondary/releases'
> +                      '/29/Server/s390x/os/images/kernel.img')
> +        kernel_hash = 'e8e8439103ef8053418ef062644ffd46a7919313'
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +
> +        self.vm.set_machine('s390-ccw-virtio')
> +        self.vm.set_console()
> +        kernel_command_line = 'console=sclp0'
> +        self.vm.add_args('-nodefaults',
> +                         '-kernel', kernel_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        console_pattern = 'Kernel command line: %s' % kernel_command_line
> +        self.wait_for_console_pattern(console_pattern)

Cool, I had been looking at adding some of the tests I'm running here
to this framework as well, and this gives me a good base to work with :)

I'll try to find some time to give it a whirl.
