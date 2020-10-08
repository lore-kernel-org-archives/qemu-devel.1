Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43074C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92C4A21789
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="d7r8eBY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C4A21789
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQbQV-0003Eb-H5
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 15:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <81fc4b3b6b6c9bf7999e79f5e7cbc364a5f09ddb@lizzy.crudebyte.com>)
 id 1kQbMj-00075h-6f
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:14:14 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:59949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <81fc4b3b6b6c9bf7999e79f5e7cbc364a5f09ddb@lizzy.crudebyte.com>)
 id 1kQbMf-0005KR-QG
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=yWCyjpMX6/vDhFgq9a+1Ll6Hc2MmzCRgMNYo8rlkO2s=; b=d7r8e
 BY8tDE3UYQmbnOF0uIz/XQ1VOxFHMOrDiCCti4vdxwOXXQoGFdAOrtv5oJbrK3cXNDPgIOvO72xXI
 1Pgk6m/2uKlsCjfeVRFiHqGkVVeaCWeyOW/4RBblPCwGz/W6mY+onrCCboMDjZ5cq46PRJi8RbexG
 OyyWtZ5iWCiFxQ+C0tginNGPDa0XfgbFQqilLCsMYFYPBw9zpElTH+4MyMCRk35/R6qeXjkSa8sAc
 AXZ4ZgH2z7bgKy/htPOjtWxlj2aNmRlwFDNwkxqwza/WRRNO/ZKQBphKXS6Sbj56WIbHWryBuBQ0i
 h2S8uzaPm85vDkTJU++koCrOzqvfA==;
Message-Id: <81fc4b3b6b6c9bf7999e79f5e7cbc364a5f09ddb.1602182956.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1602182956.git.qemu_oss@crudebyte.com>
References: <cover.1602182956.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 8 Oct 2020 20:34:56 +0200
Subject: [PATCH v4 09/12] tests/9pfs: introduce local tests
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
    Laurent Vivier <lvivier@redhat.com>,
    Paolo Bonzini <pbonzini@redhat.com>,
    Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
    Greg Kurz <groug@kaod.org>,
    "Daniel P. Berrangé" <berrange@redhat.com>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=81fc4b3b6b6c9bf7999e79f5e7cbc364a5f09ddb@lizzy.crudebyte.com;
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

This patch introduces 9pfs test cases using the 9pfs 'local'
filesystem driver which reads/writes/creates/deletes real files
and directories.

In this initial version, there is only one local test which actually
only checks if the 9pfs 'local' device was created successfully.

Before the 9pfs 'local' tests are run, a test directory 'qtest-9p-local'
is created (with world rwx permissions) under the current working
directory. At this point that test directory is not auto deleted yet.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p.c | 81 ++++++++++++++++++++++++++++++++++
 tests/qtest/libqos/virtio-9p.h |  5 +++
 tests/qtest/virtio-9p-test.c   | 44 ++++++++++++------
 3 files changed, 116 insertions(+), 14 deletions(-)

diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
index 2e300063e3..9cb284cb3c 100644
--- a/tests/qtest/libqos/virtio-9p.c
+++ b/tests/qtest/libqos/virtio-9p.c
@@ -24,6 +24,34 @@
 #include "qgraph.h"
 
 static QGuestAllocator *alloc;
+static char *local_test_path;
+
+/* Concatenates the passed 2 pathes. Returned result must be freed. */
+static char *concat_path(const char* a, const char* b)
+{
+    return g_build_filename(a, b, NULL);
+}
+
+static void init_local_test_path(void)
+{
+    char *pwd = get_current_dir_name();
+    local_test_path = concat_path(pwd, "qtest-9p-local");
+    free(pwd);
+}
+
+/* Creates the directory for the 9pfs 'local' filesystem driver to access. */
+static void create_local_test_dir(void)
+{
+    struct stat st;
+
+    g_assert(local_test_path != NULL);
+    mkdir(local_test_path, 0777);
+
+    /* ensure test directory exists now ... */
+    g_assert(stat(local_test_path, &st) == 0);
+    /* ... and is actually a directory */
+    g_assert((st.st_mode & S_IFMT) == S_IFDIR);
+}
 
 static void virtio_9p_cleanup(QVirtio9P *interface)
 {
@@ -146,11 +174,64 @@ static void *virtio_9p_pci_create(void *pci_bus, QGuestAllocator *t_alloc,
     return obj;
 }
 
+/**
+ * Performs regular expression based search and replace on @a haystack.
+ *
+ * @param haystack - input string to be parsed, result of replacement is
+ *                   stored back to @a haystack
+ * @param pattern - the regular expression pattern for scanning @a haystack
+ * @param replace_fmt - matches of supplied @a pattern are replaced by this,
+ *                      if necessary glib printf format can be used to add
+ *                      variable arguments of this function to this
+ *                      replacement string
+ */
+static void regex_replace(GString *haystack, const char *pattern,
+                          const char *replace_fmt, ...)
+{
+    GRegex *regex;
+    char *replace, *s;
+    va_list argp;
+
+    va_start(argp, replace_fmt);
+    replace = g_strdup_vprintf(replace_fmt, argp);
+    va_end(argp);
+
+    regex = g_regex_new(pattern, 0, 0, NULL);
+    s = g_regex_replace(regex, haystack->str, -1, 0, replace, 0, NULL);
+    g_string_assign(haystack, s);
+    g_free(s);
+    g_regex_unref(regex);
+    g_free(replace);
+}
+
+void virtio_9p_assign_local_driver(GString *cmd_line, const char *args)
+{
+    g_assert_nonnull(local_test_path);
+
+    /* replace 'synth' driver by 'local' driver */
+    regex_replace(cmd_line, "-fsdev synth,", "-fsdev local,");
+
+    /* append 'path=...' to '-fsdev ...' group */
+    regex_replace(cmd_line, "(-fsdev \\w[^ ]*)", "\\1,path='%s'",
+                  local_test_path);
+
+    if (!args) {
+        return;
+    }
+
+    /* append passed args to '-fsdev ...' group */
+    regex_replace(cmd_line, "(-fsdev \\w[^ ]*)", "\\1,%s", args);
+}
+
 static void virtio_9p_register_nodes(void)
 {
     const char *str_simple = "fsdev=fsdev0,mount_tag=" MOUNT_TAG;
     const char *str_addr = "fsdev=fsdev0,addr=04.0,mount_tag=" MOUNT_TAG;
 
+    /* make sure test dir for the 'local' tests exists and is clean */
+    init_local_test_path();
+    create_local_test_dir();
+
     QPCIAddress addr = {
         .devfn = QPCI_DEVFN(4, 0),
     };
diff --git a/tests/qtest/libqos/virtio-9p.h b/tests/qtest/libqos/virtio-9p.h
index b1e6badc4a..326a603f72 100644
--- a/tests/qtest/libqos/virtio-9p.h
+++ b/tests/qtest/libqos/virtio-9p.h
@@ -44,4 +44,9 @@ struct QVirtio9PDevice {
     QVirtio9P v9p;
 };
 
+/**
+ * Prepares QEMU command line for 9pfs tests using the 'local' fs driver.
+ */
+void virtio_9p_assign_local_driver(GString *cmd_line, const char *args);
+
 #endif
diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 3281153b9c..af7e169d3a 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -895,29 +895,45 @@ static void fs_readdir_split_512(void *obj, void *data,
     fs_readdir_split(obj, data, t_alloc, 512);
 }
 
+static void *assign_9p_local_driver(GString *cmd_line, void *arg)
+{
+    virtio_9p_assign_local_driver(cmd_line, "security_model=mapped-xattr");
+    return arg;
+}
+
 static void register_virtio_9p_test(void)
 {
-    qos_add_test("synth/config", "virtio-9p", pci_config, NULL);
-    qos_add_test("synth/version/basic", "virtio-9p", fs_version, NULL);
-    qos_add_test("synth/attach/basic", "virtio-9p", fs_attach, NULL);
-    qos_add_test("synth/walk/basic", "virtio-9p", fs_walk, NULL);
+
+    QOSGraphTestOptions opts = {
+    };
+
+    /* 9pfs test cases using the 'synth' filesystem driver */
+    qos_add_test("synth/config", "virtio-9p", pci_config, &opts);
+    qos_add_test("synth/version/basic", "virtio-9p", fs_version,  &opts);
+    qos_add_test("synth/attach/basic", "virtio-9p", fs_attach,  &opts);
+    qos_add_test("synth/walk/basic", "virtio-9p", fs_walk,  &opts);
     qos_add_test("synth/walk/no_slash", "virtio-9p", fs_walk_no_slash,
-                 NULL);
+                  &opts);
     qos_add_test("synth/walk/dotdot_from_root", "virtio-9p",
-                 fs_walk_dotdot, NULL);
-    qos_add_test("synth/lopen/basic", "virtio-9p", fs_lopen, NULL);
-    qos_add_test("synth/write/basic", "virtio-9p", fs_write, NULL);
+                 fs_walk_dotdot,  &opts);
+    qos_add_test("synth/lopen/basic", "virtio-9p", fs_lopen,  &opts);
+    qos_add_test("synth/write/basic", "virtio-9p", fs_write,  &opts);
     qos_add_test("synth/flush/success", "virtio-9p", fs_flush_success,
-                 NULL);
+                  &opts);
     qos_add_test("synth/flush/ignored", "virtio-9p", fs_flush_ignored,
-                 NULL);
-    qos_add_test("synth/readdir/basic", "virtio-9p", fs_readdir, NULL);
+                  &opts);
+    qos_add_test("synth/readdir/basic", "virtio-9p", fs_readdir,  &opts);
     qos_add_test("synth/readdir/split_512", "virtio-9p",
-                 fs_readdir_split_512, NULL);
+                 fs_readdir_split_512,  &opts);
     qos_add_test("synth/readdir/split_256", "virtio-9p",
-                 fs_readdir_split_256, NULL);
+                 fs_readdir_split_256,  &opts);
     qos_add_test("synth/readdir/split_128", "virtio-9p",
-                 fs_readdir_split_128, NULL);
+                 fs_readdir_split_128,  &opts);
+
+
+    /* 9pfs test cases using the 'local' filesystem driver */
+    opts.before = assign_9p_local_driver;
+    qos_add_test("local/config", "virtio-9p", pci_config,  &opts);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.20.1


