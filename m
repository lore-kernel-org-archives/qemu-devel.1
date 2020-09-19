Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF6BC43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F830208DB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLSNtHBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F830208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJfxq-0003M7-5s
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfHX-0005dH-Sk
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 12:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56517)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfHH-0007RV-0Y
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 12:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600531191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v6hVuzLmxdNrVWHNupW2COauxg+G/6js/hEZ0vqHLRU=;
 b=CLSNtHBf8xwyoVgugDOyj5xNyrmf5yMy147PHCPEImO7s2Yj2iVRDri3/EoK32czakqsW5
 b0Mi4LvFDVckmR6APvTFDX6MWqtoclSvBnkPI77+mFzR7LyT8V2YJPrWLsR50EEAVkPia8
 euXCYE64Q6O3OYNKI44GKLYnPsbZxvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-5_E2L-mbN8idU5PL7mzwPQ-1; Sat, 19 Sep 2020 11:59:49 -0400
X-MC-Unique: 5_E2L-mbN8idU5PL7mzwPQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1181D10066FE
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 15:59:49 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3EBE5576A
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 15:59:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 41/57] oslib: do not call g_strdup from qemu_get_exec_dir
Date: Sat, 19 Sep 2020 11:59:00 -0400
Message-Id: <20200919155916.1046398-42-pbonzini@redhat.com>
In-Reply-To: <20200919155916.1046398-1-pbonzini@redhat.com>
References: <20200919155916.1046398-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 11:03:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Just return the directory without requiring the caller to free it.
This also removes a bogus check for NULL in os_find_datadir and
module_load_one; g_strdup of a static variable cannot return NULL.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/osdep.h    |  8 ++------
 os-posix.c              |  6 +-----
 os-win32.c              |  2 +-
 tests/qtest/fuzz/fuzz.c |  4 ++--
 util/module.c           |  7 +------
 util/oslib-posix.c      |  8 +++++---
 util/oslib-win32.c      | 12 ++++++++----
 7 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 412962d91a..db2cfffaff 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -590,12 +590,8 @@ char *qemu_get_local_state_pathname(const char *relative_pathname);
  * Try OS specific API first, if not working, parse from argv0. */
 void qemu_init_exec_dir(const char *argv0);
 
-/* Get the saved exec dir.
- *
- * The caller is responsible for releasing the value returned with g_free()
- * after use.
- */
-char *qemu_get_exec_dir(void);
+/* Get the saved exec dir.  */
+const char *qemu_get_exec_dir(void);
 
 /**
  * qemu_getauxval:
diff --git a/os-posix.c b/os-posix.c
index bf98508b6d..8d8e7fc15c 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -90,13 +90,9 @@ void os_setup_signal_handling(void)
  */
 char *os_find_datadir(void)
 {
-    g_autofree char *exec_dir = NULL;
     g_autofree char *dir = NULL;
 
-    exec_dir = qemu_get_exec_dir();
-    g_return_val_if_fail(exec_dir != NULL, NULL);
-
-    dir = g_build_filename(exec_dir, "pc-bios", NULL);
+    dir = g_build_filename(qemu_get_exec_dir(), "pc-bios", NULL);
     if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
         return g_steal_pointer(&dir);
     }
diff --git a/os-win32.c b/os-win32.c
index c9c3afe648..eb8501b9e5 100644
--- a/os-win32.c
+++ b/os-win32.c
@@ -65,7 +65,7 @@ void os_setup_early_signal_handling(void)
  */
 char *os_find_datadir(void)
 {
-    return qemu_get_exec_dir();
+    return g_strdup(qemu_get_exec_dir());
 }
 
 void os_set_line_buffering(void)
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index 1ceea84702..e906ef9efa 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -143,7 +143,8 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
 {
 
     char *target_name;
-    char *bindir, *datadir;
+    const char *bindir;
+    char *datadir;
     bool serialize = false;
 
     /* Initialize qgraph and modules */
@@ -166,7 +167,6 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
          */
         bindir = g_path_get_dirname(**argv);
         datadir = g_build_filename(bindir, "pc-bios", NULL);
-        g_free(bindir);
         if (g_file_test(datadir, G_FILE_TEST_IS_DIR)) {
             qemu_add_data_dir(datadir);
         }
diff --git a/util/module.c b/util/module.c
index 34772e7d87..9ffe83bb32 100644
--- a/util/module.c
+++ b/util/module.c
@@ -172,7 +172,6 @@ bool module_load_one(const char *prefix, const char *lib_name)
 
 #ifdef CONFIG_MODULES
     char *fname = NULL;
-    char *exec_dir;
 #ifdef CONFIG_MODULE_UPGRADES
     char *version_dir;
 #endif
@@ -199,13 +198,12 @@ bool module_load_one(const char *prefix, const char *lib_name)
         return true;
     }
 
-    exec_dir = qemu_get_exec_dir();
     search_dir = getenv("QEMU_MODULE_DIR");
     if (search_dir != NULL) {
         dirs[n_dirs++] = g_strdup_printf("%s", search_dir);
     }
     dirs[n_dirs++] = g_strdup_printf("%s", CONFIG_QEMU_MODDIR);
-    dirs[n_dirs++] = g_strdup_printf("%s", exec_dir ? : "");
+    dirs[n_dirs++] = g_strdup(qemu_get_exec_dir());
 
 #ifdef CONFIG_MODULE_UPGRADES
     version_dir = g_strcanon(g_strdup(QEMU_PKGVERSION),
@@ -216,9 +214,6 @@ bool module_load_one(const char *prefix, const char *lib_name)
 
     assert(n_dirs <= ARRAY_SIZE(dirs));
 
-    g_free(exec_dir);
-    exec_dir = NULL;
-
     for (i = 0; i < n_dirs; i++) {
         fname = g_strdup_printf("%s/%s%s",
                 dirs[i], module_name, CONFIG_HOST_DSOSUF);
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index ad8001a4ad..0dd8d24076 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -366,7 +366,9 @@ void qemu_init_exec_dir(const char *argv0)
     char *p = NULL;
     char buf[PATH_MAX];
 
-    assert(!exec_dir[0]);
+    if (exec_dir[0]) {
+        return;
+    }
 
 #if defined(__linux__)
     {
@@ -439,9 +441,9 @@ void qemu_init_exec_dir(const char *argv0)
     g_free(dir);
 }
 
-char *qemu_get_exec_dir(void)
+const char *qemu_get_exec_dir(void)
 {
-    return g_strdup(exec_dir);
+    return exec_dir;
 }
 
 static void sigbus_handler(int signal)
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index c654dafd93..1a33912944 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -315,7 +315,7 @@ void qemu_set_tty_echo(int fd, bool echo)
     }
 }
 
-static char exec_dir[PATH_MAX];
+static char *exec_dir;
 
 void qemu_init_exec_dir(const char *argv0)
 {
@@ -324,6 +324,10 @@ void qemu_init_exec_dir(const char *argv0)
     char buf[MAX_PATH];
     DWORD len;
 
+    if (exec_dir) {
+        return;
+    }
+
     len = GetModuleFileName(NULL, buf, sizeof(buf) - 1);
     if (len == 0) {
         return;
@@ -336,13 +340,13 @@ void qemu_init_exec_dir(const char *argv0)
     }
     *p = 0;
     if (access(buf, R_OK) == 0) {
-        pstrcpy(exec_dir, sizeof(exec_dir), buf);
+        exec_dir = g_strdup(buf);
     }
 }
 
-char *qemu_get_exec_dir(void)
+const char *qemu_get_exec_dir(void)
 {
-    return g_strdup(exec_dir);
+    return exec_dir;
 }
 
 #if !GLIB_CHECK_VERSION(2, 50, 0)
-- 
2.26.2



