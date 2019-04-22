Received: from eggs.gnu.org ([209.51.188.92]:57557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hISyj-0006Te-Oz
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hISyi-00051R-Iy
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:03:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hISyi-0004zY-7W
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:03:00 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3M6rnDJ084695
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 03:02:57 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s14j4ffwq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 03:02:57 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Mon, 22 Apr 2019 08:02:56 +0100
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2019 12:32:48 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155591636364.20338.844048953355207313.stgit@aravinda>
Subject: [Qemu-devel] [PATCH v8 0/6] target-ppc/spapr: Add FWNMI support in
 QEMU for PowerKVM guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aik@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Cc: paulus@ozlabs.org, aravinda@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com

This patch set adds support for FWNMI in PowerKVM guests.

System errors such as SLB multihit and memory errors
that cannot be corrected by hardware is passed on to
the kernel for handling by raising machine check
exception (an NMI). Upon such machine check exceptions,
if the address in error belongs to guest then KVM
invokes guests' 0x200 interrupt vector if the guest
is not FWNMI capable. For FWNMI capable guest
KVM passes the control to QEMU by exiting the guest.

This patch series adds functionality to QEMU to pass
on such machine check exceptions to the FWNMI capable
guest kernel by building an error log and invoking
the guest registered machine check handling routine.

The KVM changes are now part of the upstream kernel
(commit e20bbd3d). This series contain QEMU changes.

Change Log v8:
  - Added functionality to check FWNMI capability during
    VM migration

Change Log v7:
  - Rebased to 4.1

Change Log v6:
  - Fetches rtas_addr from fdt
  - Handles all error conditions (earlier it was only UEs)

Change Log v5:
  - Handled VM migrations by including rtas_addr in VMSTATE.
  - Migration is blocked while a machine check is in progress.

---

Aravinda Prasad (6):
      ppc: spapr: Handle "ibm,nmi-register" and "ibm,nmi-interlock" RTAS calls
      Wrapper function to wait on condition for the main loop mutex
      target/ppc: Handle NMI guest exit
      target/ppc: Build rtas error log upon an MCE
      ppc: spapr: Enable FWNMI capability
      migration: Block migration while handling machine check


 cpus.c                   |    5 +
 hw/ppc/spapr.c           |   26 ++++
 hw/ppc/spapr_caps.c      |   26 ++++
 hw/ppc/spapr_events.c    |  284 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_rtas.c      |   84 ++++++++++++++
 include/hw/ppc/spapr.h   |   26 ++++
 include/qemu/main-loop.h |    8 +
 target/ppc/kvm.c         |   30 +++++
 target/ppc/kvm_ppc.h     |    8 +
 target/ppc/trace-events  |    2 
 10 files changed, 497 insertions(+), 2 deletions(-)

--
Aravinda
