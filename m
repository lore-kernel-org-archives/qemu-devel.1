Received: from eggs.gnu.org ([2001:4830:134:3::10]:56573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70O-0001SZ-5w
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70L-00044D-Pm
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:40 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Sep 2017 17:43:03 +1000
Message-Id: <20170927074316.4454-14-david@gibson.dropbear.id.au>
In-Reply-To: <20170927074316.4454-1-david@gibson.dropbear.id.au>
References: <20170927074316.4454-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 13/26] ppc/kvm: generalize the use of
 kvmppc_get_htab_fd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mark.cave-ayland@ilande.co.uk, balaton@eik.bme.hu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The use of KVM_PPC_GET_HTAB_FD is open-coded in kvmppc_read_hptes()
and kvmppc_write_hpte().

This patch modifies kvmppc_get_htab_fd() so that it can be used
everywhere we need to access the in-kernel htab:
- add an index argument
  => only kvmppc_read_hptes() passes an actual index, all other users
     pass 0
- add an errp argument to propagate error messages to the caller.
  => spapr migration code prints the error
  => hpte helpers pass &error_abort to keep the current behavior
     of hw_error()

While here, this also fixes a bug in kvmppc_write_hpte() so that it
opens the htab fd for writing instead of reading as it currently does.
This never broke anything because we currently never call this code,
as explained in the changelog of commit c1385933804bb:

"This support updating htab managed by the hypervisor. Currently
 we don't have any user for this feature. This actually bring the
 store_hpte interface in-line with the load_hpte one. We may want
 to use this when we want to emulate henter hcall in qemu for HV
 kvm."

The above is still true today.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c       | 15 +++++++--------
 target/ppc/kvm.c     | 27 +++++++++------------------
 target/ppc/kvm_ppc.h |  4 ++--
 3 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ec0ea7b5dd..90a94952c3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1211,14 +1211,15 @@ static uint64_t spapr_get_patbe(PPCVirtualHypervisor *vhyp)
  */
 static int get_htab_fd(sPAPRMachineState *spapr)
 {
+    Error *local_err = NULL;
+
     if (spapr->htab_fd >= 0) {
         return spapr->htab_fd;
     }
 
-    spapr->htab_fd = kvmppc_get_htab_fd(false);
+    spapr->htab_fd = kvmppc_get_htab_fd(false, 0, &local_err);
     if (spapr->htab_fd < 0) {
-        error_report("Unable to open fd for reading hash table from KVM: %s",
-                     strerror(spapr->htab_fd));
+        error_report_err(local_err);
     }
 
     return spapr->htab_fd;
@@ -1927,6 +1928,7 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
     sPAPRMachineState *spapr = opaque;
     uint32_t section_hdr;
     int fd = -1;
+    Error *local_err = NULL;
 
     if (version_id < 1 || version_id > 1) {
         error_report("htab_load() bad version");
@@ -1941,8 +1943,6 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
     }
 
     if (section_hdr) {
-        Error *local_err = NULL;
-
         /* First section gives the htab size */
         spapr_reallocate_hpt(spapr, section_hdr, &local_err);
         if (local_err) {
@@ -1955,10 +1955,9 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
     if (!spapr->htab) {
         assert(kvm_enabled());
 
-        fd = kvmppc_get_htab_fd(true);
+        fd = kvmppc_get_htab_fd(true, 0, &local_err);
         if (fd < 0) {
-            error_report("Unable to open fd to restore KVM hash table: %s",
-                         strerror(fd));
+            error_report_err(local_err);
             return fd;
         }
     }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 2780e692a7..5b281b2f1b 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2550,21 +2550,25 @@ int kvmppc_define_rtas_kernel_token(uint32_t token, const char *function)
     return kvm_vm_ioctl(kvm_state, KVM_PPC_RTAS_DEFINE_TOKEN, &args);
 }
 
-int kvmppc_get_htab_fd(bool write)
+int kvmppc_get_htab_fd(bool write, uint64_t index, Error **errp)
 {
     struct kvm_get_htab_fd s = {
         .flags = write ? KVM_GET_HTAB_WRITE : 0,
-        .start_index = 0,
+        .start_index = index,
     };
     int ret;
 
     if (!cap_htab_fd) {
-        fprintf(stderr, "KVM version doesn't support saving the hash table\n");
+        error_setg(errp, "KVM version doesn't support %s the HPT",
+                   write ? "writing" : "reading");
         return -ENOTSUP;
     }
 
     ret = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_HTAB_FD, &s);
     if (ret < 0) {
+        error_setg(errp, "Unable to open fd for %s HPT %s KVM: %s",
+                   write ? "writing" : "reading", write ? "to" : "from",
+                   strerror(errno));
         return -errno;
     }
 
@@ -2648,17 +2652,10 @@ void kvm_arch_init_irq_routing(KVMState *s)
 
 void kvmppc_read_hptes(ppc_hash_pte64_t *hptes, hwaddr ptex, int n)
 {
-    struct kvm_get_htab_fd ghf = {
-        .flags = 0,
-        .start_index = ptex,
-    };
     int fd, rc;
     int i;
 
-    fd = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_HTAB_FD, &ghf);
-    if (fd < 0) {
-        hw_error("kvmppc_read_hptes: Unable to open HPT fd");
-    }
+    fd = kvmppc_get_htab_fd(false, ptex, &error_abort);
 
     i = 0;
     while (i < n) {
@@ -2700,19 +2697,13 @@ void kvmppc_read_hptes(ppc_hash_pte64_t *hptes, hwaddr ptex, int n)
 void kvmppc_write_hpte(hwaddr ptex, uint64_t pte0, uint64_t pte1)
 {
     int fd, rc;
-    struct kvm_get_htab_fd ghf;
     struct {
         struct kvm_get_htab_header hdr;
         uint64_t pte0;
         uint64_t pte1;
     } buf;
 
-    ghf.flags = 0;
-    ghf.start_index = 0;     /* Ignored */
-    fd = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_HTAB_FD, &ghf);
-    if (fd < 0) {
-        hw_error("kvmppc_write_hpte: Unable to open HPT fd");
-    }
+    fd = kvmppc_get_htab_fd(true, 0 /* Ignored */, &error_abort);
 
     buf.hdr.n_valid = 1;
     buf.hdr.n_invalid = 0;
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 08aab46c5a..349f892631 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -51,7 +51,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift);
 #endif /* !CONFIG_USER_ONLY */
 bool kvmppc_has_cap_epr(void);
 int kvmppc_define_rtas_kernel_token(uint32_t token, const char *function);
-int kvmppc_get_htab_fd(bool write);
+int kvmppc_get_htab_fd(bool write, uint64_t index, Error **errp);
 int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t max_ns);
 int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
                            uint16_t n_valid, uint16_t n_invalid);
@@ -245,7 +245,7 @@ static inline int kvmppc_define_rtas_kernel_token(uint32_t token,
     return -1;
 }
 
-static inline int kvmppc_get_htab_fd(bool write)
+static inline int kvmppc_get_htab_fd(bool write, uint64_t index, Error **errp)
 {
     return -1;
 }
-- 
2.13.5
