Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D287C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9883B2225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="UKVkCUus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9883B2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZWjd-0006jS-59
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 05:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <59ff563db1cfb9f3a20075b452d1564585bbc66a@lizzy.crudebyte.com>)
 id 1kZWUv-0003pz-6g
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:51:33 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:56767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <59ff563db1cfb9f3a20075b452d1564585bbc66a@lizzy.crudebyte.com>)
 id 1kZWUt-0007H5-LB
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=UOIDmTkc6DwTYHlMlMlbXZMmXxWD39EpkVgVSQNZvDk=; b=UKVkC
 Uus4RAo4NiCL2N0iHGxSzogsxjfTHS3+CuVZ25Lv0AcrgTCauJG+qYiDZApeHEJ728W1c5OoPcTly
 03Wc85fmmd2QI0QctgxIMhzwqrv4uFsn1gK7WPxt+GYF6QvOklAtAyLnVE5ONXo03Xp7CNpfAQb/N
 iBs+7J1Y1/u/mXqePUadCJDSd6/EWRaCrIS1aZYsTf/Yu9eWc199Xk0JdGc1Y7fCOM02vwjOcLaiz
 ziyyZ4vL4iDoJyC4T5tgqQPSK6pyTfFYqDGeEjNJXk5oI+mo7iZrZFZZ3XNJPrqMsyuDLz46K3fgD
 h9kqR6fA33B8MhF4TkcQn1zSc/38w==;
Message-Id: <59ff563db1cfb9f3a20075b452d1564585bbc66a.1604309512.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1604309512.git.qemu_oss@crudebyte.com>
References: <cover.1604309512.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 21 Oct 2020 14:33:34 +0200
Subject: [PULL v3 14/17] tests/9pfs: add local Tsymlink test
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=59ff563db1cfb9f3a20075b452d1564585bbc66a@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 04:48:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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

This test case uses a Tsymlink 9p request to create a symbolic link using
the 9pfs 'local' fs driver.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <84ac76937855bf441242372cc3e62df42f0a3dc4.1603285620.git.qemu_oss@crudebyte.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 77 ++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 52ecdfab7a..d61e7d244d 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -259,6 +259,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RWRITE ? "RWRITE" :
         id == P9_RMKDIR ? "RMKDIR" :
         id == P9_RLCREATE ? "RLCREATE" :
+        id == P9_RSYMLINK ? "RSYMLINK" :
         id == P9_RUNLINKAT ? "RUNLINKAT" :
         id == P9_RFLUSH ? "RFLUSH" :
         id == P9_RREADDIR ? "READDIR" :
@@ -733,6 +734,39 @@ static void v9fs_rlcreate(P9Req *req, v9fs_qid *qid, uint32_t *iounit)
     v9fs_req_free(req);
 }
 
+/* size[4] Tsymlink tag[2] fid[4] name[s] symtgt[s] gid[4] */
+static P9Req *v9fs_tsymlink(QVirtio9P *v9p, uint32_t fid, const char *name,
+                            const char *symtgt, uint32_t gid, uint16_t tag)
+{
+    P9Req *req;
+
+    uint32_t body_size = 4 + 4;
+    uint16_t string_size = v9fs_string_size(name) + v9fs_string_size(symtgt);
+
+    g_assert_cmpint(body_size, <=, UINT32_MAX - string_size);
+    body_size += string_size;
+
+    req = v9fs_req_init(v9p, body_size, P9_TSYMLINK, tag);
+    v9fs_uint32_write(req, fid);
+    v9fs_string_write(req, name);
+    v9fs_string_write(req, symtgt);
+    v9fs_uint32_write(req, gid);
+    v9fs_req_send(req);
+    return req;
+}
+
+/* size[4] Rsymlink tag[2] qid[13] */
+static void v9fs_rsymlink(P9Req *req, v9fs_qid *qid)
+{
+    v9fs_req_recv(req, P9_RSYMLINK);
+    if (qid) {
+        v9fs_memread(req, qid, 13);
+    } else {
+        v9fs_memskip(req, 13);
+    }
+    v9fs_req_free(req);
+}
+
 /* size[4] Tunlinkat tag[2] dirfd[4] name[s] flags[4] */
 static P9Req *v9fs_tunlinkat(QVirtio9P *v9p, uint32_t dirfd, const char *name,
                              uint32_t flags, uint16_t tag)
@@ -1089,6 +1123,25 @@ static uint32_t do_lcreate(QVirtio9P *v9p, const char *path,
     return fid;
 }
 
+/* create symlink named @a clink in directory @a path pointing to @a to */
+static void do_symlink(QVirtio9P *v9p, const char *path, const char *clink,
+                       const char *to)
+{
+    char *const name = g_strdup(clink);
+    char *const dst = g_strdup(to);
+    uint32_t fid;
+    P9Req *req;
+
+    fid = do_walk(v9p, path);
+
+    req = v9fs_tsymlink(v9p, fid, name, dst, 0, 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rsymlink(req, NULL);
+
+    g_free(dst);
+    g_free(name);
+}
+
 static void do_unlinkat(QVirtio9P *v9p, const char *atpath, const char *rpath,
                         uint32_t flags)
 {
@@ -1219,6 +1272,29 @@ static void fs_unlinkat_file(void *obj, void *data, QGuestAllocator *t_alloc)
     g_free(new_file);
 }
 
+static void fs_symlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    alloc = t_alloc;
+    struct stat st;
+    char *real_file = virtio_9p_test_path("05/real_file");
+    char *symlink_file = virtio_9p_test_path("05/symlink_file");
+
+    do_attach(v9p);
+    do_mkdir(v9p, "/", "05");
+    do_lcreate(v9p, "05", "real_file");
+    g_assert(stat(real_file, &st) == 0);
+    g_assert((st.st_mode & S_IFMT) == S_IFREG);
+
+    do_symlink(v9p, "05", "symlink_file", "real_file");
+
+    /* check if created link exists now */
+    g_assert(stat(symlink_file, &st) == 0);
+
+    g_free(symlink_file);
+    g_free(real_file);
+}
+
 static void *assign_9p_local_driver(GString *cmd_line, void *arg)
 {
     virtio_9p_assign_local_driver(cmd_line, "security_model=mapped-xattr");
@@ -1262,6 +1338,7 @@ static void register_virtio_9p_test(void)
     qos_add_test("local/unlinkat_dir", "virtio-9p", fs_unlinkat_dir, &opts);
     qos_add_test("local/create_file", "virtio-9p", fs_create_file, &opts);
     qos_add_test("local/unlinkat_file", "virtio-9p", fs_unlinkat_file, &opts);
+    qos_add_test("local/symlink_file", "virtio-9p", fs_symlink_file, &opts);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.20.1


