Received: from eggs.gnu.org ([2001:4830:134:3::10]:42074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsqTk-0002ni-Du
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsqTg-0003vx-CH
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:16:20 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:45929)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dsqTg-0003ve-61
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:16:16 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 3174BA9D56
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 15:16:15 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 15 Sep 2017 15:16:10 +0200
Message-ID: <150548137066.5945.3950849052176752689.stgit@bahia.lan>
In-Reply-To: <150548133297.5945.7401220081077343726.stgit@bahia.lan>
References: <150548133297.5945.7401220081077343726.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 3/4] ppc/kvm: change kvmppc_get_htab_fd() to
 return -errno on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

When kvmppc_get_htab_fd() fails, its return value is propagated up to
qemu_savevm_state_iterate() or to qemu_savevm_state_complete_precopy().
All savevm handlers expect to receive a negative errno on error.

Let's patch kvmppc_get_htab_fd() accordingly.

While here, let's change htab_load() in the spapr code to also
propagate the error, since it doesn't make sense to abort() if
we couldn't get the htab fd from KVM.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c   |    5 +++--
 target/ppc/kvm.c |   10 ++++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 841117f6d185..1ae79326d1ac 100644
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
@@ -1962,7 +1962,8 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
         fd = kvmppc_get_htab_fd(true);
         if (fd < 0) {
             error_report("Unable to open fd to restore KVM hash table: %s",
-                         strerror(errno));
+                         strerror(fd));
+            return fd;
         }
     }
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 00d7029b8d7a..09d7dea79e2d 100644
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
