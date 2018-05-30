Received: from eggs.gnu.org ([2001:4830:134:3::10]:52079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO8AV-0003nI-Tf
	for qemu-devel@nongnu.org; Wed, 30 May 2018 16:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO8AR-000377-Ag
	for qemu-devel@nongnu.org; Wed, 30 May 2018 16:58:03 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:45740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO8AR-00036q-4F
	for qemu-devel@nongnu.org; Wed, 30 May 2018 16:57:59 -0400
Received: by mail-vk0-x243.google.com with SMTP id n134-v6so11988300vke.12
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 13:57:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180530184156.15634-1-crosa@redhat.com>
	<20180530184156.15634-6-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a8ec6474-707b-8272-7a79-a842f11d2f7f@amsat.org>
Date: Wed, 30 May 2018 17:57:52 -0300
MIME-Version: 1.0
In-Reply-To: <20180530184156.15634-6-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 5/5] Acceptance tests: add Linux kernel
 boot and console checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>

Hi Cleber,

On 05/30/2018 03:41 PM, Cleber Rosa wrote:
> This test boots a Linux kernel, and checks that the given command
> line was effective in two ways:
> 
>  * It makes the kernel use the set "console device" as a console
>  * The kernel records the command line as expected in the console
> 
> Given that way too many error conditions may occur, and detecting the
> kernel boot progress status may not be trivial, this test relies on a
> timeout to handle unexpected situations.  Also, it's *not* tagged as a
> quick test for obvious reasons.
> 
> It may be useful, while interactively running/debugging this test, or
> tests similar to this one, to show some of the logging channels.
> Example:
> 
>  $ avocado --show=QMP,console run boot_linux_console.py
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py | 47 ++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 tests/acceptance/boot_linux_console.py
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> new file mode 100644
> index 0000000000..98324f7591
> --- /dev/null
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -0,0 +1,47 @@
> +# Functional test that boots a Linux kernel and checks the console
> +#
> +# Copyright (c) 2018 Red Hat, Inc.
> +#
> +# Author:
> +#  Cleber Rosa <crosa@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import logging
> +
> +from avocado_qemu import Test
> +
> +
> +class BootLinuxConsole(Test):
> +    """
> +    Boots a x86_64 Linux kernel and checks that the console is operational
> +    and the kernel command line is properly passed from QEMU to the kernel
> +
> +    :avocado: enable
> +    :avocado: tags=x86_64

Can you move tags=x86_64 to the test() method?

> +    """
> +
> +    timeout = 60
> +
> +    def test(self):


Can we rename this test_fedora28_x86_64_pc()?

> +        kernel_url = ('https://mirrors.kernel.org/fedora/releases/28/'
> +                      'Everything/x86_64/os/images/pxeboot/vmlinuz')
> +        kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)

Not related to this patch, but while trying to extend your test, I
noticed fetch_asset() use the url filename as cache filename, so all
further tests (other arch) keep overwriting the same file and no caching
is done.
This is in particular why I used the hashed url as the filename in my
first dirty attempt.
https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg03082.html

> +
> +        self.vm.set_machine('pc')
> +        self.vm.set_console()
> +        kernel_command_line = 'console=ttyS0'
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-append', kernel_command_line)
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

Thanks for cleaning/fixing this test =)

Moving the :avocado: tag:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Regards,

Phil.
