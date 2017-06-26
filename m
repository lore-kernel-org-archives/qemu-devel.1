Received: from eggs.gnu.org ([2001:4830:134:3::10]:56536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPXCK-0004dD-Ux
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPXCH-0004EE-Ru
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:49:13 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:36303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dPXCH-0004Di-L8
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:49:09 -0400
Received: by mail-wm0-x22c.google.com with SMTP id 62so2857214wmw.1
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 09:49:09 -0700 (PDT)
References: <20170621024831.26019-1-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170621024831.26019-1-rth@twiddle.net>
Date: Mon, 26 Jun 2017 17:49:58 +0100
Message-ID: <871sq6y9qh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/16] Cleanups within TCG middle-end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net


Richard Henderson <rth@twiddle.net> writes:

> There are two conceptually unrelated cleanups in here, though
> the second touches many of the same lines as the first, so
> separating the two would be ugly.
>
> The first is to split gen_opparam_buf and move the pieces into
> TCGOp.  This has two effects: the operands for an op is in the
> same cacheline as the op, and we get to drop the pointer into
> gen_opparam_buf, freeing up a register and/or function argument.
>
> The second is to change what value is stored in TCGArg for each
> TCG temporary.  Rather than store the index into tcg_ctx.temps,
> store the pointer to the temp itself.  This allows us to drop
> some arithmetic on many uses of a temp within the backend.
>
> Making that second change is tricky, as we don't want to miss any
> of the places that ought to be changed.  To do that I introduce a
> number of helpers.
>
> As a final step I changed the type of TCGOp.args to a structure,
> and annotated the places that access constant arguments.  I found
> that final patch to be really ugly, so I dropped it.  But I'm
> fairly confident that I've updated all of the non-constant args.
>
> The effect of this is nearly noise, but does reduce code size,
>
>    text	   data	    bss	    dec	    hex	filename
> 6648688	2106408	4486112	13241208 ca0b78	qemu-system-alpha (before)
> 6627656	2106408	4502496	13236560 c9f950	qemu-system-alpha (after)
>
> or about 21k.

Hmm it compile tested fine on mine but:

qemu-system-sparc: /home/alex/lsrc/qemu/qemu.git/tcg/tcg.h:725: temp_arg: Assertion `n < tcg_ctx.nb_temps' failed.
Broken pipe
GTester: last random seed: R02Sd6911d835e4140adeb8780ec1bf70af1
qemu-system-sparc: /home/alex/lsrc/qemu/qemu.git/tcg/tcg.h:725: temp_arg: Assertion `n < tcg_ctx.nb_temps' failed.
Broken pipe
GTester: last random seed: R02Sff8343267ed0c224ea97a4f54e970d65
qemu-system-sparc: /home/alex/lsrc/qemu/qemu.git/tcg/tcg.h:725: temp_arg: Assertion `n < tcg_ctx.nb_temps' failed.
Broken pipe
GTester: last random seed: R02Sfb0d300ff314d4f31a4f5bb414f5f249
/home/alex/lsrc/qemu/qemu.git/tests/Makefile.include:824: recipe for target 'check-qtest-sparc' failed
make: *** [check-qtest-sparc] Error 1
test: Expected a combining operator like '-a' at index 1

And also Travis is quite un-happy:

  https://travis-ci.org/stsquad/qemu/builds/247099991


>
>
> r~
>
>
> Richard Henderson (16):
>   tcg: Merge opcode arguments into TCGOp
>   tcg: Propagate args to op->args in optimizer
>   tcg: Propagate args to op->args in tcg.c
>   tcg: Propagate TCGOp down to allocators
>   tcg: Introduce arg_temp
>   tcg: Add temp_global bit to TCGTemp
>   tcg: Return NULL temp for TCG_CALL_DUMMY_ARG
>   tcg: Introduce temp_arg
>   tcg: Use per-temp state data in liveness
>   tcg: Avoid loops against variable bounds
>   tcg: Change temp_allocate_frame arg to TCGTemp
>   tcg: Remove unused TCG_CALL_DUMMY_TCGV
>   tcg: Export temp_idx
>   tcg: Use per-temp state data in optimize
>   tcg: Define separate structures for TCGv_*
>   tcg: Store pointers to temporaries directly in TCGArg
>
>  tcg/optimize.c | 647 ++++++++++++++++++++++++++++++++-------------------------
>  tcg/tcg-op.c   |  99 ++++-----
>  tcg/tcg.c      | 610 ++++++++++++++++++++++++-----------------------------
>  tcg/tcg.h      | 287 ++++++++++++++-----------
>  4 files changed, 841 insertions(+), 802 deletions(-)


--
Alex Bennée
