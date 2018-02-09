Received: from eggs.gnu.org ([2001:4830:134:3::10]:39921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sv-000163-Hw
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Su-00026h-Pa
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:37 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ek6Su-00023a-JX
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:36 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6St-0002ed-KR
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:03:35 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Feb 2018 11:03:12 +0000
Message-Id: <20180209110314.11766-29-peter.maydell@linaro.org>
In-Reply-To: <20180209110314.11766-1-peter.maydell@linaro.org>
References: <20180209110314.11766-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 28/30] target/arm/kvm: gic: Prevent creating
 userspace GICv3 with KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Christoffer Dall <christoffer.dall@linaro.org>

KVM doesn't support emulating a GICv3 in userspace, only GICv2.  We
currently attempt this anyway, and as a result a KVM guest doesn't
receive interrupts and the user is left wondering why.  Report an error
to the user if this particular combination is requested.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180201205307.30343-1-christoffer.dall@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index ff53e9fafb..cfb7e5af72 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -234,6 +234,10 @@ static inline const char *gicv3_class_name(void)
         exit(1);
 #endif
     } else {
+        if (kvm_enabled()) {
+            error_report("Userspace GICv3 is not supported with KVM");
+            exit(1);
+        }
         return "arm-gicv3";
     }
 }
-- 
2.16.1
