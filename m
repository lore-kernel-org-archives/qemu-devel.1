Received: from eggs.gnu.org ([2001:4830:134:3::10]:48367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyY-0007bm-9J
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyV-0006Y6-FZ
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:58 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:44274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyU-0006Vx-TT
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:55 -0400
Received: by mail-wr1-x42a.google.com with SMTP id 63-v6so35061259wra.11
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:53 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:59 +0200
Message-Id: <1539894735-14232-33-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 32/48] hyperv: split hyperv-proto.h into x86 and
 arch-independent parts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Kagan <rkagan@virtuozzo.com>

From: Roman Kagan <rkagan@virtuozzo.com>

Some parts of the Hyper-V hypervisor-guest interface appear to be
target-independent, so move them into a proper header.

Not that Hyper-V ARM64 emulation is around the corner but it seems more
conveninent to have most of Hyper-V and VMBus target-independent, and
allows to avoid conflicts with inclusion of arch-specific headers down
the road in VMBus implementation.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180921082041.29380-2-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/hyperv/hyperv-proto.h | 129 +++++++++++++++++++++++++++++++++++++++
 target/i386/hyperv-proto.h       | 115 +---------------------------------
 2 files changed, 132 insertions(+), 112 deletions(-)
 create mode 100644 include/hw/hyperv/hyperv-proto.h

diff --git a/include/hw/hyperv/hyperv-proto.h b/include/hw/hyperv/hyperv-proto.h
new file mode 100644
index 0000000..2dc78ee
--- /dev/null
+++ b/include/hw/hyperv/hyperv-proto.h
@@ -0,0 +1,129 @@
+/*
+ * Definitions for Hyper-V guest/hypervisor interaction
+ *
+ * Copyright (c) 2017-2018 Virtuozzo International GmbH.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_HYPERV_HYPERV_PROTO_H
+#define HW_HYPERV_HYPERV_PROTO_H
+
+#include "qemu/bitmap.h"
+
+/*
+ * Hypercall status code
+ */
+#define HV_STATUS_SUCCESS                     0
+#define HV_STATUS_INVALID_HYPERCALL_CODE      2
+#define HV_STATUS_INVALID_HYPERCALL_INPUT     3
+#define HV_STATUS_INVALID_ALIGNMENT           4
+#define HV_STATUS_INVALID_PARAMETER           5
+#define HV_STATUS_INSUFFICIENT_MEMORY         11
+#define HV_STATUS_INVALID_CONNECTION_ID       18
+#define HV_STATUS_INSUFFICIENT_BUFFERS        19
+
+/*
+ * Hypercall numbers
+ */
+#define HV_POST_MESSAGE                       0x005c
+#define HV_SIGNAL_EVENT                       0x005d
+#define HV_HYPERCALL_FAST                     (1u << 16)
+
+/*
+ * Message size
+ */
+#define HV_MESSAGE_PAYLOAD_SIZE               240
+
+/*
+ * Message types
+ */
+#define HV_MESSAGE_NONE                       0x00000000
+#define HV_MESSAGE_VMBUS                      0x00000001
+#define HV_MESSAGE_UNMAPPED_GPA               0x80000000
+#define HV_MESSAGE_GPA_INTERCEPT              0x80000001
+#define HV_MESSAGE_TIMER_EXPIRED              0x80000010
+#define HV_MESSAGE_INVALID_VP_REGISTER_VALUE  0x80000020
+#define HV_MESSAGE_UNRECOVERABLE_EXCEPTION    0x80000021
+#define HV_MESSAGE_UNSUPPORTED_FEATURE        0x80000022
+#define HV_MESSAGE_EVENTLOG_BUFFERCOMPLETE    0x80000040
+#define HV_MESSAGE_X64_IOPORT_INTERCEPT       0x80010000
+#define HV_MESSAGE_X64_MSR_INTERCEPT          0x80010001
+#define HV_MESSAGE_X64_CPUID_INTERCEPT        0x80010002
+#define HV_MESSAGE_X64_EXCEPTION_INTERCEPT    0x80010003
+#define HV_MESSAGE_X64_APIC_EOI               0x80010004
+#define HV_MESSAGE_X64_LEGACY_FP_ERROR        0x80010005
+
+/*
+ * Message flags
+ */
+#define HV_MESSAGE_FLAG_PENDING               0x1
+
+/*
+ * Number of synthetic interrupts
+ */
+#define HV_SINT_COUNT                         16
+
+/*
+ * Event flags number per SINT
+ */
+#define HV_EVENT_FLAGS_COUNT                  (256 * 8)
+
+/*
+ * Connection id valid bits
+ */
+#define HV_CONNECTION_ID_MASK                 0x00ffffff
+
+/*
+ * Input structure for POST_MESSAGE hypercall
+ */
+struct hyperv_post_message_input {
+    uint32_t connection_id;
+    uint32_t _reserved;
+    uint32_t message_type;
+    uint32_t payload_size;
+    uint8_t  payload[HV_MESSAGE_PAYLOAD_SIZE];
+};
+
+/*
+ * Input structure for SIGNAL_EVENT hypercall
+ */
+struct hyperv_signal_event_input {
+    uint32_t connection_id;
+    uint16_t flag_number;
+    uint16_t _reserved_zero;
+};
+
+/*
+ * SynIC message structures
+ */
+struct hyperv_message_header {
+    uint32_t message_type;
+    uint8_t  payload_size;
+    uint8_t  message_flags; /* HV_MESSAGE_FLAG_XX */
+    uint8_t  _reserved[2];
+    uint64_t sender;
+};
+
+struct hyperv_message {
+    struct hyperv_message_header header;
+    uint8_t payload[HV_MESSAGE_PAYLOAD_SIZE];
+};
+
+struct hyperv_message_page {
+    struct hyperv_message slot[HV_SINT_COUNT];
+};
+
+/*
+ * SynIC event flags structures
+ */
+struct hyperv_event_flags {
+    DECLARE_BITMAP(flags, HV_EVENT_FLAGS_COUNT);
+};
+
+struct hyperv_event_flags_page {
+    struct hyperv_event_flags slot[HV_SINT_COUNT];
+};
+
+#endif
diff --git a/target/i386/hyperv-proto.h b/target/i386/hyperv-proto.h
index 87f36d1..8c572cd 100644
--- a/target/i386/hyperv-proto.h
+++ b/target/i386/hyperv-proto.h
@@ -1,7 +1,7 @@
 /*
- * Definitions for Hyper-V guest/hypervisor interaction
+ * Definitions for Hyper-V guest/hypervisor interaction - x86-specific part
  *
- * Copyright (C) 2017 Parallels International GmbH
+ * Copyright (c) 2017-2018 Virtuozzo International GmbH.
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
@@ -10,7 +10,7 @@
 #ifndef TARGET_I386_HYPERV_PROTO_H
 #define TARGET_I386_HYPERV_PROTO_H
 
-#include "qemu/bitmap.h"
+#include "hw/hyperv/hyperv-proto.h"
 
 #define HV_CPUID_VENDOR_AND_MAX_FUNCTIONS     0x40000000
 #define HV_CPUID_INTERFACE                    0x40000001
@@ -139,25 +139,6 @@
 #define HV_X64_MSR_TSC_EMULATION_STATUS         0x40000108
 
 /*
- * Hypercall status code
- */
-#define HV_STATUS_SUCCESS                     0
-#define HV_STATUS_INVALID_HYPERCALL_CODE      2
-#define HV_STATUS_INVALID_HYPERCALL_INPUT     3
-#define HV_STATUS_INVALID_ALIGNMENT           4
-#define HV_STATUS_INVALID_PARAMETER           5
-#define HV_STATUS_INSUFFICIENT_MEMORY         11
-#define HV_STATUS_INVALID_CONNECTION_ID       18
-#define HV_STATUS_INSUFFICIENT_BUFFERS        19
-
-/*
- * Hypercall numbers
- */
-#define HV_POST_MESSAGE                       0x005c
-#define HV_SIGNAL_EVENT                       0x005d
-#define HV_HYPERCALL_FAST                     (1u << 16)
-
-/*
  * Hypercall MSR bits
  */
 #define HV_HYPERCALL_ENABLE                   (1u << 0)
@@ -166,7 +147,6 @@
  * Synthetic interrupt controller definitions
  */
 #define HV_SYNIC_VERSION                      1
-#define HV_SINT_COUNT                         16
 #define HV_SYNIC_ENABLE                       (1u << 0)
 #define HV_SIMP_ENABLE                        (1u << 0)
 #define HV_SIEFP_ENABLE                       (1u << 0)
@@ -176,94 +156,5 @@
 
 #define HV_STIMER_COUNT                       4
 
-/*
- * Message size
- */
-#define HV_MESSAGE_PAYLOAD_SIZE               240
-
-/*
- * Message types
- */
-#define HV_MESSAGE_NONE                       0x00000000
-#define HV_MESSAGE_VMBUS                      0x00000001
-#define HV_MESSAGE_UNMAPPED_GPA               0x80000000
-#define HV_MESSAGE_GPA_INTERCEPT              0x80000001
-#define HV_MESSAGE_TIMER_EXPIRED              0x80000010
-#define HV_MESSAGE_INVALID_VP_REGISTER_VALUE  0x80000020
-#define HV_MESSAGE_UNRECOVERABLE_EXCEPTION    0x80000021
-#define HV_MESSAGE_UNSUPPORTED_FEATURE        0x80000022
-#define HV_MESSAGE_EVENTLOG_BUFFERCOMPLETE    0x80000040
-#define HV_MESSAGE_X64_IOPORT_INTERCEPT       0x80010000
-#define HV_MESSAGE_X64_MSR_INTERCEPT          0x80010001
-#define HV_MESSAGE_X64_CPUID_INTERCEPT        0x80010002
-#define HV_MESSAGE_X64_EXCEPTION_INTERCEPT    0x80010003
-#define HV_MESSAGE_X64_APIC_EOI               0x80010004
-#define HV_MESSAGE_X64_LEGACY_FP_ERROR        0x80010005
-
-/*
- * Message flags
- */
-#define HV_MESSAGE_FLAG_PENDING               0x1
-
-/*
- * Event flags number per SINT
- */
-#define HV_EVENT_FLAGS_COUNT                  (256 * 8)
-
-/*
- * Connection id valid bits
- */
-#define HV_CONNECTION_ID_MASK                 0x00ffffff
-
-/*
- * Input structure for POST_MESSAGE hypercall
- */
-struct hyperv_post_message_input {
-    uint32_t connection_id;
-    uint32_t _reserved;
-    uint32_t message_type;
-    uint32_t payload_size;
-    uint8_t  payload[HV_MESSAGE_PAYLOAD_SIZE];
-};
-
-/*
- * Input structure for SIGNAL_EVENT hypercall
- */
-struct hyperv_signal_event_input {
-    uint32_t connection_id;
-    uint16_t flag_number;
-    uint16_t _reserved_zero;
-};
-
-/*
- * SynIC message structures
- */
-struct hyperv_message_header {
-    uint32_t message_type;
-    uint8_t  payload_size;
-    uint8_t  message_flags; /* HV_MESSAGE_FLAG_XX */
-    uint8_t  _reserved[2];
-    uint64_t sender;
-};
-
-struct hyperv_message {
-    struct hyperv_message_header header;
-    uint8_t payload[HV_MESSAGE_PAYLOAD_SIZE];
-};
-
-struct hyperv_message_page {
-    struct hyperv_message slot[HV_SINT_COUNT];
-};
-
-/*
- * SynIC event flags structures
- */
-struct hyperv_event_flags {
-    DECLARE_BITMAP(flags, HV_EVENT_FLAGS_COUNT);
-};
-
-struct hyperv_event_flags_page {
-    struct hyperv_event_flags slot[HV_SINT_COUNT];
-};
 
 #endif
-- 
1.8.3.1
