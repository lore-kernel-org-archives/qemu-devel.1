Received: from eggs.gnu.org ([209.51.188.92]:52398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugBa-0003bQ-6z
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugBZ-0006g4-8Y
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:17:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35768
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gugBZ-0006fR-2Y
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:17:57 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FGBeB5109163
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 11:17:56 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qp0ga1pf3-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 11:17:23 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 15 Feb 2019 16:16:54 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Feb 2019 17:16:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20190215161648.9600-1-clg@kaod.org>
Subject: [Qemu-devel] [PATCH 00/10] ppc: Add Hypervisor Virtualization
 Interrupt on POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Here is a series of fixes and extensions provided by Ben which modify
the POWER9 interrupt model to prepare ground for the support of the
XIVE interrupt controller as found on POWER9 PowerNV machines.

Thanks

C.

Changes since initial patchset :

 - modified the commit log to comment the use of EXCP_HLT instead
   of POWERPC_EXCP_STOP
 - modified the icp_realize() and xive_tctx_realize() to take
   into account explicitely the POWER9 interrupt model
 - introduced a specific power9_set_irq for POWER9


Benjamin Herrenschmidt (10):
  target/ppc: Fix nip on power management instructions
  target/ppc: Don't clobber MSR:EE on PM instructions
  target/ppc: Fix support for "STOP light" states on POWER9
  target/ppc: Move "wakeup reset" code to a separate function
  target/ppc: Rename "in_pm_state" to "resume_as_sreset"
  target/ppc: Add POWER9 exception model
  target/ppc: Detect erroneous condition in interrupt delivery
  target/ppc: Add Hypervisor Virtualization Interrupt on POWER9
  target/ppc: Add POWER9 external interrupt model
  target/ppc: Add support for LPCR:HEIC on POWER9

 include/hw/ppc/ppc.h            |   2 +
 target/ppc/cpu-qom.h            |   5 +
 target/ppc/cpu.h                |  26 ++++-
 hw/intc/xics.c                  |   3 +
 hw/intc/xive.c                  |   3 +
 hw/ppc/ppc.c                    |  44 ++++++++-
 target/ppc/excp_helper.c        | 164 +++++++++++++++++++++-----------
 target/ppc/translate.c          |  28 ++++--
 target/ppc/translate_init.inc.c |  34 ++++++-
 9 files changed, 238 insertions(+), 71 deletions(-)

-- 
2.20.1
