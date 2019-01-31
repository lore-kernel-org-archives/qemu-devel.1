Received: from eggs.gnu.org ([209.51.188.92]:50961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpA7K-0001w7-AQ
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpA7I-0008Pc-Ut
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:02:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gpA7I-0008PD-PC
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:02:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so2071855wmc.1
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 03:02:44 -0800 (PST)
References: <20190125140017.6092-1-alex.bennee@linaro.org>
	<20190125140017.6092-13-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <21071b28-7cc9-e57e-b3a8-3597e51318b8@redhat.com>
Date: Thu, 31 Jan 2019 12:02:42 +0100
MIME-Version: 1.0
In-Reply-To: <20190125140017.6092-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 12/14] tests/vm: add --build-target
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>

On 1/25/19 3:00 PM, Alex Bennée wrote:
> This allows us to invoke the build with a custom target (for the VMs
> that use the {target} format string specifier). Currently OpenBSD is
> still hardwired due to problems running check.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/vm/basevm.py   | 3 +++
>  tests/vm/freebsd     | 2 +-
>  tests/vm/netbsd      | 2 +-
>  tests/vm/ubuntu.i386 | 2 +-
>  4 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 5caf77d6b8..bdca6cb2fc 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -228,6 +228,8 @@ def parse_args(vmcls):
>                        help="build image")
>      parser.add_option("--build-qemu",
>                        help="build QEMU from source in guest")
> +    parser.add_option("--build-target",
> +                      help="QEMU build target", default="check")
>      parser.add_option("--interactive", "-I", action="store_true",
>                        help="Interactively run command")
>      parser.add_option("--snapshot", "-s", action="store_true",
> @@ -255,6 +257,7 @@ def main(vmcls):
>              cmd = [vm.BUILD_SCRIPT.format(
>                     configure_opts = " ".join(argv),
>                     jobs=args.jobs,
> +                   target=args.build_target,
>                     verbose = "V=1" if args.verbose else "")]
>          else:
>              cmd = argv
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index a85c866c30..1d64c31b7c 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -25,7 +25,7 @@ class FreeBSDVM(basevm.BaseVM):
>          cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
>          tar -xf /dev/vtbd1;
>          ./configure {configure_opts};
> -        gmake --output-sync -j{jobs} check {verbose};
> +        gmake --output-sync -j{jobs} {target} {verbose};
>      """
>  
>      def build_image(self, img):
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index edea113bb5..a2c3d13af4 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -25,7 +25,7 @@ class NetBSDVM(basevm.BaseVM):
>          cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
>          tar -xf /dev/rld1a;
>          ./configure --python=python2.7 {configure_opts};
> -        gmake --output-sync -j{jobs} check {verbose};
> +        gmake --output-sync -j{jobs} {target} {verbose};
>      """
>  
>      def build_image(self, img):
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> index 252e514859..a22d137e76 100755
> --- a/tests/vm/ubuntu.i386
> +++ b/tests/vm/ubuntu.i386
> @@ -26,7 +26,7 @@ class UbuntuX86VM(basevm.BaseVM):
>          sudo chmod a+r /dev/vdb;
>          tar -xf /dev/vdb;
>          ./configure {configure_opts};
> -        make --output-sync check -j{jobs} {verbose};
> +        make --output-sync {target} -j{jobs} {verbose};
>      """
>  
>      def _gen_cloud_init_iso(self):
> 
