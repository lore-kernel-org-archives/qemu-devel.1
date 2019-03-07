Received: from eggs.gnu.org ([209.51.188.92]:53647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1uSS-0003MH-UB
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:57:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1uSR-0007hL-Su
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:57:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h1uSR-0007g3-IG
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:57:15 -0500
References: <20190307142822.8531-1-philmd@redhat.com>
	<20190307142822.8531-3-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6ea02dad-37bb-1c22-19c9-168a99048504@redhat.com>
Date: Thu, 7 Mar 2019 15:57:09 +0100
MIME-Version: 1.0
In-Reply-To: <20190307142822.8531-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/2] configure: Disable W^X on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Brad Smith <brad@comstyle.com>

On 07/03/2019 15.28, Philippe Mathieu-Daud=C3=A9 wrote:
> Since OpenBSD 6.0 [1], W^X is enforced by default [2].
> TCG requires WX access. Disable W^X if it is available.
> This fixes:
>=20
>   # lm32-softmmu/qemu-system-lm32
>   Could not allocate dynamic translator buffer
>=20
>   # sysctl kern.wxabort=3D1
>   kern.wxabort: 0 -> 1
>   # lm32-softmmu/qemu-system-lm32
>   mmap: Not supported
>   Abort trap (core dumped)
>   # gdb -q lm32-softmmu/qemu-system-lm32 qemu-system-lm32.core
>   (gdb) bt
>   #0  0x000017e3c156c50a in _thread_sys___syscall () at {standard input=
}:5
>   #1  0x000017e3c15e5d7a in *_libc_mmap (addr=3DVariable "addr" is not =
available.) at /usr/src/lib/libc/sys/mmap.c:47
>   #2  0x000017e17d9abc8b in alloc_code_gen_buffer () at /usr/src/qemu/a=
ccel/tcg/translate-all.c:1064
>   #3  0x000017e17d9abd04 in code_gen_alloc (tb_size=3D0) at /usr/src/qe=
mu/accel/tcg/translate-all.c:1112
>   #4  0x000017e17d9abe81 in tcg_exec_init (tb_size=3D0) at /usr/src/qem=
u/accel/tcg/translate-all.c:1149
>   #5  0x000017e17d9897e9 in tcg_init (ms=3D0x17e45e456800) at /usr/src/=
qemu/accel/tcg/tcg-all.c:66
>   #6  0x000017e17d9891b8 in accel_init_machine (acc=3D0x17e3c3f50800, m=
s=3D0x17e45e456800) at /usr/src/qemu/accel/accel.c:63
>   #7  0x000017e17d989312 in configure_accelerator (ms=3D0x17e45e456800,=
 progname=3D0x7f7fffff07b0 "lm32-softmmu/qemu-system-lm32") at /usr/src/q=
emu/accel/accel.c:111
>   #8  0x000017e17d9d8616 in main (argc=3D1, argv=3D0x7f7fffff06b8, envp=
=3D0x7f7fffff06c8) at vl.c:4325
>=20
> [1] https://www.openbsd.org/faq/upgrade60.html
> [2] https://undeadly.org/cgi?action=3Darticle&sid=3D20160527203200
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  configure | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/configure b/configure
> index cefeb8fcce..abfd60923a 100755
> --- a/configure
> +++ b/configure
> @@ -5835,6 +5835,17 @@ if test "$mingw32" =3D "yes" ; then
>      done
>  fi
> =20
> +# Disable OpenBSD W^X if available
> +if test "$tcg" =3D "yes" && test "$targetos" =3D "OpenBSD"; then
> +    cat > $TMPC <<EOF
> +    int main(void) { return 0; }
> +EOF

You can use write_c_skeleton for this instead.

 Thomas
