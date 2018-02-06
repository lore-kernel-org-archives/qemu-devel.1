Received: from eggs.gnu.org ([2001:4830:134:3::10]:33247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej1Mi-0000tF-8i
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:24:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej1Mf-0007HR-3p
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:24:44 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:33621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ej1Me-0007F0-Pq
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:24:41 -0500
Received: by mail-wm0-x22b.google.com with SMTP id x4-v6so17394072wmc.0
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 03:24:40 -0800 (PST)
References: <20180126045742.5487-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180126045742.5487-1-richard.henderson@linaro.org>
Date: Tue, 06 Feb 2018 11:24:38 +0000
Message-ID: <87eflywebt.fsf@linaro.org>
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

I think this series is good to go.

A quick word on performance. I saw a slight dip for the string sort in
Emilio's dbt-bench/nbench:

  https://i.imgur.com/K5AFr1u.png

And:

                         NBench score; higher is better

  140 +-+-----+------+-------+-------+------+-------+-------+------+-----+-+
      |                           ****                                     |
      |                           *  *##               development         |
  120 +-+.........................*..*.#....................master.......+-+
      |                           *  * #                                   |
  100 +-+............####.........*..*.#.................................+-+
      |              #  #         *  * #                                   |
      |            ***  #         *  * #                                   |
   80 +-+..........*.*..#.........*..*.#.........****###.................+-+
      |            * *  #         *  * #         *  *  #                   |
   60 +-+..........*.*..#.........*..*.#..***###.*..*..#.........***###..+-+
      |            * *  # ****### *  * #  * *  # *  *  #         * *  #    |
      |            * *  # *  *  # *  * #  * *  # *  *  # ****##  * *  #    |
   40 +-+..........*.*..#.*..*..#.*..*.#..*.*..#.*..*..#.*..*.#..*.*..#..+-+
      |            * *  # *  *  # *  * #  * *  # *  *  # *  * #  * *  #    |
   20 +-+..........*.*..#.*..*..#.*..*.#..*.*..#.*..*..#.*..*.#..*.*..#..+-+
      |    ****##  * *  # *  *  # *  * #  * *  # *  *  # *  * #  * *  #    |
      |    *  * #  * *  # *  *  # *  * #  * *  # *  *  # *  * #  * *  #    |
    0 +-+--****##--***###-****###-****##--***###-****###-****##--***###--+-+
        NUMERIC STRING SOBITFIEFP EMULAASSIGNMENT IDEA   HUFFMAN gmean

We think this is likely the strajust function which hits a loop
utilising a single vector. We already know a single vector-op is a worse
case given the latency but this improves if the code is -funrolled or
ultimately re-built with support for bigger vectors ;-)

I certainly don't think it's a blocker to merging given the other
benchmarks look pretty good including slight wins on others.

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
>  accel/tcg/tcg-runtime.h      |  118 +++
>  target/arm/cpu.h             |    2 +-
>  tcg/aarch64/tcg-target.h     |   25 +-
>  tcg/aarch64/tcg-target.opc.h |    3 +
>  tcg/i386/tcg-target.h        |   41 +-
>  tcg/i386/tcg-target.opc.h    |   13 +
>  tcg/tcg-gvec-desc.h          |   49 +
>  tcg/tcg-op-gvec.h            |  306 ++++++
>  tcg/tcg-op.h                 |   52 +-
>  tcg/tcg-opc.h                |   46 +
>  tcg/tcg.h                    |   87 ++
>  accel/tcg/tcg-runtime-gvec.c |  997 +++++++++++++++++++
>  target/arm/translate-a64.c   |  979 ++++++++++++++-----
>  tcg/aarch64/tcg-target.inc.c |  588 ++++++++++-
>  tcg/i386/tcg-target.inc.c    |  987 ++++++++++++++++++-
>  tcg/optimize.c               |  150 +--
>  tcg/tcg-op-gvec.c            | 2215 ++++++++++++++++++++++++++++++++++++=
++++++
>  tcg/tcg-op-vec.c             |  389 ++++++++
>  tcg/tcg-op.c                 |   42 +-
>  tcg/tcg-pool.inc.c           |  115 ++-
>  tcg/tcg.c                    |  125 ++-
>  accel/tcg/Makefile.objs      |    2 +-
>  configure                    |   48 +
>  tcg/README                   |   86 ++
>  25 files changed, 6973 insertions(+), 496 deletions(-)
>  create mode 100644 tcg/aarch64/tcg-target.opc.h
>  create mode 100644 tcg/i386/tcg-target.opc.h
>  create mode 100644 tcg/tcg-gvec-desc.h
>  create mode 100644 tcg/tcg-op-gvec.h
>  create mode 100644 accel/tcg/tcg-runtime-gvec.c
>  create mode 100644 tcg/tcg-op-gvec.c
>  create mode 100644 tcg/tcg-op-vec.c


--
Alex Benn=C3=A9e
