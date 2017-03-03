Received: from eggs.gnu.org ([2001:4830:134:3::10]:35354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjlvY-0001xc-HS
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:03:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjlvT-0006Wt-HV
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:03:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cjlvT-0006WD-C4
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:03:11 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77E082EF168
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 12:03:11 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-102.ams2.redhat.com
	[10.36.117.102])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v23C3AGi027923
	for <qemu-devel@nongnu.org>; Fri, 3 Mar 2017 07:03:10 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  3 Mar 2017 13:03:08 +0100
Message-Id: <20170303120308.6815-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] target-nios2: take BQL around interrupt check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The interrupt controller does not have its own locking.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/nios2/op_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/nios2/op_helper.c b/target/nios2/op_helper.c
index 538853c..efb1c48 100644
--- a/target/nios2/op_helper.c
+++ b/target/nios2/op_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
+#include "qemu/main-loop.h"
 
 #if !defined(CONFIG_USER_ONLY)
 void helper_mmu_read_debug(CPUNios2State *env, uint32_t rn)
@@ -35,7 +36,9 @@ void helper_mmu_write(CPUNios2State *env, uint32_t rn, uint32_t v)
 
 void helper_check_interrupts(CPUNios2State *env)
 {
+    qemu_mutex_lock_iothread();
     nios2_check_interrupts(env);
+    qemu_mutex_unlock_iothread();
 }
 #endif /* !CONFIG_USER_ONLY */
 
-- 
2.9.3
