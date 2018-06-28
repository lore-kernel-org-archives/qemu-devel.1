Received: from eggs.gnu.org ([2001:4830:134:3::10]:37848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAR-00075X-9t
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAQ-00009Z-3K
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:23 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:32825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAP-00007Z-Ob
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:21 -0400
Received: by mail-wr0-x22c.google.com with SMTP id k7-v6so3189088wrq.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:21 -0700 (PDT)
Received: from 640k.lan ([82.84.124.111]) by smtp.gmail.com with ESMTPSA id
	127-v6sm6211110wmd.18.2018.06.28.13.05.19 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Jun 2018 13:05:19 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:17 +0200
Message-Id: <1530216310-52873-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/60] whpx: commit missing file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Not included by mistake in commit 327fccb288976f95808efa968082fc9d4a9ced84.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whp-dispatch.h | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 target/i386/whp-dispatch.h

diff --git a/target/i386/whp-dispatch.h b/target/i386/whp-dispatch.h
new file mode 100644
index 0000000..d8d3485
--- /dev/null
+++ b/target/i386/whp-dispatch.h
@@ -0,0 +1,56 @@
+#include "windows.h"
+#include <stdbool.h>
+
+#include <WinHvPlatform.h>
+#include <WinHvEmulation.h>
+
+#ifndef WHP_DISPATCH_H
+#define WHP_DISPATCH_H
+
+
+#define LIST_WINHVPLATFORM_FUNCTIONS(X) \
+  X(HRESULT, WHvGetCapability, (WHV_CAPABILITY_CODE CapabilityCode, VOID* CapabilityBuffer, UINT32 CapabilityBufferSizeInBytes, UINT32* WrittenSizeInBytes)) \
+  X(HRESULT, WHvCreatePartition, (WHV_PARTITION_HANDLE* Partition)) \
+  X(HRESULT, WHvSetupPartition, (WHV_PARTITION_HANDLE Partition)) \
+  X(HRESULT, WHvDeletePartition, (WHV_PARTITION_HANDLE Partition)) \
+  X(HRESULT, WHvGetPartitionProperty, (WHV_PARTITION_HANDLE Partition, WHV_PARTITION_PROPERTY_CODE PropertyCode, VOID* PropertyBuffer, UINT32 PropertyBufferSizeInBytes, UINT32* WrittenSizeInBytes)) \
+  X(HRESULT, WHvSetPartitionProperty, (WHV_PARTITION_HANDLE Partition, WHV_PARTITION_PROPERTY_CODE PropertyCode, const VOID* PropertyBuffer, UINT32 PropertyBufferSizeInBytes)) \
+  X(HRESULT, WHvMapGpaRange, (WHV_PARTITION_HANDLE Partition, VOID* SourceAddress, WHV_GUEST_PHYSICAL_ADDRESS GuestAddress, UINT64 SizeInBytes, WHV_MAP_GPA_RANGE_FLAGS Flags)) \
+  X(HRESULT, WHvUnmapGpaRange, (WHV_PARTITION_HANDLE Partition, WHV_GUEST_PHYSICAL_ADDRESS GuestAddress, UINT64 SizeInBytes)) \
+  X(HRESULT, WHvTranslateGva, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, WHV_GUEST_VIRTUAL_ADDRESS Gva, WHV_TRANSLATE_GVA_FLAGS TranslateFlags, WHV_TRANSLATE_GVA_RESULT* TranslationResult, WHV_GUEST_PHYSICAL_ADDRESS* Gpa)) \
+  X(HRESULT, WHvCreateVirtualProcessor, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, UINT32 Flags)) \
+  X(HRESULT, WHvDeleteVirtualProcessor, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex)) \
+  X(HRESULT, WHvRunVirtualProcessor, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, VOID* ExitContext, UINT32 ExitContextSizeInBytes)) \
+  X(HRESULT, WHvCancelRunVirtualProcessor, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, UINT32 Flags)) \
+  X(HRESULT, WHvGetVirtualProcessorRegisters, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, const WHV_REGISTER_NAME* RegisterNames, UINT32 RegisterCount, WHV_REGISTER_VALUE* RegisterValues)) \
+  X(HRESULT, WHvSetVirtualProcessorRegisters, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, const WHV_REGISTER_NAME* RegisterNames, UINT32 RegisterCount, const WHV_REGISTER_VALUE* RegisterValues)) \
+
+
+#define LIST_WINHVEMULATION_FUNCTIONS(X) \
+  X(HRESULT, WHvEmulatorCreateEmulator, (const WHV_EMULATOR_CALLBACKS* Callbacks, WHV_EMULATOR_HANDLE* Emulator)) \
+  X(HRESULT, WHvEmulatorDestroyEmulator, (WHV_EMULATOR_HANDLE Emulator)) \
+  X(HRESULT, WHvEmulatorTryIoEmulation, (WHV_EMULATOR_HANDLE Emulator, VOID* Context, const WHV_VP_EXIT_CONTEXT* VpContext, const WHV_X64_IO_PORT_ACCESS_CONTEXT* IoInstructionContext, WHV_EMULATOR_STATUS* EmulatorReturnStatus)) \
+  X(HRESULT, WHvEmulatorTryMmioEmulation, (WHV_EMULATOR_HANDLE Emulator, VOID* Context, const WHV_VP_EXIT_CONTEXT* VpContext, const WHV_MEMORY_ACCESS_CONTEXT* MmioInstructionContext, WHV_EMULATOR_STATUS* EmulatorReturnStatus)) \
+
+
+#define WHP_DEFINE_TYPE(return_type, function_name, signature) \
+    typedef return_type (WINAPI *function_name ## _t) signature;
+
+#define WHP_DECLARE_MEMBER(return_type, function_name, signature) \
+    function_name ## _t function_name;
+
+/* Define function typedef */
+LIST_WINHVPLATFORM_FUNCTIONS(WHP_DEFINE_TYPE)
+LIST_WINHVEMULATION_FUNCTIONS(WHP_DEFINE_TYPE)
+
+struct WHPDispatch {
+    LIST_WINHVPLATFORM_FUNCTIONS(WHP_DECLARE_MEMBER)
+    LIST_WINHVEMULATION_FUNCTIONS(WHP_DECLARE_MEMBER)
+};
+
+extern struct WHPDispatch whp_dispatch;
+
+bool init_whp_dispatch(void);
+
+
+#endif /* WHP_DISPATCH_H */
-- 
1.8.3.1
