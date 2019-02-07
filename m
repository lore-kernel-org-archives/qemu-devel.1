Received: from eggs.gnu.org ([209.51.188.92]:42398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1grmt1-0001bZ-BN
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1grmsz-0007z8-7b
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:50:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1grmsx-0007xV-M5
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:50:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id h22so4819433wmb.0
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 08:50:45 -0800 (PST)
References: <20190205001835.25660-1-philmd@redhat.com>
	<20190205001835.25660-2-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <99509706-b027-bf45-b17b-e9f66943f86c@redhat.com>
Date: Thu, 7 Feb 2019 17:50:42 +0100
MIME-Version: 1.0
In-Reply-To: <20190205001835.25660-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/8] ahci-test: Add dependency to
 qemu-img tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 2/5/19 1:18 AM, Philippe Mathieu-Daudé wrote:
> Since the ahci-test uses qemu-img, add a dependency to build it
> before using it.
> This fixes:
> 
>   $ gmake check-qtest V=1
>   QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img tests/ahci-test
>   Failed to execute child process "/tmp/qemu-test.19tMRF/qemu-img" (No such file or directory)
>   ERROR:tests/libqos/libqos.c:192:mkimg: assertion failed: (ret && !err)
> 
> Reviewed-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Slighly related is when vm-tests expect qemu-img available:
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08415.html
> 
>   $ make vm-build-ubuntu.i386
>   Traceback (most recent call last):
>     File "source/qemu/tests/vm/basevm.py", line 236, in main
>       return vm.build_image(args.image)
>     File "tests/vm/ubuntu.i386", line 67, in build_image
>       subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
>   OSError: [Errno 2] No such file or directory
>   tests/vm/Makefile.include:23: recipe for target 'tests/vm/ubuntu.i386.img' failed
>   make: *** [tests/vm/ubuntu.i386.img] Error 2
> 
> A better fix would be checking those tools via ./configure...
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 75ad9c0dd3..679656b64a 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -708,7 +708,7 @@ tests/prom-env-test$(EXESUF): tests/prom-env-test.o $(libqos-obj-y)
>  tests/rtas-test$(EXESUF): tests/rtas-test.o $(libqos-spapr-obj-y)
>  tests/fdc-test$(EXESUF): tests/fdc-test.o
>  tests/ide-test$(EXESUF): tests/ide-test.o $(libqos-pc-obj-y)
> -tests/ahci-test$(EXESUF): tests/ahci-test.o $(libqos-pc-obj-y)
> +tests/ahci-test$(EXESUF): tests/ahci-test.o $(libqos-pc-obj-y) qemu-img$(EXESUF)

In [*] Cleber noticed if we configure using --disable-tools, qemu-img is
still built by when running "make check-block" due to this rule.

I think this is OK because
- at least a test requires it, so this test will run (which is what
  we want)
- while the tool is available in the build directory, it still won't
  be installed by "make install"

[*] https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01947.html

>  tests/ipmi-kcs-test$(EXESUF): tests/ipmi-kcs-test.o
>  tests/ipmi-bt-test$(EXESUF): tests/ipmi-bt-test.o
>  tests/hd-geo-test$(EXESUF): tests/hd-geo-test.o
> 
