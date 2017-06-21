Received: from eggs.gnu.org ([2001:4830:134:3::10]:33834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNVhA-0006Pf-Nk
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNVh7-0002Jd-Lz
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:40 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:33486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNVh7-0002JV-HU
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:37 -0400
Received: by mail-qt0-x22a.google.com with SMTP id u12so147845143qth.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 19:48:37 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 20 Jun 2017 19:48:15 -0700
Message-Id: <20170621024831.26019-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 00/16] Cleanups within TCG middle-end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net

There are two conceptually unrelated cleanups in here, though
the second touches many of the same lines as the first, so
separating the two would be ugly.

The first is to split gen_opparam_buf and move the pieces into
TCGOp.  This has two effects: the operands for an op is in the
same cacheline as the op, and we get to drop the pointer into
gen_opparam_buf, freeing up a register and/or function argument.

The second is to change what value is stored in TCGArg for each
TCG temporary.  Rather than store the index into tcg_ctx.temps,
store the pointer to the temp itself.  This allows us to drop
some arithmetic on many uses of a temp within the backend.

Making that second change is tricky, as we don't want to miss any
of the places that ought to be changed.  To do that I introduce a
number of helpers.

As a final step I changed the type of TCGOp.args to a structure,
and annotated the places that access constant arguments.  I found
that final patch to be really ugly, so I dropped it.  But I'm
fairly confident that I've updated all of the non-constant args.

The effect of this is nearly noise, but does reduce code size,

   text	   data	    bss	    dec	    hex	filename
6648688	2106408	4486112	13241208 ca0b78	qemu-system-alpha (before)
6627656	2106408	4502496	13236560 c9f950	qemu-system-alpha (after)

or about 21k.


r~


Richard Henderson (16):
  tcg: Merge opcode arguments into TCGOp
  tcg: Propagate args to op->args in optimizer
  tcg: Propagate args to op->args in tcg.c
  tcg: Propagate TCGOp down to allocators
  tcg: Introduce arg_temp
  tcg: Add temp_global bit to TCGTemp
  tcg: Return NULL temp for TCG_CALL_DUMMY_ARG
  tcg: Introduce temp_arg
  tcg: Use per-temp state data in liveness
  tcg: Avoid loops against variable bounds
  tcg: Change temp_allocate_frame arg to TCGTemp
  tcg: Remove unused TCG_CALL_DUMMY_TCGV
  tcg: Export temp_idx
  tcg: Use per-temp state data in optimize
  tcg: Define separate structures for TCGv_*
  tcg: Store pointers to temporaries directly in TCGArg

 tcg/optimize.c | 647 ++++++++++++++++++++++++++++++++-------------------------
 tcg/tcg-op.c   |  99 ++++-----
 tcg/tcg.c      | 610 ++++++++++++++++++++++++-----------------------------
 tcg/tcg.h      | 287 ++++++++++++++-----------
 4 files changed, 841 insertions(+), 802 deletions(-)

-- 
2.9.4
