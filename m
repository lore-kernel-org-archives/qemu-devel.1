Received: from eggs.gnu.org ([209.51.188.92]:60138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0c-0005ZQ-LX
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0X-0004Rp-Jl
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:54 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:04 +1000
Message-Id: <20190426060627.18153-14-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/36] target/ppc: Style fixes for kvm_ppc.h and
 kvm.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/kvm.c     | 178 +++++++++++++++++++++++++++----------------
 target/ppc/kvm_ppc.h |   3 +-
 2 files changed, 115 insertions(+), 66 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 2427c8ee13..a1c223385d 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -49,7 +49,7 @@
 #include "elf.h"
 #include "sysemu/kvm_int.h"
=20
-//#define DEBUG_KVM
+/* #define DEBUG_KVM */
=20
 #ifdef DEBUG_KVM
 #define DPRINTF(fmt, ...) \
@@ -65,8 +65,8 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[=
] =3D {
     KVM_CAP_LAST_INFO
 };
=20
-static int cap_interrupt_unset =3D false;
-static int cap_interrupt_level =3D false;
+static int cap_interrupt_unset;
+static int cap_interrupt_level;
 static int cap_segstate;
 static int cap_booke_sregs;
 static int cap_ppc_smt;
@@ -96,7 +96,8 @@ static int cap_large_decr;
=20
 static uint32_t debug_inst_opcode;
=20
-/* XXX We have a race condition where we actually have a level triggered
+/*
+ * XXX We have a race condition where we actually have a level triggered
  *     interrupt, but the infrastructure can't expose that yet, so the g=
uest
  *     takes but ignores it, goes to sleep and never gets notified that =
there's
  *     still an interrupt pending.
@@ -114,10 +115,12 @@ static void kvm_kick_cpu(void *opaque)
     qemu_cpu_kick(CPU(cpu));
 }
=20
-/* Check whether we are running with KVM-PR (instead of KVM-HV).  This
+/*
+ * Check whether we are running with KVM-PR (instead of KVM-HV).  This
  * should only be used for fallback tests - generally we should use
  * explicit capabilities for the features we want, rather than
- * assuming what is/isn't available depending on the KVM variant. */
+ * assuming what is/isn't available depending on the KVM variant.
+ */
 static bool kvmppc_is_pr(KVMState *ks)
 {
     /* Assume KVM-PR if the GET_PVINFO capability is available */
@@ -143,8 +146,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_hior =3D kvm_check_extension(s, KVM_CAP_PPC_HIOR);
     cap_epr =3D kvm_check_extension(s, KVM_CAP_PPC_EPR);
     cap_ppc_watchdog =3D kvm_check_extension(s, KVM_CAP_PPC_BOOKE_WATCHD=
OG);
-    /* Note: we don't set cap_papr here, because this capability is
-     * only activated after this by kvmppc_set_papr() */
+    /*
+     * Note: we don't set cap_papr here, because this capability is
+     * only activated after this by kvmppc_set_papr()
+     */
     cap_htab_fd =3D kvm_vm_check_extension(s, KVM_CAP_PPC_HTAB_FD);
     cap_fixup_hcalls =3D kvm_check_extension(s, KVM_CAP_PPC_FIXUP_HCALL)=
;
     cap_ppc_smt =3D kvm_vm_check_extension(s, KVM_CAP_PPC_SMT);
@@ -160,7 +165,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
      * in KVM at this moment.
      *
      * TODO: call kvm_vm_check_extension() with the right capability
-     * after the kernel starts implementing it.*/
+     * after the kernel starts implementing it.
+     */
     cap_ppc_pvr_compat =3D false;
=20
     if (!cap_interrupt_level) {
@@ -186,10 +192,13 @@ static int kvm_arch_sync_sregs(PowerPCCPU *cpu)
     int ret;
=20
     if (cenv->excp_model =3D=3D POWERPC_EXCP_BOOKE) {
-        /* What we're really trying to say is "if we're on BookE, we use
-           the native PVR for now". This is the only sane way to check
-           it though, so we potentially confuse users that they can run
-           BookE guests on BookS. Let's hope nobody dares enough :) */
+        /*
+         * What we're really trying to say is "if we're on BookE, we
+         * use the native PVR for now". This is the only sane way to
+         * check it though, so we potentially confuse users that they
+         * can run BookE guests on BookS. Let's hope nobody dares
+         * enough :)
+         */
         return 0;
     } else {
         if (!cap_segstate) {
@@ -421,12 +430,14 @@ void kvm_check_mmu(PowerPCCPU *cpu, Error **errp)
     }
=20
     if (ppc_hash64_has(cpu, PPC_HASH64_CI_LARGEPAGE)) {
-        /* Mostly what guest pagesizes we can use are related to the
+        /*
+         * Mostly what guest pagesizes we can use are related to the
          * host pages used to map guest RAM, which is handled in the
          * platform code. Cache-Inhibited largepages (64k) however are
          * used for I/O, so if they're mapped to the host at all it
          * will be a normal mapping, not a special hugepage one used
-         * for RAM. */
+         * for RAM.
+         */
         if (getpagesize() < 0x10000) {
             error_setg(errp,
                        "KVM can't supply 64kiB CI pages, which guest exp=
ects");
@@ -440,9 +451,9 @@ unsigned long kvm_arch_vcpu_id(CPUState *cpu)
     return POWERPC_CPU(cpu)->vcpu_id;
 }
=20
-/* e500 supports 2 h/w breakpoint and 2 watchpoint.
- * book3s supports only 1 watchpoint, so array size
- * of 4 is sufficient for now.
+/*
+ * e500 supports 2 h/w breakpoint and 2 watchpoint.  book3s supports
+ * only 1 watchpoint, so array size of 4 is sufficient for now.
  */
 #define MAX_HW_BKPTS 4
=20
@@ -497,9 +508,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
         break;
     case POWERPC_MMU_2_07:
         if (!cap_htm && !kvmppc_is_pr(cs->kvm_state)) {
-            /* KVM-HV has transactional memory on POWER8 also without th=
e
-             * KVM_CAP_PPC_HTM extension, so enable it here instead as
-             * long as it's availble to userspace on the host. */
+            /*
+             * KVM-HV has transactional memory on POWER8 also without
+             * the KVM_CAP_PPC_HTM extension, so enable it here
+             * instead as long as it's availble to userspace on the
+             * host.
+             */
             if (qemu_getauxval(AT_HWCAP2) & PPC_FEATURE2_HAS_HTM) {
                 cap_htm =3D true;
             }
@@ -800,10 +814,12 @@ static int kvm_put_vpa(CPUState *cs)
     struct kvm_one_reg reg;
     int ret;
=20
-    /* SLB shadow or DTL can't be registered unless a master VPA is
+    /*
+     * SLB shadow or DTL can't be registered unless a master VPA is
      * registered.  That means when restoring state, if a VPA *is*
      * registered, we need to set that up first.  If not, we need to
-     * deregister the others before deregistering the master VPA */
+     * deregister the others before deregistering the master VPA
+     */
     assert(spapr_cpu->vpa_addr
            || !(spapr_cpu->slb_shadow_addr || spapr_cpu->dtl_addr));
=20
@@ -929,8 +945,9 @@ int kvm_arch_put_registers(CPUState *cs, int level)
=20
     regs.pid =3D env->spr[SPR_BOOKE_PID];
=20
-    for (i =3D 0;i < 32; i++)
+    for (i =3D 0; i < 32; i++) {
         regs.gpr[i] =3D env->gpr[i];
+    }
=20
     regs.cr =3D 0;
     for (i =3D 0; i < 8; i++) {
@@ -938,8 +955,9 @@ int kvm_arch_put_registers(CPUState *cs, int level)
     }
=20
     ret =3D kvm_vcpu_ioctl(cs, KVM_SET_REGS, &regs);
-    if (ret < 0)
+    if (ret < 0) {
         return ret;
+    }
=20
     kvm_put_fp(cs);
=20
@@ -962,10 +980,12 @@ int kvm_arch_put_registers(CPUState *cs, int level)
     if (cap_one_reg) {
         int i;
=20
-        /* We deliberately ignore errors here, for kernels which have
+        /*
+         * We deliberately ignore errors here, for kernels which have
          * the ONE_REG calls, but don't support the specific
          * registers, there's a reasonable chance things will still
-         * work, at least until we try to migrate. */
+         * work, at least until we try to migrate.
+         */
         for (i =3D 0; i < 1024; i++) {
             uint64_t id =3D env->spr_cb[i].one_reg_id;
=20
@@ -1207,8 +1227,9 @@ int kvm_arch_get_registers(CPUState *cs)
     int i, ret;
=20
     ret =3D kvm_vcpu_ioctl(cs, KVM_GET_REGS, &regs);
-    if (ret < 0)
+    if (ret < 0) {
         return ret;
+    }
=20
     cr =3D regs.cr;
     for (i =3D 7; i >=3D 0; i--) {
@@ -1236,8 +1257,9 @@ int kvm_arch_get_registers(CPUState *cs)
=20
     env->spr[SPR_BOOKE_PID] =3D regs.pid;
=20
-    for (i =3D 0;i < 32; i++)
+    for (i =3D 0; i < 32; i++) {
         env->gpr[i] =3D regs.gpr[i];
+    }
=20
     kvm_get_fp(cs);
=20
@@ -1262,10 +1284,12 @@ int kvm_arch_get_registers(CPUState *cs)
     if (cap_one_reg) {
         int i;
=20
-        /* We deliberately ignore errors here, for kernels which have
+        /*
+         * We deliberately ignore errors here, for kernels which have
          * the ONE_REG calls, but don't support the specific
          * registers, there's a reasonable chance things will still
-         * work, at least until we try to migrate. */
+         * work, at least until we try to migrate.
+         */
         for (i =3D 0; i < 1024; i++) {
             uint64_t id =3D env->spr_cb[i].one_reg_id;
=20
@@ -1339,16 +1363,20 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_ru=
n *run)
=20
     qemu_mutex_lock_iothread();
=20
-    /* PowerPC QEMU tracks the various core input pins (interrupt, criti=
cal
-     * interrupt, reset, etc) in PPC-specific env->irq_input_state. */
+    /*
+     * PowerPC QEMU tracks the various core input pins (interrupt,
+     * critical interrupt, reset, etc) in PPC-specific
+     * env->irq_input_state.
+     */
     if (!cap_interrupt_level &&
         run->ready_for_interrupt_injection &&
         (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
-        (env->irq_input_state & (1<<PPC_INPUT_INT)))
+        (env->irq_input_state & (1 << PPC_INPUT_INT)))
     {
-        /* For now KVM disregards the 'irq' argument. However, in the
-         * future KVM could cache it in-kernel to avoid a heavyweight ex=
it
-         * when reading the UIC.
+        /*
+         * For now KVM disregards the 'irq' argument. However, in the
+         * future KVM could cache it in-kernel to avoid a heavyweight
+         * exit when reading the UIC.
          */
         irq =3D KVM_INTERRUPT_SET;
=20
@@ -1363,9 +1391,12 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run=
 *run)
                        (NANOSECONDS_PER_SECOND / 50));
     }
=20
-    /* We don't know if there are more interrupts pending after this. Ho=
wever,
-     * the guest will return to userspace in the course of handling this=
 one
-     * anyways, so we will get a chance to deliver the rest. */
+    /*
+     * We don't know if there are more interrupts pending after
+     * this. However, the guest will return to userspace in the course
+     * of handling this one anyways, so we will get a chance to
+     * deliver the rest.
+     */
=20
     qemu_mutex_unlock_iothread();
 }
@@ -1394,18 +1425,22 @@ static int kvmppc_handle_halt(PowerPCCPU *cpu)
 }
=20
 /* map dcr access to existing qemu dcr emulation */
-static int kvmppc_handle_dcr_read(CPUPPCState *env, uint32_t dcrn, uint3=
2_t *data)
+static int kvmppc_handle_dcr_read(CPUPPCState *env,
+                                  uint32_t dcrn, uint32_t *data)
 {
-    if (ppc_dcr_read(env->dcr_env, dcrn, data) < 0)
+    if (ppc_dcr_read(env->dcr_env, dcrn, data) < 0) {
         fprintf(stderr, "Read to unhandled DCR (0x%x)\n", dcrn);
+    }
=20
     return 0;
 }
=20
-static int kvmppc_handle_dcr_write(CPUPPCState *env, uint32_t dcrn, uint=
32_t data)
+static int kvmppc_handle_dcr_write(CPUPPCState *env,
+                                   uint32_t dcrn, uint32_t data)
 {
-    if (ppc_dcr_write(env->dcr_env, dcrn, data) < 0)
+    if (ppc_dcr_write(env->dcr_env, dcrn, data) < 0) {
         fprintf(stderr, "Write to unhandled DCR (0x%x)\n", dcrn);
+    }
=20
     return 0;
 }
@@ -1832,7 +1867,7 @@ static int read_cpuinfo(const char *field, char *va=
lue, int len)
             ret =3D 0;
             break;
         }
-    } while(*line);
+    } while (*line);
=20
     fclose(f);
=20
@@ -1849,7 +1884,8 @@ uint32_t kvmppc_get_tbfreq(void)
         return retval;
     }
=20
-    if (!(ns =3D strchr(line, ':'))) {
+    ns =3D strchr(line, ':');
+    if (!ns) {
         return retval;
     }
=20
@@ -1875,7 +1911,8 @@ static int kvmppc_find_cpu_dt(char *buf, int buf_le=
n)
     struct dirent *dirp;
     DIR *dp;
=20
-    if ((dp =3D opendir(PROC_DEVTREE_CPU)) =3D=3D NULL) {
+    dp =3D opendir(PROC_DEVTREE_CPU);
+    if (!dp) {
         printf("Can't open directory " PROC_DEVTREE_CPU "\n");
         return -1;
     }
@@ -1929,10 +1966,11 @@ static uint64_t kvmppc_read_int_dt(const char *fi=
lename)
     return 0;
 }
=20
-/* Read a CPU node property from the host device tree that's a single
+/*
+ * Read a CPU node property from the host device tree that's a single
  * integer (32-bit or 64-bit).  Returns 0 if anything goes wrong
- * (can't find or open the property, or doesn't understand the
- * format) */
+ * (can't find or open the property, or doesn't understand the format)
+ */
 static uint64_t kvmppc_read_int_cpu_dt(const char *propname)
 {
     char buf[PATH_MAX], *tmp;
@@ -1991,7 +2029,7 @@ int kvmppc_get_hasidle(CPUPPCState *env)
=20
 int kvmppc_get_hypercall(CPUPPCState *env, uint8_t *buf, int buf_len)
 {
-    uint32_t *hc =3D (uint32_t*)buf;
+    uint32_t *hc =3D (uint32_t *)buf;
     struct kvm_ppc_pvinfo pvinfo;
=20
     if (!kvmppc_get_pvinfo(env, &pvinfo)) {
@@ -2064,8 +2102,10 @@ void kvmppc_set_papr(PowerPCCPU *cpu)
         exit(1);
     }
=20
-    /* Update the capability flag so we sync the right information
-     * with kvm */
+    /*
+     * Update the capability flag so we sync the right information
+     * with kvm
+     */
     cap_papr =3D 1;
 }
=20
@@ -2133,8 +2173,10 @@ uint64_t kvmppc_rma_size(uint64_t current_size, un=
signed int hash_shift)
     long rampagesize, best_page_shift;
     int i;
=20
-    /* Find the largest hardware supported page size that's less than
-     * or equal to the (logical) backing page size of guest RAM */
+    /*
+     * Find the largest hardware supported page size that's less than
+     * or equal to the (logical) backing page size of guest RAM
+     */
     kvm_get_smmu_info(&info, &error_fatal);
     rampagesize =3D qemu_getrampagesize();
     best_page_shift =3D 0;
@@ -2184,7 +2226,8 @@ void *kvmppc_create_spapr_tce(uint32_t liobn, uint3=
2_t page_shift,
     int fd;
     void *table;
=20
-    /* Must set fd to -1 so we don't try to munmap when called for
+    /*
+     * Must set fd to -1 so we don't try to munmap when called for
      * destroying the table, which the upper layers -will- do
      */
     *pfd =3D -1;
@@ -2229,7 +2272,7 @@ void *kvmppc_create_spapr_tce(uint32_t liobn, uint3=
2_t page_shift,
     len =3D nb_table * sizeof(uint64_t);
     /* FIXME: round this up to page size */
=20
-    table =3D mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+    table =3D mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0)=
;
     if (table =3D=3D MAP_FAILED) {
         fprintf(stderr, "KVM: Failed to map TCE table for liobn 0x%x\n",
                 liobn);
@@ -2272,10 +2315,12 @@ int kvmppc_reset_htab(int shift_hint)
         int ret;
         ret =3D kvm_vm_ioctl(kvm_state, KVM_PPC_ALLOCATE_HTAB, &shift);
         if (ret =3D=3D -ENOTTY) {
-            /* At least some versions of PR KVM advertise the
+            /*
+             * At least some versions of PR KVM advertise the
              * capability, but don't implement the ioctl().  Oops.
              * Return 0 so that we allocate the htab in qemu, as is
-             * correct for PR. */
+             * correct for PR.
+             */
             return 0;
         } else if (ret < 0) {
             return ret;
@@ -2283,9 +2328,12 @@ int kvmppc_reset_htab(int shift_hint)
         return shift;
     }
=20
-    /* We have a kernel that predates the htab reset calls.  For PR
+    /*
+     * We have a kernel that predates the htab reset calls.  For PR
      * KVM, we need to allocate the htab ourselves, for an HV KVM of
-     * this era, it has allocated a 16MB fixed size hash table already. =
*/
+     * this era, it has allocated a 16MB fixed size hash table
+     * already.
+     */
     if (kvmppc_is_pr(kvm_state)) {
         /* PR - tell caller to allocate htab */
         return 0;
@@ -2667,8 +2715,8 @@ int kvmppc_save_htab(QEMUFile *f, int fd, size_t bu=
fsize, int64_t max_ns)
             }
         }
     } while ((rc !=3D 0)
-             && ((max_ns < 0)
-                 || ((qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - starttime=
) < max_ns)));
+             && ((max_ns < 0) ||
+                 ((qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - starttime) <=
 max_ns)));
=20
     return (rc =3D=3D 0) ? 1 : 0;
 }
@@ -2677,7 +2725,7 @@ int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uin=
t32_t index,
                            uint16_t n_valid, uint16_t n_invalid)
 {
     struct kvm_get_htab_header *buf;
-    size_t chunksize =3D sizeof(*buf) + n_valid*HASH_PTE_SIZE_64;
+    size_t chunksize =3D sizeof(*buf) + n_valid * HASH_PTE_SIZE_64;
     ssize_t rc;
=20
     buf =3D alloca(chunksize);
@@ -2685,7 +2733,7 @@ int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uin=
t32_t index,
     buf->n_valid =3D n_valid;
     buf->n_invalid =3D n_invalid;
=20
-    qemu_get_buffer(f, (void *)(buf + 1), HASH_PTE_SIZE_64*n_valid);
+    qemu_get_buffer(f, (void *)(buf + 1), HASH_PTE_SIZE_64 * n_valid);
=20
     rc =3D write(fd, buf, chunksize);
     if (rc < 0) {
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 2c2ea30e87..22385134b4 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -117,7 +117,8 @@ static inline int kvmppc_get_hasidle(CPUPPCState *env=
)
     return 0;
 }
=20
-static inline int kvmppc_get_hypercall(CPUPPCState *env, uint8_t *buf, i=
nt buf_len)
+static inline int kvmppc_get_hypercall(CPUPPCState *env,
+                                       uint8_t *buf, int buf_len)
 {
     return -1;
 }
--=20
2.20.1
