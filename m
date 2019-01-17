Received: from eggs.gnu.org ([209.51.188.92]:43776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkBcG-0003Vg-ND
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:38:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkBcF-00008K-Pj
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:38:08 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:46418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkBcF-00006K-AG
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:38:07 -0500
Received: by mail-oi1-x230.google.com with SMTP id x202so6770572oif.13
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 09:38:06 -0800 (PST)
MIME-Version: 1.0
References: <20190117132703.17790-1-alex.bennee@linaro.org>
In-Reply-To: <20190117132703.17790-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jan 2019 17:37:54 +0000
Message-ID: <CAFEAcA_E2Lf9Zh2WhVDddJiD5TPPyLk1RvT7_Asn4vXnao1NjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/7] check-softfloat,
 fp-bench and clang compile fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 17 Jan 2019 at 13:27, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 4b9f0b0f7c84eea2dfb0d5be3e0254bc91319d=
bc:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-01-15 17:24:00 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-fpu-next-170119-1
>
> for you to fetch changes up to f722d6877d4e91e984480a4b687cf12971b6c931:
>
>   tests/Makfile: add check-softfloat rule (2019-01-17 09:12:33 +0000)
>
> ----------------------------------------------------------------
> Some more softfloat/fpu fixes
>
>    - make check-softfloat
>    - fixes for fp-bench
>    - workaround broken host fma
>    - compile fix for s390x/clang
>
> ----------------------------------------------------------------

FreeBSD, OSX, x86-64 Linux clang builds:

Lots of these trying to build code in tests/fp:

warning: unknown warning option '-Wno-discarded-qualifiers'; did you
mean '-Wno-ignored-qualifiers'? [-Wunknown-warning-option]
warning: unknown warning option '-Wno-maybe-uninitialized'; did you
mean '-Wno-uninitialized'? [-Wunknown-warning-option]


/var/tmp/qemu-test.Z0AmK8/tests/fp/berkeley-testfloat-3/source/fail.c:44:7:
warning: initializing 'char *' with an expression of type 'const char
[1]' discards qualifiers
[-Wincompatible-pointer-types-discards-qualifiers]
char *fail_programName =3D "";
      ^                  ~~


fp-test.c:905:33: warning: incompatible pointer types assigning to
'uint_fast8_t (*)(void)' (aka 'unsigned int (*)(void)') from 'uint8_t
(void)' (aka 'unsigned char (void)') [-Wincompatible-pointer-types]
    testLoops_trueFlagsFunction =3D slow_clear_flags;
                                ^ ~~~~~~~~~~~~~~~~
fp-test.c:906:33: warning: incompatible pointer types assigning to
'uint_fast8_t (*)(void)' (aka 'unsigned int (*)(void)') from 'uint8_t
(void)' (aka 'unsigned char (void)') [-Wincompatible-pointer-types]
    testLoops_subjFlagsFunction =3D qemu_clear_flags;
                                ^ ~~~~~~~~~~~~~~~~


PPC64, AArch64:
 * same warning about discarding 'const' in fail.c as above
 * cc1: warning: unrecognized command line option
"-Wno-discarded-qualifiers" [enabled by default]

NetBSD:
 * same warning about slow_clear_flags/qemu_clear_flags assignments

S390X host:
Looks like a failure running the tests, but no diagnostics about
what exactly went wrong or clear "test failed" indicator:

cd /home/linux1/qemu/build/all/tests/fp && ./fp-test -s -l 1
i32_to_f16 i64_to_f16 i32_to_f32 i64_t
o_f32 i32_to_f64 i64_to_f64 i32_to_f128 i64_to_f128 >
int-to-float.out 2>  int-to-float.err
/home/linux1/qemu/tests/Makefile.include:913: recipe for target
'check-softfloat-conv' failed
make: *** [check-softfloat-conv] Error 1

thanks
-- PMM
