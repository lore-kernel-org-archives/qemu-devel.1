Received: from eggs.gnu.org ([2001:4830:134:3::10]:43058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRPw3-0002ZM-Rq
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 18:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRPvz-0000GX-6c
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 18:04:59 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:46475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gRPvy-0000GK-Vm
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 18:04:55 -0500
Received: by mail-pg1-x52d.google.com with SMTP id w7so6858683pgp.13
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 15:04:54 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-170-180.tukw.qwest.net.
	[97.113.170.180]) by smtp.gmail.com with ESMTPSA id
	o13sm1798703pfk.57.2018.11.26.15.04.51 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 26 Nov 2018 15:04:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 26 Nov 2018 15:04:46 -0800
Message-Id: <20181126230450.672-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/4] tcg: Remove unreachable code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I've been meaning to add a trivial cleanup pass like this for some time.

There have occasionally been instaces within front ends wherein we want
to raise an invalid operand exception (or some such) deep within a set
of subroutines.  And without a longjmp (or some such) back to the top
level of the translator loop we must return a dummy value so that we
produce valid tcg code following the exception.

While we still probably have to return a dummy value, we can clean up
the dead code that follows the exception.

In addition, when optimization is able to fold a conditional branch,
the original code sequence:

	brcond x,y,$L1
	goto_tb
	mov pc,foo
	exit_tb $1
        set_label $L1
        goto_tb 
        mov pc,bar
        exit_tb $2

The initial brcond is either folded to br, or removed as a never taken
branch, which leaves one of the two sets of goto_tb ... exit_tb unreachable.

With this we can completely remove the code for the dead branch.

While I do not expect this to have any noticable effect, this dead
code could get in the way of some other changes that I'm planning.


r~


Richard Henderson (4):
  tcg: Renumber TCG_CALL_* flags
  tcg: Add TCG_CALL_NO_RETURN
  tcg: Reference count labels
  tcg: Add reachable_code_pass

 include/exec/helper-head.h | 13 ++++++
 include/exec/helper-tcg.h  | 21 ++++++---
 tcg/tcg-op.h               |  1 +
 tcg/tcg.h                  | 11 +++--
 tcg/tcg-op.c               |  2 +
 tcg/tcg.c                  | 96 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 133 insertions(+), 11 deletions(-)

-- 
2.17.2
