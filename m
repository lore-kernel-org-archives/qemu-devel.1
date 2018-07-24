Received: from eggs.gnu.org ([2001:4830:134:3::10]:48813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fhyE5-0006OI-JT
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fhyE4-0007ri-IR
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:23:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 24 Jul 2018 15:23:31 +0100
Message-Id: <20180724142331.14669-2-stefanha@redhat.com>
In-Reply-To: <20180724142331.14669-1-stefanha@redhat.com>
References: <20180724142331.14669-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-3.0 1/1] block/file-posix: add
 bdrv_attach_aio_context callback for host dev and cdrom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>

From: Nishanth Aravamudan <naravamudan@digitalocean.com>

In ed6e2161 ("linux-aio: properly bubble up errors from initialzation"),
I only added a bdrv_attach_aio_context callback for the bdrv_file
driver. There are several other drivers that use the shared
aio_plug callback, though, and they will trip the assertion added to
aio_get_linux_aio because they did not call aio_setup_linux_aio first.
Add the appropriate callback definition to the affected driver
definitions.

Fixes: ed6e2161 ("linux-aio: properly bubble up errors from initialization")
Reported-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Nishanth Aravamudan <naravamudan@digitalocean.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20180718211256.29774-1-naravamudan@digitalocean.com
Cc: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fam Zheng <famz@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 60af4b3d51..ad299beb38 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3158,6 +3158,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_refresh_limits = raw_refresh_limits,
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
+    .bdrv_attach_aio_context = raw_aio_attach_aio_context,
 
     .bdrv_co_truncate       = raw_co_truncate,
     .bdrv_getlength	= raw_getlength,
@@ -3280,6 +3281,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_refresh_limits = raw_refresh_limits,
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
+    .bdrv_attach_aio_context = raw_aio_attach_aio_context,
 
     .bdrv_co_truncate    = raw_co_truncate,
     .bdrv_getlength      = raw_getlength,
@@ -3410,6 +3412,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_refresh_limits = raw_refresh_limits,
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
+    .bdrv_attach_aio_context = raw_aio_attach_aio_context,
 
     .bdrv_co_truncate    = raw_co_truncate,
     .bdrv_getlength      = raw_getlength,
-- 
2.17.1
