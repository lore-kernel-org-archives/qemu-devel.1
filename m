Received: from eggs.gnu.org ([2001:4830:134:3::10]:35204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3uQL-0001XQ-Ej
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 22:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3uQG-0000ro-Oi
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 22:14:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  5 Apr 2018 12:14:24 +1000
Message-Id: <20180405021437.16761-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.13 00/13] target/ppc: Assorted cpu
 cleanups (esp. hash64 MMU)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, groug@kaod.org
Cc: qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

Here's a set of cleanups for the ppc cpu code.  Most are related
specifically to the 64-bit hash MMU, but there are some others as
well.

In particular it establishes a new structure PPCHash64Options which
contains details of the hash64 mmu which can vary from one cpu to
another.  This attempts to gather such options in one place, instead
of spreading them around various bits of env->mmu_model as well as
other fields.

Most of these arose while I was looking to improve the way we handle
available page sizes for the pseries machine type, although they're
mostly not closely tied to that.

Changes since RFC:
  * Added an extra patch folding slb_nr into the new scheme
  * Assorted minor fixes based on feedback

David Gibson (13):
  target/ppc: Standardize instance_init and realize function names
  target/ppc: Simplify cpu valid check in ppc_cpu_realize
  target/ppc: Pass cpu instead of env to ppc_create_page_sizes_prop()
  target/ppc: Avoid taking "env" parameter to mmu-hash64 functions
  target/ppc: Remove fallback 64k pagesize information
  target/ppc: Move page size setup to helper function
  target/ppc: Split page size information into a separate allocation
  target/ppc: Make hash64_opts field mandatory for 64-bit hash MMUs
  target/ppc: Move 1T segment and AMR options to PPCHash64Options
  target/ppc: Fold ci_large_pages flag into PPCHash64Options
  target/ppc: Remove unnecessary POWERPC_MMU_V3 flag from mmu_model
  target/ppc: Get rid of POWERPC_MMU_VER() macros
  target/ppc: Fold slb_nr into PPCHash64Options

 hw/ppc/fdt.c                |   7 +-
 hw/ppc/pnv.c                |   9 +--
 hw/ppc/spapr.c              |  20 +++---
 include/hw/ppc/fdt.h        |   2 +-
 target/ppc/cpu-qom.h        |  27 ++------
 target/ppc/cpu.h            |  30 ++-------
 target/ppc/kvm.c            |  31 ++++-----
 target/ppc/machine.c        |  23 ++++++-
 target/ppc/mmu-hash64.c     | 152 +++++++++++++++++++++++++++++++-------=
------
 target/ppc/mmu-hash64.h     |  48 +++++++++++++-
 target/ppc/mmu_helper.c     |  24 +++----
 target/ppc/translate.c      |  12 ++--
 target/ppc/translate_init.c | 126 +++++++-----------------------------
 13 files changed, 263 insertions(+), 248 deletions(-)

--=20
2.14.3
