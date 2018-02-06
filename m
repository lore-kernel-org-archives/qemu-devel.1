Received: from eggs.gnu.org ([2001:4830:134:3::10]:54748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej636-0004px-9W
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:24:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej633-0002YP-L6
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:24:48 -0500
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:45871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ej633-0002XD-Ef
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:24:45 -0500
Received: by mail-wr0-x22d.google.com with SMTP id h9so2556291wre.12
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 08:24:45 -0800 (PST)
References: <20180126045742.5487-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180126045742.5487-1-richard.henderson@linaro.org>
Date: Tue, 06 Feb 2018 16:24:42 +0000
Message-ID: <87bmh2w0fp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 00/20] tcg: generic vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Changes since v11:
>   * Use dup_const more.
>   * Cleanup some gvec 2i and 2s routines.
>   * Use more helpers and less gotos in target/arm/translate-a64.c.

I just noticed the aarch64 cross build breaks:

n file included from /root/src/github.com/stsquad/qemu/tcg/tcg.c:296:0:
/root/src/github.com/stsquad/qemu/tcg/aarch64/tcg-target.inc.c: In function=
 'tcg_out_dupi_vec':
/root/src/github.com/stsquad/qemu/tcg/aarch64/tcg-target.inc.c:806:9: error=
: implicit declaration of function 'new_pool_l2' [-Werror=3Dimplicit-functi=
on-declaration]
         new_pool_l2(s, R_AARCH64_CONDBR19, s->code_ptr, 0, v64, v64);

>
> Changes since v10:
>   * Squashed a fixup patch which escaped my attention while preparing
>     the patch set.  Ho hum.
>
> Changes since v9:
>   * Detect whether __attribute__((vector_size(16))) operations are
>     supported by the host compiler.  This includes the case affecting
>     ppc64 where gcc-4.8.5 crashes.  Note that gcc-7.2 does pass the
>     test on ppc64.
>
>   * Dropped support for vector interleaves and element size changes.
>     My target/arm patches were failing RISU checks on a big-endian host.
>     I need to re-think what to do about host endianness and target
>     representation of vector operations crossing lanes.  For now, only
>     support generic vector operations that are agnostic to element order.
>
>
> r~
>
>
> Richard Henderson (20):
>   tcg: Allow multiple word entries into the constant pool
>   tcg: Add types and basic operations for host vectors
>   tcg: Standardize integral arguments to expanders
>   tcg: Add generic vector expanders
>   tcg: Add generic vector ops for constant shifts
>   tcg: Add generic vector ops for comparisons
>   tcg: Add generic vector ops for multiplication
>   tcg: Add generic helpers for saturating arithmetic
>   tcg: Add generic vector helpers with a scalar operand
>   tcg/optimize: Handle vector opcodes during optimize
>   target/arm: Align vector registers
>   target/arm: Use vector infrastructure for aa64 add/sub/logic
>   target/arm: Use vector infrastructure for aa64 mov/not/neg
>   target/arm: Use vector infrastructure for aa64 dup/movi
>   target/arm: Use vector infrastructure for aa64 constant shifts
>   target/arm: Use vector infrastructure for aa64 compares
>   target/arm: Use vector infrastructure for aa64 multiplies
>   target/arm: Use vector infrastructure for aa64 orr/bic immediate
>   tcg/i386: Add vector operations
>   tcg/aarch64: Add vector operations
>
>  Makefile.target              |    4 +-
<snip>

--
Alex Benn=C3=A9e
