Received: from eggs.gnu.org ([2001:4830:134:3::10]:33776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d2vIg-0008Fz-DG
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d2vIf-0000jq-3Y
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:54:18 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 25 Apr 2017 03:53:46 -0400
Message-Id: <1493106839-10438-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 00/13] TCG optimizations for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

v1 for context:
  https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02021.html

This series is aimed at 2.10 or beyond. Its goal is to improve
TCG code execution performance by optimizing:

1- Cross-page direct jumps (softmmu only, obviously)
2- Indirect branches (both softmmu and user-mode)
3- tb_jmp_cache hashing in user-mode (last patch)

Optimizations 1 and 2 are optional. This series implements them
for the i386 TCG backend and the ARM and i386 front-ends; other
backends/frontends can easily opt-in later on.

Changes from v1:

- Followed Richard's design, i.e. have a single helper in tcg-runtime
  and have the TCG op (now called "goto_ptr") to directly jump
  to the host pointer. This pointer is always valid since it's
  either pointing to the (valid) target or to TCG's epilogue. This
  simplifies the whole thing; the only branch in the code path is
  now the one that checks whether the tb pointer from tb_jmp_cache
  is valid.

- Much better performance (e.g. 2.4x speedup for "train" xalancbmk) --
  I'm guessing the design with just one branch is the reason. Also,
  I was unconditionally assigning ret=0 when entering the epilogue;
  fixed now.

- Document goto_ptr in tcg/README, as suggested by Paolo.

- target/i386: also optimized ret/ret im.

- Ensure that TCGContext's read-mostly fields are accessed without
  cache line bouncing. Note that (1) every time we translate,
  TCGContext is heavily written to, and (2) the address of the
  epilogue, which is now accessed in a fast path, is part of
  TCGContext. So patches 3 and 4 make sure there is no false sharing
  of cache lines between these two access patterns.

- Evaluated Paolo's suggestion of using multiplicative hashing. See
  the last patch's commit log.

Things I didn't do:

- Apply the optimization to syscall instructions in target/i386.

- Look at the impact of TLB flushes. With these (new, improved) perf
  numbers there is less reason to worry about this, although they
  should explain the perf differences between softmmu and user-mode.
  Thanks Alex for pointing me out to your profiling code though!
  Learning to use trace points is next in my QEMU TODO list, so I'll
  take a look.

The series applies cleanly on v2.9.0. Measurements are in the
commit logs. You can inspect/fetch the changes at:
  https://github.com/cota/qemu/tree/tcg-opt-v2

Thanks,

		Emilio
