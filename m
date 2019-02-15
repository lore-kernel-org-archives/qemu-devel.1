Received: from eggs.gnu.org ([209.51.188.92]:50855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gubqm-0004Bf-CJ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gubqi-0005Yz-Mx
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57818
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gubqg-0005Ef-Kl
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:08 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FBXvDL080781
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:39:50 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qnt8tf30g-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:39:49 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 15 Feb 2019 11:39:47 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri, 15 Feb 2019 12:39:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 00/10] xics: Get rid of KVM specific classes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

As recently pointed [1], using different object types for the KVM and
non-KVM scenarios was a bad idea: "In general different device types
should represent guest-visibly different objects, not just implementation
differences."

This series converts the base ICP class and the "simple" ICS class to
support KVM. This is done through the use of kvm_irqchip_in_kernel(),
which allows the compiler to optimize the KVM branches out when CONFIG_KVM
isn't set.

The removal of the KVM specific object types greatly simplifies the code.

Please comment.

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg03580.html

--
Greg

---

Greg Kurz (10):
      xics: Explicitely call KVM ICP methods from the common code
      xics: Handle KVM ICP reset from the common code
      xics: Handle KVM ICP realize from the common code
      spapr/irq: Use the base ICP class for KVM
      xics: Drop the KVM ICP class
      xics: Explicitely call KVM ICS methods from the common code
      xics: Handle KVM ICS reset from the "simple" ICS code
      xics: Handle KVM interrupt presentation from "simple" ICS code
      spapr/irq: Use the "simple" ICS class for KVM
      xics: Drop the KVM ICS class


 hw/intc/xics.c         |   76 +++++++++++++++++-------------
 hw/intc/xics_kvm.c     |  120 +++---------------------------------------------
 hw/ppc/spapr_irq.c     |   28 ++++-------
 include/hw/ppc/spapr.h |    1 
 include/hw/ppc/xics.h  |   26 ++++------
 5 files changed, 71 insertions(+), 180 deletions(-)
