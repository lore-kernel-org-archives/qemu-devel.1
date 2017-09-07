Received: from eggs.gnu.org ([2001:4830:134:3::10]:56411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwr2-0000zn-4N
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqw-0007d8-VM
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:24 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dpwqw-0007Xf-MX
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:18 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqm-0001Xz-Jf
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:28:08 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Sep 2017 14:28:00 +0100
Message-Id: <1504790904-17018-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
References: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 07/31] hw/arm/allwinner-a10: Mark the
 allwinner-a10 device with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

QEMU currently exits unexpectedly when the user accidentially
tries to do something like this:

$ aarch64-softmmu/qemu-system-aarch64 -S -M integratorcp -nographic
QEMU 2.9.93 monitor - type 'help' for more information
(qemu) device_add allwinner-a10
Unsupported NIC model: smc91c111

Exiting just due to a "device_add" should not happen. Looking closer
at the the realize and instance_init function of this device also
reveals that it is using serial_hds and nd_table directly there, so
this device is clearly not creatable by the user and should be marked
accordingly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-id: 1503416789-32080-1-git-send-email-thuth@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/allwinner-a10.c    | 2 ++
 scripts/device-crash-test | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index f62a9a3..43a3f01 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -118,6 +118,8 @@ static void aw_a10_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = aw_a10_realize;
+    /* Reason: Uses serial_hds in realize and nd_table in instance_init */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo aw_a10_type_info = {
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index e77b693..81d65b9 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -187,7 +187,6 @@ ERROR_WHITELIST = [
     {'log':r"Device [\w.,-]+ can not be dynamically instantiated"},
     {'log':r"Platform Bus: Can not fit MMIO region of size "},
     # other more specific errors we will ignore:
-    {'device':'allwinner-a10', 'log':"Unsupported NIC model:"},
     {'device':'.*-spapr-cpu-core', 'log':r"CPU core type should be"},
     {'log':r"MSI(-X)? is not supported by interrupt controller"},
     {'log':r"pxb-pcie? devices cannot reside on a PCIe? bus"},
-- 
2.7.4
