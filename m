Received: from eggs.gnu.org ([2001:4830:134:3::10]:59997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dABVY-00016S-Fs
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dABVV-0007Ky-CG
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:37:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48575
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dABVV-0007KT-7U
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:37:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4F8XiI6038094
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 04:37:32 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2aedxn23b9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 04:37:31 -0400
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 15 May 2017 18:37:28 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon, 15 May 2017 14:05:09 +0530
Message-Id: <20170515083509.24607-1-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] target/ppc: reset reservation in do_rfi()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, rth@twiddle.net, nikunj@linux.vnet.ibm.com

For transitioning back to userspace after the interrupt.

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/excp_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index a6bcb47..9cb2123 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -995,6 +995,9 @@ static inline void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
      */
     cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
 
+    /* Reset the reservation */
+    env->reserve_addr = -1;
+
     /* Context synchronizing: check if TCG TLB needs flush */
     check_tlb_flush(env, false);
 }
-- 
2.9.3
