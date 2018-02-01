Received: from eggs.gnu.org ([208.118.235.92]:42030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christoffer.dall@linaro.org>) id 1ehLsB-0005aG-E5
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christoffer.dall@linaro.org>) id 1ehLr7-0007Cm-BG
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:54:19 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <christoffer.dall@linaro.org>)
	id 1ehLr6-0007Bc-Ut
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:53:13 -0500
Received: by mail-wm0-x243.google.com with SMTP id f3so8327446wmc.1
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 12:53:12 -0800 (PST)
From: Christoffer Dall <christoffer.dall@linaro.org>
Date: Thu,  1 Feb 2018 21:53:07 +0100
Message-Id: <20180201205307.30343-1-christoffer.dall@linaro.org>
Subject: [Qemu-devel] [PATCH] target/arm/kvm: gic: Prevent creating
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Alex Bennee <alex.bennee@linaro.org>, Christoffer Dall <christoffer.dall@linaro.org>

KVM doesn't support emulating a GICv3 in userspace, only GICv2.  We
currently attempt this anyway, and as a result a KVM guest doesn't
receive interrupts and the user is left wondering why.  Report an error
to the user if this particular combination is requested.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
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
2.14.2
