Received: from eggs.gnu.org ([2001:4830:134:3::10]:59640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngx-0004fJ-1R
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngv-0001Ao-I2
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:19 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52072)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngv-0001AO-5C
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:17 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:06:15 +0300
Message-ID: <150642397488.3900.828583173542559010.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 23/43] windbg: kernel's structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

Defined Windows kernel's structures (CPU_CONTEXT and CPU_KSPECIAL_REGISTERS) for i386 and x64_86.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 windbgstub-utils.c |  247 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 247 insertions(+)

diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 1bde60a1e9..3c81ecefb8 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -23,6 +23,253 @@
 # define OFFSET_KPRCB_CURRTHREAD 0x4
 #endif
 
+/*
+ * Next code copied from winnt.h
+ */
+#ifdef TARGET_X86_64
+
+#define CPU_CONTEXT_AMD64 0x100000
+
+#define CPU_CONTEXT_CONTROL         (CPU_CONTEXT_AMD64 | 0x1)
+#define CPU_CONTEXT_INTEGER         (CPU_CONTEXT_AMD64 | 0x2)
+#define CPU_CONTEXT_SEGMENTS        (CPU_CONTEXT_AMD64 | 0x4)
+#define CPU_CONTEXT_FLOATING_POINT  (CPU_CONTEXT_AMD64 | 0x8)
+#define CPU_CONTEXT_DEBUG_REGISTERS (CPU_CONTEXT_AMD64 | 0x10)
+
+#define CPU_CONTEXT_FULL \
+    (CPU_CONTEXT_CONTROL | CPU_CONTEXT_INTEGER | CPU_CONTEXT_FLOATING_POINT)
+#define CPU_CONTEXT_ALL \
+    (CPU_CONTEXT_FULL | CPU_CONTEXT_SEGMENTS | CPU_CONTEXT_DEBUG_REGISTERS)
+
+typedef struct _CPU_DESCRIPTOR {
+    uint16_t Pad[3];
+    uint16_t Limit;
+    uint64_t Base;
+} CPU_DESCRIPTOR, *PCPU_DESCRIPTOR;
+
+typedef struct _CPU_KSPECIAL_REGISTERS {
+    uint64_t Cr0;
+    uint64_t Cr2;
+    uint64_t Cr3;
+    uint64_t Cr4;
+    uint64_t KernelDr0;
+    uint64_t KernelDr1;
+    uint64_t KernelDr2;
+    uint64_t KernelDr3;
+    uint64_t KernelDr6;
+    uint64_t KernelDr7;
+    CPU_DESCRIPTOR Gdtr;
+    CPU_DESCRIPTOR Idtr;
+    uint16_t Tr;
+    uint16_t Ldtr;
+    uint32_t MxCsr;
+    uint64_t DebugControl;
+    uint64_t LastBranchToRip;
+    uint64_t LastBranchFromRip;
+    uint64_t LastExceptionToRip;
+    uint64_t LastExceptionFromRip;
+    uint64_t Cr8;
+    uint64_t MsrGsBase;
+    uint64_t MsrGsSwap;
+    uint64_t MsrStar;
+    uint64_t MsrLStar;
+    uint64_t MsrCStar;
+    uint64_t MsrSyscallMask;
+    uint64_t Xcr0;
+} CPU_KSPECIAL_REGISTERS, *PCPU_KSPECIAL_REGISTERS;
+
+#pragma pack(push, 2)
+typedef struct _CPU_M128A {
+    uint64_t Low;
+    int64_t High;
+} CPU_M128A, *PCPU_M128A;
+#pragma pack(pop)
+
+typedef struct _CPU_XMM_SAVE_AREA32 {
+    uint16_t ControlWord;
+    uint16_t StatusWord;
+    uint8_t TagWord;
+    uint8_t Reserved1;
+    uint16_t ErrorOpcode;
+    uint32_t ErrorOffset;
+    uint16_t ErrorSelector;
+    uint16_t Reserved2;
+    uint32_t DataOffset;
+    uint16_t DataSelector;
+    uint16_t Reserved3;
+    uint32_t MxCsr;
+    uint32_t MxCsr_Mask;
+    CPU_M128A FloatRegisters[8];
+    CPU_M128A XmmRegisters[16];
+    uint8_t Reserved4[96];
+} CPU_XMM_SAVE_AREA32, *PCPU_XMM_SAVE_AREA32;
+
+#pragma pack(push, 2)
+typedef struct _CPU_CONTEXT { /* sizeof = 1232 */
+    uint64_t P1Home;
+    uint64_t P2Home;
+    uint64_t P3Home;
+    uint64_t P4Home;
+    uint64_t P5Home;
+    uint64_t P6Home;
+    uint32_t ContextFlags;
+    uint32_t MxCsr;
+    uint16_t SegCs;
+    uint16_t SegDs;
+    uint16_t SegEs;
+    uint16_t SegFs;
+    uint16_t SegGs;
+    uint16_t SegSs;
+    uint32_t EFlags;
+    uint64_t Dr0;
+    uint64_t Dr1;
+    uint64_t Dr2;
+    uint64_t Dr3;
+    uint64_t Dr6;
+    uint64_t Dr7;
+    uint64_t Rax;
+    uint64_t Rcx;
+    uint64_t Rdx;
+    uint64_t Rbx;
+    uint64_t Rsp;
+    uint64_t Rbp;
+    uint64_t Rsi;
+    uint64_t Rdi;
+    uint64_t R8;
+    uint64_t R9;
+    uint64_t R10;
+    uint64_t R11;
+    uint64_t R12;
+    uint64_t R13;
+    uint64_t R14;
+    uint64_t R15;
+    uint64_t Rip;
+    union {
+        CPU_XMM_SAVE_AREA32 FltSave;
+        CPU_XMM_SAVE_AREA32 FloatSave;
+        struct {
+            CPU_M128A Header[2];
+            CPU_M128A Legacy[8];
+            CPU_M128A Xmm0;
+            CPU_M128A Xmm1;
+            CPU_M128A Xmm2;
+            CPU_M128A Xmm3;
+            CPU_M128A Xmm4;
+            CPU_M128A Xmm5;
+            CPU_M128A Xmm6;
+            CPU_M128A Xmm7;
+            CPU_M128A Xmm8;
+            CPU_M128A Xmm9;
+            CPU_M128A Xmm10;
+            CPU_M128A Xmm11;
+            CPU_M128A Xmm12;
+            CPU_M128A Xmm13;
+            CPU_M128A Xmm14;
+            CPU_M128A Xmm15;
+        };
+    };
+    CPU_M128A VectorRegister[26];
+    uint64_t VectorControl;
+    uint64_t DebugControl;
+    uint64_t LastBranchToRip;
+    uint64_t LastBranchFromRip;
+    uint64_t LastExceptionToRip;
+    uint64_t LastExceptionFromRip;
+} CPU_CONTEXT, *PCPU_CONTEXT;
+#pragma pack(pop)
+
+#else
+
+#define SIZE_OF_X86_REG 80
+#define MAX_SUP_EXT 512
+
+#define CPU_CONTEXT_i386 0x10000
+
+#define CPU_CONTEXT_CONTROL            (CPU_CONTEXT_i386 | 0x1)
+#define CPU_CONTEXT_INTEGER            (CPU_CONTEXT_i386 | 0x2)
+#define CPU_CONTEXT_SEGMENTS           (CPU_CONTEXT_i386 | 0x4)
+#define CPU_CONTEXT_FLOATING_POINT     (CPU_CONTEXT_i386 | 0x8)
+#define CPU_CONTEXT_DEBUG_REGISTERS    (CPU_CONTEXT_i386 | 0x10)
+#define CPU_CONTEXT_EXTENDED_REGISTERS (CPU_CONTEXT_i386 | 0x20)
+
+#define CPU_CONTEXT_FULL \
+    (CPU_CONTEXT_CONTROL | CPU_CONTEXT_INTEGER | CPU_CONTEXT_SEGMENTS)
+#define CPU_CONTEXT_ALL \
+    (CPU_CONTEXT_FULL | CPU_CONTEXT_FLOATING_POINT | \
+     CPU_CONTEXT_DEBUG_REGISTERS | CPU_CONTEXT_EXTENDED_REGISTERS)
+
+typedef struct _CPU_DESCRIPTOR {
+    uint16_t Pad;
+    uint16_t Limit;
+    uint32_t Base;
+} CPU_DESCRIPTOR, *PCPU_DESCRIPTOR;
+
+typedef struct _CPU_KSPECIAL_REGISTERS {
+    uint32_t Cr0;
+    uint32_t Cr2;
+    uint32_t Cr3;
+    uint32_t Cr4;
+    uint32_t KernelDr0;
+    uint32_t KernelDr1;
+    uint32_t KernelDr2;
+    uint32_t KernelDr3;
+    uint32_t KernelDr6;
+    uint32_t KernelDr7;
+    CPU_DESCRIPTOR Gdtr;
+    CPU_DESCRIPTOR Idtr;
+    uint16_t Tr;
+    uint16_t Ldtr;
+    uint32_t Reserved[6];
+} CPU_KSPECIAL_REGISTERS, *PCPU_KSPECIAL_REGISTERS;
+
+typedef struct _CPU_FLOATING_SAVE_AREA {
+    uint32_t ControlWord;
+    uint32_t StatusWord;
+    uint32_t TagWord;
+    uint32_t ErrorOffset;
+    uint32_t ErrorSelector;
+    uint32_t DataOffset;
+    uint32_t DataSelector;
+    uint8_t RegisterArea[SIZE_OF_X86_REG];
+    uint32_t Cr0NpxState;
+} CPU_FLOATING_SAVE_AREA, *PCPU_FLOATING_SAVE_AREA;
+
+typedef struct _CPU_CONTEXT { /* sizeof = 716 */
+    uint32_t ContextFlags;
+    uint32_t Dr0;
+    uint32_t Dr1;
+    uint32_t Dr2;
+    uint32_t Dr3;
+    uint32_t Dr6;
+    uint32_t Dr7;
+    CPU_FLOATING_SAVE_AREA FloatSave;
+    uint32_t SegGs;
+    uint32_t SegFs;
+    uint32_t SegEs;
+    uint32_t SegDs;
+
+    uint32_t Edi;
+    uint32_t Esi;
+    uint32_t Ebx;
+    uint32_t Edx;
+    uint32_t Ecx;
+    uint32_t Eax;
+    uint32_t Ebp;
+    uint32_t Eip;
+    uint32_t SegCs;
+    uint32_t EFlags;
+    uint32_t Esp;
+    uint32_t SegSs;
+    uint8_t ExtendedRegisters[MAX_SUP_EXT];
+} CPU_CONTEXT, *PCPU_CONTEXT;
+
+typedef struct _CPU_KPROCESSOR_STATE {
+    CPU_CONTEXT ContextFrame;
+    CPU_KSPECIAL_REGISTERS SpecialRegisters;
+} CPU_KPROCESSOR_STATE, *PCPU_KPROCESSOR_STATE;
+
+#endif
+
 typedef struct KDData {
     InitedAddr KPCR;
     InitedAddr version;
