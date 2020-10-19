Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56700C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACEF12225F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="YvfBnelb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEF12225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUes8-0006oS-Mw
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 19:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <ee6d9e1147d05bcf0b51b02ef6757f4b4691ba2d@lizzy.crudebyte.com>)
 id 1kUekA-00075h-FY
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:39:10 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:56165)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <ee6d9e1147d05bcf0b51b02ef6757f4b4691ba2d@lizzy.crudebyte.com>)
 id 1kUek8-0002T8-P4
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=vA3i8SPVfAVvIXbvf5MMFPnqoVqWzTlxfDM9uLSyPg4=; b=YvfBn
 elb92ps34Lj7d7G4bK6adeNhWk1MIWmt1UoIwlpjsiUXErdmxPgpCj4h79xyKDqtpG5kfAQszBGfZ
 zXmfiV62VK4KLTEqWk3bTGpNt3mLnalWlhgwbdipD9r8ds15sI1rtB4fOfdkXD3AVIpcPEkVUTH2u
 J/YO7Avv6A9ZzDRHfV7B6KgzDTGsoL7KRQgWQlqysEAUzUm3z1kNvIcZ+9WvbDfet/eT5ykl7dx7H
 EmXygE1T1zKFTu6wOxeFVutAOf6ihNeQ5u+oxiFmbcYPMY8e3RqEBi1G+c0I+ffPYsC+vNdQw1DVE
 h55LRIUmkak3wxcU84XVKgDAbMCnA==;
Message-Id: <ee6d9e1147d05bcf0b51b02ef6757f4b4691ba2d.1603149434.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1603149434.git.qemu_oss@crudebyte.com>
References: <cover.1603149434.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 20 Oct 2020 01:13:24 +0200
Subject: [PATCH 7/8] tests/9pfs: add local Tlink test
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=ee6d9e1147d05bcf0b51b02ef6757f4b4691ba2d@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 19:37:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This test case uses a Tlink request to create a hard link to a regular
file using the 9pfs 'local' fs driver.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 61 ++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index f7d18f6274..447d8e3344 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -260,6 +260,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RMKDIR ? "RMKDIR" :
         id == P9_RLCREATE ? "RLCREATE" :
         id == P9_RSYMLINK ? "RSYMLINK" :
+        id == P9_RLINK ? "RLINK" :
         id == P9_RUNLINKAT ? "RUNLINKAT" :
         id == P9_RFLUSH ? "RFLUSH" :
         id == P9_RREADDIR ? "READDIR" :
@@ -742,6 +743,33 @@ static void v9fs_rsymlink(P9Req *req, v9fs_qid *qid)
     v9fs_req_free(req);
 }
 
+/* size[4] Tlink tag[2] dfid[4] fid[4] name[s] */
+static P9Req *v9fs_tlink(QVirtio9P *v9p, uint32_t dfid, uint32_t fid,
+                         const char *name, uint16_t tag)
+{
+    P9Req *req;
+
+    uint32_t body_size = 4 + 4;
+    uint16_t string_size = v9fs_string_size(name);
+
+    g_assert_cmpint(body_size, <=, UINT32_MAX - string_size);
+    body_size += string_size;
+
+    req = v9fs_req_init(v9p, body_size, P9_TLINK, tag);
+    v9fs_uint32_write(req, dfid);
+    v9fs_uint32_write(req, fid);
+    v9fs_string_write(req, name);
+    v9fs_req_send(req);
+    return req;
+}
+
+/* size[4] Rlink tag[2] */
+static void v9fs_rlink(P9Req *req)
+{
+    v9fs_req_recv(req, P9_RLINK);
+    v9fs_req_free(req);
+}
+
 /* size[4] Tunlinkat tag[2] dirfd[4] name[s] flags[4] */
 static P9Req *v9fs_tunlinkat(QVirtio9P *v9p, uint32_t dirfd, const char *name,
                              uint32_t flags, uint16_t tag)
@@ -1318,6 +1346,38 @@ static void fs_unlinkat_symlink(void *obj, void *data,
     g_free(real_file);
 }
 
+static void fs_hardlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    P9Req *req;
+    uint32_t dfid, fid;
+    struct stat st_real, st_link;
+    char *real_file = virtio_9p_test_path("07/real_file");
+    char *hardlink_file = virtio_9p_test_path("07/hardlink_file");
+
+    fs_attach(v9p, NULL, t_alloc);
+    fs_mkdir(v9p, data, t_alloc, "/", "07");
+    fid = fs_lcreate(v9p, data, t_alloc, "07", "real_file");
+    g_assert(stat(real_file, &st_real) == 0);
+    g_assert((st_real.st_mode & S_IFMT) == S_IFREG);
+
+    dfid = fs_walk_fid(v9p, data, t_alloc, "07");
+
+    req = v9fs_tlink(v9p, dfid, fid, "hardlink_file", 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rlink(req);
+
+    /* check if link exists now ... */
+    g_assert(stat(hardlink_file, &st_link) == 0);
+    /* ... and it's a hard link, right? */
+    g_assert((st_link.st_mode & S_IFMT) == S_IFREG);
+    g_assert(st_link.st_dev == st_real.st_dev);
+    g_assert(st_link.st_ino == st_real.st_ino);
+
+    g_free(hardlink_file);
+    g_free(real_file);
+}
+
 static void *assign_9p_local_driver(GString *cmd_line, void *arg)
 {
     virtio_9p_assign_local_driver(cmd_line, "security_model=mapped-xattr");
@@ -1363,6 +1423,7 @@ static void register_virtio_9p_test(void)
     qos_add_test("local/unlinkat_file", "virtio-9p", fs_unlinkat_file, &opts);
     qos_add_test("local/symlink_file", "virtio-9p", fs_symlink_file, &opts);
     qos_add_test("local/unlinkat_symlink", "virtio-9p", fs_unlinkat_symlink, &opts);
+    qos_add_test("local/hardlink_file", "virtio-9p", fs_hardlink_file, &opts);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.20.1


