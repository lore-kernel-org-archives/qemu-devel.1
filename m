Received: from eggs.gnu.org ([2001:4830:134:3::10]:35205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1chJmU-0003vR-50
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1chJmS-0005JQ-PF
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:46 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1chJmS-0004Og-I1
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:44 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 17:35:19 +0000
Message-Id: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH risu 0/9] risu: refactor and reduce
 CPU-specific code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Laurent Vivier <laurent@vivier.eu>

This patchset refactors the risu C code to reduce the significant
amount of duplicated and duplicated-but-not-quite-the-same code
in the per-CPU files.

I've compile tested this for all architectures, but I'm not in a
position to do runtime tests for non-ARM (my attempt to use the
ppc64le risu under QEMU gives mismatch errors even without these
patches, and the m68k risu makes QEMU crash, presumably because our
m68k support isn't complete yet).  So I wasn't quite prepared to just
push it straight out to master the way I've done with previous
changes I've been making.

Nikunj, Laurent: if you have time to test this patchset to confirm
that it hasn't broken anything for you that would be great.
If not, no problem; I'll probably push it to master in a week
or so and we can sort any issues with it out later as separate
patches.

You can find a git branch with these changes at
https://git.linaro.org/people/peter.maydell/risu-dev.git cpu-refactor

(nb that's not the official risu upstream repo, but a different
one on the same server that I'm using for development/testing).


My motivation for all this, incidentally, is that I wanted to have
a go at resurrecting the x86 backend as a test case for how we
should support variable-length instruction sets. I got distracted
by how much duplicate code we were dealing with both in risugen
and in risu itself...

thanks
-- PMM


Peter Maydell (9):
  Drop the weird modification of a ucontext in the ppc reginfo_is_eq()
  Abstract out getting and setting parameter register
  Make get_risuop() a formal part of the CPU interface
  ppc64le, m68k: Make reginfo_dump() API match arm, aarch64
  m68k: Drop unused ucontext_t* argument to reginfo_is_eq()
  Make reginfo_{init,is_eq,dump,dump_mismatch} official per-CPU API
  Move send_register_info() to reginfo.c
  Move recv_and_compare_register_info() and report_match_status() to
    reginfo.c
  Tidy up #include lines

 Makefile               |   4 +-
 reginfo.c              | 151 ++++++++++++++++++++++++++++++++++++++++++++++
 risu.h                 |  43 ++++++++++++-
 risu_aarch64.c         | 152 +++-------------------------------------------
 risu_arm.c             | 159 ++++---------------------------------------------
 risu_m68k.c            | 136 +++---------------------------------------
 risu_ppc64le.c         | 136 +++---------------------------------------
 risu_reginfo_aarch64.h |  12 ----
 risu_reginfo_arm.h     |  12 ----
 risu_reginfo_m68k.c    |  23 +++----
 risu_reginfo_m68k.h    |  12 ----
 risu_reginfo_ppc64le.c |  59 ++++++++----------
 risu_reginfo_ppc64le.h |  12 ----
 13 files changed, 271 insertions(+), 640 deletions(-)
 create mode 100644 reginfo.c

-- 
2.7.4
