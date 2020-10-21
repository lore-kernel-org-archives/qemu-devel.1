Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01995C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6801820727
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="JnB2CYo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6801820727
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVs9-0003kx-Af
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d000bdac155c2c3e38c0fcde6c7aa5a77efd44cd@lizzy.crudebyte.com>)
 id 1kYVfl-0002Nr-VT
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:46:34 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:60943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d000bdac155c2c3e38c0fcde6c7aa5a77efd44cd@lizzy.crudebyte.com>)
 id 1kYVfk-0003NW-8V
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=wE/8N1R/Y5ft9aFlOJdMEJqi1XpAlJXf89HVnVRNyyQ=; b=JnB2C
 Yo5v4U7ZwzamqHgr7b/uK3xsrwg7Jpvp1hwY2xHQmwPPXjtJRf7YwjEtRhEE/l1pwsRTYmCd0yflt
 72VPGqhod6P8+wBDE1a5EYhdEL+DAKAfR5s9UrQ/YNiDj9A0djryvtS08uopeO6dH05QwPsFsper2
 Z8RGSLLexAzXXy19pwAyY5Yg0kwzZL48a0IL3TTnxQJtWw+Cv9qyyTPsytaOelb4dvBc72Thjb2Zs
 Y8FAYr974QZR3gckqPtbwYF0koDg44lBrcCkUMZWEPWuvVj9O7fI7ezeOHNHKwRb5tNzABHfq/4LU
 h+dWxVIYWgvPUSJ1nE0hLl7EscSHg==;
Message-Id: <d000bdac155c2c3e38c0fcde6c7aa5a77efd44cd.1604067568.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1604067568.git.qemu_oss@crudebyte.com>
References: <cover.1604067568.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 21 Oct 2020 14:51:09 +0200
Subject: [PULL v2 15/16] tests/9pfs: add local Tlink test
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=d000bdac155c2c3e38c0fcde6c7aa5a77efd44cd@lizzy.crudebyte.com;
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

This test case uses a Tlink request to create a hard link to a regular
file using the 9pfs 'local' fs driver.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <f0d869770ad23ee5ce10f7da90fdb742cadcad72.1603285620.git.qemu_oss@crudebyte.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 71 ++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 33cba24b18..460fa49fe3 100644
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
@@ -767,6 +768,33 @@ static void v9fs_rsymlink(P9Req *req, v9fs_qid *qid)
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
@@ -1142,6 +1170,21 @@ static void do_symlink(QVirtio9P *v9p, const char *path, const char *clink,
     g_free(name);
 }
 
+/* create a hard link named @a clink in directory @a path pointing to @a to */
+static void do_hardlink(QVirtio9P *v9p, const char *path, const char *clink,
+                        const char *to)
+{
+    uint32_t dfid, fid;
+    P9Req *req;
+
+    dfid = do_walk(v9p, path);
+    fid = do_walk(v9p, to);
+
+    req = v9fs_tlink(v9p, dfid, fid, clink, 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rlink(req);
+}
+
 static void do_unlinkat(QVirtio9P *v9p, const char *atpath, const char *rpath,
                         uint32_t flags)
 {
@@ -1321,6 +1364,33 @@ static void fs_unlinkat_symlink(void *obj, void *data,
     g_free(real_file);
 }
 
+static void fs_hardlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    alloc = t_alloc;
+    struct stat st_real, st_link;
+    char *real_file = virtio_9p_test_path("07/real_file");
+    char *hardlink_file = virtio_9p_test_path("07/hardlink_file");
+
+    do_attach(v9p);
+    do_mkdir(v9p, "/", "07");
+    do_lcreate(v9p, "07", "real_file");
+    g_assert(stat(real_file, &st_real) == 0);
+    g_assert((st_real.st_mode & S_IFMT) == S_IFREG);
+
+    do_hardlink(v9p, "07", "hardlink_file", "07/real_file");
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
@@ -1367,6 +1437,7 @@ static void register_virtio_9p_test(void)
     qos_add_test("local/symlink_file", "virtio-9p", fs_symlink_file, &opts);
     qos_add_test("local/unlinkat_symlink", "virtio-9p", fs_unlinkat_symlink,
                  &opts);
+    qos_add_test("local/hardlink_file", "virtio-9p", fs_hardlink_file, &opts);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.20.1


