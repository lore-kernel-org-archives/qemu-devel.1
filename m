Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D3EC32771
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A285422522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Mc7SE8q4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A285422522
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itign-0004dj-Qd
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 20:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <b1eae734604cdbda0cecf1fbb7d103dd249642ee@lizzy.crudebyte.com>)
 id 1iticW-0001Gq-FD
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <b1eae734604cdbda0cecf1fbb7d103dd249642ee@lizzy.crudebyte.com>)
 id 1iticV-0007on-4f
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:46:20 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:57503)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <b1eae734604cdbda0cecf1fbb7d103dd249642ee@lizzy.crudebyte.com>)
 id 1iticU-0007JR-Tf
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:46:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=ByUYiVdvoBSwlhivjSmx2Q2G2RuIKbbuG2BmPS71kXA=; b=Mc7SE
 8q48huHLSEyPaNWJLE9fEsc/WaRXtgZReTlWkH80HGWcqW1WD4rrB/JTTNQdQ9lW5f5usoLh9/zo+
 Ye7tf+Km2RJZBxCscjLG9tDT4wQn79RCz1JbY4mCzVplqxPmnbjILPX+YmEbW4URvSopdcbxjoA/l
 /YYxB3xHdxfNgzSrfumKP8wLor0lYjCWOUNJs75RjTfFlTZCUNSWJfESd10S3Z6bArCunIeWHUFkl
 6F+AeEHjoxQjIKaKtFh6lh9qfEpKaGAYeaTqFWL+UTdj79lChjLPl3VCByyfnuyowbZ+ieo/rx5Px
 Z28SnNfTkHmm9/gtNLCcpk1KQ/VEg==;
Message-Id: <b1eae734604cdbda0cecf1fbb7d103dd249642ee.1579567020.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1579567019.git.qemu_oss@crudebyte.com>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 21 Jan 2020 01:23:55 +0100
Subject: [PATCH v4 08/11] 9pfs: readdir benchmark
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
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
make && make tests/qtest/qos-test
export QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
tests/qtest/qos-test -p $(tests/qtest/qos-test -l | grep readdir/basic)

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
 hw/9pfs/9p-synth.h           |  2 +-
 tests/qtest/virtio-9p-test.c | 37 +++++++++++++++++++++++++++++++++++-
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
diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index e47b286340..d71b37aa6c 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
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
@@ -600,12 +612,35 @@ static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rlopen(req, &qid, NULL);
 
+    const double start = wall_time();
+
     /*
      * submit count = msize - 11, because 11 is the header size of Rreaddir
      */
     req = v9fs_treaddir(v9p, 1, 0, P9_MAX_SIZE - 11, 0);
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


