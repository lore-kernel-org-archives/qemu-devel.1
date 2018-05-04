Received: from eggs.gnu.org ([2001:4830:134:3::10]:51670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJ9-0005br-La
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJ8-0000YJ-PB
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:47 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fEeJ8-0000Wt-IG
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:46 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJ7-00031i-M9
	for qemu-devel@nongnu.org; Fri, 04 May 2018 18:15:45 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  4 May 2018 18:15:22 +0100
Message-Id: <20180504171540.25813-7-peter.maydell@linaro.org>
In-Reply-To: <20180504171540.25813-1-peter.maydell@linaro.org>
References: <20180504171540.25813-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 06/24] arm: boot: set boot_info starting from
 first_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Igor Mammedov <imammedo@redhat.com>

Even though nothing is currently broken (since all boards
use first_cpu as boot cpu), make sure that boot_info is set
on all CPUs.
If some board would like support heterogenuos setup (i.e.
init boot_info on subset of CPUs) in future, it should add
a reasonable API to do it, instead of starting assigning
boot_info from some CPU and till the end of present CPUs
list.

Ref:
"Message-ID: <CAFEAcA_NMWuA8WSs3cNeY6xX1kerO_uAcN_3=fK02BEhHJW86g@mail.gmail.com>"

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1525176522-200354-5-git-send-email-imammedo@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 9ae6ab2689..1e2be20731 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1170,7 +1170,7 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
     }
     info->is_linux = is_linux;
 
-    for (cs = CPU(cpu); cs; cs = CPU_NEXT(cs)) {
+    for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
         ARM_CPU(cs)->env.boot_info = info;
     }
 }
-- 
2.17.0
