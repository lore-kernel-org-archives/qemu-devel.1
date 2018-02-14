Received: from eggs.gnu.org ([2001:4830:134:3::10]:52076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1em2uy-00035F-Uc
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:40:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1em2ut-0002sH-Pz
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:40:36 -0500
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:51245)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1em2ut-0002pN-3C
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:40:31 -0500
Received: from player168.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 535EDA3140
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 20:40:22 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 14 Feb 2018 20:40:08 +0100
Message-ID: <151863720814.3003.4939908778788942974.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/5] spapr: fix VCPU ids miscalculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Sam Bobroff <sam.bobroff@au1.ibm.com>, Laurent Vivier <lvivier@redhat.com>

After the review of Laurent's patch "spapr: set vsmt to MAX(8, smp_threads)",
I realized that most of the machine code that deals with VCPU ids assume the
spacing between cores is kvmppc_smt_threads() instead of spapr->vsmt. Most
of the time this is ok because both are equals, and QEMU used to exit if
it failed to set the VSMT mode into KVM.

This changed with the recent commit 8904e5a75005 "spapr: Adjust default
VSMT value for better migration compatibility", and really hurts setups
where kvmppc_smt_threads() and spapr->vsmt can have a different value:
older KVMs or even a recent KVM on a POWER8 host with subcores. The most
notable effects are DRCs associated to wrong VCPUs, which makes CPU
hot-plug completely unusable.

The fix is as simple as using spapr->vsmt everywhere. This is patch 1.
The rest of the series is an effort to consolidate the numbering logic
in a single place. This will avoid future breakage if the VCPU id logic
needs to be changed again later. Changes in patches 2 to 4 are rather
mechanical. Patch 5 is a bit more controversial as it breaks the
migration of unusual CPU topologies that used to be supported by
pre-2.7 machine types.

Please comment.

--
Greg

---

Greg Kurz (5):
      spapr: use spapr->vsmt to compute VCPU ids
      spapr: move VCPU calculation to core machine code
      spapr: rename spapr_vcpu_id() to spapr_get_vcpu_id()
      spapr: consolidate the VCPU id numbering logic in a single place
      spapr: drop DIV_ROUND_UP() from xics_max_server_number()


 hw/ppc/spapr.c          |   74 +++++++++++++++++++++++++++++++++--------------
 hw/ppc/spapr_cpu_core.c |    9 +-----
 include/hw/ppc/spapr.h  |    3 +-
 3 files changed, 56 insertions(+), 30 deletions(-)
