Received: from eggs.gnu.org ([2001:4830:134:3::10]:41414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qu-0001tu-Cz
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qo-00056Z-E5
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qo-00055W-4c
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:42 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8jht025508
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:41 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ae098ujx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:40 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:39 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:22 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-59-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 58/81] ahci: advertise HOST_CAP_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ladi Prosek <lprosek@redhat.com>, John Snow <jsnow@redhat.com>

From: Ladi Prosek <lprosek@redhat.com>

The AHCI emulation code supports 64-bit addressing and should advertise this
fact in the Host Capabilities register. Both Linux and Windows drivers test
this bit to decide if the upper 32 bits of various registers may be written
to, and at least some versions of Windows have a bug where DMA is attempted
with an address above 4GB but, in the absence of HOST_CAP_64, the upper 32
bits are left unititialized which leads to a memory corruption.

[Maintainer edit:

This fixes https://bugzilla.redhat.com/show_bug.cgi?id=1411105,
which affects Windows Server 2008 SP2 in some cases.]

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Message-id: 1484305370-6220-1-git-send-email-lprosek@redhat.com
[Amended commit message --js]
Signed-off-by: John Snow <jsnow@redhat.com>

(cherry picked from commit 98cb5dccb192b0082626080890dac413473573c6)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ide/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 3c19bda..6a17acf 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -488,7 +488,7 @@ static void ahci_reg_init(AHCIState *s)
     s->control_regs.cap = (s->ports - 1) |
                           (AHCI_NUM_COMMAND_SLOTS << 8) |
                           (AHCI_SUPPORTED_SPEED_GEN1 << AHCI_SUPPORTED_SPEED) |
-                          HOST_CAP_NCQ | HOST_CAP_AHCI;
+                          HOST_CAP_NCQ | HOST_CAP_AHCI | HOST_CAP_64;
 
     s->control_regs.impl = (1 << s->ports) - 1;
 
-- 
2.7.4
