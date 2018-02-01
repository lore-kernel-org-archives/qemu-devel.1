Received: from eggs.gnu.org ([2001:4830:134:3::10]:40633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eh695-0000WJ-Vh
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 23:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eh695-0008Oo-6N
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 23:06:43 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 31 Jan 2018 23:06:35 -0500
Message-Id: <20180201040635.5749-3-jcody@redhat.com>
In-Reply-To: <20180201040635.5749-1-jcody@redhat.com>
References: <20180201040635.5749-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] iotests: Make 200 run on tmpfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

200 currently fails on tmpfs because it sets cache=none.  However,
without that (and aio=native), the test still works now and it fails
before Jeff's series (on fc7dbc119e0852a70dc9fa68bb41a318e49e4cd6).  So
we can probably remove the aio=native safely, and replace cache=none by
cache=$CACHEMODE.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Message-id: 20180117135015.15051-1-mreitz@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/200 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index d8787dd..ddbdedc 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -60,7 +60,7 @@ qemu_comm_method="qmp"
 _launch_qemu -device pci-bridge,id=bridge1,chassis_nr=1,bus=pci.0 \
              -object iothread,id=iothread0 \
              -device virtio-scsi-pci,bus=bridge1,addr=0x1f,id=scsi0,iothread=iothread0 \
-             -drive file="${TEST_IMG}",media=disk,if=none,cache=none,id=drive_sysdisk,aio=native,format=$IMGFMT \
+             -drive file="${TEST_IMG}",media=disk,if=none,cache=$CACHEMODE,id=drive_sysdisk,format=$IMGFMT \
              -device scsi-hd,drive=drive_sysdisk,bus=scsi0.0,id=sysdisk,bootindex=0
 h1=$QEMU_HANDLE
 
-- 
2.9.5
