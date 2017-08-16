Received: from eggs.gnu.org ([2001:4830:134:3::10]:46319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dhuN9-0000N3-M7
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:12:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dhuN6-00044Y-BH
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:12:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36405
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1dhuN6-00044E-5b
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:12:16 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7G99S2q022754
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 05:12:14 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ccerg3ry5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 05:12:14 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Wed, 16 Aug 2017 05:12:13 -0400
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Wed, 16 Aug 2017 14:41:59 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <150287457293.9760.17827532208744487789.stgit@aravinda>
Subject: [Qemu-devel] [PATCH v3 0/5] target-ppc/spapr: Add FWNMI support in
 QEMU for PowerKVM guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Cc: aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com

This series of patches adds support for FWNMI in PowerKVM guests.

Memory error such as bit flips that cannot be corrected
by hardware is passed on to the kernel for handling
by raising machine check exception (an NMI). Upon such
machine check exception, if the address in error belongs
to guest then KVM causes a guest exit with KVM_EXIT_NMI
exit reason.

This patch series adds functionality to pass on such
machine check exception to the guest kernel by suitably
handling KVM_EXIT_NMI exit and building the error log.

The KVM changes are now part of the upstream kernel
(commit e20bbd3d). This series contain QEMU changes.

Change Log v3:
    - Rebased to v2.10.0-rc0 (git://github.com/dgibson/qemu)

Change Log v2:
    - Added KVM capability
    - Serialized multiple NMIs with a conditional wait

---

Aravinda Prasad (5):
      ppc: spapr: Register and handle HCALL to receive updated RTAS region
      ppc: spapr: Handle "ibm,nmi-register" and "ibm,nmi-interlock" RTAS calls
      Wrapper function to wait on condition for the main loop mutex
      target/ppc: Handle NMI guest exit
      ppc: spapr: Enable FWNMI capability


 cpus.c                   |    5 +++
 hw/ppc/spapr.c           |   12 ++++++
 hw/ppc/spapr_hcall.c     |    8 ++++
 hw/ppc/spapr_rtas.c      |   52 +++++++++++++++++++++++++++
 include/hw/ppc/spapr.h   |   14 ++++++-
 include/qemu/main-loop.h |    8 ++++
 target/ppc/kvm.c         |   88 ++++++++++++++++++++++++++++++++++++++++++++++
 target/ppc/kvm_ppc.h     |   81 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 266 insertions(+), 2 deletions(-)

--
Aravinda Prasad
