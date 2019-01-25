Received: from eggs.gnu.org ([209.51.188.92]:56120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gn9U3-0002vB-Jh
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 16:57:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gn9U2-0000ZW-DD
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 16:57:55 -0500
References: <20190125203402.18904-1-philmd@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <1c788b0e-6a4b-f04f-b413-e7211fc62e85@redhat.com>
Date: Fri, 25 Jan 2019 16:57:35 -0500
MIME-Version: 1.0
In-Reply-To: <20190125203402.18904-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] ahci-test: Add dependency to qemu-img
 tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>



On 1/25/19 3:34 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Since the ahci-test uses qemu-img, add a dependency to build it
> before using it.
> This fixes:
>=20
>   $ gmake check-qtest V=3D1
>   QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3D=
qemu-img tests/ahci-test
>   Failed to execute child process "/tmp/qemu-test.19tMRF/qemu-img" (No =
such file or directory)
>   ERROR:tests/libqos/libqos.c:192:mkimg: assertion failed: (ret && !err=
)
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> RFC because while this dependency is valid, I don't think this is the
> clever way to solve this problem (which is, assuming the host
> distribution has the qemu-tools installed).
> I guess remember a thread about it (Eric, John?) where it was asked
> "What do we want to test, qemu-img or AHCI? Can we trust an unstable
> version of a tool to verify a device?"
>=20

Yeah, these discussions have a great track record of preventing us from
fixing problems.

Here's my two cents: "make check" already exports QTEST_QEMU_IMG as the
one we're building and gets passed to ahci-test -- might as well make
the dependency explicit in that same way.

> Slighly related is when vm-tests expect qemu-img available:
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08415.html
>=20
>   $ make vm-build-ubuntu.i386
>   Traceback (most recent call last):
>     File "source/qemu/tests/vm/basevm.py", line 236, in main
>       return vm.build_image(args.image)
>     File "tests/vm/ubuntu.i386", line 67, in build_image
>       subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
>   OSError: [Errno 2] No such file or directory
>   tests/vm/Makefile.include:23: recipe for target 'tests/vm/ubuntu.i386=
.img' failed
>   make: *** [tests/vm/ubuntu.i386.img] Error 2
>=20
> A better fix would be checking those tools via ./configure...
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 19b4c0a696..5e03416c81 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -706,7 +706,7 @@ tests/prom-env-test$(EXESUF): tests/prom-env-test.o=
 $(libqos-obj-y)
>  tests/rtas-test$(EXESUF): tests/rtas-test.o $(libqos-spapr-obj-y)
>  tests/fdc-test$(EXESUF): tests/fdc-test.o
>  tests/ide-test$(EXESUF): tests/ide-test.o $(libqos-pc-obj-y)
> -tests/ahci-test$(EXESUF): tests/ahci-test.o $(libqos-pc-obj-y)
> +tests/ahci-test$(EXESUF): tests/ahci-test.o $(libqos-pc-obj-y) qemu-im=
g$(EXESUF)
>  tests/ipmi-kcs-test$(EXESUF): tests/ipmi-kcs-test.o
>  tests/ipmi-bt-test$(EXESUF): tests/ipmi-bt-test.o
>  tests/hd-geo-test$(EXESUF): tests/hd-geo-test.o
>=20

Reviewed-by: John Snow <jsnow@redhat.com>
