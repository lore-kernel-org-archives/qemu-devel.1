Received: from eggs.gnu.org ([2001:4830:134:3::10]:39243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <petrutlucian94@gmail.com>) id 1fMDJO-0007Dm-KM
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <petrutlucian94@gmail.com>) id 1fMDJI-0000Vm-Ng
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:03:18 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <petrutlucian94@gmail.com>)
	id 1fMDJI-0000V8-Hj
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:03:12 -0400
Received: by mail-wm0-x243.google.com with SMTP id n10-v6so14895884wmc.1
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 07:03:12 -0700 (PDT)
From: petrutlucian94@gmail.com
Date: Fri, 25 May 2018 17:02:21 +0300
Message-Id: <1527256943-7667-1-git-send-email-lpetrut@cloudbasesolutions.com>
Subject: [Qemu-devel] [PATCH v3 1/3] WHPX Add signature CPUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Lucian Petrut <lpetrut@cloudbasesolutions.com>, Alessandro Pilotti <apilotti@cloudbasesolutions.com>, Justin Terry <juterry@microsoft.com>

From: Lucian Petrut <lpetrut@cloudbasesolutions.com>

Adds the CPUID trap for CPUID 0x40000000, sending the WHPX signature
to the guest upon request. This is consistent with other QEMU
accelerators (KVM).

Signed-off-by: Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
Signed-off-by: Lucian Petrut <lpetrut@cloudbasesolutions.com>
---
 target/i386/whpx-all.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 5843517..ffc083e 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -29,6 +29,8 @@
 #include <WinHvPlatform.h>
 #include <WinHvEmulation.h>
 
+#define WHPX_CPUID_SIGNATURE 0x40000000
+
 struct whpx_state {
     uint64_t mem_quota;
     WHV_PARTITION_HANDLE partition;
@@ -1349,6 +1351,27 @@ static int whpx_accel_init(MachineState *ms)
         goto error;
     }
 
+    UINT32 signature[3] = {0};
+    memcpy(signature, "Hv#1\0\0\0\0\0\0\0\0", 12);
+
+    WHV_X64_CPUID_RESULT cpuidResultList[1] = {0};
+    cpuidResultList[0].Function = WHPX_CPUID_SIGNATURE;
+    cpuidResultList[0].Eax = 0;
+    cpuidResultList[0].Ebx = signature[0];
+    cpuidResultList[0].Ecx = signature[1];
+    cpuidResultList[0].Edx = signature[2];
+    hr = WHvSetPartitionProperty(whpx->partition,
+                                 WHvPartitionPropertyCodeCpuidResultList,
+                                 cpuidResultList,
+                                 RTL_NUMBER_OF(cpuidResultList) *
+                                    sizeof(WHV_X64_CPUID_RESULT));
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set partition CpuidResultList hr=%08lx",
+                     hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
     hr = WHvSetupPartition(whpx->partition);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to setup partition, hr=%08lx", hr);
-- 
2.7.4
