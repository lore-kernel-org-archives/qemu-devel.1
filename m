Received: from eggs.gnu.org ([2001:4830:134:3::10]:50372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fcoTB-00032h-VR
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fcoT9-0003uD-Ds
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:58:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:44704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1fcoT9-0003tC-5d
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:57:59 -0400
From: Jingqi Liu <jingqi.liu@intel.com>
Date: Tue, 10 Jul 2018 16:57:32 +0800
Message-Id: <1531213054-63327-2-git-send-email-jingqi.liu@intel.com>
In-Reply-To: <1531213054-63327-1-git-send-email-jingqi.liu@intel.com>
References: <1531213054-63327-1-git-send-email-jingqi.liu@intel.com>
Subject: [Qemu-devel] [PATCH 1/3] x86/cpu: Enable UMONITOR/UMWAIT/TPAUSE cpu
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, wei.w.wang@intel.com, Jingqi Liu <jingqi.liu@intel.com>

UMONITOR, UMWAIT, and TPAUSE are a set of user wait instructions.

UMONITOR arms address monitoring hardware using an address. A store
to an address within the specified address range triggers the
monitoring hardware to wake up the processor waiting in umwait.

UMWAIT instructs the processor to enter an implementation-dependent
optimized state while monitoring a range of addresses. The optimized
state may be either a light-weight power/performance optimized state
or an improved power/performance optimized state.

TPAUSE instructs the processor to enter an implementation-dependent
optimized state c0.1 or c0.2 state and wake up when time-stamp counter
reaches specified timeout.

The bit definition:
CPUID.(EAX=7,ECX=0):ECX[bit 05] WAITPKG

The release document ref below link:
https://software.intel.com/sites/default/files/managed/c5/15/\
architecture-instruction-set-extensions-programming-reference.pdf

Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e0e2f2e..e0d151f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -978,7 +978,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_7_0_ECX] = {
         .feat_names = {
             NULL, "avx512vbmi", "umip", "pku",
-            NULL /* ospke */, NULL, "avx512vbmi2", NULL,
+            NULL /* ospke */, "waitpkg", "avx512vbmi2", NULL,
             "gfni", "vaes", "vpclmulqdq", "avx512vnni",
             "avx512bitalg", NULL, "avx512-vpopcntdq", NULL,
             "la57", NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2c5a0d9..f651105 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -674,6 +674,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_ECX_UMIP     (1U << 2)
 #define CPUID_7_0_ECX_PKU      (1U << 3)
 #define CPUID_7_0_ECX_OSPKE    (1U << 4)
+#define CPUID_7_0_ECX_WAITPKG  (1U << 5) /* UMONITOR/UMWAIT/TPAUSE Instructions */
 #define CPUID_7_0_ECX_VBMI2    (1U << 6) /* Additional VBMI Instrs */
 #define CPUID_7_0_ECX_GFNI     (1U << 8)
 #define CPUID_7_0_ECX_VAES     (1U << 9)
-- 
1.8.3.1
