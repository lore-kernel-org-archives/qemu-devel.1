Received: from eggs.gnu.org ([2001:4830:134:3::10]:56622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70P-0001TO-2T
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70N-00046I-Jc
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:41 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Sep 2017 17:43:02 +1000
Message-Id: <20170927074316.4454-13-david@gibson.dropbear.id.au>
In-Reply-To: <20170927074316.4454-1-david@gibson.dropbear.id.au>
References: <20170927074316.4454-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 12/26] ppc/kvm: change kvmppc_get_htab_fd() to
 return -errno on error
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

When kvmppc_get_htab_fd() fails, its return value is propagated up to
qemu_savevm_state_iterate() or to qemu_savevm_state_complete_precopy().
All savevm handlers expect to receive a negative errno on error.

Let's patch kvmppc_get_htab_fd() accordingly.

While here, let's change htab_load() in the spapr code to also
propagate the error, since it doesn't make sense to abort() if
we couldn't get the htab fd from KVM.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c   |  5 +++--
 target/ppc/kvm.c | 10 ++++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 17ea77618c..ec0ea7b5dd 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1218,7 +1218,7 @@ static int get_htab_fd(sPAPRMachineState *spapr)
     spapr->htab_fd = kvmppc_get_htab_fd(false);
     if (spapr->htab_fd < 0) {
         error_report("Unable to open fd for reading hash table from KVM: %s",
-                     strerror(errno));
+                     strerror(spapr->htab_fd));
     }
 
     return spapr->htab_fd;
@@ -1958,7 +1958,8 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
         fd = kvmppc_get_htab_fd(true);
         if (fd < 0) {
             error_report("Unable to open fd to restore KVM hash table: %s",
-                         strerror(errno));
+                         strerror(fd));
+            return fd;
         }
     }
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index be27429b57..2780e692a7 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2556,13 +2556,19 @@ int kvmppc_get_htab_fd(bool write)
         .flags = write ? KVM_GET_HTAB_WRITE : 0,
         .start_index = 0,
     };
+    int ret;
 
     if (!cap_htab_fd) {
         fprintf(stderr, "KVM version doesn't support saving the hash table\n");
-        return -1;
+        return -ENOTSUP;
+    }
+
+    ret = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_HTAB_FD, &s);
+    if (ret < 0) {
+        return -errno;
     }
 
-    return kvm_vm_ioctl(kvm_state, KVM_PPC_GET_HTAB_FD, &s);
+    return ret;
 }
 
 int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t max_ns)
-- 
2.13.5
