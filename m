Received: from eggs.gnu.org ([2001:4830:134:3::10]:44214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d9BhI-0004jk-FO
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d9BhF-0004n4-D7
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:37:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60197)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d9BhF-0004mS-6l
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:37:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 12 May 2017 10:37:17 -0400
Message-Id: <20170512143717.30391-4-stefanha@redhat.com>
In-Reply-To: <20170512143717.30391-1-stefanha@redhat.com>
References: <20170512143717.30391-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 3/3] aio: add missing aio_notify() to
 aio_enable_external()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The main loop uses aio_disable_external()/aio_enable_external() to
temporarily disable processing of external AioContext clients like
device emulation.

This allows monitor commands to quiesce I/O and prevent the guest from
submitting new requests while a monitor command is in progress.

The aio_enable_external() API is currently broken when an IOThread is in
aio_poll() waiting for fd activity when the main loop re-enables
external clients.  Incrementing ctx->external_disable_cnt does not wake
the IOThread from ppoll(2) so fd processing remains suspended and leads
to unresponsive emulated devices.

This patch adds an aio_notify() call to aio_enable_external() so the
IOThread is kicked out of ppoll(2) and will re-arm the file descriptors.

The bug can be reproduced as follows:

  $ qemu -M accel=kvm -m 1024 \
         -object iothread,id=iothread0 \
         -device virtio-scsi-pci,iothread=iothread0,id=virtio-scsi-pci0 \
         -drive if=none,id=drive0,aio=native,cache=none,format=raw,file=test.img \
         -device scsi-hd,id=scsi-hd0,drive=drive0 \
         -qmp tcp::5555,server,nowait

  $ scripts/qmp/qmp-shell localhost:5555
  (qemu) blockdev-snapshot-sync device=drive0 snapshot-file=sn1.qcow2
         mode=absolute-paths format=qcow2

After blockdev-snapshot-sync completes the SCSI disk will be
unresponsive.  This leads to request timeouts inside the guest.

Reported-by: Qianqian Zhu <qizhu@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170508180705.20609-1-stefanha@redhat.com
Suggested-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/aio.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 406e323..e9aeeae 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -454,8 +454,14 @@ static inline void aio_disable_external(AioContext *ctx)
  */
 static inline void aio_enable_external(AioContext *ctx)
 {
-    assert(ctx->external_disable_cnt > 0);
-    atomic_dec(&ctx->external_disable_cnt);
+    int old;
+
+    old = atomic_fetch_dec(&ctx->external_disable_cnt);
+    assert(old > 0);
+    if (old == 1) {
+        /* Kick event loop so it re-arms file descriptors */
+        aio_notify(ctx);
+    }
 }
 
 /**
-- 
2.9.3
