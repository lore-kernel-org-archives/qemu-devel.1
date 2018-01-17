Received: from eggs.gnu.org ([2001:4830:134:3::10]:45563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQJ-0007rK-B5
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:25:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQI-0001JC-3k
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:25:55 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 17 Jan 2018 13:25:13 +1100
Message-Id: <20180117022525.31767-11-david@gibson.dropbear.id.au>
In-Reply-To: <20180117022525.31767-1-david@gibson.dropbear.id.au>
References: <20180117022525.31767-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 10/22] ppc: Change Power9 compat table to
 support at most 8 threads/core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

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
2.14.3
