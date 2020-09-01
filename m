Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2E4C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D967F2071B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3jKJAS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D967F2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCzhE-00033N-V2
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 02:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCzeg-00062o-29
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 02:20:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCzed-0000mh-S7
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 02:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598941227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1ivvTlvLg7AQlWAjK0/Hz1PJE3X143Bw4l4uh4gfFc=;
 b=L3jKJAS0l5C03EY+leo/Rxqe3yE/eZIOq4zIT381zihKu2xzSIzXSWyMi7qME/nBb8gM/H
 +t9FnZZBMcd5Hh7KGhQzpoaAj/o6CBomBYTJvH/c4rN1G9fxLFojJ0hRdM6I6fDC/r57VS
 DI7GC/Mtu7S7Br/EaqkvVYlyik1jEiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-jYoUgaLfOc2_ffBE7UYHOw-1; Tue, 01 Sep 2020 02:20:25 -0400
X-MC-Unique: jYoUgaLfOc2_ffBE7UYHOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49A0A1DDF6;
 Tue,  1 Sep 2020 06:20:24 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 073211002393;
 Tue,  1 Sep 2020 06:20:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/13] vl: relocate paths to data directories
Date: Tue,  1 Sep 2020 02:20:15 -0400
Message-Id: <20200901062020.26660-9-pbonzini@redhat.com>
In-Reply-To: <20200901062020.26660-1-pbonzini@redhat.com>
References: <20200901062020.26660-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 01:27:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As an additional advantage, the logic is now unified between
POSIX and Win32 systems.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu-common.h   |  1 -
 include/sysemu/sysemu.h |  2 +-
 os-posix.c              | 20 --------------------
 os-win32.c              | 11 -----------
 softmmu/vl.c            | 40 ++++++++++++++++++++++++++++------------
 tests/qtest/fuzz/fuzz.c |  5 +++--
 6 files changed, 32 insertions(+), 47 deletions(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index bb9496bd80..b856bfcec4 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -131,7 +131,6 @@ char *qemu_find_file(int type, const char *name);
 
 /* OS specific functions */
 void os_setup_early_signal_handling(void);
-char *os_find_datadir(void);
 int os_parse_cmd_args(int index, const char *optarg);
 
 /*
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 4b6a5c459c..817ff4cf75 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -14,7 +14,7 @@ extern const char *qemu_name;
 extern QemuUUID qemu_uuid;
 extern bool qemu_uuid_set;
 
-void qemu_add_data_dir(const char *path);
+void qemu_add_data_dir(char *path);
 
 void qemu_add_exit_notifier(Notifier *notify);
 void qemu_remove_exit_notifier(Notifier *notify);
diff --git a/os-posix.c b/os-posix.c
index 8d8e7fc15c..af91089c01 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -80,26 +80,6 @@ void os_setup_signal_handling(void)
     sigaction(SIGTERM, &act, NULL);
 }
 
-/*
- * Find a likely location for support files using the location of the binary.
- * When running from the build tree this will be "$bindir/pc-bios".
- * Otherwise, this is CONFIG_QEMU_DATADIR.
- *
- * The caller must use g_free() to free the returned data when it is
- * no longer required.
- */
-char *os_find_datadir(void)
-{
-    g_autofree char *dir = NULL;
-
-    dir = g_build_filename(qemu_get_exec_dir(), "pc-bios", NULL);
-    if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
-        return g_steal_pointer(&dir);
-    }
-
-    return g_strdup(CONFIG_QEMU_DATADIR);
-}
-
 void os_set_proc_name(const char *s)
 {
 #if defined(PR_SET_NAME)
diff --git a/os-win32.c b/os-win32.c
index eb8501b9e5..fd1137bab1 100644
--- a/os-win32.c
+++ b/os-win32.c
@@ -57,17 +57,6 @@ void os_setup_early_signal_handling(void)
     atexit(os_undo_timer_resolution);
 }
 
-/*
- * Look for support files in the same directory as the executable.
- *
- * The caller must use g_free() to free the returned data when it is
- * no longer required.
- */
-char *os_find_datadir(void)
-{
-    return g_strdup(qemu_get_exec_dir());
-}
-
 void os_set_line_buffering(void)
 {
     setbuf(stdout, NULL);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 0cc86b0766..81e325fa44 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2005,7 +2005,7 @@ char *qemu_find_file(int type, const char *name)
     return NULL;
 }
 
-void qemu_add_data_dir(const char *path)
+void qemu_add_data_dir(char *path)
 {
     int i;
 
@@ -2017,10 +2017,11 @@ void qemu_add_data_dir(const char *path)
     }
     for (i = 0; i < data_dir_idx; i++) {
         if (strcmp(data_dir[i], path) == 0) {
-            return; /* duplicate */
+            g_free(path); /* duplicate */
+            return;
         }
     }
-    data_dir[data_dir_idx++] = g_strdup(path);
+    data_dir[data_dir_idx++] = path;
 }
 
 static inline bool nonempty_str(const char *str)
@@ -2829,6 +2830,26 @@ static void create_default_memdev(MachineState *ms, const char *path)
                             &error_fatal);
 }
 
+/*
+ * Find a likely location for support files using the location of the binary.
+ * When running from the build tree this will be "$bindir/pc-bios".
+ * Otherwise, this is CONFIG_QEMU_DATADIR (possibly relocated).
+ *
+ * The caller must use g_free() to free the returned data when it is
+ * no longer required.
+ */
+static char *find_datadir(void)
+{
+    g_autofree char *dir = NULL;
+
+    dir = g_build_filename(qemu_get_exec_dir(), "pc-bios", NULL);
+    if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
+        return g_steal_pointer(&dir);
+    }
+
+    return get_relocated_path(CONFIG_QEMU_DATADIR);
+}
+
 void qemu_init(int argc, char **argv, char **envp)
 {
     int i;
@@ -2862,7 +2883,7 @@ void qemu_init(int argc, char **argv, char **envp)
     Error *main_loop_err = NULL;
     Error *err = NULL;
     bool list_data_dirs = false;
-    char *dir, **dirs;
+    char **dirs;
     const char *mem_path = NULL;
     bool have_custom_ram_size;
     BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
@@ -3195,7 +3216,7 @@ void qemu_init(int argc, char **argv, char **envp)
                 if (is_help_option(optarg)) {
                     list_data_dirs = true;
                 } else {
-                    qemu_add_data_dir(optarg);
+                    qemu_add_data_dir(g_strdup(optarg));
                 }
                 break;
             case QEMU_OPTION_bios:
@@ -3927,17 +3948,12 @@ void qemu_init(int argc, char **argv, char **envp)
     /* add configured firmware directories */
     dirs = g_strsplit(CONFIG_QEMU_FIRMWAREPATH, G_SEARCHPATH_SEPARATOR_S, 0);
     for (i = 0; dirs[i] != NULL; i++) {
-        qemu_add_data_dir(dirs[i]);
+        qemu_add_data_dir(get_relocated_path(dirs[i]));
     }
     g_strfreev(dirs);
 
     /* try to find datadir relative to the executable path */
-    dir = os_find_datadir();
-    qemu_add_data_dir(dir);
-    g_free(dir);
-
-    /* add the datadir specified when building */
-    qemu_add_data_dir(CONFIG_QEMU_DATADIR);
+    qemu_add_data_dir(find_datadir());
 
     /* -L help lists the data directories and exits. */
     if (list_data_dirs) {
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index 1811cb1d88..d9ef4b3e1e 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -170,8 +170,9 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
         datadir = g_build_filename(bindir, "pc-bios", NULL);
         if (g_file_test(datadir, G_FILE_TEST_IS_DIR)) {
             qemu_add_data_dir(datadir);
-        }
-        g_free(datadir);
+        } else {
+            g_free(datadir);
+	}
     } else if (*argc > 1) {  /* The target is specified as an argument */
         target_name = (*argv)[1];
         if (!strstr(target_name, "--fuzz-target=")) {
-- 
2.26.2



