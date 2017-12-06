Received: from eggs.gnu.org ([2001:4830:134:3::10]:49388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCR-0000hU-2o
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCN-0000dY-Th
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48376
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCN-0000c0-M7
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:39 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE4lY015623
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:39 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epn0ac1dk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:38 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:37 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:25 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-33-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 32/55] nios2: define tcg_env
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marek Vasut <marex@denx.de>

From: Paolo Bonzini <pbonzini@redhat.com>

This should be done by all target and, since commit 53f6672bcf
("gen-icount: use tcg_ctx.tcg_env instead of cpu_env", 2017-06-30),
is causing the NIOS2 target to hang.

This is because the test for "should I exit to the main loop"
was being done with the correct offset to the icount decrementer,
but using TCG temporary 0 (the frame pointer) rather than the
env pointer.

Cc: qemu-stable@nongnu.org
Cc: Marek Vasut <marex@denx.de>
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 17bd9597be45b96ae00716b0ae01a4d11bbee1ab)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/nios2/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 8b97d6585f..f25ef7e2bb 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -942,6 +942,7 @@ void nios2_tcg_init(void)
     int i;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
+    tcg_ctx.tcg_env = cpu_env;
 
     for (i = 0; i < NUM_CORE_REGS; i++) {
         cpu_R[i] = tcg_global_mem_new(cpu_env,
-- 
2.11.0
