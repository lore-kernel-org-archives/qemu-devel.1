Received: from eggs.gnu.org ([2001:4830:134:3::10]:37955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eFOKk-0001kb-6q
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:52:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eFOKg-0003DF-Uu
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:52:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52998
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eFOKg-0003CK-Ng
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:52:10 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAGHnSke117699
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 12:52:02 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e9de96tqk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 12:52:01 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Thu, 16 Nov 2017 17:52:00 -0000
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 16 Nov 2017 18:51:49 +0100
In-Reply-To: <1510854715-7081-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1510854715-7081-1-git-send-email-pmorel@linux.vnet.ibm.com>
Message-Id: <1510854715-7081-2-git-send-email-pmorel@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/7] s390x/pci: factor out endianess
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

There are two places where the same endianness conversion
is done.
Let's factor this out into a static function.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 hw/s390x/s390-pci-inst.c | 59 +++++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 8e088f3..ded1556 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -314,6 +314,36 @@ out:
     return 0;
 }
 
+/**
+ * This function is called when endianess is fixed, whatever the host endianess
+ * is, like in our case from s390x BIG endian registers to little endian PCI
+ * Bars, to translate the uint64_t pointed from one endianess to the other.
+ *
+ * @ptr: a pointer to a uint64_t data field
+ * @len: the length of the valid data, must be 1,2,4 or 8
+ */
+static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
+{
+    uint64_t data = *ptr;
+    switch (len) {
+    case 1:
+        break;
+    case 2:
+        data = bswap16(data);
+        break;
+    case 4:
+        data = bswap32(data);
+        break;
+    case 8:
+        data = bswap64(data);
+        break;
+    default:
+        return -EINVAL;
+    }
+    *ptr = data;
+    return 0;
+}
+
 int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
 {
     CPUS390XState *env = &cpu->env;
@@ -385,19 +415,7 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
         data =  pci_host_config_read_common(
                    pbdev->pdev, offset, pci_config_size(pbdev->pdev), len);
 
-        switch (len) {
-        case 1:
-            break;
-        case 2:
-            data = bswap16(data);
-            break;
-        case 4:
-            data = bswap32(data);
-            break;
-        case 8:
-            data = bswap64(data);
-            break;
-        default:
+        if (zpci_endian_swap(&data, len)) {
             program_interrupt(env, PGM_OPERAND, 4);
             return 0;
         }
@@ -500,19 +518,8 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
             program_interrupt(env, PGM_OPERAND, 4);
             return 0;
         }
-        switch (len) {
-        case 1:
-            break;
-        case 2:
-            data = bswap16(data);
-            break;
-        case 4:
-            data = bswap32(data);
-            break;
-        case 8:
-            data = bswap64(data);
-            break;
-        default:
+
+        if (zpci_endian_swap(&data, len)) {
             program_interrupt(env, PGM_OPERAND, 4);
             return 0;
         }
-- 
2.7.4
