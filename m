Received: from eggs.gnu.org ([2001:4830:134:3::10]:45388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d6a4q-0006Ay-QN
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d6a4p-0007O0-Vd
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:03:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  5 May 2017 11:02:55 +0100
Message-Id: <20170505100255.11145-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2] aio: add missing aio_notify() to
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
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

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
Suggested-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v2:
 * Only notify when necessary [Fam]

 include/block/aio.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 406e323..b3d6f76 100644
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
+    old = atomic_dec_fetch(&ctx->external_disable_cnt);
+    assert(old > 0);
+    if (old == 1) {
+        /* Kick event loop so it re-arms file descriptors */
+        aio_notify(ctx);
+    }
 }
 
 /**
-- 
2.9.3
