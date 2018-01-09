Received: from eggs.gnu.org ([2001:4830:134:3::10]:56529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYrnv-0004B1-LM
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:10:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYrns-0000PB-Cz
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:10:51 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYrns-0000OS-5y
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:10:48 -0500
Received: by mail-qk0-x244.google.com with SMTP id b76so5140415qkc.1
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 03:10:48 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
	<20180104160523.22995-16-marcandre.lureau@redhat.com>
	<8883f760-89d9-b232-a3f1-4b733bef474c@amsat.org>
Message-ID: <fb97ecca-ec9f-5417-7370-01a4bd4a3c9e@amsat.org>
Date: Tue, 9 Jan 2018 08:10:43 -0300
MIME-Version: 1.0
In-Reply-To: <8883f760-89d9-b232-a3f1-4b733bef474c@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="xojl3a59MSxzdrdeX4WMXLU9dortflcbd"
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
--xojl3a59MSxzdrdeX4WMXLU9dortflcbd
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, famz@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Message-ID: <fb97ecca-ec9f-5417-7370-01a4bd4a3c9e@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v3 15/18] ucontext: annotate coroutine stack
 for ASAN
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
 <20180104160523.22995-16-marcandre.lureau@redhat.com>
 <8883f760-89d9-b232-a3f1-4b733bef474c@amsat.org>
In-Reply-To: <8883f760-89d9-b232-a3f1-4b733bef474c@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> On 01/04/2018 01:05 PM, Marc-Andr=C3=A9 Lureau wrote:
>> It helps ASAN to detect more leaks on coroutine stacks, as found in
>> the following patch.
>>
>> A similar work would need to be done for sigaltstack & windows fibers
>> to have similar coverage. Since ucontext is preferred, I didn't bother=

>> checking the other coroutine implementations for now.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>  include/qemu/compiler.h   |  4 ++++
>>  util/coroutine-ucontext.c | 46 ++++++++++++++++++++++++++++++++++++++=
++++++++
>>  2 files changed, 50 insertions(+)
>>
>> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
>> index 340e5fdc09..5fcc4f7ec7 100644
>> --- a/include/qemu/compiler.h
>> +++ b/include/qemu/compiler.h
>> @@ -111,4 +111,8 @@
>>  #define GCC_FMT_ATTR(n, m)
>>  #endif
>> =20
>> +#ifndef __has_feature
>> +#define __has_feature(x) 0 /* compatibility with non-clang compilers =
*/
>> +#endif
>> +
>>  #endif /* COMPILER_H */
>> diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
>> index 6621f3f692..e78eae8766 100644
>> --- a/util/coroutine-ucontext.c
>> +++ b/util/coroutine-ucontext.c
>> @@ -31,6 +31,11 @@
>>  #include <valgrind/valgrind.h>
>>  #endif
>> =20
>> +#if defined(__SANITIZE_ADDRESS__) || __has_feature(address_sanitizer)=

>> +#define CONFIG_ASAN 1
>> +#include <sanitizer/asan_interface.h>
>> +#endif
>=20
> Sadly this fails on Travis:
>=20
> $ export CONFIG=3D"--enable-debug --enable-debug-tcg
> --enable-trace-backends=3Dlog"
> $ export CC=3Dgcc
> $ ./configure ${CONFIG}
> C compiler        gcc
> Host C compiler   cc
> C++ compiler      c++
> Objective-C compiler clang
> CFLAGS            -Wno-maybe-uninitialized -Og -fsanitize=3Daddress -g
> [...]
>   CC      util/qemu-coroutine.o
>   CC      util/qemu-coroutine-lock.o
>   CC      util/qemu-coroutine-io.o
>   CC      util/qemu-coroutine-sleep.o
>   CC      util/coroutine-ucontext.o
> util/coroutine-ucontext.c:36:38: fatal error:
> sanitizer/asan_interface.h: No such file or directory
>  #include <sanitizer/asan_interface.h>
>                                       ^
> compilation terminated.
> make: *** [util/coroutine-ucontext.o] Error 1
>=20
> You simply need to update the .travis.yml, but does that mean your
> previous patch "Enable ASAN/UBSan by default if the compiler supports
> it." isn't correct?

Err, the previous patch subject is "build-sys: add some sanitizers when
--enable-debug if possible"

>> +
>>  typedef struct {
>>      Coroutine base;
>>      void *stack;
>> @@ -59,11 +64,37 @@ union cc_arg {
>>      int i[2];
>>  };
>> =20
>> +static void finish_switch_fiber(void *fake_stack_save)
>> +{
>> +#ifdef CONFIG_ASAN
>> +    const void *bottom_old;
>> +    size_t size_old;
>> +
>> +    __sanitizer_finish_switch_fiber(fake_stack_save, &bottom_old, &si=
ze_old);
>> +
>> +    if (!leader.stack) {
>> +        leader.stack =3D (void *)bottom_old;
>> +        leader.stack_size =3D size_old;
>> +    }
>> +#endif
>> +}
>> +
>> +static void start_switch_fiber(void **fake_stack_save,
>> +                               const void *bottom, size_t size)
>> +{
>> +#ifdef CONFIG_ASAN
>> +    __sanitizer_start_switch_fiber(fake_stack_save, bottom, size);
>> +#endif
>> +}
>> +
>>  static void coroutine_trampoline(int i0, int i1)
>>  {
>>      union cc_arg arg;
>>      CoroutineUContext *self;
>>      Coroutine *co;
>> +    void *fake_stack_save =3D NULL;
>> +
>> +    finish_switch_fiber(NULL);
>> =20
>>      arg.i[0] =3D i0;
>>      arg.i[1] =3D i1;
>> @@ -72,9 +103,13 @@ static void coroutine_trampoline(int i0, int i1)
>> =20
>>      /* Initialize longjmp environment and switch back the caller */
>>      if (!sigsetjmp(self->env, 0)) {
>> +        start_switch_fiber(&fake_stack_save,
>> +                           leader.stack, leader.stack_size);
>>          siglongjmp(*(sigjmp_buf *)co->entry_arg, 1);
>>      }
>> =20
>> +    finish_switch_fiber(fake_stack_save);
>> +
>>      while (true) {
>>          co->entry(co->entry_arg);
>>          qemu_coroutine_switch(co, co->caller, COROUTINE_TERMINATE);
>> @@ -87,6 +122,7 @@ Coroutine *qemu_coroutine_new(void)
>>      ucontext_t old_uc, uc;
>>      sigjmp_buf old_env;
>>      union cc_arg arg =3D {0};
>> +    void *fake_stack_save =3D NULL;
>> =20
>>      /* The ucontext functions preserve signal masks which incurs a
>>       * system call overhead.  sigsetjmp(buf, 0)/siglongjmp() does not=

>> @@ -122,8 +158,12 @@ Coroutine *qemu_coroutine_new(void)
>> =20
>>      /* swapcontext() in, siglongjmp() back out */
>>      if (!sigsetjmp(old_env, 0)) {
>> +        start_switch_fiber(&fake_stack_save, co->stack, co->stack_siz=
e);
>>          swapcontext(&old_uc, &uc);
>>      }
>> +
>> +    finish_switch_fiber(fake_stack_save);
>> +
>>      return &co->base;
>>  }
>> =20
>> @@ -169,13 +209,19 @@ qemu_coroutine_switch(Coroutine *from_, Coroutin=
e *to_,
>>      CoroutineUContext *from =3D DO_UPCAST(CoroutineUContext, base, fr=
om_);
>>      CoroutineUContext *to =3D DO_UPCAST(CoroutineUContext, base, to_)=
;
>>      int ret;
>> +    void *fake_stack_save =3D NULL;
>> =20
>>      current =3D to_;
>> =20
>>      ret =3D sigsetjmp(from->env, 0);
>>      if (ret =3D=3D 0) {
>> +        start_switch_fiber(action =3D=3D COROUTINE_TERMINATE ?
>> +                           NULL : &fake_stack_save, to->stack, to->st=
ack_size);
>>          siglongjmp(to->env, action);
>>      }
>> +
>> +    finish_switch_fiber(fake_stack_save);
>> +
>>      return ret;
>>  }
>> =20
>>
>=20


--xojl3a59MSxzdrdeX4WMXLU9dortflcbd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpUozMACgkQ4+MsLN6t
wN5LNxAAyzXjQQDvyw9ikNAMvKi+FPg+zxsPw2bkXXfKn6Tvx6gzaaotA4d23oqS
5mRrdaRIvk23DcP3SnMpgNIBuL+p/gRdDRJCkJKQw87lJ06pGiPLaiqHBfh2mCE4
d+QmDW8eqrOrK5Wc2zTbbU2ktTMrPij9ZdOOeAB1woN+8SVHFWtPEeI+h02+fr53
/Q0QUmlMzdI7VgIo7sADC6YZZ9MeFU2b16vJYtE8kOVv0H6b2I6NuiCu6vxJ2+33
MJa9edfLZIo9LMKea72XvlT2N8DLIntaWt2PdRGR0JIoR/fFFVzk8FIMUCh7wLPF
RckZeI1+Xa09Z7ZgAHfqduiOjEBpe9RmY6MkJmZfW4eOjDY/MgrsvXsmrqwnwBlX
GnXeB/RFtwX+CqfY5oeKziYbLldv7pqxF8xncCttAZaJ8B9rtqfpynqGpfmJEC5m
b/puCA+XbIsBWGcBrFVK7ldx+xjdk/9N5abfwtaRm0EuhEX9HbojENM/UXWm15En
GSa3O5wyfsRWpzD3vGlEHujzC64tl4J9G82plb5ai/5Spsgxy65gMz34BypPAoLQ
fOZJIuu20zeSjVGIwt63u9o1aBzBYIDnDUW6O8D3uxDB4yZ1bOevMoxUbEmVKyL+
VJZ78cS1MSBrh+kj69J2BMFbzwviAv6qFYYcCkbKtZcvdvVc6Kc=
=cuQC
-----END PGP SIGNATURE-----

--xojl3a59MSxzdrdeX4WMXLU9dortflcbd--
