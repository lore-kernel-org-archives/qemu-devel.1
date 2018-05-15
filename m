Received: from eggs.gnu.org ([2001:4830:134:3::10]:47169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <petrutlucian94@gmail.com>) id 1fIdrV-0001dq-55
	for qemu-devel@nongnu.org; Tue, 15 May 2018 13:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <petrutlucian94@gmail.com>) id 1fIdrR-0006sU-7B
	for qemu-devel@nongnu.org; Tue, 15 May 2018 13:35:45 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:32910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <petrutlucian94@gmail.com>)
	id 1fIdrR-0006sF-0B
	for qemu-devel@nongnu.org; Tue, 15 May 2018 13:35:41 -0400
Received: by mail-wm0-x244.google.com with SMTP id x12-v6so16717550wmc.0
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 10:35:40 -0700 (PDT)
From: petrutlucian94@gmail.com
Date: Tue, 15 May 2018 20:35:20 +0300
Message-Id: <1526405722-10887-1-git-send-email-lpetrut@cloudbasesolutions.com>
Subject: [Qemu-devel] [PATCH v2 1/3] WHPX Add signature CPUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Lucian Petrut <lpetrut@cloudbasesolutions.com>, Alessandro Pilotti <apilotti@cloudbasesolutions.com>, Justin Terry <juterry@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

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
index 5843517..64ef79a 100644
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
+    memcpy(signature, "WHPXWHPXWHPX", 12);
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
