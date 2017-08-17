Received: from eggs.gnu.org ([2001:4830:134:3::10]:47773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diH1G-0007HM-El
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diH1F-0000g5-1j
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:23:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1diH1E-0000fP-OU
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:23:12 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 17 Aug 2017 11:22:25 +0200
Message-Id: <20170817092225.4264-11-david@redhat.com>
In-Reply-To: <20170817092225.4264-1-david@redhat.com>
References: <20170817092225.4264-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.11 10/10] target/s390x: cleanup cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com

Let's reshuffle the function prototypes so we get a cleaner outline
of the files.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h | 140 ++++++++++++++++++++++++++---------------------------
 1 file changed, 69 insertions(+), 71 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index aeb730c..3650cfc 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -391,48 +391,6 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
 #define PER_CODE_EVENT_STORE_REAL      0x0800
 #define PER_CODE_EVENT_NULLIFICATION   0x0100
 
-S390CPU *cpu_s390x_init(const char *cpu_model);
-S390CPU *s390x_new_cpu(const char *cpu_model, int64_t id, Error **errp);
-
-/* you can call this signal handler from your SIGBUS and SIGSEGV
-   signal handlers to inform the virtual CPU of exceptions. non zero
-   is returned if the signal was handled by the virtual CPU.  */
-int cpu_s390x_signal_handler(int host_signum, void *pinfo,
-                           void *puc);
-
-
-#ifndef CONFIG_USER_ONLY
-
-void s390_enable_css_support(S390CPU *cpu);
-int s390_virtio_hypercall(CPUS390XState *env);
-
-int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low);
-int s390_set_clock(uint8_t *tod_high, uint64_t *tod_low);
-
-S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
-unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu);
-
-void gtod_save(QEMUFile *f, void *opaque);
-int gtod_load(QEMUFile *f, void *opaque, int version_id);
-
-/* service interrupts are floating therefore we must not pass an cpustate */
-void s390_sclp_extint(uint32_t parm);
-
-#else
-static inline unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
-{
-    return 0;
-}
-#endif
-
-extern void subsystem_reset(void);
-
-#define cpu_init(model) CPU(cpu_s390x_init(model))
-#define cpu_signal_handler cpu_s390x_signal_handler
-
-void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf);
-#define cpu_list s390_cpu_list
-
 #define EXCP_EXT 1 /* external interrupt */
 #define EXCP_SVC 2 /* supervisor call (syscall) */
 #define EXCP_PGM 3 /* program interruption */
@@ -652,39 +610,10 @@ struct sysib_322 {
 /* SIGP order code mask corresponding to bit positions 56-63 */
 #define SIGP_ORDER_MASK 0x000000ff
 
-int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
-
-int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
-                         int len, bool is_write);
-
-#define s390_cpu_virt_mem_read(cpu, laddr, ar, dest, len)    \
-        s390_cpu_virt_mem_rw(cpu, laddr, ar, dest, len, false)
-#define s390_cpu_virt_mem_write(cpu, laddr, ar, dest, len)       \
-        s390_cpu_virt_mem_rw(cpu, laddr, ar, dest, len, true)
-#define s390_cpu_virt_mem_check_write(cpu, laddr, ar, len)   \
-        s390_cpu_virt_mem_rw(cpu, laddr, ar, NULL, len, true)
-
 /* from s390-virtio-ccw */
 #define MEM_SECTION_SIZE             0x10000000UL
 #define MAX_AVAIL_SLOTS              32
 
-/* automatically detect the instruction length */
-#define ILEN_AUTO                   0xff
-void program_interrupt(CPUS390XState *env, uint32_t code, int ilen);
-
-
-int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit);
-void s390_cmma_reset(void);
-int s390_cpu_restart(S390CPU *cpu);
-int s390_get_memslot_count(KVMState *s);
-void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
-                       uint32_t io_int_parm, uint32_t io_int_word);
-void s390_crw_mchk(void);
-int s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch_id,
-                                int vq, bool assign);
-void s390_crypto_reset(void);
-bool s390_get_squash_mcss(void);
-
 /* machine check interruption code */
 
 /* subclasses */
@@ -730,4 +659,73 @@ bool s390_get_squash_mcss(void);
 #define MCIC_VB_CT 0x0000000000020000ULL
 #define MCIC_VB_CC 0x0000000000010000ULL
 
+
+/* cpu.c */
+int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low);
+int s390_set_clock(uint8_t *tod_high, uint64_t *tod_low);
+void s390_crypto_reset(void);
+bool s390_get_squash_mcss(void);
+int s390_get_memslot_count(KVMState *s);
+int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit);
+void s390_cmma_reset(void);
+int s390_cpu_restart(S390CPU *cpu);
+void s390_enable_css_support(S390CPU *cpu);
+int s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch_id,
+                                int vq, bool assign);
+#ifndef CONFIG_USER_ONLY
+unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu);
+#else
+static inline unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
+{
+    return 0;
+}
+#endif /* CONFIG_USER_ONLY */
+
+
+/* cpu_models.c */
+void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf);
+#define cpu_list s390_cpu_list
+
+
+/* helper.c */
+S390CPU *cpu_s390x_init(const char *cpu_model);
+#define cpu_init(model) CPU(cpu_s390x_init(model))
+S390CPU *s390x_new_cpu(const char *cpu_model, int64_t id, Error **errp);
+/* you can call this signal handler from your SIGBUS and SIGSEGV
+   signal handlers to inform the virtual CPU of exceptions. non zero
+   is returned if the signal was handled by the virtual CPU.  */
+int cpu_s390x_signal_handler(int host_signum, void *pinfo, void *puc);
+#define cpu_signal_handler cpu_s390x_signal_handler
+
+
+/* interrupt.c */
+void s390_crw_mchk(void);
+void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
+                       uint32_t io_int_parm, uint32_t io_int_word);
+/* automatically detect the instruction length */
+#define ILEN_AUTO                   0xff
+void program_interrupt(CPUS390XState *env, uint32_t code, int ilen);
+/* service interrupts are floating therefore we must not pass an cpustate */
+void s390_sclp_extint(uint32_t parm);
+
+
+/* mmu_helper.c */
+int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
+                         int len, bool is_write);
+#define s390_cpu_virt_mem_read(cpu, laddr, ar, dest, len)    \
+        s390_cpu_virt_mem_rw(cpu, laddr, ar, dest, len, false)
+#define s390_cpu_virt_mem_write(cpu, laddr, ar, dest, len)       \
+        s390_cpu_virt_mem_rw(cpu, laddr, ar, dest, len, true)
+#define s390_cpu_virt_mem_check_write(cpu, laddr, ar, len)   \
+        s390_cpu_virt_mem_rw(cpu, laddr, ar, NULL, len, true)
+
+
+/* outside of target/s390x/ */
+S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
+extern void subsystem_reset(void);
+int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
+int s390_virtio_hypercall(CPUS390XState *env);
+void gtod_save(QEMUFile *f, void *opaque);
+int gtod_load(QEMUFile *f, void *opaque, int version_id);
+
 #endif
-- 
2.9.4
