Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731E7C33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 00:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C629207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 00:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="nbaiZAgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C629207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irAJv-0005Np-OR
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 19:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <d87e44492e7100b538702469ef509d7ccbd56269@lizzy.crudebyte.com>)
 id 1irAIR-0004NN-Fm
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:43:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <d87e44492e7100b538702469ef509d7ccbd56269@lizzy.crudebyte.com>)
 id 1irAIQ-0006mN-5u
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:43:03 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:50147)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <d87e44492e7100b538702469ef509d7ccbd56269@lizzy.crudebyte.com>)
 id 1irAIO-0005yJ-TQ
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=SnTKgxtm8KmUuX3BQOZ3np4LjvhrN0t+xCNcOwfTQIA=; b=nbaiZ
 AgzDoowlhpeixAKc6oacENig/yRE3YgC6Ds0cU+R6nQmaZ0aSVFLAARfn7NIu9PvyLCoG9eG/kn0u
 au8x3tPkrP+7IaI2cM1h+8HBQ0g5L8831ujbtp/CBubeW6IpPoJB5i9CunogAmiOxW5gI5eM7jI95
 JL2QIf3TtIct7yhoV8f/0bIqphDHet0mi+6NrDZzCIkbO8rDqmEDM1Ik/mU6HjtosoB4ZFN3tD17H
 /hFzjo0yGM9ghyIUPZu+lQTnx6PaazRTAV172zMugerZSAHNJoj6ZvaI9aef2wvpfxBmwy/XqUYSQ
 RC8P4BnQ6QkqfrSyIhBS9Y+hjXAZw==;
Message-Id: <d87e44492e7100b538702469ef509d7ccbd56269.1578957500.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1578957500.git.qemu_oss@crudebyte.com>
References: <cover.1578957500.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 14 Jan 2020 00:11:08 +0100
Subject: [PATCH v3 06/11] tests/virtio-9p: added splitted readdir test
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

The previous, already existing readdir test simply used a 'count'
parameter big enough to retrieve all directory entries with a
single Treaddir request.

In this new 'splitted' readdir test, directory entries are
retrieved, splitted over several Treaddir requests by picking small
'count' parameters which force the server to truncate the response.
So the test client sends as many Treaddir requests as necessary to
get all directory entries. Currently this test covers actually two
tests: a sequence of Treaddir requests with count=512 and then a
subsequent test with a sequence of Treaddir requests with count=256.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/virtio-9p-test.c | 91 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 721f13c1fb..55bfe41dfd 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -578,6 +578,7 @@ static bool fs_dirents_contain_name(struct V9fsDirent *e, const char* name)
     return false;
 }
 
+/* basic readdir test where reply fits into a single response message */
 static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
@@ -628,6 +629,95 @@ static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
     g_free(wnames[0]);
 }
 
+/* readdir test where overall request is splitted over several messages */
+static void fs_readdir_split(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    alloc = t_alloc;
+    char *const wnames[] = { g_strdup(QTEST_V9FS_SYNTH_READDIR_DIR) };
+    uint16_t nqid;
+    v9fs_qid qid;
+    uint32_t count, nentries, npartialentries;
+    struct V9fsDirent *entries, *tail, *partialentries;
+    P9Req *req;
+    int subtest;
+    int fid;
+    uint64_t offset;
+    /* the Treaddir 'count' parameter values to be tested */
+    const uint32_t vcount[] = { 512, 256 };
+    const int nvcount = sizeof(vcount) / sizeof(uint32_t);
+
+    fs_attach(v9p, NULL, t_alloc);
+
+    /* iterate over all 'count' parameter values to be tested with Treaddir */
+    for (subtest = 0; subtest < nvcount; ++subtest) {
+        fid = subtest + 1;
+        offset = 0;
+        entries = NULL;
+        nentries = 0;
+        tail = NULL;
+
+        req = v9fs_twalk(v9p, 0, fid, 1, wnames, 0);
+        v9fs_req_wait_for_reply(req, NULL);
+        v9fs_rwalk(req, &nqid, NULL);
+        g_assert_cmpint(nqid, ==, 1);
+
+        req = v9fs_tlopen(v9p, fid, O_DIRECTORY, 0);
+        v9fs_req_wait_for_reply(req, NULL);
+        v9fs_rlopen(req, &qid, NULL);
+
+        /*
+         * send as many Treaddir requests as required to get all directory
+         * entries
+         */
+        while (true) {
+            npartialentries = 0;
+            partialentries = NULL;
+
+            req = v9fs_treaddir(v9p, fid, offset, vcount[subtest], 0);
+            v9fs_req_wait_for_reply(req, NULL);
+            v9fs_rreaddir(req, &count, &npartialentries, &partialentries);
+            if (npartialentries > 0 && partialentries) {
+                if (!entries) {
+                    entries = partialentries;
+                    nentries = npartialentries;
+                    tail = partialentries;
+                } else {
+                    tail->next = partialentries;
+                    nentries += npartialentries;
+                }
+                while (tail->next) {
+                    tail = tail->next;
+                }
+                offset = tail->offset;
+            } else {
+                break;
+            }
+        }
+
+        g_assert_cmpint(
+            nentries, ==,
+            QTEST_V9FS_SYNTH_READDIR_NFILES + 2 /* "." and ".." */
+        );
+
+        /*
+         * Check all file names exist in returned entries, ignore their order
+         * though.
+         */
+        g_assert_cmpint(fs_dirents_contain_name(entries, "."), ==, true);
+        g_assert_cmpint(fs_dirents_contain_name(entries, ".."), ==, true);
+        for (int i = 0; i < QTEST_V9FS_SYNTH_READDIR_NFILES; ++i) {
+            char *name = g_strdup_printf(QTEST_V9FS_SYNTH_READDIR_FILE, i);
+            g_assert_cmpint(fs_dirents_contain_name(entries, name), ==, true);
+            g_free(name);
+        }
+
+        v9fs_free_dirents(entries);
+    }
+
+    g_free(wnames[0]);
+}
+
 static void fs_walk_no_slash(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
@@ -807,6 +897,7 @@ static void register_virtio_9p_test(void)
     qos_add_test("fs/flush/ignored", "virtio-9p", fs_flush_ignored,
                  NULL);
     qos_add_test("fs/readdir/basic", "virtio-9p", fs_readdir, NULL);
+    qos_add_test("fs/readdir/split", "virtio-9p", fs_readdir_split, NULL);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.20.1


