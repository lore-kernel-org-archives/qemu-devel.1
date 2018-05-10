Received: from eggs.gnu.org ([2001:4830:134:3::10]:59733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGmW3-0005Xz-9e
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGmW2-0004O1-BW
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:25:55 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:39042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fGmW2-0004Nv-5e
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:25:54 -0400
Received: by mail-oi0-x241.google.com with SMTP id n65-v6so1910528oig.6
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 07:25:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9TU_xejXo7ZFUFWK1anqLJ-cHjBLJHmgNnEr=kd-mnXw@mail.gmail.com>
References: <20180508151437.4232-1-richard.henderson@linaro.org>
	<20180508151437.4232-5-richard.henderson@linaro.org>
	<CAFEAcA-6uQ4P=e7iJeNvPBVn6hxLFysG1-dLPdDeTpdpRn8mwQ@mail.gmail.com>
	<CAFEAcA_YUTbDrTKGBzZtR5MUS3VTCFANmxZ0cBLMMS=OuO_R9A@mail.gmail.com>
	<CAFEAcA9TU_xejXo7ZFUFWK1anqLJ-cHjBLJHmgNnEr=kd-mnXw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 15:25:26 +0100
Message-ID: <CAFEAcA-j8hk13j0Pr0j=s5iyThNPL2+NcsgVTyPiNyaHx1v9Qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/10] tcg: Introduce atomic helpers for
 integer min/max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 May 2018 at 19:27, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 8 May 2018 at 18:49, Peter Maydell <peter.maydell@linaro.org> wrote:
>> [weird compiler errors]
>
> This fixes them:
>
> --- a/include/qemu/atomic.h
> +++ b/include/qemu/atomic.h
> @@ -187,7 +187,7 @@
>  /* Returns the eventual value, failed or not */
>  #define atomic_cmpxchg__nocheck(ptr, old, new)    ({                    =
\
>      typeof_strip_qual(*ptr) _old =3D (old);                             =
  \
> -    __atomic_compare_exchange_n(ptr, &_old, new, false,                 =
\
> +    (void)__atomic_compare_exchange_n(ptr, &_old, new, false,           =
\
>                                __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST);      =
\
>      _old;                                                               =
\
>  })
>
> Seems pretty clearly a compiler bug -- rth says newer gcc don't
> do this, so presumably fixed upstream somewhere between gcc 5 and 6.

Standalone testcase, fwiw:

=3D=3D=3Dbegin=3D=3D=3D
/*
 * Weirdly, this compiler will complain about FOO(int8_t) but not
 * the others:
 * $ gcc -g -Wall -Wunused-value -o zz9.o -c zz9.c
 * zz9.c: In function =E2=80=98foo_int8_t=E2=80=99:
 * zz9.c:12:5: warning: value computed is not used [-Wunused-value]
 *     __atomic_compare_exchange_n(p, exp, des, 0, __ATOMIC_SEQ_CST,
__ATOMIC_SEQ_CST); \
 *     ^
 * /tmp/zz9.c:17:1: note: in expansion of macro =E2=80=98FOO=E2=80=99
 * FOO(int8_t)
 * ^
 *
 * This is gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
 */

typedef unsigned char uint8_t;
typedef signed char int8_t;

#define FOO(TYPE) \
void foo_##TYPE(TYPE *p, TYPE *exp, TYPE *des) { \
    __atomic_compare_exchange_n(p, exp, des, 0, __ATOMIC_SEQ_CST,
__ATOMIC_SEQ_CST); \
}

FOO(int)
FOO(uint8_t)
FOO(int8_t)
=3D=3D=3Dendit=3D=3D=3D

thanks
-- PMM
