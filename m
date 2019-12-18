Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B63C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 15:16:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90CFC24676
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 15:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="KHMIw4j4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CFC24676
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihb3h-0004SS-C8
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 10:16:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <7c0b113e491530d31731b20cba51ffb00a4435c4@lizzy.crudebyte.com>)
 id 1ihb2F-00037q-Jk
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:14:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <7c0b113e491530d31731b20cba51ffb00a4435c4@lizzy.crudebyte.com>)
 id 1ihb2D-0001pq-4s
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:14:46 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:59215)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <7c0b113e491530d31731b20cba51ffb00a4435c4@lizzy.crudebyte.com>)
 id 1ihb2C-0006UA-Pi
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Subject:Date:Cc:To:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=u7Pi8DHq80FsSvKzTS9rTP58g706j7ijrYyMVBFOJ30=; b=KHMIw
 4j4HYF0Jtxbb7wsBGMun0Bnab2as5VIWJ13C7oESKhlb+Y11Tir7Tc9FYEahHTshxueqJSfc3tccF
 zQknFyiFe3pK1tuy/QP2zkN62Bgkh0AXwbmH6kGfNQBgli4FA5xZEixJnSb7EflVOIkV1R81xn5Mn
 MrFFYzccMS+6KduMDtl9QOogJhreHuoicA+8LvF6aUd0m3AXx5P5gGp0nDT4DT0PvTuYr+5KGkNxe
 +4hbPKikNyVJafFFo9QZEHGTxClVzsv11vyDk6FlbECi0eg5mdwusNI8rthcGU/YZlXu7f2Tzm6eY
 /2uJ3XPPTUON5J5lRUoJYyJQ8ChFA==;
Message-Id: <7c0b113e491530d31731b20cba51ffb00a4435c4.1576678644.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1576678644.git.qemu_oss@crudebyte.com>
References: <cover.1576678644.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Date: Wed, 18 Dec 2019 14:43:38 +0100
Subject: [PATCH v2 6/9] 9pfs: readdir benchmark
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.194.90.13
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch is not intended to be merged. It just provides a
temporary benchmark foundation for coneniently A/B comparison
of the subsequent 9p readdir optimization patches:

* hw/9pfs/9p-synth: increase amount of simulated files for
  readdir test to 2000 files.

* tests/virtio-9p: measure wall time that elapsed between
  sending T_readdir request and arrival of R_readdir response
  and print out that measured duration, as well as amount of
  directory entries received, and the amount of bytes of the
  response message.

* tests/virtio-9p: increased msize to 256kiB to allow
  retrieving all 2000 files (simulated by 9pfs synth driver)
  with only one T_readdir request.

Running this benchmark is fairly quick & simple and does not
require any guest OS installation or other prerequisites:

cd build
make && make tests/qos-test
export QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
tests/qos-test -p $(tests/qos-test -l | grep readdir/basic)

Since this benchmark uses the 9pfs synth driver, the host
machine's I/O hardware (SSDs/HDDs) is not relevant for the
benchmark result, because the synth backend's readdir
implementation returns immediately (without any blocking I/O
that would incur with a real-life fs driver) and just returns
already prepared, simulated directory entries directly from RAM.
So this benchmark focuses on the efficiency of the 9pfs
controller code (or top half) for readdir request handling.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-synth.h     |  2 +-
 tests/virtio-9p-test.c | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p-synth.h b/hw/9pfs/9p-synth.h
index 036d7e4a5b..7d6cedcdac 100644
--- a/hw/9pfs/9p-synth.h
+++ b/hw/9pfs/9p-synth.h
@@ -58,7 +58,7 @@ int qemu_v9fs_synth_add_file(V9fsSynthNode *parent, int mode,
 /* for READDIR test */
 #define QTEST_V9FS_SYNTH_READDIR_DIR "ReadDirDir"
 #define QTEST_V9FS_SYNTH_READDIR_FILE "ReadDirFile%d"
-#define QTEST_V9FS_SYNTH_READDIR_NFILES 100
+#define QTEST_V9FS_SYNTH_READDIR_NFILES 2000
 
 /* Any write to the "FLUSH" file is handled one byte at a time by the
  * backend. If the byte is zero, the backend returns success (ie, 1),
diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index cb5c9fb420..7feeca06ff 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -15,6 +15,18 @@
 #include "libqos/virtio-9p.h"
 #include "libqos/qgraph.h"
 
+/*
+ * to benchmark the real time (not CPU time) that elapsed between start of
+ * a request and arrival of its response
+ */
+static double wall_time(void)
+{
+    struct timeval t;
+    struct timezone tz;
+    gettimeofday(&t, &tz);
+    return t.tv_sec + t.tv_usec * 0.000001;
+}
+
 #define QVIRTIO_9P_TIMEOUT_US (10 * 1000 * 1000)
 static QGuestAllocator *alloc;
 
@@ -36,7 +48,7 @@ static void pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
     g_free(tag);
 }
 
-#define P9_MAX_SIZE 4096 /* Max size of a T-message or R-message */
+#define P9_MAX_SIZE (256 * 1024) /* Max size of a T-message or R-message */
 
 typedef struct {
     QTestState *qts;
@@ -596,9 +608,32 @@ static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rlopen(req, &qid, NULL);
 
+    const double start = wall_time();
+
     req = v9fs_treaddir(v9p, 1, 0, P9_MAX_SIZE - P9_IOHDRSZ, 0);
+    const double treaddir = wall_time();
     v9fs_req_wait_for_reply(req, NULL);
+    const double waitforreply = wall_time();
     v9fs_rreaddir(req, &count, &nentries, &entries);
+    const double end = wall_time();
+
+    printf("\nTime client spent on sending T_readdir: %fs\n\n",
+           treaddir - start);
+
+    printf("Time client spent for waiting for reply from server: %fs "
+           "[MOST IMPORTANT]\n", waitforreply - start);
+    printf("(This is the most important value, because it reflects the time\n"
+           "the 9p server required to process and return the result of the\n"
+           "T_readdir request.)\n\n");
+
+    printf("Total client time: %fs\n", end - start);
+    printf("(NOTE: this time is not relevant; this huge time comes from\n"
+           "inefficient qtest_memread() calls. So you can discard this\n"
+           "value as a problem of this test client implementation while\n"
+           "processing the received server T_readdir reply.)\n\n");
+
+    printf("Details of response message data: R_readddir nentries=%d "
+           "rbytes=%d\n", nentries, count);
 
     /*
      * Assuming msize (P9_MAX_SIZE) is large enough so we can retrieve all
-- 
2.20.1


