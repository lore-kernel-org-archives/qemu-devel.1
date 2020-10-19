Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3430CC43457
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE5B2222F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="aNLDaItp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE5B2222F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUelb-00086Z-MY
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 19:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a42df8544e913b8c0bf1702d0788724d79103110@lizzy.crudebyte.com>)
 id 1kUejf-0006fK-Jh
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:38:40 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:59157)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a42df8544e913b8c0bf1702d0788724d79103110@lizzy.crudebyte.com>)
 id 1kUejd-0002Pe-NM
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=H3glx/McXEtcE4BZrJ1LIdOSYG5JKITjfdQJ79RoGRk=; b=aNLDa
 ItpfZnCkWeHR3ZCa4uuHZCFsqektzZFjz0gbGixVkW7Sv8OxdGkTWYsJgsuDO+LkNIIcsn544p8sQ
 QWFwvwqbVQRJ0Plqfdy/yj9dqpC5Y3+l8xPMkCStdYz6kRJuA3yxqY009F9iBMHCVGWyLR6HTT1lV
 u2MME24U7TgdI/JNi9uOMwOSORZu/KjXNFh1I7o79EJE+4HG6mC8rdx0jUZYmcMha1uDjQWGbBRFn
 yX32qn/rTJPRKEgESYE/EahHdvvcRrLQUq6bm/wFZfsAlIE52GxFee0mFarrwXD1u6YE6Eb7h6lVM
 YA+Xex24AFnBZtCIhCaQi+T58dJ1A==;
Message-Id: <a42df8544e913b8c0bf1702d0788724d79103110.1603149434.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1603149434.git.qemu_oss@crudebyte.com>
References: <cover.1603149434.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 20 Oct 2020 01:13:23 +0200
Subject: [PATCH 2/8] tests/9pfs: add local unlinkat directory test
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=a42df8544e913b8c0bf1702d0788724d79103110@lizzy.crudebyte.com;
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

This test case uses a Tunlinkat 9p request with flag AT_REMOVEDIR
(see 'man 2 unlink') to remove a directory from host's test directory.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 72 ++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index dc724bbb1e..990d074d33 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -258,6 +258,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RLOPEN ? "RLOPEN" :
         id == P9_RWRITE ? "RWRITE" :
         id == P9_RMKDIR ? "RMKDIR" :
+        id == P9_RUNLINKAT ? "RUNLINKAT" :
         id == P9_RFLUSH ? "RFLUSH" :
         id == P9_RREADDIR ? "READDIR" :
         "<unknown>";
@@ -668,6 +669,33 @@ static void v9fs_rmkdir(P9Req *req, v9fs_qid *qid)
     v9fs_req_free(req);
 }
 
+/* size[4] Tunlinkat tag[2] dirfd[4] name[s] flags[4] */
+static P9Req *v9fs_tunlinkat(QVirtio9P *v9p, uint32_t dirfd, const char *name,
+                             uint32_t flags, uint16_t tag)
+{
+    P9Req *req;
+
+    uint32_t body_size = 4 + 4;
+    uint16_t string_size = v9fs_string_size(name);
+
+    g_assert_cmpint(body_size, <=, UINT32_MAX - string_size);
+    body_size += string_size;
+
+    req = v9fs_req_init(v9p, body_size, P9_TUNLINKAT, tag);
+    v9fs_uint32_write(req, dirfd);
+    v9fs_string_write(req, name);
+    v9fs_uint32_write(req, flags);
+    v9fs_req_send(req);
+    return req;
+}
+
+/* size[4] Runlinkat tag[2] */
+static void v9fs_runlinkat(P9Req *req)
+{
+    v9fs_req_recv(req, P9_RUNLINKAT);
+    v9fs_req_free(req);
+}
+
 /* basic readdir test where reply fits into a single response message */
 static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
 {
@@ -1004,6 +1032,24 @@ static void fs_mkdir(void *obj, void *data, QGuestAllocator *t_alloc,
     g_free(name);
 }
 
+static void fs_unlinkat(void *obj, void *data, QGuestAllocator *t_alloc,
+                        const char *atpath, const char *rpath, uint32_t flags)
+{
+    QVirtio9P *v9p = obj;
+    alloc = t_alloc;
+    char *const name = g_strdup(rpath);
+    uint32_t fid;
+    P9Req *req;
+
+    fid = fs_walk_fid(v9p, data, t_alloc, atpath);
+
+    req = v9fs_tunlinkat(v9p, fid, name, flags, 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_runlinkat(req);
+
+    g_free(name);
+}
+
 static void fs_readdir_split_128(void *obj, void *data,
                                  QGuestAllocator *t_alloc)
 {
@@ -1046,6 +1092,31 @@ static void fs_create_dir(void *obj, void *data, QGuestAllocator *t_alloc)
     g_free(root_path);
 }
 
+static void fs_unlinkat_dir(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    struct stat st;
+    char *root_path = virtio_9p_test_path("");
+    char *new_dir = virtio_9p_test_path("02");
+
+    g_assert(root_path != NULL);
+
+    fs_attach(v9p, NULL, t_alloc);
+    fs_mkdir(v9p, data, t_alloc, "/", "02");
+
+    /* check if created directory really exists now ... */
+    g_assert(stat(new_dir, &st) == 0);
+    /* ... and is actually a directory */
+    g_assert((st.st_mode & S_IFMT) == S_IFDIR);
+
+    fs_unlinkat(v9p, data, t_alloc, "/", "02", AT_REMOVEDIR);
+    /* directory should be gone now */
+    g_assert(stat(new_dir, &st) != 0);
+
+    g_free(new_dir);
+    g_free(root_path);
+}
+
 static void *assign_9p_local_driver(GString *cmd_line, void *arg)
 {
     virtio_9p_assign_local_driver(cmd_line, "security_model=mapped-xattr");
@@ -1086,6 +1157,7 @@ static void register_virtio_9p_test(void)
     opts.before = assign_9p_local_driver;
     qos_add_test("local/config", "virtio-9p", pci_config,  &opts);
     qos_add_test("local/create_dir", "virtio-9p", fs_create_dir, &opts);
+    qos_add_test("local/unlinkat_dir", "virtio-9p", fs_unlinkat_dir, &opts);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.20.1


