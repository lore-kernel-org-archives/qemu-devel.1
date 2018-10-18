Received: from eggs.gnu.org ([2001:4830:134:3::10]:45329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDG7f-0002wS-A9
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 17:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDG7U-0002HT-Hh
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 17:46:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gDG7K-0002Cm-Ph
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 17:46:09 -0400
References: <20181018162057.19348-1-wainersm@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <f53ae31c-a0e6-9370-2b77-26d313380f3a@redhat.com>
Date: Thu, 18 Oct 2018 17:45:56 -0400
MIME-Version: 1.0
In-Reply-To: <20181018162057.19348-1-wainersm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Acceptance tests: add Linux initrd
 checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, lizhijian@cn.fujitsu.com, ccarrara@redhat.com, philmd@redhat.com



On 10/18/18 12:20 PM, Wainer dos Santos Moschetta wrote:
> QEMU used to exits with a not accurate error message when
> an initrd >= 2GB was passed. That was fixed on patch:
> 
> 	commit f3839fda5771596152b75dd1e1a6d050e6e6e380
> 	Author: Li Zhijian <lizhijian@cn.fujitsu.com>
> 	Date:   Thu Sep 13 18:07:13 2018 +0800
> 
>     	change get_image_size return type to int64_t
> 
> This change adds a regression test for that fix. It starts
> QEMU with a 2GB dummy initrd, and check it evaluates the file
> size correctly and prints accurate message.
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  tests/acceptance/linux_initrd.py | 47 ++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 tests/acceptance/linux_initrd.py
> 
> diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_initrd.py
> new file mode 100644
> index 0000000000..7d9e5862cd
> --- /dev/null
> +++ b/tests/acceptance/linux_initrd.py
> @@ -0,0 +1,47 @@
> +# Linux initrd acceptance test.
> +#
> +# Copyright (c) 2018 Red Hat, Inc.
> +#
> +# Author:
> +#  Wainer dos Santos Moschetta <wainersm@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import tempfile
> +
> +from avocado_qemu import Test
> +from avocado.utils.process import run
> +
> +
> +class LinuxInitrd(Test):
> +    """
> +    Checks QEMU evaluates correctly the initrd file passed as -initrd option.
> +
> +    :avocado: enable
> +    :avocado: tags=x86_64
> +    """
> +
> +    timeout = 60
> +
> +    def test_with_2GB_file_should_exit_error_msg(self):
> +        """
> +        Pretends to boot QEMU with an initrd file with size of 2GB
> +        and expect it exits with error message.
> +        Regression test for bug fixed on commit f3839fda5771596152.
> +        """
> +        kernel_url = ('https://mirrors.kernel.org/fedora/releases/28/'
> +                      'Everything/x86_64/os/images/pxeboot/vmlinuz')
> +        kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +
> +        with tempfile.NamedTemporaryFile() as initrd:
> +            initrd.seek(2048*(1024**2) -1)

It's a style issue, but I'd go with spaces between operators:

        initrd.seek(2048 * (1024 ** 2) - 1)

One other possibility that may improve code readability is:

        from avocado.utils.data_structures import DataSize
        initrd.seek(DataSize('2G').b - 1)

Or finally, just set a "max_size" variable to the 2GB literal value.

> +            initrd.write(b'\0')
> +            initrd.flush()
> +            cmd = "%s -kernel %s -initrd %s" % (self.qemu_bin, kernel_path,
> +                                                initrd.name)
> +            res = run(cmd, ignore_status=True)
> +            self.assertNotEqual(res.exit_status, 0)
> +            expected_msg = r'.*initrd is too large.*max: \d+, need \d+.*'

I'd be a bit more assertive here and do something like:

      expected_msg = r'.*initrd is too large.*max: \d+, need %d\)' %
max_size

And if "134053887" (which appears in "max"), is a QEMU constant, that
can be added there as well.

- Cleber.

> +            self.assertRegex(res.stderr_text, expected_msg)
> 
