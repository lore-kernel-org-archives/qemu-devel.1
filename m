Received: from eggs.gnu.org ([2001:4830:134:3::10]:36731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9i-0003XW-RP
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9g-0006en-Jq
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:38 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cnp9g-0006eC-Cs
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:36 -0400
Received: by mail-wr0-x242.google.com with SMTP id u108so24540470wrb.2
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:18:36 -0700 (PDT)
Received: from 640k.lan (94-39-132-181.adsl-ull.clienti.tiscali.it.
	[94.39.132.181])
	by smtp.gmail.com with ESMTPSA id k195sm408197wmd.7.2017.03.14.09.18.34
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 Mar 2017 09:18:34 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 17:18:13 +0100
Message-Id: <1489508300-48184-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/18] target/nios2: take BQL around interrupt
 check
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
1.8.3.1
