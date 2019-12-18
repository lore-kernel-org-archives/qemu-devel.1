Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C83C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 15:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF7C218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 15:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="LxsxYt1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF7C218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihaws-0003vB-RF
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 10:09:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <a8d6dab2625554d425bd44a4d54d84459f083b18@lizzy.crudebyte.com>)
 id 1ihawF-0003Tf-Nw
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:08:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <a8d6dab2625554d425bd44a4d54d84459f083b18@lizzy.crudebyte.com>)
 id 1ihawE-0003SZ-4y
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:08:35 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:52141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <a8d6dab2625554d425bd44a4d54d84459f083b18@lizzy.crudebyte.com>)
 id 1ihawD-0006FQ-KN
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Subject:Date:Cc:To:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=qIKNwOBYoiZIKrTToOWeUyN8KcypATIyiBDvg/u2X54=; b=LxsxY
 t1CG7a8ljFxs3XKf9WXE0AHpMn3T9oQsPUpzVppgMFPLI5ZJb/JHhjbvUEKl+YBx85fD5BodTKWdE
 8OxlK2XjynbpY/be5f7Q71xTqv8Sjg8/21f1/XZvx0MbttADP04QhOsvmNuDX7+uxuXCDaY4FNLvY
 GUjURJRQs7J5sLxt1CNVv5hcnuS4Hs5n9jVJd2BQjxVeb6ux6ZELgq/NQp09m++chFWclzkciZSJW
 XdNL1Nk6/JFr6VPh0deYdW4H/ipEUonIcfKWEX7ulFRM3zPBqUu2kHuTJWg6eWhRNAHxCqPIjWjas
 6enTWuGGpJs9vlHrizkjBlb9XTkiw==;
Message-Id: <a8d6dab2625554d425bd44a4d54d84459f083b18.1576678644.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1576678644.git.qemu_oss@crudebyte.com>
References: <cover.1576678644.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Date: Wed, 18 Dec 2019 14:30:43 +0100
Subject: [PATCH v2 4/9] tests/virtio-9p: added readdir test
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

This first readdir test simply checks the amount of directory
entries returned by 9pfs server, according to the created amount
of virtual files on 9pfs synth driver side.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/virtio-9p-test.c | 124 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 06263edb53..48c0eca292 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -68,6 +68,11 @@ static void v9fs_memread(P9Req *req, void *addr, size_t len)
     req->r_off += len;
 }
 
+static void v9fs_uint8_read(P9Req *req, uint8_t *val)
+{
+    v9fs_memread(req, val, 1);
+}
+
 static void v9fs_uint16_write(P9Req *req, uint16_t val)
 {
     uint16_t le_val = cpu_to_le16(val);
@@ -101,6 +106,12 @@ static void v9fs_uint32_read(P9Req *req, uint32_t *val)
     le32_to_cpus(val);
 }
 
+static void v9fs_uint64_read(P9Req *req, uint64_t *val)
+{
+    v9fs_memread(req, val, 8);
+    le64_to_cpus(val);
+}
+
 /* len[2] string[len] */
 static uint16_t v9fs_string_size(const char *string)
 {
@@ -191,6 +202,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RLOPEN ? "RLOPEN" :
         id == P9_RWRITE ? "RWRITE" :
         id == P9_RFLUSH ? "RFLUSH" :
+        id == P9_RREADDIR ? "READDIR" :
         "<unknown>";
 }
 
@@ -348,6 +360,79 @@ static void v9fs_rwalk(P9Req *req, uint16_t *nwqid, v9fs_qid **wqid)
     v9fs_req_free(req);
 }
 
+/* size[4] Treaddir tag[2] fid[4] offset[8] count[4] */
+static P9Req *v9fs_treaddir(QVirtio9P *v9p, uint32_t fid, uint64_t offset,
+                            uint32_t count, uint16_t tag)
+{
+    P9Req *req;
+
+    req = v9fs_req_init(v9p, 4 + 8 + 4, P9_TREADDIR, tag);
+    v9fs_uint32_write(req, fid);
+    v9fs_uint64_write(req, offset);
+    v9fs_uint32_write(req, count);
+    v9fs_req_send(req);
+    return req;
+}
+
+struct v9fs_dirent {
+    v9fs_qid qid;
+    uint64_t offset;
+    uint8_t type;
+    char *name;
+    struct v9fs_dirent *next;
+};
+
+/* size[4] Rreaddir tag[2] count[4] data[count] */
+static void v9fs_rreaddir(P9Req *req, uint32_t *count, uint32_t *nentries,
+                          struct v9fs_dirent **entries)
+{
+    uint32_t sz;
+    struct v9fs_dirent *e = NULL;
+    uint16_t slen;
+    uint32_t n = 0;
+
+    v9fs_req_recv(req, P9_RREADDIR);
+    v9fs_uint32_read(req, &sz);
+
+    if (count) {
+        *count = sz;
+    }
+
+    for (int32_t togo = (int32_t)sz;
+         togo >= 13 + 8 + 1 + 2;
+         togo -= 13 + 8 + 1 + 2 + slen, ++n)
+    {
+        if (!e) {
+            e = g_malloc(sizeof(struct v9fs_dirent));
+            if (entries)
+                *entries = e;
+        } else {
+            e = e->next = g_malloc(sizeof(struct v9fs_dirent));
+        }
+        e->next = NULL;
+        /* qid[13] offset[8] type[1] name[s] */
+        v9fs_memread(req, &e->qid, 13);
+        v9fs_uint64_read(req, &e->offset);
+        v9fs_uint8_read(req, &e->type);
+        v9fs_string_read(req, &slen, &e->name);
+    }
+
+    if (nentries) {
+        *nentries = n;
+    }
+}
+
+static void v9fs_free_dirents(struct v9fs_dirent *e)
+{
+    struct v9fs_dirent *next = NULL;
+
+    for (; e; e = next) {
+        next = e->next;
+        g_free(e->name);
+        g_free(e);
+    }
+}
+
 /* size[4] Tlopen tag[2] fid[4] flags[4] */
 static P9Req *v9fs_tlopen(QVirtio9P *v9p, uint32_t fid, uint32_t flags,
                           uint16_t tag)
@@ -480,6 +565,44 @@ static void fs_walk(void *obj, void *data, QGuestAllocator *t_alloc)
     g_free(wqid);
 }
 
+static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    alloc = t_alloc;
+    char *const wnames[] = { g_strdup(QTEST_V9FS_SYNTH_READDIR_DIR) };
+    uint16_t nqid;
+    v9fs_qid qid;
+    uint32_t count, nentries;
+    struct v9fs_dirent *entries = NULL;
+    P9Req *req;
+
+    fs_attach(v9p, NULL, t_alloc);
+    req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rwalk(req, &nqid, NULL);
+    g_assert_cmpint(nqid, ==, 1);
+
+    req = v9fs_tlopen(v9p, 1, O_DIRECTORY, 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rlopen(req, &qid, NULL);
+
+    req = v9fs_treaddir(v9p, 1, 0, P9_MAX_SIZE - P9_IOHDRSZ, 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rreaddir(req, &count, &nentries, &entries);
+
+    /*
+     * Assuming msize (P9_MAX_SIZE) is large enough so we can retrieve all
+     * dir entries with only one readdir request.
+     */
+    g_assert_cmpint(
+        nentries, ==,
+        QTEST_V9FS_SYNTH_READDIR_NFILES + 2 /* "." and ".." */
+    );
+
+    v9fs_free_dirents(entries);
+    g_free(wnames[0]);
+}
+
 static void fs_walk_no_slash(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
@@ -658,6 +781,7 @@ static void register_virtio_9p_test(void)
                  NULL);
     qos_add_test("fs/flush/ignored", "virtio-9p", fs_flush_ignored,
                  NULL);
+    qos_add_test("fs/readdir/basic", "virtio-9p", fs_readdir, NULL);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.20.1


