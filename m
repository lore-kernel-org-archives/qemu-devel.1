Received: from eggs.gnu.org ([2001:4830:134:3::10]:57191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dIrUO-0000Mg-9D
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dIrUN-0007bw-1y
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:04:16 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu,  8 Jun 2017 17:03:46 +1000
Message-Id: <20170608070351.1434-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [PATCH 0/5] target/ppc: Implement support for the
 Large Decrementer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, agraf@suse.de, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The POWER9 processor introduces a new operating mode of the decrementer
called large decrementer mode.

If large decrementer mode is disabled then the decrementer behaves before
as a 32-bit decrementing register. If large decrementer mode is enabled
then the decrementer behaves as a d-bit decrementing register, the value
of which is sign extended to 64-bits (where d is implementation dependent).

The hypervisor decrementer is now a h-bit decrementing register which is
always sign extended to 64-bits (where h is implementation dependent).

To use the large decrementer both the guest and the host must have support
for it. If the host has support then qemu will advertise this to the guest
and tell the host that the guest is using the large decrementer. In TCG we
always advertise support and enable the large decrementer if we detect that
the guest will use it. 

The large decrementer can be disabled on the command line to ensure
migration between hosts with differing levels of support or decrementer
size.

This patch series is based on the branch dwg/ppc-for-2.10

Suraj Jitindar Singh (5):
  target/ppc: Implement large decrementer support for TCG
  target/ppc: Implement large decrementer support for KVM
  target/ppc: Implement migration support for large decrementer
  target/ppc: Enable the large decrementer for TCG and KVM guests
  target/ppc: Add cmd line option to disable the large decrementer

 hw/ppc/ppc.c                |  81 +++++++++++++++++++---------
 hw/ppc/spapr.c              | 128 ++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_hcall.c        |  36 +++++++++++++
 include/hw/ppc/spapr.h      |   2 +
 target/ppc/cpu-qom.h        |   1 +
 target/ppc/cpu.h            |   8 +--
 target/ppc/kvm.c            |  59 ++++++++++++++++++++
 target/ppc/kvm_ppc.h        |  25 +++++++++
 target/ppc/mmu-hash64.c     |   2 +-
 target/ppc/translate.c      |   2 +-
 target/ppc/translate_init.c |   3 ++
 11 files changed, 317 insertions(+), 30 deletions(-)

-- 
2.9.4
