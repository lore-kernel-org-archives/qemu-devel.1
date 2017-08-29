Received: from eggs.gnu.org ([2001:4830:134:3::10]:47575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCE-0000wx-9Q
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCB-0005C4-21
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52595
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCA-0005Bu-Rt
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E9gd081527
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:54 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmurncr8y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:54 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:15:53 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:13:56 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-22-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 21/79] aio: add missing aio_notify() to
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
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

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
(cherry picked from commit 321d1dba8bef9676a77e9399484e3cd8bf2cf16a)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.7.4
