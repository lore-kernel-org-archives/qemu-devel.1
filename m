Received: from eggs.gnu.org ([2001:4830:134:3::10]:56310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDBPP-0006yO-Ly
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 12:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDBPM-0006Iv-0W
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 12:44:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDBPL-0006HX-Pu
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 12:44:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so34449276wrw.3
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 09:44:23 -0700 (PDT)
References: <20181018162057.19348-1-wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0b3ebfae-e868-daee-31bb-601bd562cc28@redhat.com>
Date: Thu, 18 Oct 2018 18:44:21 +0200
MIME-Version: 1.0
In-Reply-To: <20181018162057.19348-1-wainersm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: ccarrara@redhat.com, ehabkost@redhat.com, crosa@redhat.com, lizhijian@cn.fujitsu.com

On 18/10/2018 18:20, Wainer dos Santos Moschetta wrote:
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

I'll let Cleber check if he wants we use 'tags=arch:x86_64' here.

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


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
> +            initrd.write(b'\0')
> +            initrd.flush()
> +            cmd = "%s -kernel %s -initrd %s" % (self.qemu_bin, kernel_path,
> +                                                initrd.name)
> +            res = run(cmd, ignore_status=True)
> +            self.assertNotEqual(res.exit_status, 0)
> +            expected_msg = r'.*initrd is too large.*max: \d+, need \d+.*'
> +            self.assertRegex(res.stderr_text, expected_msg)
> 
