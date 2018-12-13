Received: from eggs.gnu.org ([2001:4830:134:3::10]:42228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gXTpy-0006rt-VG
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gXTpy-0002mC-01
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:27:46 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Thu, 13 Dec 2018 17:27:26 +0100
Message-Id: <20181213162727.17438-4-lvivier@redhat.com>
In-Reply-To: <20181213162727.17438-1-lvivier@redhat.com>
References: <20181213162727.17438-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/4] block/file-posix: Convert from
 DPRINTF() macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Liu Yuan <namei.unix@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Laurent Vivier <lvivier@redhat.com>

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 block/file-posix.c | 25 ++++++-------------------
 block/trace-events |  7 +++++++
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 07bbdab953..cf90899a6e 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -102,19 +102,7 @@
 #include <xfs/xfs.h>
 #endif
=20
-//#define DEBUG_BLOCK
-
-#ifdef DEBUG_BLOCK
-# define DEBUG_BLOCK_PRINT 1
-#else
-# define DEBUG_BLOCK_PRINT 0
-#endif
-#define DPRINTF(fmt, ...) \
-do { \
-    if (DEBUG_BLOCK_PRINT) { \
-        printf(fmt, ## __VA_ARGS__); \
-    } \
-} while (0)
+#include "trace.h"
=20
 /* OS X does not have O_DSYNC */
 #ifndef O_DSYNC
@@ -1386,7 +1374,7 @@ static int xfs_write_zeroes(BDRVRawState *s, int64_=
t offset, uint64_t bytes)
=20
     if (xfsctl(NULL, s->fd, XFS_IOC_ZERO_RANGE, &fl) < 0) {
         err =3D errno;
-        DPRINTF("cannot write zero range (%s)\n", strerror(errno));
+        trace_file_xfs_write_zeroes(strerror(errno));
         return -err;
     }
=20
@@ -1405,7 +1393,7 @@ static int xfs_discard(BDRVRawState *s, int64_t off=
set, uint64_t bytes)
=20
     if (xfsctl(NULL, s->fd, XFS_IOC_UNRESVSP64, &fl) < 0) {
         err =3D errno;
-        DPRINTF("cannot punch hole (%s)\n", strerror(errno));
+        trace_file_xfs_discard(strerror(errno));
         return -err;
     }
=20
@@ -2798,7 +2786,7 @@ static char *FindEjectableOpticalMedia(io_iterator_=
t *mediaIterator)
=20
         /* If a match was found, leave the loop */
         if (*mediaIterator !=3D 0) {
-            DPRINTF("Matching using %s\n", matching_array[index]);
+            trace_file_FindEjectableOpticalMedia(matching_array[index]);
             mediaType =3D g_strdup(matching_array[index]);
             break;
         }
@@ -2858,7 +2846,7 @@ static bool setup_cdrom(char *bsd_path, Error **err=
p)
     if (partition_found =3D=3D false) {
         error_setg(errp, "Failed to find a working partition on disc");
     } else {
-        DPRINTF("Using %s as optical disc\n", test_partition);
+        trace_file_setup_cdrom(test_partition);
         pstrcpy(bsd_path, MAXPATHLEN, test_partition);
     }
     return partition_found;
@@ -2953,8 +2941,7 @@ static bool hdev_is_sg(BlockDriverState *bs)
=20
     ret =3D ioctl(s->fd, SG_GET_SCSI_ID, &scsiid);
     if (ret >=3D 0) {
-        DPRINTF("SG device found: type=3D%d, version=3D%d\n",
-            scsiid.scsi_type, sg_version);
+        trace_file_hdev_is_sg(scsiid.scsi_type, sg_version);
         return true;
     }
=20
diff --git a/block/trace-events b/block/trace-events
index 128ac2dd93..06dbe65080 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -182,3 +182,10 @@ curl_open(const char *file) "opening %s"
 curl_open_size(uint64_t size) "size =3D %" PRIu64
 curl_setup_preadv(uint64_t bytes, uint64_t start, const char *range) "re=
ading %" PRIu64 " at %" PRIu64 " (%s)"
 curl_close(void) "close"
+
+# block/file-posix.c
+file_xfs_write_zeroes(const char *error) "cannot write zero range (%s)"
+file_xfs_discard(const char* error) "cannot punch hole (%s)"
+file_FindEjectableOpticalMedia(const char *media) "Matching using %s"
+file_setup_cdrom(const char *partition) "Using %s as optical disc"
+file_hdev_is_sg(int type, int version) "SG device found: type=3D%d, vers=
ion=3D%d"
--=20
2.19.2
