Received: from eggs.gnu.org ([2001:4830:134:3::10]:47062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dozCq-0003en-Tk
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dozCm-0002nA-C1
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:46:56 -0400
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:49442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dozCm-0002mG-5T
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:46:52 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 802504AC77
	for <qemu-devel@nongnu.org>; Mon,  4 Sep 2017 23:46:50 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 04 Sep 2017 23:46:44 +0200
Message-ID: <150456160452.17000.3290192176290246589.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/4] ppc: fix migration with KVM PR (nested)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Thomas Huth <thuth@redhat.com>

A guest running with KVM PR ends up irresponsive after migration most of the
time. This happens because the HPT allocated by QEMU is likely to have a
different address on the destination than it had on the source, but we push
the source address to KVM.

This series does a little cleanup and fixes the issue. I could successfully
test it with a nested setup (KVM PR running in KVM HV).

However, this isn't enough to fix migration when using KVM PR on baremetal...
CPUs seem to end up looping on H_CEDE in the guest. I can't figure out what's
happening... Any suggestion would be appreciated.

Cheers,

--
Greg

---

Greg Kurz (4):
      spapr: only update SDR1 once per-cpu during CAS
      spapr: introduce a helper to compute the address of the HPT
      ppc: kvm: introduce a helper to update SDR1 for a single CPU
      ppc: kvm: update HPT pointer in KVM PR after migration


 hw/ppc/spapr.c          |   15 +++++++++++++++
 hw/ppc/spapr_cpu_core.c |    8 +++-----
 hw/ppc/spapr_hcall.c    |   20 +++++++++-----------
 include/hw/ppc/spapr.h  |    1 +
 target/ppc/cpu.h        |    1 +
 target/ppc/kvm.c        |   12 ++++++++----
 target/ppc/kvm_ppc.h    |    3 ++-
 target/ppc/machine.c    |    7 +++++++
 8 files changed, 46 insertions(+), 21 deletions(-)
