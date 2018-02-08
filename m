Received: from eggs.gnu.org ([2001:4830:134:3::10]:36527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejnA4-0005IN-Eg
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejnA3-00012Q-GF
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:26:52 -0500
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:45050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejnA3-00012G-AV
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:26:51 -0500
Received: by mail-oi0-x234.google.com with SMTP id b3so3581787oib.11
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 06:26:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180207225540.31698-1-richard.henderson@linaro.org>
References: <20180207225540.31698-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2018 14:26:29 +0000
Message-ID: <CAFEAcA91kk1p_98okxYXEzJfXonv=QfqGdAeRRdqFWWboWK4rA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/20] tcg: generic vector operaions
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

On 7 February 2018 at 22:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Aside from r-b markers, there is only one minor change from v11.
>
> The check_operand_size assert loosened to allow 8-byte operation
> with a large (in this case 32-byte) clear.  Previously we'd test
> the clear size and require the operation be a multiple of 16.
> This showed up during an AdvSIMD insn with SVE enabled.
>
>
> r~
>
>
> The following changes since commit 17a5bbb44df9a4a79166332bc26e2d8ca6bd8fa8:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-02-06' into staging (2018-02-07 16:26:01 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20180207
>
> for you to fetch changes up to b63799b11c17e8f1068dbd05c18cbb9c9aa69c56:
>
>   tcg/aarch64: Add vector operations (2018-02-07 14:47:50 -0800)
>
> ----------------------------------------------------------------
> tcg generic vectors

alpha guest boot-serial-test fails on ppc64 host:

QTEST_QEMU_BINARY=alpha-softmmu/qemu-system-alpha
QTEST_QEMU_IMG=qemu-img MALLOC_PERTURB_=${MALLOC_PERTURB_:-$((
${RANDOM:-0} % 255 +
1))} gtester -k --verbose -m=quick tests/boot-serial-test
tests/qmp-test tests/device-introspect-test tests/qom-test
tests/test-hmp
TEST: tests/boot-serial-test... (pid=60169)
  /alpha/boot-serial/clipper:
qemu-system-alpha: /home/pm215/qemu/tcg/ppc/tcg-target.inc.c:55
5: patch_reloc: Assertion `hi + lo == value' failed.
Broken pipe
FAIL
GTester: last random seed: R02Sdc2c32b69bd880017ace08222ce46dd8
(pid=60174)
FAIL: tests/boot-serial-test

and on sparc64 host:

QTEST_QEMU_BINARY=alpha-softmmu/qemu-system-alpha
QTEST_QEMU_IMG=qemu-img MALLOC_PERTURB_=${MALLOC_PERTURB_:-$((
${RANDOM:-0} % 255 +
1))} gtester -k --verbose -m=quick tests/boot-serial-test
tests/qmp-test tests/device-introspect-test tests/qom-test
tests/test-hmp
TEST: tests/boot-serial-test... (pid=15664)
  /alpha/boot-serial/clipper:
qemu-system-alpha: /home/pm215/qemu/tcg/sparc/tcg-target.inc.c:319:
patch_reloc: Assertion `check_fit_ptr(value, 13)' failed.
Broken pipe
FAIL
GTester: last random seed: R02Se799092027459ef1507e239bdc0212a2
(pid=15801)
FAIL: tests/boot-serial-test

(same assert also fires for hppa boot-serial test and numerous other
tests that run guest code)

thanks
-- PMM
