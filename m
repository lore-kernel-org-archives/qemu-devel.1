Received: from eggs.gnu.org ([2001:4830:134:3::10]:56312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYrmm-0003Kq-Ue
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:09:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYrmj-0006wA-Mm
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:09:40 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:38509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYrmj-0006vH-Fw
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:09:37 -0500
Received: by mail-qk0-x241.google.com with SMTP id j185so7187095qkc.5
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 03:09:37 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
	<20180104160523.22995-16-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8883f760-89d9-b232-a3f1-4b733bef474c@amsat.org>
Date: Tue, 9 Jan 2018 08:09:30 -0300
MIME-Version: 1.0
In-Reply-To: <20180104160523.22995-16-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="jHxxiIVFr3Oq8u5RqAeoHPMVcTjCkjWh1"
Subject: Re: [Qemu-devel] [PATCH v3 15/18] ucontext: annotate coroutine
 stack for ASAN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, famz@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jHxxiIVFr3Oq8u5RqAeoHPMVcTjCkjWh1
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, famz@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Message-ID: <8883f760-89d9-b232-a3f1-4b733bef474c@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v3 15/18] ucontext: annotate coroutine stack
 for ASAN
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
 <20180104160523.22995-16-marcandre.lureau@redhat.com>
In-Reply-To: <20180104160523.22995-16-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Marc-Andr=C3=A9,

On 01/04/2018 01:05 PM, Marc-Andr=C3=A9 Lureau wrote:
> It helps ASAN to detect more leaks on coroutine stacks, as found in
> the following patch.
>=20
> A similar work would need to be done for sigaltstack & windows fibers
> to have similar coverage. Since ucontext is preferred, I didn't bother
> checking the other coroutine implementations for now.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/qemu/compiler.h   |  4 ++++
>  util/coroutine-ucontext.c | 46 +++++++++++++++++++++++++++++++++++++++=
+++++++
>  2 files changed, 50 insertions(+)
>=20
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 340e5fdc09..5fcc4f7ec7 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -111,4 +111,8 @@
>  #define GCC_FMT_ATTR(n, m)
>  #endif
> =20
> +#ifndef __has_feature
> +#define __has_feature(x) 0 /* compatibility with non-clang compilers *=
/
> +#endif
> +
>  #endif /* COMPILER_H */
> diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
> index 6621f3f692..e78eae8766 100644
> --- a/util/coroutine-ucontext.c
> +++ b/util/coroutine-ucontext.c
> @@ -31,6 +31,11 @@
>  #include <valgrind/valgrind.h>
>  #endif
> =20
> +#if defined(__SANITIZE_ADDRESS__) || __has_feature(address_sanitizer)
> +#define CONFIG_ASAN 1
> +#include <sanitizer/asan_interface.h>
> +#endif

Sadly this fails on Travis:

$ export CONFIG=3D"--enable-debug --enable-debug-tcg
--enable-trace-backends=3Dlog"
$ export CC=3Dgcc
$ ./configure ${CONFIG}
C compiler        gcc
Host C compiler   cc
C++ compiler      c++
Objective-C compiler clang
CFLAGS            -Wno-maybe-uninitialized -Og -fsanitize=3Daddress -g
[...]
  CC      util/qemu-coroutine.o
  CC      util/qemu-coroutine-lock.o
  CC      util/qemu-coroutine-io.o
  CC      util/qemu-coroutine-sleep.o
  CC      util/coroutine-ucontext.o
util/coroutine-ucontext.c:36:38: fatal error:
sanitizer/asan_interface.h: No such file or directory
 #include <sanitizer/asan_interface.h>
                                      ^
compilation terminated.
make: *** [util/coroutine-ucontext.o] Error 1

You simply need to update the .travis.yml, but does that mean your
previous patch "Enable ASAN/UBSan by default if the compiler supports
it." isn't correct?

> +
>  typedef struct {
>      Coroutine base;
>      void *stack;
> @@ -59,11 +64,37 @@ union cc_arg {
>      int i[2];
>  };
> =20
> +static void finish_switch_fiber(void *fake_stack_save)
> +{
> +#ifdef CONFIG_ASAN
> +    const void *bottom_old;
> +    size_t size_old;
> +
> +    __sanitizer_finish_switch_fiber(fake_stack_save, &bottom_old, &siz=
e_old);
> +
> +    if (!leader.stack) {
> +        leader.stack =3D (void *)bottom_old;
> +        leader.stack_size =3D size_old;
> +    }
> +#endif
> +}
> +
> +static void start_switch_fiber(void **fake_stack_save,
> +                               const void *bottom, size_t size)
> +{
> +#ifdef CONFIG_ASAN
> +    __sanitizer_start_switch_fiber(fake_stack_save, bottom, size);
> +#endif
> +}
> +
>  static void coroutine_trampoline(int i0, int i1)
>  {
>      union cc_arg arg;
>      CoroutineUContext *self;
>      Coroutine *co;
> +    void *fake_stack_save =3D NULL;
> +
> +    finish_switch_fiber(NULL);
> =20
>      arg.i[0] =3D i0;
>      arg.i[1] =3D i1;
> @@ -72,9 +103,13 @@ static void coroutine_trampoline(int i0, int i1)
> =20
>      /* Initialize longjmp environment and switch back the caller */
>      if (!sigsetjmp(self->env, 0)) {
> +        start_switch_fiber(&fake_stack_save,
> +                           leader.stack, leader.stack_size);
>          siglongjmp(*(sigjmp_buf *)co->entry_arg, 1);
>      }
> =20
> +    finish_switch_fiber(fake_stack_save);
> +
>      while (true) {
>          co->entry(co->entry_arg);
>          qemu_coroutine_switch(co, co->caller, COROUTINE_TERMINATE);
> @@ -87,6 +122,7 @@ Coroutine *qemu_coroutine_new(void)
>      ucontext_t old_uc, uc;
>      sigjmp_buf old_env;
>      union cc_arg arg =3D {0};
> +    void *fake_stack_save =3D NULL;
> =20
>      /* The ucontext functions preserve signal masks which incurs a
>       * system call overhead.  sigsetjmp(buf, 0)/siglongjmp() does not
> @@ -122,8 +158,12 @@ Coroutine *qemu_coroutine_new(void)
> =20
>      /* swapcontext() in, siglongjmp() back out */
>      if (!sigsetjmp(old_env, 0)) {
> +        start_switch_fiber(&fake_stack_save, co->stack, co->stack_size=
);
>          swapcontext(&old_uc, &uc);
>      }
> +
> +    finish_switch_fiber(fake_stack_save);
> +
>      return &co->base;
>  }
> =20
> @@ -169,13 +209,19 @@ qemu_coroutine_switch(Coroutine *from_, Coroutine=
 *to_,
>      CoroutineUContext *from =3D DO_UPCAST(CoroutineUContext, base, fro=
m_);
>      CoroutineUContext *to =3D DO_UPCAST(CoroutineUContext, base, to_);=

>      int ret;
> +    void *fake_stack_save =3D NULL;
> =20
>      current =3D to_;
> =20
>      ret =3D sigsetjmp(from->env, 0);
>      if (ret =3D=3D 0) {
> +        start_switch_fiber(action =3D=3D COROUTINE_TERMINATE ?
> +                           NULL : &fake_stack_save, to->stack, to->sta=
ck_size);
>          siglongjmp(to->env, action);
>      }
> +
> +    finish_switch_fiber(fake_stack_save);
> +
>      return ret;
>  }
> =20
>=20


--jHxxiIVFr3Oq8u5RqAeoHPMVcTjCkjWh1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpUouoACgkQ4+MsLN6t
wN4z4g/+Mgsa72516I2tr0wQn3oWxVEVtmPdQD+6v9Nx28ZA9FTDlxCa6DMvyHo2
qMt93ECLkzaCy7/O1fyQBTtb3z4MveGvT0/+rcahDRw/CM/BAugHX9qOOKNKCEY6
Qnh3VTLQ3ZWsazeQCp04PlLJuyecbbCTTdVCBF2/IN1m7ngyQ2rgUKusG7UpLt8v
swLRXw+7I44CPFLtjq3yRTquLoOkiKjnEJMqz95onNfCDefbLTO0hHDcoCaaOJ/F
kqa5flMSWxiFt3aeYGKKn/Cc2Npb2NBFRDMscxKsJ6a/f1AoO19qbftN6J2a3yM6
NVGy5w4aUeQQXgEc1Ww6ixQYub3Wl5b61sSOg+hs0DNndB1VAz0u/hNqIIdtwFVr
FElyW9xIDgNQZKdnOdmgQad30OUi2qgN7WtqTUFPDqQM0jIKEZALGtBxmCs1bWpc
QPULpnhuC5FeqaoPjoyQGY7RvVDBjY9r7qLcU+GttuMoLvYq6BeQncqUXn1q/ar/
QFOR+juRCWPdcH9Y/EVsXhHrMWAlMQnlpQXLTNrDwnEjZ7NLgOwA0J+v6wnykTmI
Z59fqsrJT+vlkCZn8Su9jZAYcMBgXOyL7TGQW2k/HF8vhM9ytTV2SPxAo/BSA+yj
VG35WmBgJ3JJRg/HP3Mt1wi7JjDogFDKtTYkbKw8oElUJKZohFI=
=pbSh
-----END PGP SIGNATURE-----

--jHxxiIVFr3Oq8u5RqAeoHPMVcTjCkjWh1--
