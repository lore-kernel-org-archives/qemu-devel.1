Received: from eggs.gnu.org ([2001:4830:134:3::10]:50435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1fVBY3-00086q-GJ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 03:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1fVBY2-0008Jv-QG
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 03:59:31 -0400
From: Zheng Xiang <zhengxiang9@huawei.com>
Date: Tue, 19 Jun 2018 15:58:21 +0800
Message-ID: <20180619075821.9884-1-zhengxiang9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] target-arm: fix a segmentation fault due to
 illegal memory access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: zhaoshenglong@huawei.com, peter.maydell@linaro.org, Zheng Xiang <xiang.zheng@linaro.org>

From: Zheng Xiang <xiang.zheng@linaro.org>

The elements of kvm_devices_head list are freed in kvm_arm_machine_init_done(),
but we still access these illegal memory in kvm_arm_devlistener_del().

This will cause segment fault when booting guest with MALLOC_PERTURB_=1.

Signed-off-by: Zheng Xiang <xiang.zheng@linaro.org>
---
 target/arm/kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 98f5006..5bf41e1 100644
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
1.8.3.1
