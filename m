Received: from eggs.gnu.org ([2001:4830:134:3::10]:49933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd2-0003T4-6y
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd0-0005IE-Ur
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:28 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fWLd0-0005AA-L0
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:26 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcp-0003qI-Ug
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:57:15 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:56:48 +0100
Message-Id: <20180622125713.15303-4-peter.maydell@linaro.org>
In-Reply-To: <20180622125713.15303-1-peter.maydell@linaro.org>
References: <20180622125713.15303-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/28] target-arm: fix a segmentation fault due
 to illegal memory access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Zheng Xiang <xiang.zheng@linaro.org>

The elements of kvm_devices_head list are freed in kvm_arm_machine_init_done(),
but we still access these illegal memory in kvm_arm_devlistener_del().

This will cause segment fault when booting guest with MALLOC_PERTURB_=1.

Signed-off-by: Zheng Xiang <xiang.zheng@linaro.org>
Message-id: 20180619075821.9884-1-zhengxiang9@huawei.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 98f50063238..5bf41e151c6 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -256,6 +256,7 @@ static void kvm_arm_machine_init_done(Notifier *notifier, void *data)
             kvm_arm_set_device_addr(kd);
         }
         memory_region_unref(kd->mr);
+        QSLIST_REMOVE_HEAD(&kvm_devices_head, entries);
         g_free(kd);
     }
     memory_listener_unregister(&devlistener);
-- 
2.17.1
