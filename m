Received: from eggs.gnu.org ([2001:4830:134:3::10]:43125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tpearson@raptorengineering.com>) id 1eJLyM-0006Rr-8V
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:09:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tpearson@raptorengineering.com>) id 1eJLyG-00066k-0E
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:09:30 -0500
Received: from mail.rptsys.com ([192.119.205.245]:12698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tpearson@raptorengineering.com>)
	id 1eJLyF-00065Z-9E
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:09:23 -0500
Message-ID: <5A1C38AF.5000108@raptorengineering.com>
Date: Mon, 27 Nov 2017 10:09:19 -0600
From: Timothy Pearson <tpearson@raptorengineering.com>
MIME-Version: 1.0
References: <20171121212534.5177-1-richard.henderson@linaro.org>
In-Reply-To: <20171121212534.5177-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 00/26] tcg: generic vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

Just as a note, I've been watching these series with great interest.
Once the changes settle down / are mergeable we will be looking to
implement vector <--> vector support between a couple of other
architectures.

Thanks for working on this!

On 11/21/2017 03:25 PM, Richard Henderson wrote:
> Quite a lot has changed since last time.
> 
> The representation has changed such that the vector length and element
> size is stored in the TCGOp structure.  The functions have changed such
> that the element size is passed explicitly rather than being encoded in
> the function name.
> 
> I've added additional operations for multiply, immediate shifts, compares,
> element interleaves, and widening.  I believe this is all we'll need for
> implementing ARM SVE, so I'll leave off for now.
> 
> This has been tested vs aa64 risu on both x86_64 and aa64 hosts.
> 
> 
> r~
> 
> 
> Richard Henderson (26):
>   tcg: Remove TCGV_UNUSED* and TCGV_IS_UNUSED*
>   tcg: Dynamically allocate TCGOps
>   tcg: Generalize TCGOp parameters
>   tcg: Add types and basic operations for host vectors
>   tcg: Add generic vector expanders
>   tcg: Allow multiple word entries into the constant pool
>   tcg: Add tcg_signed_cond
>   target/arm: Align vector registers
>   target/arm: Use vector infrastructure for aa64 add/sub/logic
>   target/arm: Use vector infrastructure for aa64 mov/not/neg
>   target/arm: Use vector infrastructure for aa64 dup/movi
>   tcg/i386: Add vector operations
>   tcg: Add tcg_expand_vec_op and tcg-target.opc.h
>   tcg: Add generic vector ops for interleave
>   target/arm: Use vector infrastructure for aa64 zip/uzp/trn/xtn
>   tcg: Add generic vector ops for constant shifts
>   target/arm: Use vector infrastructure for aa64 constant shifts
>   tcg: Add generic vector ops for comparisons
>   target/arm: Use vector infrastructure for aa64 compares
>   tcg/i386: Add vector operations/expansions for shift/cmp/interleave
>   tcg: Add generic vector ops for multiplication
>   target/arm: Use vector infrastructure for aa64 multiplies
>   tcg: Add generic vector ops for extension
>   target/arm: Use vector infrastructure for aa64 widening shifts
>   tcg/i386: Add vector operations/expansions for mul/extend
>   tcg/aarch64: Add vector operations
> 
>  Makefile.target               |    4 +-
>  accel/tcg/tcg-runtime.h       |  102 +++
>  include/exec/gen-icount.h     |    9 +-
>  include/qemu/queue.h          |    5 +
>  target/arm/cpu.h              |    2 +-
>  target/arm/translate.h        |   10 +-
>  tcg/aarch64/tcg-target.h      |   30 +-
>  tcg/aarch64/tcg-target.opc.h  |    3 +
>  tcg/i386/tcg-target.h         |   46 +-
>  tcg/i386/tcg-target.opc.h     |   11 +
>  tcg/tcg-gvec-desc.h           |   49 +
>  tcg/tcg-op-gvec.h             |  219 +++++
>  tcg/tcg-op.h                  |   55 +-
>  tcg/tcg-opc.h                 |   59 ++
>  tcg/tcg.h                     |  135 ++-
>  accel/tcg/tcg-runtime-gvec.c  |  616 +++++++++++++
>  target/alpha/translate.c      |   22 +-
>  target/arm/translate-a64.c    | 1135 ++++++++++++++++-------
>  target/arm/translate.c        |   31 +-
>  target/cris/translate.c       |    4 +-
>  target/hppa/translate.c       |   63 +-
>  target/i386/translate.c       |   13 +-
>  target/lm32/translate.c       |    2 -
>  target/m68k/translate.c       |   14 +-
>  target/microblaze/translate.c |    4 -
>  target/mips/translate.c       |    2 +-
>  target/nios2/translate.c      |    6 +-
>  target/ppc/translate.c        |    2 +-
>  target/s390x/translate.c      |   42 +-
>  target/sh4/translate.c        |    2 +-
>  target/sparc/translate.c      |    2 +-
>  target/tilegx/translate.c     |   10 +-
>  target/unicore32/translate.c  |    4 +-
>  tcg/aarch64/tcg-target.inc.c  |  674 +++++++++++++-
>  tcg/i386/tcg-target.inc.c     | 1325 +++++++++++++++++++++++++--
>  tcg/optimize.c                |   20 +-
>  tcg/tcg-op-gvec.c             | 2010 +++++++++++++++++++++++++++++++++++++++++
>  tcg/tcg-op-vec.c              |  566 ++++++++++++
>  tcg/tcg-op.c                  |   24 -
>  tcg/tcg-pool.inc.c            |  115 ++-
>  tcg/tcg.c                     |  286 ++++--
>  accel/tcg/Makefile.objs       |    2 +-
>  tcg/README                    |  148 +++
>  43 files changed, 7107 insertions(+), 776 deletions(-)
>  create mode 100644 tcg/aarch64/tcg-target.opc.h
>  create mode 100644 tcg/i386/tcg-target.opc.h
>  create mode 100644 tcg/tcg-gvec-desc.h
>  create mode 100644 tcg/tcg-op-gvec.h
>  create mode 100644 accel/tcg/tcg-runtime-gvec.c
>  create mode 100644 tcg/tcg-op-gvec.c
>  create mode 100644 tcg/tcg-op-vec.c
> 


-- 
Timothy Pearson
Raptor Engineering
+1 (415) 727-8645 (direct line)
+1 (512) 690-0200 (switchboard)
https://www.raptorengineering.com
