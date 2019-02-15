Received: from eggs.gnu.org ([209.51.188.92]:33578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugrF-0001xb-A5
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:01:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugrD-0005nT-SL
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:01:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53966
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gugrD-0005LJ-KD
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:59 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FH0LDx012954
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:47 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qp0uj1eg7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:46 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 15 Feb 2019 17:00:44 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Feb 2019 18:00:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20190215170029.15641-1-clg@kaod.org>
Subject: [Qemu-devel] [PATCH 00/12] ppc: add native hash and radix support
 for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Here is another series of fixes and extensions from Ben providing
support for POWER9 native hash MMU and POWER9 native radix MMU. These
prepare ground for the support of QEMU POWER9 PowerNV machines.

>From there, I hand over the patchset to Suraj for any follow-ups.

Thanks,

C.

Benjamin Herrenschmidt (12):
  target/ppc/spapr: Set LPCR:HR when using Radix mode
  target/ppci/mmu: Use LPCR:HR to chose radix vs. hash translation
  target/ppc: Re-enable RMLS on POWER9 for virtual hypervisors
  target/ppc: Fix #include guard in mmu-book3s-v3.h
  target/ppc: Cleanup 64-bit MMU includes
  target/ppc: Fix ordering of hash MMU accesses
  target/ppc: Add basic support for "new format" HPTE as found on POWER9
  target/ppc: Fix synchronization of mttcg with broadcast TLB flushes
  target/ppc: Flush the TLB locally when the LPIDR is written
  target/ppc: Rename PATB/PATBE -> PATE
  target/ppc: Support for POWER9 native hash
  target/ppc: Basic POWER9 bare-metal radix MMU support

 include/hw/ppc/spapr.h          |  1 +
 target/ppc/cpu.h                |  7 ++-
 target/ppc/helper.h             |  1 +
 target/ppc/helper_regs.h        | 27 ++++------
 target/ppc/mmu-book3s-v3.h      | 89 +++++++++++++++++++++++++++---
 target/ppc/mmu-hash64.h         | 22 ++------
 target/ppc/mmu-radix64.h        |  4 +-
 hw/ppc/spapr.c                  | 86 ++++++++++++++++++++++++-----
 hw/ppc/spapr_hcall.c            | 69 +++++++-----------------
 hw/ppc/spapr_rtas.c             |  6 +--
 target/ppc/misc_helper.c        | 15 ++++++
 target/ppc/mmu-book3s-v3.c      | 31 +++++++++--
 target/ppc/mmu-hash32.c         |  6 +++
 target/ppc/mmu-hash64.c         | 28 ++++++++--
 target/ppc/mmu-radix64.c        | 96 ++++++++++++++++++++++++++-------
 target/ppc/mmu_helper.c         |  9 +---
 target/ppc/translate_init.inc.c |  7 ++-
 17 files changed, 361 insertions(+), 143 deletions(-)

-- 
2.20.1
