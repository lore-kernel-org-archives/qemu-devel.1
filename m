Received: from eggs.gnu.org ([2001:4830:134:3::10]:52237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egaAV-0005Dm-SL
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:58:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egaA2-0007Ar-8t
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:58:03 -0500
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:34819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1egaA1-00079l-Ql
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:57:34 -0500
Received: by mail-ot0-x233.google.com with SMTP id j45so8368874ota.2
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 09:57:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180130044621.10464-1-richard.henderson@linaro.org>
References: <20180130044621.10464-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jan 2018 17:57:12 +0000
Message-ID: <CAFEAcA8Vf0VR2jqiY1gwok-d_x=6spZbHrTZTiBD-hKicq+zbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v5 00/43] hppa-softmmu
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

On 30 January 2018 at 04:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Changes since v4:
>   * Fix format warnings for 32-bit host.
>
>
> r~
>
>
> The following changes since commit 30d9fefe1aca1e92c785214aa9201fd7c2287d=
56:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/input-20180129-v2-pul=
l-request' into staging (2018-01-29 15:52:27 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-hppa-20180129
>
> for you to fetch changes up to 8d077702ca076c0264e111b95c2c211e5ab9a314:
>
>   target/hppa: Implement PROBE for system mode (2018-01-29 20:40:01 -0800=
)
>
> ----------------------------------------------------------------
> Implement hppa-softmmu
>
> ----------------------------------------------------------------

The Windows build fails:

/home/petmay01/linaro/qemu-for-merges/target/hppa/translate.c: In
function =E2=80=98gen_hlt=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/target/hppa/translate.c:2336:9:
error: implicit declaration of function =E2=80=98gen_helper_shutdown=E2=80=
=99
[-Werror=3Dimplicit-function-declaration]
         gen_helper_shutdown(cpu_env);
         ^
/home/petmay01/linaro/qemu-for-merges/target/hppa/translate.c:2336:9:
error: nested extern declaration of =E2=80=98gen_helper_shutdown=E2=80=99
[-Werror=3Dnested-externs]

I think here you're falling foul of this thing in include/win32/os-win32.h:

#define shutdown qemu_shutdown_wrap

which messes up the use in the HELPER macro.


/home/petmay01/linaro/qemu-for-merges/target/hppa/translate.c: In
function =E2=80=98trans_probe=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/target/hppa/translate.c:2403:37:
error: =E2=80=98PROT_WRITE=E2=80=99 undeclared (first use in this function)
     want =3D tcg_const_i32(is_write ? PROT_WRITE : PROT_READ);
                                     ^
/home/petmay01/linaro/qemu-for-merges/target/hppa/translate.c:2403:37:
note: each undeclared identifier is reported only once for each
function it appears in
/home/petmay01/linaro/qemu-for-merges/target/hppa/translate.c:2403:50:
error: =E2=80=98PROT_READ=E2=80=99 undeclared (first use in this function)
     want =3D tcg_const_i32(is_write ? PROT_WRITE : PROT_READ);
                                                  ^
cc1: all warnings being treated as errors

I'm guessing you wanted PAGE_READ and PAGE_WRITE.

thanks
-- PMM
