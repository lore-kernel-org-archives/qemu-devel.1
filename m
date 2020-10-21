Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2BBC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93EF720578
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Iis+k5qk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EF720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVnk-0004ry-FJ
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bf7adaa3d133f81daf2bdf68546a3c1072ce28a5@lizzy.crudebyte.com>)
 id 1kYVfK-0001nN-Lp
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:46:06 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:52639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bf7adaa3d133f81daf2bdf68546a3c1072ce28a5@lizzy.crudebyte.com>)
 id 1kYVfI-0003Ca-Sw
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=7F7Z+yXYLuM3MjkIbqlf4UwiBRT7dXMX22Ht94r12PE=; b=Iis+k
 5qkAjOcyXxi7UoYM8Ey7/7sS4Kc1p7toUWGsKs5je4PT+Gx9NUakbDWpqeJC5IYsSAdRbXNZhKDCR
 d9Ah6rrW7i0E6e9075ZtffVwYr65joymQcQBs1i3tFTPF6IrOjueTS1TO+FtuQkb9YjIiIJQ6tLpT
 frsh5Y8yTwxuF+cWzG9SbizZMlw4S6QJC4wyfSPSud5l8Er0tQWCUJHcIG+2qWfdu4H5EqeGWlrau
 d5EEMYd518OqgXklX+/O2T5FhfBUUy5tA7Ekgv2jLJ1n0fHxfitdi2LHeDOrad/BjlgE81YgAIlRg
 c+r7/Z/IWHd7pICjei/6q2KdcZ9zw==;
Message-Id: <bf7adaa3d133f81daf2bdf68546a3c1072ce28a5.1604067568.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1604067568.git.qemu_oss@crudebyte.com>
References: <cover.1604067568.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 21 Oct 2020 14:25:33 +0200
Subject: [PULL v2 11/16] tests/9pfs: add local Tlcreate test
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=bf7adaa3d133f81daf2bdf68546a3c1072ce28a5@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 07:59:50
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

This test case uses a Tlcreate 9p request to create a regular file inside
host's test directory.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <269cae0c00af941a3a4ae78f1e319f93462a7eb4.1603285620.git.qemu_oss@crudebyte.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 77 ++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index abd7e44648..c030bc2a6c 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -258,6 +258,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RLOPEN ? "RLOPEN" :
         id == P9_RWRITE ? "RWRITE" :
         id == P9_RMKDIR ? "RMKDIR" :
+        id == P9_RLCREATE ? "RLCREATE" :
         id == P9_RUNLINKAT ? "RUNLINKAT" :
         id == P9_RFLUSH ? "RFLUSH" :
         id == P9_RREADDIR ? "READDIR" :
@@ -694,6 +695,44 @@ static void v9fs_rmkdir(P9Req *req, v9fs_qid *qid)
     v9fs_req_free(req);
 }
 
+/* size[4] Tlcreate tag[2] fid[4] name[s] flags[4] mode[4] gid[4] */
+static P9Req *v9fs_tlcreate(QVirtio9P *v9p, uint32_t fid, const char *name,
+                            uint32_t flags, uint32_t mode, uint32_t gid,
+                            uint16_t tag)
+{
+    P9Req *req;
+
+    uint32_t body_size = 4 + 4 + 4 + 4;
+    uint16_t string_size = v9fs_string_size(name);
+
+    g_assert_cmpint(body_size, <=, UINT32_MAX - string_size);
+    body_size += string_size;
+
+    req = v9fs_req_init(v9p, body_size, P9_TLCREATE, tag);
+    v9fs_uint32_write(req, fid);
+    v9fs_string_write(req, name);
+    v9fs_uint32_write(req, flags);
+    v9fs_uint32_write(req, mode);
+    v9fs_uint32_write(req, gid);
+    v9fs_req_send(req);
+    return req;
+}
+
+/* size[4] Rlcreate tag[2] qid[13] iounit[4] */
+static void v9fs_rlcreate(P9Req *req, v9fs_qid *qid, uint32_t *iounit)
+{
+    v9fs_req_recv(req, P9_RLCREATE);
+    if (qid) {
+        v9fs_memread(req, qid, 13);
+    } else {
+        v9fs_memskip(req, 13);
+    }
+    if (iounit) {
+        v9fs_uint32_read(req, iounit);
+    }
+    v9fs_req_free(req);
+}
+
 /* size[4] Tunlinkat tag[2] dirfd[4] name[s] flags[4] */
 static P9Req *v9fs_tunlinkat(QVirtio9P *v9p, uint32_t dirfd, const char *name,
                              uint32_t flags, uint16_t tag)
@@ -1032,6 +1071,24 @@ static void do_mkdir(QVirtio9P *v9p, const char *path, const char *cname)
     g_free(name);
 }
 
+/* create a regular file with Tlcreate and return file's fid */
+static uint32_t do_lcreate(QVirtio9P *v9p, const char *path,
+                           const char *cname)
+{
+    char *const name = g_strdup(cname);
+    uint32_t fid;
+    P9Req *req;
+
+    fid = do_walk(v9p, path);
+
+    req = v9fs_tlcreate(v9p, fid, name, 0, 0750, 0, 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rlcreate(req, NULL, NULL);
+
+    g_free(name);
+    return fid;
+}
+
 static void do_unlinkat(QVirtio9P *v9p, const char *atpath, const char *rpath,
                         uint32_t flags)
 {
@@ -1120,6 +1177,25 @@ static void fs_unlinkat_dir(void *obj, void *data, QGuestAllocator *t_alloc)
     g_free(root_path);
 }
 
+static void fs_create_file(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    alloc = t_alloc;
+    struct stat st;
+    char *new_file = virtio_9p_test_path("03/1st_file");
+
+    do_attach(v9p);
+    do_mkdir(v9p, "/", "03");
+    do_lcreate(v9p, "03", "1st_file");
+
+    /* check if created file exists now ... */
+    g_assert(stat(new_file, &st) == 0);
+    /* ... and is a regular file */
+    g_assert((st.st_mode & S_IFMT) == S_IFREG);
+
+    g_free(new_file);
+}
+
 static void *assign_9p_local_driver(GString *cmd_line, void *arg)
 {
     virtio_9p_assign_local_driver(cmd_line, "security_model=mapped-xattr");
@@ -1161,6 +1237,7 @@ static void register_virtio_9p_test(void)
     qos_add_test("local/config", "virtio-9p", pci_config,  &opts);
     qos_add_test("local/create_dir", "virtio-9p", fs_create_dir, &opts);
     qos_add_test("local/unlinkat_dir", "virtio-9p", fs_unlinkat_dir, &opts);
+    qos_add_test("local/create_file", "virtio-9p", fs_create_file, &opts);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.20.1


