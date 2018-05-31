Received: from eggs.gnu.org ([2001:4830:134:3::10]:59394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORBS-0006J5-3o
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORBR-00040R-4Y
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59758 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fORBQ-00040B-VV
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FA1840201A0
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:16 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-47.ams2.redhat.com
	[10.36.117.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2FA0863F34
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:15:58 +0200
Message-Id: <20180531171606.21604-7-pbonzini@redhat.com>
In-Reply-To: <20180531171606.21604-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
	<20180531171606.21604-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 45/53] target/i386/kvm.c: Handle renaming of
 KVM_HINTS_DEDICATED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

In kernel header commit 633711e8287, the define KVM_HINTS_DEDICATED
was renamed to KVM_HINTS_REALTIME. Work around this compatibility
break by (a) using the new constant name, and (b) defining it
if the headers don't.

Part (b) can be removed once we've updated our copy of the kernel
headers to a version that defines KVM_HINTS_REALTIME.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180525132755.21839-5-peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 9d8f80f4c0..8eae654991 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -47,6 +47,11 @@
 #include "exec/memattrs.h"
 #include "trace.h"
 
+/* Work around this kernel header constant changing its name */
+#ifndef KVM_HINTS_REALTIME
+#define KVM_HINTS_REALTIME KVM_HINTS_DEDICATED
+#endif
+
 //#define DEBUG_KVM
 
 #ifdef DEBUG_KVM
@@ -386,7 +391,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
             ret &= ~(1U << KVM_FEATURE_PV_UNHALT);
         }
     } else if (function == KVM_CPUID_FEATURES && reg == R_EDX) {
-        ret |= 1U << KVM_HINTS_DEDICATED;
+        ret |= 1U << KVM_HINTS_REALTIME;
         found = 1;
     }
 
-- 
2.17.0
