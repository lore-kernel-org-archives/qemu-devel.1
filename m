Received: from eggs.gnu.org ([2001:4830:134:3::10]:38942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIfu-0000vc-7p
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIfr-0002U3-6r
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:13:50 -0400
Received: from mail.ispras.ru ([83.149.199.45]:36434)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIfq-0002TO-Tn
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:13:47 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 25 Jul 2018 15:13:46 +0300
Message-ID: <20180725121346.12867.11131.stgit@pasha-VirtualBox>
In-Reply-To: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v5 06/24] qcow2: introduce icount field for
 snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

This patch introduces the icount field for saving within the snapshot.
It is required for navigation between the snapshots in record/replay mode.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

--

v2:
 - documented format changes in docs/interop/qcow2.txt
   (suggested by Eric Blake)
---
 block/qcow2-snapshot.c |    7 +++++++
 block/qcow2.h          |    2 ++
 docs/interop/qcow2.txt |    4 ++++
 3 files changed, 13 insertions(+)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index bb6a5b7..d682946 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -103,6 +103,12 @@ int qcow2_read_snapshots(BlockDriverState *bs)
             sn->disk_size = bs->total_sectors * BDRV_SECTOR_SIZE;
         }
 
+        if (extra_data_size >= 24) {
+            sn->icount = be64_to_cpu(extra.icount);
+        } else {
+            sn->icount = -1ULL;
+        }
+
         /* Read snapshot ID */
         sn->id_str = g_malloc(id_str_size + 1);
         ret = bdrv_pread(bs->file, offset, sn->id_str, id_str_size);
@@ -209,6 +215,7 @@ static int qcow2_write_snapshots(BlockDriverState *bs)
         memset(&extra, 0, sizeof(extra));
         extra.vm_state_size_large = cpu_to_be64(sn->vm_state_size);
         extra.disk_size = cpu_to_be64(sn->disk_size);
+        extra.icount = cpu_to_be64(sn->icount);
 
         id_str_size = strlen(sn->id_str);
         name_size = strlen(sn->name);
diff --git a/block/qcow2.h b/block/qcow2.h
index 81b844e..b24ec93 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -148,6 +148,7 @@ typedef struct QEMU_PACKED QCowSnapshotHeader {
 typedef struct QEMU_PACKED QCowSnapshotExtraData {
     uint64_t vm_state_size_large;
     uint64_t disk_size;
+    uint64_t icount;
 } QCowSnapshotExtraData;
 
 
@@ -161,6 +162,7 @@ typedef struct QCowSnapshot {
     uint32_t date_sec;
     uint32_t date_nsec;
     uint64_t vm_clock_nsec;
+    uint64_t icount;
 } QCowSnapshot;
 
 struct Qcow2Cache;
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 845d40a..aa1101d 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -506,6 +506,10 @@ Snapshot table entry:
 
                     Byte 48 - 55:   Virtual disk size of the snapshot in bytes
 
+                    Byte 56 - 63:   icount value which corresponds to
+                                    the record/replay step when the snapshot
+                                    was taken
+
                     Version 3 images must include extra data at least up to
                     byte 55.
 
