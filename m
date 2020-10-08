Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1C7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D07221FE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="JR5A0yr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D07221FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQbkC-0007VU-KE
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 15:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <be342f236842272275f65dbe05587f0a5409ad77@lizzy.crudebyte.com>)
 id 1kQbj1-0006zP-W0
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:37:16 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:42847)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <be342f236842272275f65dbe05587f0a5409ad77@lizzy.crudebyte.com>)
 id 1kQbiz-0007wn-VL
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=ePtsKC4aFi7jGHFiSRI09MokuHMPuECH1mLHa2h/FG4=; b=JR5A0
 yr2ZZ0wMwJaCswuM3mci+SUSowug5bo/xscfqY5wdcWGivVaQLwA63LU1GksSNPzZgF0laLSs1I4v
 l55494bjsp1yaekWNxhPSrU8H7r6U9Q0feKRfhyCTCW2ab+Mhvc2C2fAc/Xxo2tEXI/iUbqOVcb4K
 crAiG3S+hqmYULJvPh47tk01yUqXLhRKGHpppTDpG307wL1dlDtMNoM2lfXzRZMxcPviIXbmKa8ae
 Lerlh8NASYMOCjMzv/m6t3BZaY+fa+GbntZTtdZU4g5w7WTBMkUoihjB33FuCNP+m5U3PZk53QlcU
 ntngcInSINTLvU9T40xSw4nWy+TlA==;
Message-Id: <be342f236842272275f65dbe05587f0a5409ad77.1602182956.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1602182956.git.qemu_oss@crudebyte.com>
References: <cover.1602182956.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 8 Oct 2020 20:34:56 +0200
Subject: [PATCH v4 12/12] tests/9pfs: add local Tmkdir test
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
    Laurent Vivier <lvivier@redhat.com>,
    Paolo Bonzini <pbonzini@redhat.com>,
    Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
    Greg Kurz <groug@kaod.org>,
    "Daniel P. Berrangé" <berrange@redhat.com>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=be342f236842272275f65dbe05587f0a5409ad77@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 15:12:00
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

This test case uses the 9pfs 'local' driver to create a directory
and then checks if the expected directory was actually created
(as real directory) on host side.

This patch introduces a custom split() implementation, because
the test code requires non empty array elements as result. For
that reason g_strsplit() would not be a good alternative, as
it would require additional filter code for reshuffling the
array, and the resulting code would be even more complex than
this split() function.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 139 +++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index af7e169d3a..c15908f27b 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -18,6 +18,62 @@
 #define QVIRTIO_9P_TIMEOUT_US (10 * 1000 * 1000)
 static QGuestAllocator *alloc;
 
+/*
+ * Used to auto generate new fids. Start with arbitrary high value to avoid
+ * collision with hard coded fids in basic test code.
+ */
+static uint32_t fid_generator = 1000;
+
+static uint32_t genfid(void)
+{
+    return fid_generator++;
+}
+
+/**
+ * Splits the @a in string by @a delim into individual (non empty) strings
+ * and outputs them to @a out. The output array @a out is NULL terminated.
+ *
+ * Output array @a out must be freed by calling split_free().
+ *
+ * @returns number of individual elements in output array @a out (without the
+ *          final NULL terminating element)
+ */
+static int split(const char *in, const char *delim, char ***out)
+{
+    int n = 0, i = 0;
+    char *tmp, *p;
+
+    tmp = g_strdup(in);
+    for (p = strtok(tmp, delim); p != NULL; p = strtok(NULL, delim)) {
+        if (strlen(p) > 0) {
+            ++n;
+        }
+    }
+    g_free(tmp);
+
+    *out = g_new0(char *, n + 1); /* last element NULL delimiter */
+
+    tmp = g_strdup(in);
+    for (p = strtok(tmp, delim); p != NULL; p = strtok(NULL, delim)) {
+        if (strlen(p) > 0) {
+            (*out)[i++] = g_strdup(p);
+        }
+    }
+    g_free(tmp);
+
+    return n;
+}
+
+static void split_free(char ***out)
+{
+    int i;
+    for (i = 0; (*out)[i]; ++i) {
+        g_free((*out)[i]);
+    }
+    g_free(*out);
+    *out = NULL;
+}
+
 static void pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
@@ -201,6 +257,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RWALK ? "RWALK" :
         id == P9_RLOPEN ? "RLOPEN" :
         id == P9_RWRITE ? "RWRITE" :
+        id == P9_RMKDIR ? "RMKDIR" :
         id == P9_RFLUSH ? "RFLUSH" :
         id == P9_RREADDIR ? "READDIR" :
         "<unknown>";
@@ -578,6 +635,39 @@ static bool fs_dirents_contain_name(struct V9fsDirent *e, const char* name)
     return false;
 }
 
+/* size[4] Tmkdir tag[2] dfid[4] name[s] mode[4] gid[4] */
+static P9Req *v9fs_tmkdir(QVirtio9P *v9p, uint32_t dfid, const char *name,
+                          uint32_t mode, uint32_t gid, uint16_t tag)
+{
+    P9Req *req;
+
+    uint32_t body_size = 4 + 4 + 4;
+    uint16_t string_size = v9fs_string_size(name);
+
+    g_assert_cmpint(body_size, <=, UINT32_MAX - string_size);
+    body_size += string_size;
+
+    req = v9fs_req_init(v9p, body_size, P9_TMKDIR, tag);
+    v9fs_uint32_write(req, dfid);
+    v9fs_string_write(req, name);
+    v9fs_uint32_write(req, mode);
+    v9fs_uint32_write(req, gid);
+    v9fs_req_send(req);
+    return req;
+}
+
+/* size[4] Rmkdir tag[2] qid[13] */
+static void v9fs_rmkdir(P9Req *req, v9fs_qid *qid)
+{
+    v9fs_req_recv(req, P9_RMKDIR);
+    if (qid) {
+        v9fs_memread(req, qid, 13);
+    } else {
+        v9fs_memskip(req, 13);
+    }
+    v9fs_req_free(req);
+}
+
 /* basic readdir test where reply fits into a single response message */
 static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
 {
@@ -877,6 +967,30 @@ static void fs_flush_ignored(void *obj, void *data, QGuestAllocator *t_alloc)
     g_free(wnames[0]);
 }
 
+static void fs_mkdir(void *obj, void *data, QGuestAllocator *t_alloc,
+                     const char *path, const char *cname)
+{
+    QVirtio9P *v9p = obj;
+    alloc = t_alloc;
+    char **wnames;
+    char *const name = g_strdup(cname);
+    P9Req *req;
+    const uint32_t fid = genfid();
+
+    int nwnames = split(path, "/", &wnames);
+
+    req = v9fs_twalk(v9p, 0, fid, nwnames, wnames, 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rwalk(req, NULL, NULL);
+
+    req = v9fs_tmkdir(v9p, fid, name, 0750, 0, 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rmkdir(req, NULL);
+
+    g_free(name);
+    split_free(&wnames);
+}
+
 static void fs_readdir_split_128(void *obj, void *data,
                                  QGuestAllocator *t_alloc)
 {
@@ -895,6 +1009,30 @@ static void fs_readdir_split_512(void *obj, void *data,
     fs_readdir_split(obj, data, t_alloc, 512);
 }
 
+
+/* tests using the 9pfs 'local' fs driver */
+
+static void fs_create_dir(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    struct stat st;
+    char *root_path = virtio_9p_test_path("");
+    char *new_dir = virtio_9p_test_path("01");
+
+    g_assert(root_path != NULL);
+
+    fs_attach(v9p, NULL, t_alloc);
+    fs_mkdir(v9p, data, t_alloc, "/", "01");
+
+    /* check if created directory really exists now ... */
+    g_assert(stat(new_dir, &st) == 0);
+    /* ... and is actually a directory */
+    g_assert((st.st_mode & S_IFMT) == S_IFDIR);
+
+    g_free(new_dir);
+    g_free(root_path);
+}
+
 static void *assign_9p_local_driver(GString *cmd_line, void *arg)
 {
     virtio_9p_assign_local_driver(cmd_line, "security_model=mapped-xattr");
@@ -934,6 +1072,7 @@ static void register_virtio_9p_test(void)
     /* 9pfs test cases using the 'local' filesystem driver */
     opts.before = assign_9p_local_driver;
     qos_add_test("local/config", "virtio-9p", pci_config,  &opts);
+    qos_add_test("local/create_dir", "virtio-9p", fs_create_dir, &opts);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.20.1


