Received: from eggs.gnu.org ([2001:4830:134:3::10]:54031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eC7cQ-0001xp-35
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eC7cM-0005Iv-UG
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:24:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eC7cM-0005IX-IX
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:24:54 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA7HNtwI115064
	for <qemu-devel@nongnu.org>; Tue, 7 Nov 2017 12:24:48 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e3fpc59pf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 12:24:47 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Tue, 7 Nov 2017 17:24:43 -0000
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Tue,  7 Nov 2017 18:24:33 +0100
In-Reply-To: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
Message-Id: <1510075479-17224-2-git-send-email-pmorel@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/7] s390x/pci: factor out endianess conversion
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
---
 hw/s390x/s390-pci-inst.c | 58 ++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 8e088f3..8fcb02d 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -314,6 +314,35 @@ out:
     return 0;
 }
 
+/**
+ * This function swaps the data at ptr according from one
+ * endianness to the other.
+ * valid data in the uint64_t data field.
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
@@ -385,19 +414,7 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
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
@@ -500,19 +517,8 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
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
