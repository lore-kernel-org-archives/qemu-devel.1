Received: from eggs.gnu.org ([209.51.188.92]:45598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gtEW5-0002bj-WC
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gtEW2-0003bX-0J
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:33:09 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:49500 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gtEVz-0002g7-M3
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:33:05 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 11 Feb 2019 17:31:18 +0100
Message-Id: <1549902684-21740-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 0/6] target-mips: support MTTCG feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com, alex.bennee@linaro.org, pburton@wavecomp.com, cota@braap.org

From: Aleksandar Markovic <amarkovic@wavecomp.com>

v2->v3:

  - rebased to the latest QEMU code, most notably:
     - LL/SC-related EVA instructions integration
     - LL/SC-related nanoMIPS instructions integration

v1->v2:

  - patches #3 and #4 are squashed into one to avoid bisect breaking
  - improved locking features in patch #5 (formerly #6)
  - commit messages reviewed and improved
  - rebased to the latest code


This series introduces MTTCG feature for MIPS targets by adding all
missing bits and pieces, and formally enabling corresponding QEMU
builds to support such configurations.

PATCH ORGANIZATION
==================

The organization of patches is as follows:

  - patches 1 and 2 deal with MIPS' LL/SC instruction emulation
    improvements related to MTTCG. They are based on a previously
    sent patch series by Leon Alrae (this is the last version, v3):
    http://lists.gnu.org/archive/html/qemu-devel/2016-09/msg06870.html

  - patches 3, 4, and 5 deal with locking/synchronization issues
    that surfaced while introducing MTTCG for MIPS. Similar sets of
    patches have been already integrated for some other platforms
    (arm, intel, ppc, sparc).

  - patch 6 just enables QEMU build system to support MTTCG feature
    for MIPS targets.

PERFORMANCE TESTING
===================

Performance testing was performed using atomic_add-bench test program
that tests LL/SC-related functionality in multithread environment. The
observed performance gain was significant.

For the sake of comparison, test case organization mimics the one from
a previously sent patch set:

target-arm: emulate aarch64's LL/SC using cmpxchg helpers
https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg06653.html

-----------------------------------------------------------------------

          atomic_add-bench: 1000000 ops/thread, [0,1] range
                                               
throughput                                  M - MTTCG     N - no MTTCG

 50 +---------+---------+---------+---------+---------+---------+----+
    |                                                                |
    |M                                                               |
 40 +.                                                               +
    |.                                                               |
    |.                                                               |
 30 +.                                                               +
    |.                                                               |
    |.                                                               |
 20 +.                                                               +
    | M                                                              |
    | .                                                              |
 10 +  .M...M.......M.......M.......M.......M.......M.......M.......M+
    |N                                                               |
    | N.N...N.......N.......N.......N.......N.......N.......N.......N|
  0 +---------+---------+---------+---------+---------+---------+----+
    0         10        20        30        40        50        60

                            number of threads

-----------------------------------------------------------------------

          atomic_add-bench: 1000000 ops/thread, [0,2] range
                                               
throughput                                  M - MTTCG     N - no MTTCG

 50 +---------+---------+---------+---------+---------+---------+----+
    |                                                                |
    |M                                                               |
 40 +.                                                               +
    |.                                                               |
    |.                                                               |
 30 + .                                                              +
    | M                                                              |
    | .                                                              |
 20 +  .M...M.......M.......M.......M.......M.......M.......M.......M+
    |                                                                |
    |                                                                |
 10 +                                                                +
    |N                                                               |
    | N.N...N.......N.......N.......N.......N.......N.......N.......N|
  0 +---------+---------+---------+---------+---------+---------+----+
    0         10        20        30        40        50        60

                            number of threads

-----------------------------------------------------------------------

          atomic_add-bench: 1000000 ops/thread, [0,1] range
                                               
throughput                                  M - MTTCG     N - no MTTCG

150 +---------+---------+---------+---------+---------+---------+----+
    |                                                                |
    |                                            ...M...        ....M|
120 +                   ....M.......M........M...       ....M...     +
    |           ....M...                                             |
    |     ..M...                                                     |
 90 +    .                                                           +
    |  .M                                                            |
    | .                                                              |
 60 + M                                                              +
    |.                                                               |
    |M                                                               |
 30 +                                                                +
    |                                                                |
    |NN.N...N.......N.......N.......N.......N.......N.......N.......N|
  0 +---------+---------+---------+---------+---------+---------+----+
    0         10        20        30        40        50        60

                            number of threads

-----------------------------------------------------------------------

          atomic_add-bench: 1000000 ops/thread, [0,2] range
                                               
throughput                                  M - MTTCG     N - no MTTCG

150 +---------+---------+---------+---------+---------+---------+----+
    |                                            ...M.......M.......M|
    |                           ....M...       ..                    |
120 +           ....M.......M...        ....M..                      +
    |     ..M...                                                     |
    |   M.                                                           |
 90 +  .                                                             +
    | .                                                              |
    | .                                                              |
 60 + M                                                              +
    |.                                                               |
    |M                                                               |
 30 +                                                                +
    |                                                                |
    |NN.N...N.......N.......N.......N.......N.......N.......N.......N|
  0 +---------+---------+---------+---------+---------+---------+----+
    0         10        20        30        40        50        60

                            number of threads

-----------------------------------------------------------------------

Numerical data:

Ops
Range-->      1               2              128            1024

# of     no              no              no              no
 thr.    MTTCG  MTTCG    MTTCG  MTTCG    MTTCG  MTTCG    MTTCG  MTTCG

  1      4.95   42.61    4.94   42.27    4.89   42.24    4.85   41.81
  2      1.23   18.41    1.29   25.71    1.33   57.41    1.36   60.34
  4      0.46   11.99    0.48   19.69    0.53   78.98    0.50   95.39
  8      0.18    9.59    0.18   19.11    0.19  104.66    0.20  112.66
 16      0.11   11.19    0.12   19.12    0.12  108.29    0.13  121.90
 24      0.10   10.18    0.09   19.14    0.11  115.53    0.10  127.40
 32      0.11   11.15    0.12   19.36    0.09  120.60    0.10  131.60
 40      0.08   10.47    0.11   20.88    0.12  124.59    0.10  124.74
 48      0.12   11.78    0.13   20.09    0.11  129.24    0.11  137.19
 56      0.14   12.40    0.13   22.13    0.15  124.16    0.15  138.52
 64      0.14   11.08    0.20   21.08    0.18  131.28    0.19  144.84

-----------------------------------------------------------------------

Graphical representation:

 https://i.imgur.com/OtNLpVX.png

-----------------------------------------------------------------------

REGRESSION TESTING
==================

Regression testing was also performed. The main test bed for regression
testing was LTP test suite executed on QEMU-emulated Debian mips64
system.

Some LTP tests (getrusage04, copy_file_range01) that used to fail for
non-MTTCG systems, pass for MTTCG-enabled systems. Also, some LTP tests
(nanosleep01, poll02, pselect01) intermittently fail on both non-MTTCG
and MTTCG configurations, and therefore do not represent valid
regressions.

Emulation by itself did not appear to have any problems while executing
LTP test suite.

QEMU user mode MTTCG-enabled emulation was also tested to some extent.

-----------------------------------------------------------------------

Aleksandar Markovic (2):
  hw/mips_int: hold BQL for all interrupt requests
  target/mips: introduce MTTCG-enabled builds

Goran Ferenc (1):
  target/mips: hold BQL in mips_vpe_wake()

Leon Alrae (2):
  target/mips: compare virtual addresses in LL/SC sequence
  target/mips: reimplement SC instruction emulation and use cmpxchg

Miodrag Dinic (1):
  hw/mips_cpc: kick a VP when putting it into Run statewq

 configure                  |   3 ++
 hw/mips/mips_int.c         |  12 +++++
 hw/misc/mips_cpc.c         |  17 +++++-
 linux-user/mips/cpu_loop.c |  73 --------------------------
 target/mips/cpu.h          |   9 ++--
 target/mips/helper.c       |   6 +--
 target/mips/helper.h       |   2 -
 target/mips/machine.c      |   7 +--
 target/mips/op_helper.c    |  76 ++++++++-------------------
 target/mips/translate.c    | 127 ++++++++++++++++-----------------------------
 10 files changed, 105 insertions(+), 227 deletions(-)

-- 
2.7.4
