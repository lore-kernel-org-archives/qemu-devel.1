Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDABDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130AE2223C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="nSuC/f+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130AE2223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUeod-0002nj-1H
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 19:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <fe723557735b19282e3c12f304a69a898d0a4819@lizzy.crudebyte.com>)
 id 1kUejm-0006ky-HH
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:38:46 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:41423)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <fe723557735b19282e3c12f304a69a898d0a4819@lizzy.crudebyte.com>)
 id 1kUejk-0002Q9-Mt
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=in3U1t/MFXBXTZQt4whAHkL0n/tjx73g1jNlbMqKveU=; b=nSuC/
 f+wmCl5xAizLG4weEv0jBFBzH7j1aZvy9yI5+kNz4zSm+V2RglI7Ni5bReL2Re8XFI8zVJu/XrP5s
 aZP5tQQNbWJvkyuYt7BmaXKmoN6piAXJidOiRbOD8UieNxGmtNFHjURZkXqmpFyhmrYsL/7nwwnUL
 AdvgFcYregvLEp82vc9sU5gUPntfKjYho0WRaNARXU8GvxYFnYkzX/B9GDXYEWykESQvnCGI8Eo+R
 y9XK63IwGb86/90uR27DYuGAbZTDvguECWTLTDtiIigrnkwrEerBXYKUI72c6tpUvueTTRu+NtAt2
 1B/Ddk6WJDs4VCRm5+nZ5vcZmwzIg==;
Message-Id: <fe723557735b19282e3c12f304a69a898d0a4819.1603149434.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1603149434.git.qemu_oss@crudebyte.com>
References: <cover.1603149434.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 20 Oct 2020 01:13:24 +0200
Subject: [PATCH 3/8] tests/9pfs: add local Tlcreate test
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=fe723557735b19282e3c12f304a69a898d0a4819@lizzy.crudebyte.com;
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

This test case uses a Tlcreate 9p request to create a regular file inside
host's test directory.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 78 ++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 990d074d33..1b133f52bd 100644
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
@@ -669,6 +670,44 @@ static void v9fs_rmkdir(P9Req *req, v9fs_qid *qid)
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
@@ -1032,6 +1071,26 @@ static void fs_mkdir(void *obj, void *data, QGuestAllocator *t_alloc,
     g_free(name);
 }
 
+/* create a regular file with Tlcreate and return file's fid */
+static uint32_t fs_lcreate(void *obj, void *data, QGuestAllocator *t_alloc,
+                           const char *path, const char *cname)
+{
+    QVirtio9P *v9p = obj;
+    alloc = t_alloc;
+    char *const name = g_strdup(cname);
+    uint32_t fid;
+    P9Req *req;
+
+    fid = fs_walk_fid(v9p, data, t_alloc, path);
+
+    req = v9fs_tlcreate(v9p, fid, name, 0, 0750, 0, 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rlcreate(req, NULL, NULL);
+
+    g_free(name);
+    return fid;
+}
+
 static void fs_unlinkat(void *obj, void *data, QGuestAllocator *t_alloc,
                         const char *atpath, const char *rpath, uint32_t flags)
 {
@@ -1117,6 +1176,24 @@ static void fs_unlinkat_dir(void *obj, void *data, QGuestAllocator *t_alloc)
     g_free(root_path);
 }
 
+static void fs_create_file(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    struct stat st;
+    char *new_file = virtio_9p_test_path("03/1st_file");
+
+    fs_attach(v9p, NULL, t_alloc);
+    fs_mkdir(v9p, data, t_alloc, "/", "03");
+    fs_lcreate(v9p, data, t_alloc, "03", "1st_file");
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
@@ -1158,6 +1235,7 @@ static void register_virtio_9p_test(void)
     qos_add_test("local/config", "virtio-9p", pci_config,  &opts);
     qos_add_test("local/create_dir", "virtio-9p", fs_create_dir, &opts);
     qos_add_test("local/unlinkat_dir", "virtio-9p", fs_unlinkat_dir, &opts);
+    qos_add_test("local/create_file", "virtio-9p", fs_create_file, &opts);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.20.1


