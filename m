Received: from eggs.gnu.org ([2001:4830:134:3::10]:50108)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dACq5-0001rG-AO
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dACq2-0006Qa-8X
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:02:53 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:49534 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dACq1-0006Q8-Vk
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:02:50 -0400
From: Peter Lieven <pl@kamp.de>
Date: Mon, 15 May 2017 12:02:43 +0200
Message-Id: <1494842563-6534-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [RFC PATCH] qemu-io: add drain/undrain cmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, Peter Lieven <pl@kamp.de>

Hi Block developers,

I would like to add a feature to Qemu to drain all traffic from a block so that
I can take external snaphosts without the risk to that in the middle of a write
operation. Its meant for cases where where QGA freeze/thaw is not available.

For me its enough to have this through qemu-io, but Kevin asked me to check
if its not worth to have a stable API for it and present it via QMP/HMP.

What are your thoughts?

Thanks,
Peter

---
 qemu-io-cmds.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 312fc6d..49d82fe 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1565,6 +1565,82 @@ static const cmdinfo_t flush_cmd = {
     .oneline    = "flush all in-core file state to disk",
 };
 
+static const cmdinfo_t drain_cmd;
+
+static int drain_f(BlockBackend *blk, int argc, char **argv)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    bool flush = false;
+    int c;
+
+    while ((c = getopt(argc, argv, "f")) != -1) {
+        switch (c) {
+        case 'f':
+            flush = true;
+            break;
+        default:
+            return qemuio_command_usage(&drain_cmd);
+        }
+    }
+
+    if (optind != argc) {
+        return qemuio_command_usage(&drain_cmd);
+    }
+
+
+    if (bs->quiesce_counter) {
+        printf("drain failed: device is already drained!\n");
+        return 1;
+    }
+
+    bdrv_drained_begin(bs); /* complete I/O */
+    if (flush) {
+        bdrv_flush(bs);
+        bdrv_drain(bs); /* in case flush left pending I/O */
+        printf("flushed all pending I/O\n");
+    }
+    printf("drain successful\n");
+    return 0;
+}
+
+static void drain_help(void)
+{
+    printf(
+"\n"
+" Drains all external I/O from the device\n"
+"\n"
+" -f, -- flush all in-core file state to disk\n"
+"\n");
+}
+
+static const cmdinfo_t drain_cmd = {
+    .name       = "drain",
+    .cfunc      = drain_f,
+    .args       = "[-f]",
+    .argmin     = 0,
+    .argmax     = -1,
+    .oneline    = "cease to send I/O to the device",
+    .help       = drain_help
+};
+
+static int undrain_f(BlockBackend *blk, int argc, char **argv)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    if (!bs->quiesce_counter) {
+        printf("undrain failed: device is not drained!\n");
+        return 1;
+    }
+    bdrv_drained_end(bs);
+    printf("undrain successful\n");
+    return 0;
+}
+
+static const cmdinfo_t undrain_cmd = {
+    .name       = "undrain",
+    .cfunc      = undrain_f,
+    .oneline    = "continue I/O to a drained device",
+};
+
 static int truncate_f(BlockBackend *blk, int argc, char **argv)
 {
     int64_t offset;
@@ -2296,6 +2372,8 @@ static void __attribute((constructor)) init_qemuio_commands(void)
     qemuio_add_command(&aio_write_cmd);
     qemuio_add_command(&aio_flush_cmd);
     qemuio_add_command(&flush_cmd);
+    qemuio_add_command(&drain_cmd);
+    qemuio_add_command(&undrain_cmd);
     qemuio_add_command(&truncate_cmd);
     qemuio_add_command(&length_cmd);
     qemuio_add_command(&info_cmd);
-- 
1.9.1
