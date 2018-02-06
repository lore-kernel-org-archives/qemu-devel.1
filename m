Received: from eggs.gnu.org ([2001:4830:134:3::10]:43744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ic-00059m-OZ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ib-0007uD-Jg
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8ib-0007tL-Bo
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:49 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JExx4118348
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:48 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyh46kmvc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:46 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:40 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:33 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-13-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 12/54] hw/intc/arm_gic: reserved register
 addresses are RAZ/WI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

The GICv2 specification says that reserved register addresses
must RAZ/WI; now that we implement external abort handling
for Arm CPUs this means we must return MEMTX_OK rather than
MEMTX_ERROR, to avoid generating a spurious guest data abort.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1513183941-24300-3-git-send-email-peter.maydell@linaro.org
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
(cherry picked from commit 0cf09852015e47a5fbb974ff7ac320366afd21ee)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/intc/arm_gic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 5a0e2a3c1a..d701e49ff9 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1261,7 +1261,8 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "gic_cpu_read: Bad offset %x\n", (int)offset);
-        return MEMTX_ERROR;
+        *data = 0;
+        break;
     }
     return MEMTX_OK;
 }
@@ -1329,7 +1330,7 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "gic_cpu_write: Bad offset %x\n", (int)offset);
-        return MEMTX_ERROR;
+        return MEMTX_OK;
     }
     gic_update(s);
     return MEMTX_OK;
-- 
2.11.0
