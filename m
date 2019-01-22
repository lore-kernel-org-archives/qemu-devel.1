Received: from eggs.gnu.org ([209.51.188.92]:40201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glsxH-0004V1-Uq
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glsxB-0003O5-Ca
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:06:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glsxB-0003CE-3U
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:06:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so13631971wmt.0
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 02:06:32 -0800 (PST)
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-11-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4b7decb3-c198-cff6-0ec1-5fc58df64a74@redhat.com>
Date: Tue, 22 Jan 2019 11:06:29 +0100
MIME-Version: 1.0
In-Reply-To: <20190117185628.21862-11-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/18] Boot Linux Console Test: refactor
 the console watcher into utility method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

Hi Cleber,

On 1/17/19 7:56 PM, Cleber Rosa wrote:
> This introduces a utility method that monitors the console device and
> looks for either a message that signals the test success or failure.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py | 30 ++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 35b31162d4..278bb2be3d 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -23,6 +23,25 @@ class BootLinuxConsole(Test):
>  
>      timeout = 60
>  
> +    def wait_for_console_pattern(self, success_message,
> +                                 failure_message='Kernel panic - not syncing'):
> +        """
> +        Waits for messages to appear on the console, while logging the content
> +
> +        :param success_message: if this message appears, test succeeds
> +        :param failure_message: if this message appears, test fails
> +        """
> +        console = self.vm.console_socket.makefile()
> +        console_logger = logging.getLogger('console')
> +        while True:
> +            msg = console.readline()
> +            console_logger.debug(msg.strip())
> +            if success_message in msg:
> +                break
> +            if failure_message in msg:
> +                fail = 'Failure message found in console: %s' % failure_message
> +                self.fail(fail)
> +

This helper is more generic than the BootLinuxConsole class, can you
move it out? I'd like to use it in test_uefi_ovmf_x86_64_pc and
test_uefi_armvirtqemu_aarch64_virt.

Anyway this can be a follow-up patch, so regardless:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>      def test_x86_64_pc(self):
>          """
>          :avocado: tags=arch:x86_64
> @@ -39,12 +58,5 @@ class BootLinuxConsole(Test):
>          self.vm.add_args('-kernel', kernel_path,
>                           '-append', kernel_command_line)
>          self.vm.launch()
> -        console = self.vm.console_socket.makefile()
> -        console_logger = logging.getLogger('console')
> -        while True:
> -            msg = console.readline()
> -            console_logger.debug(msg.strip())
> -            if 'Kernel command line: %s' % kernel_command_line in msg:
> -                break
> -            if 'Kernel panic - not syncing' in msg:
> -                self.fail("Kernel panic reached")
> +        console_pattern = 'Kernel command line: %s' % kernel_command_line
> +        self.wait_for_console_pattern(console_pattern)
> 
