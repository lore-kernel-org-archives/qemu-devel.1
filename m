Received: from eggs.gnu.org ([2001:4830:134:3::10]:44506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8j3-0005eU-5g
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8iu-0008AK-E8
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39734
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8iu-00089Y-1j
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:08 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEJwI131132
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:16:07 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fyfvm70cf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:16:06 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:16:05 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:15:06 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-46-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 45/54] ppc: Change Power9 compat table to
 support at most 8 threads/core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

Increases the max smt mode to 8 for Power9. That's because KVM supports
smt emulation in this platform so QEMU should allow users to use it as
well.

Today if we try to pass -smp ...,threads=8, QEMU will silently truncate
it to smt4 mode and may cause a crash if we try to perform a cpu
hotplug.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
[dwg: Added an explanatory comment]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

(cherry picked from commit 03ee51d3548f5f553a3089f466483c1c6d5c666b)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/ppc/compat.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index ad8f93c064..276b5b52c2 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -73,7 +73,14 @@ static const CompatInfo compat_table[] = {
         .pvr = CPU_POWERPC_LOGICAL_3_00,
         .pcr = PCR_COMPAT_3_00,
         .pcr_level = PCR_COMPAT_3_00,
-        .max_threads = 4,
+        /*
+         * POWER9 hardware only supports 4 threads / core, but this
+         * limit is for guests.  We need to support 8 vthreads/vcore
+         * on POWER9 for POWER8 compatibility guests, and it's very
+         * confusing if half of the threads disappear from the guest
+         * if it announces it's POWER9 aware at CAS time.
+         */
+        .max_threads = 8,
     },
 };
 
-- 
2.11.0
