Received: from eggs.gnu.org ([2001:4830:134:3::10]:53863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkAC-0006jl-Tk
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkAB-0001T1-0q
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:32 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:34804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkAA-0001Re-Fg
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:30 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 26 Apr 2018 17:53:31 +0100
Message-ID: <1524761612-5307-7-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 6/7] error reporting: Use
 error_report_errnoval in obvious places
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ian Jackson <ian.jackson@eu.citrix.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>

This patch is the result of

  git-grep -l 'error_report.*strerror' | xargs perl -p -i~ ../t

with ../t containing

  s{error_report\("(.*): \%s"(, .*)?, strerror\((.*)\)\)\;}{error_report_errnoval\($3, "$1"$2)\;}

Like the previous patch to use error_report_errno, this patch does not
contain any cleanups of the occasional idiosyncratic messages.  That
is left to the future.

No functional change, since error_report_errnoval does exactly what
this previous open-coded pattern does.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
 block/nvme.c                 |  2 +-
 block/rbd.c                  |  2 +-
 cpus.c                       |  2 +-
 hw/ppc/spapr_hcall.c         |  2 +-
 hw/s390x/s390-stattrib-kvm.c |  6 +++---
 hw/s390x/s390-virtio-ccw.c   |  2 +-
 hw/scsi/vhost-scsi.c         |  2 +-
 hw/scsi/vhost-user-scsi.c    |  2 +-
 migration/migration.c        |  2 +-
 qemu-img.c                   | 10 +++++-----
 qemu-io-cmds.c               |  4 ++--
 qemu-nbd.c                   |  6 +++---
 target/arm/kvm64.c           |  4 ++--
 13 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index c4f3a7b..d479ea9 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1144,7 +1144,7 @@ static void nvme_register_buf(BlockDriverState *bs, void *host, size_t size)
         /* FIXME: we may run out of IOVA addresses after repeated
          * bdrv_register_buf/bdrv_unregister_buf, because nvme_vfio_dma_unmap
          * doesn't reclaim addresses for fixed mappings. */
-        error_report("nvme_register_buf failed: %s", strerror(-ret));
+        error_report_errnoval(-ret, "nvme_register_buf failed");
     }
 }
 
diff --git a/block/rbd.c b/block/rbd.c
index c9359d0..e7b5d15 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1020,7 +1020,7 @@ static int qemu_rbd_snap_create(BlockDriverState *bs,
 
     r = rbd_snap_create(s->image, sn_info->name);
     if (r < 0) {
-        error_report("failed to create snap: %s", strerror(-r));
+        error_report_errnoval(-r, "failed to create snap");
         return r;
     }
 
diff --git a/cpus.c b/cpus.c
index 38eba8b..f62b3a8 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1200,7 +1200,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
 
     r = kvm_init_vcpu(cpu);
     if (r < 0) {
-        error_report("kvm_init_vcpu failed: %s", strerror(-r));
+        error_report_errnoval(-r, "kvm_init_vcpu failed");
         exit(1);
     }
 
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 16bccdd..112156f 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -693,7 +693,7 @@ static void do_push_sregs_to_kvm_pr(CPUState *cs, run_on_cpu_data data)
 
     ret = kvmppc_put_books_sregs(POWERPC_CPU(cs));
     if (ret < 0) {
-        error_report("failed to push sregs to KVM: %s", strerror(-ret));
+        error_report_errnoval(-ret, "failed to push sregs to KVM");
         exit(1);
     }
 }
diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index 480551c..fea2bce 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -52,7 +52,7 @@ static int kvm_s390_stattrib_read_helper(S390StAttribState *sa,
 
     r = kvm_vm_ioctl(kvm_state, KVM_S390_GET_CMMA_BITS, &clog);
     if (r < 0) {
-        error_report("KVM_S390_GET_CMMA_BITS failed: %s", strerror(-r));
+        error_report_errnoval(-r, "KVM_S390_GET_CMMA_BITS failed");
         return r;
     }
 
@@ -119,7 +119,7 @@ static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
             clog.values = (uint64_t)(sas->incoming_buffer + cx);
             r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
             if (r) {
-                error_report("KVM_S390_SET_CMMA_BITS failed: %s", strerror(-r));
+                error_report_errnoval(-r, "KVM_S390_SET_CMMA_BITS failed");
                 return;
             }
         }
@@ -129,7 +129,7 @@ static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
             clog.values = (uint64_t)(sas->incoming_buffer + cx);
             r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
             if (r) {
-                error_report("KVM_S390_SET_CMMA_BITS failed: %s", strerror(-r));
+                error_report_errnoval(-r, "KVM_S390_SET_CMMA_BITS failed");
             }
         }
         g_free(sas->incoming_buffer);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 435f7c9..d580b48 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -228,7 +228,7 @@ static int gtod_load(QEMUFile *f, void *opaque, int version_id)
 
     r = s390_set_clock(&tod_high, &tod_low);
     if (r) {
-        error_report("Unable to set KVM guest TOD clock: %s", strerror(-r));
+        error_report_errnoval(-r, "Unable to set KVM guest TOD clock");
     }
 
     return r;
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 9c1bea8..354aaef 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -123,7 +123,7 @@ static void vhost_scsi_set_status(VirtIODevice *vdev, uint8_t val)
 
         ret = vhost_scsi_start(s);
         if (ret < 0) {
-            error_report("unable to start vhost-scsi: %s", strerror(-ret));
+            error_report_errnoval(-ret, "unable to start vhost-scsi");
             exit(1);
         }
     } else {
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 9389ed4..aa027e1 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -52,7 +52,7 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
 
         ret = vhost_scsi_common_start(vsc);
         if (ret < 0) {
-            error_report("unable to start vhost-user-scsi: %s", strerror(-ret));
+            error_report_errnoval(-ret, "unable to start vhost-user-scsi");
             exit(1);
         }
     } else {
diff --git a/migration/migration.c b/migration/migration.c
index 0bdb28e..2732519 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -403,7 +403,7 @@ static void process_incoming_migration_co(void *opaque)
 
         migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                           MIGRATION_STATUS_FAILED);
-        error_report("load of migration failed: %s", strerror(-ret));
+        error_report_errnoval(-ret, "load of migration failed");
         qemu_fclose(mis->from_src_file);
         if (multifd_load_cleanup(&local_err) != 0) {
             error_report_err(local_err);
diff --git a/qemu-img.c b/qemu-img.c
index 855fa52..3527455 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -820,7 +820,7 @@ static int img_check(int argc, char **argv)
 
     if (ret || check->check_errors) {
         if (ret) {
-            error_report("Check failed: %s", strerror(-ret));
+            error_report_errnoval(-ret, "Check failed");
         } else {
             error_report("Check failed");
         }
@@ -2831,7 +2831,7 @@ static int img_map(int argc, char **argv)
         ret = get_block_status(bs, offset, n, &next);
 
         if (ret < 0) {
-            error_report("Could not read file metadata: %s", strerror(-ret));
+            error_report_errnoval(-ret, "Could not read file metadata");
             goto out;
         }
 
@@ -3730,7 +3730,7 @@ static int img_amend(int argc, char **argv)
     ret = bdrv_amend_options(bs, opts, &amend_status_cb, NULL);
     qemu_progress_print(100.f, 0);
     if (ret < 0) {
-        error_report("Error while amending options: %s", strerror(-ret));
+        error_report_errnoval(-ret, "Error while amending options");
         goto out;
     }
 
@@ -3770,7 +3770,7 @@ typedef struct BenchData {
 static void bench_undrained_flush_cb(void *opaque, int ret)
 {
     if (ret < 0) {
-        error_report("Failed flush request: %s", strerror(-ret));
+        error_report_errnoval(-ret, "Failed flush request");
         exit(EXIT_FAILURE);
     }
 }
@@ -3781,7 +3781,7 @@ static void bench_cb(void *opaque, int ret)
     BlockAIOCB *acb;
 
     if (ret < 0) {
-        error_report("Failed request: %s", strerror(-ret));
+        error_report_errnoval(-ret, "Failed request");
         exit(EXIT_FAILURE);
     }
 
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 9b3cd00..379a1ee 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1862,14 +1862,14 @@ static int map_f(BlockBackend *blk, int argc, char **argv)
     offset = 0;
     bytes = blk_getlength(blk);
     if (bytes < 0) {
-        error_report("Failed to query image length: %s", strerror(-bytes));
+        error_report_errnoval(-bytes, "Failed to query image length");
         return 0;
     }
 
     while (bytes) {
         ret = map_is_allocated(blk_bs(blk), offset, bytes, &num);
         if (ret < 0) {
-            error_report("Failed to get allocation status: %s", strerror(-ret));
+            error_report_errnoval(-ret, "Failed to get allocation status");
             return 0;
         } else if (!num) {
             error_report("Unexpected end of image");
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 47b6957..70cb564 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -179,7 +179,7 @@ static int find_partition(BlockBackend *blk, int partition,
 
     ret = blk_pread(blk, 0, data, sizeof(data));
     if (ret < 0) {
-        error_report("error while reading: %s", strerror(-ret));
+        error_report_errnoval(-ret, "error while reading");
         exit(EXIT_FAILURE);
     }
 
@@ -202,7 +202,7 @@ static int find_partition(BlockBackend *blk, int partition,
             ret = blk_pread(blk, mbr[i].start_sector_abs * MBR_SIZE,
                             data1, sizeof(data1));
             if (ret < 0) {
-                error_report("error while reading: %s", strerror(-ret));
+                error_report_errnoval(-ret, "error while reading");
                 exit(EXIT_FAILURE);
             }
 
@@ -1021,7 +1021,7 @@ int main(int argc, char **argv)
 
         ret = pthread_create(&client_thread, NULL, nbd_client_thread, device);
         if (ret != 0) {
-            error_report("Failed to create client thread: %s", strerror(ret));
+            error_report_errnoval(ret, "Failed to create client thread");
             exit(EXIT_FAILURE);
         }
     } else {
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index e0b8246..64b47b6 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -387,13 +387,13 @@ static bool kvm_arm_pmu_set_attr(CPUState *cs, struct kvm_device_attr *attr)
 
     err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
     if (err != 0) {
-        error_report("PMU: KVM_HAS_DEVICE_ATTR: %s", strerror(-err));
+        error_report_errnoval(-err, "PMU: KVM_HAS_DEVICE_ATTR");
         return false;
     }
 
     err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, attr);
     if (err != 0) {
-        error_report("PMU: KVM_SET_DEVICE_ATTR: %s", strerror(-err));
+        error_report_errnoval(-err, "PMU: KVM_SET_DEVICE_ATTR");
         return false;
     }
 
-- 
2.1.4
