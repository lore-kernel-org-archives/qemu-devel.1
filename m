Received: from eggs.gnu.org ([209.51.188.92]:57182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzIvC-0005AV-Qm
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:28:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzIvB-0000db-K8
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:28:10 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:33513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzIvB-0000VY-8J
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:28:09 -0500
Received: by mail-ot1-x334.google.com with SMTP id q24so17238482otk.0
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 02:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20190225203233.3439-1-jcmvbkbc@gmail.com>
In-Reply-To: <20190225203233.3439-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 10:27:38 +0000
Message-ID: <CAFEAcA_oanfMXGd1cD=+ypL5N32Hm8JR064LWdW09WCVwZXVRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/40] target/xtensa queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 25 Feb 2019 at 20:32, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Hi Peter,
>
> please pull the following batch of target/xtensa updates:
>
> The following changes since commit 1c3d45df5e94042d5fb2bb31416072563ab30e49:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-02-04' into staging (2019-02-05 12:46:18 +0000)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20190225-xtensa
>
> for you to fetch changes up to 116f9089402081231ebc6d0012e4e029f21f63af:
>
>   tests/tcg/xtensa: add FPU2000 coprocessor tests (2019-02-18 22:09:10 -0800)
>
> ----------------------------------------------------------------
> target/xtensa: FLIX support, various fixes and test improvements
>
> - add FLIX (flexible length instructions extension) support;
> - make testsuite runnable on wider range of xtensa cores;
> - add floating point opcode tests;
> - don't add duplicate 'static' in import_core.sh script;
> - fix undefined opcodes detection in test_mmuhifi_c3 overlay.
>

Hi -- I'm afraid this fails to build on some clang compilers:

/Users/pm215/src/qemu-for-merges/target/xtensa/translate.c:967:14:
error: result of comparison of constant 256 with expression of type
'enum resource_type' is always true
[-Werror,-Wtautological-constant-out-of-range-compare]
    assert(r < 256 && g < 256 && n < 65536);
           ~ ^ ~~~
/usr/include/assert.h:93:25: note: expanded from macro 'assert'
    (__builtin_expect(!(e), 0) ? __assert_rtn(__func__, __FILE__,
__LINE__, #e) : (void)0)
                        ^

Here r is of type 'enum resource_type', so the compiler
is allowed to pick any type to represent it that will fit all
the values in the enum. In this case the compiler has picked
a char type. Asserting that r is either RES_REGFILE or RES_STATE
would probably work better.

thanks
-- PMM
