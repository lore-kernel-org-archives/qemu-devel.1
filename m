Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38F6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:10:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6419E2070C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnYo9aGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6419E2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqx76-0008Nv-II
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 07:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqx67-0006WN-2w
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:09:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38603
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqx63-0000yy-Cw
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593688178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WqsUNPdvVPrSeQBT7SD9EG91ASwWpWM4zBsvJolu33g=;
 b=OnYo9aGneSJqwATXcqkzNmpsCMQo/wMq1zfMuRlfpxEIzwiF5pW8+U040MP12uHwdhhGvh
 Ocozqv01T07XKTE+LKLbZUjga+z1+rwHwxcl+wc8qRCm19EbPrdiVMznr6oG2x10m4bCR9
 Co7ra5rG1ao7iOnUvSS2vkdYXnQk+nE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-BVYEmo_1OWmCkujBqN9I8A-1; Thu, 02 Jul 2020 07:09:36 -0400
X-MC-Unique: BVYEmo_1OWmCkujBqN9I8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FBD28015F3
 for <qemu-devel@nongnu.org>; Thu,  2 Jul 2020 11:09:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B74DF5C1D6;
 Thu,  2 Jul 2020 11:09:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A4CBF1138472; Thu,  2 Jul 2020 13:09:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/28] tests: Use &error_abort where appropriate
Date: Thu,  2 Jul 2020 13:09:09 +0200
Message-Id: <20200702110931.2953148-7-armbru@redhat.com>
In-Reply-To: <20200702110931.2953148-1-armbru@redhat.com>
References: <20200702110931.2953148-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Receiving the error in a local variable only to assert there is none
is less clear than passing &error_abort.  Clean up.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200630090351.1247703-5-armbru@redhat.com>
---
 tests/check-qobject.c              |   5 +-
 tests/check-qom-proplist.c         |   7 +-
 tests/test-logging.c               |  12 +---
 tests/test-qemu-opts.c             |  22 ++----
 tests/test-replication.c           | 109 +++++++++--------------------
 tests/test-string-input-visitor.c  |  33 +++------
 tests/test-string-output-visitor.c |  16 ++---
 7 files changed, 59 insertions(+), 145 deletions(-)

diff --git a/tests/check-qobject.c b/tests/check-qobject.c
index 593c3a0618..6b6deaeb8b 100644
--- a/tests/check-qobject.c
+++ b/tests/check-qobject.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "block/qdict.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
@@ -213,7 +214,6 @@ static void qobject_is_equal_list_test(void)
 
 static void qobject_is_equal_dict_test(void)
 {
-    Error *local_err = NULL;
     QDict *dict_0, *dict_1, *dict_cloned;
     QDict *dict_different_key, *dict_different_value, *dict_different_null_key;
     QDict *dict_longer, *dict_shorter, *dict_nested;
@@ -276,8 +276,7 @@ static void qobject_is_equal_dict_test(void)
                   dict_different_null_key, dict_longer, dict_shorter,
                   dict_nested);
 
-    dict_crumpled = qobject_to(QDict, qdict_crumple(dict_1, &local_err));
-    g_assert(!local_err);
+    dict_crumpled = qobject_to(QDict, qdict_crumple(dict_1, &error_abort));
     check_equal(dict_crumpled, dict_nested);
 
     qdict_flatten(dict_nested);
diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index 13a824cfae..8c71734e1a 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -419,9 +419,7 @@ static void test_dummy_createcmdl(void)
     g_assert(dobj->bv == true);
     g_assert(dobj->av == DUMMY_PLATYPUS);
 
-    user_creatable_del("dev0", &err);
-    g_assert(err == NULL);
-    error_free(err);
+    user_creatable_del("dev0", &error_abort);
 
     object_unref(OBJECT(dobj));
 
@@ -485,8 +483,7 @@ static void test_dummy_getenum(void)
     val = object_property_get_enum(OBJECT(dobj),
                                    "av",
                                    "DummyAnimal",
-                                   &err);
-    g_assert(err == NULL);
+                                   &error_abort);
     g_assert(val == DUMMY_PLATYPUS);
 
     /* A bad enum type name */
diff --git a/tests/test-logging.c b/tests/test-logging.c
index 8580b82420..8a1161de1d 100644
--- a/tests/test-logging.c
+++ b/tests/test-logging.c
@@ -113,7 +113,6 @@ static void test_logfile_write(gconstpointer data)
     QemuLogFile *logfile;
     QemuLogFile *logfile2;
     gchar const *dir = data;
-    Error *err = NULL;
     g_autofree gchar *file_path = NULL;
     g_autofree gchar *file_path1 = NULL;
     FILE *orig_fd;
@@ -132,8 +131,7 @@ static void test_logfile_write(gconstpointer data)
      * Test that even if an open file handle is changed,
      * our handle remains valid due to RCU.
      */
-    qemu_set_log_filename(file_path, &err);
-    g_assert(!err);
+    qemu_set_log_filename(file_path, &error_abort);
     rcu_read_lock();
     logfile = atomic_rcu_read(&qemu_logfile);
     orig_fd = logfile->fd;
@@ -142,8 +140,7 @@ static void test_logfile_write(gconstpointer data)
     fflush(logfile->fd);
 
     /* Change the logfile and ensure that the handle is still valid. */
-    qemu_set_log_filename(file_path1, &err);
-    g_assert(!err);
+    qemu_set_log_filename(file_path1, &error_abort);
     logfile2 = atomic_rcu_read(&qemu_logfile);
     g_assert(logfile->fd == orig_fd);
     g_assert(logfile2->fd != logfile->fd);
@@ -156,7 +153,6 @@ static void test_logfile_lock(gconstpointer data)
 {
     FILE *logfile;
     gchar const *dir = data;
-    Error *err = NULL;
     g_autofree gchar *file_path = NULL;
 
     file_path = g_build_filename(dir, "qemu_test_logfile_lock0.log", NULL);
@@ -166,7 +162,7 @@ static void test_logfile_lock(gconstpointer data)
      * that even if an open file handle is closed,
      * our handle remains valid for use due to RCU.
      */
-    qemu_set_log_filename(file_path, &err);
+    qemu_set_log_filename(file_path, &error_abort);
     logfile = qemu_log_lock();
     g_assert(logfile);
     fprintf(logfile, "%s 1st write to file\n", __func__);
@@ -180,8 +176,6 @@ static void test_logfile_lock(gconstpointer data)
     fprintf(logfile, "%s 2nd write to file\n", __func__);
     fflush(logfile);
     qemu_log_unlock(logfile);
-
-    g_assert(!err);
 }
 
 /* Remove a directory and all its entries (non-recursive). */
diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index 2a0f42a09b..297ffe79dd 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -187,7 +187,6 @@ static void test_qemu_opt_get(void)
 
 static void test_qemu_opt_get_bool(void)
 {
-    Error *err = NULL;
     QemuOptsList *list;
     QemuOpts *opts;
     bool opt;
@@ -210,16 +209,14 @@ static void test_qemu_opt_get_bool(void)
     opt = qemu_opt_get_bool(opts, "bool1", false);
     g_assert(opt == false);
 
-    qemu_opt_set_bool(opts, "bool1", true, &err);
-    g_assert(!err);
+    qemu_opt_set_bool(opts, "bool1", true, &error_abort);
 
     /* now we have set bool1, should know about it */
     opt = qemu_opt_get_bool(opts, "bool1", false);
     g_assert(opt == true);
 
     /* having reset the value, opt should be the reset one not defval */
-    qemu_opt_set_bool(opts, "bool1", false, &err);
-    g_assert(!err);
+    qemu_opt_set_bool(opts, "bool1", false, &error_abort);
 
     opt = qemu_opt_get_bool(opts, "bool1", true);
     g_assert(opt == false);
@@ -233,7 +230,6 @@ static void test_qemu_opt_get_bool(void)
 
 static void test_qemu_opt_get_number(void)
 {
-    Error *err = NULL;
     QemuOptsList *list;
     QemuOpts *opts;
     uint64_t opt;
@@ -256,16 +252,14 @@ static void test_qemu_opt_get_number(void)
     opt = qemu_opt_get_number(opts, "number1", 5);
     g_assert(opt == 5);
 
-    qemu_opt_set_number(opts, "number1", 10, &err);
-    g_assert(!err);
+    qemu_opt_set_number(opts, "number1", 10, &error_abort);
 
     /* now we have set number1, should know about it */
     opt = qemu_opt_get_number(opts, "number1", 5);
     g_assert(opt == 10);
 
     /* having reset it, the returned should be the reset one not defval */
-    qemu_opt_set_number(opts, "number1", 15, &err);
-    g_assert(!err);
+    qemu_opt_set_number(opts, "number1", 15, &error_abort);
 
     opt = qemu_opt_get_number(opts, "number1", 5);
     g_assert(opt == 15);
@@ -367,7 +361,6 @@ static void test_qemu_opt_unset(void)
 
 static void test_qemu_opts_reset(void)
 {
-    Error *err = NULL;
     QemuOptsList *list;
     QemuOpts *opts;
     uint64_t opt;
@@ -390,8 +383,7 @@ static void test_qemu_opts_reset(void)
     opt = qemu_opt_get_number(opts, "number1", 5);
     g_assert(opt == 5);
 
-    qemu_opt_set_number(opts, "number1", 10, &err);
-    g_assert(!err);
+    qemu_opt_set_number(opts, "number1", 10, &error_abort);
 
     /* now we have set number1, should know about it */
     opt = qemu_opt_get_number(opts, "number1", 5);
@@ -406,7 +398,6 @@ static void test_qemu_opts_reset(void)
 
 static void test_qemu_opts_set(void)
 {
-    Error *err = NULL;
     QemuOptsList *list;
     QemuOpts *opts;
     const char *opt;
@@ -421,8 +412,7 @@ static void test_qemu_opts_set(void)
     g_assert(opts == NULL);
 
     /* implicitly create opts and set str3 value */
-    qemu_opts_set(list, NULL, "str3", "value", &err);
-    g_assert(!err);
+    qemu_opts_set(list, NULL, "str3", "value", &error_abort);
     g_assert(!QTAILQ_EMPTY(&list->head));
 
     /* get the just created opts */
diff --git a/tests/test-replication.c b/tests/test-replication.c
index cbc37db2df..e0b03dafc2 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -139,8 +139,6 @@ static void make_temp(char *template)
 
 static void prepare_imgs(void)
 {
-    Error *local_err = NULL;
-
     make_temp(p_local_disk);
     make_temp(s_local_disk);
     make_temp(s_active_disk);
@@ -148,19 +146,15 @@ static void prepare_imgs(void)
 
     /* Primary */
     bdrv_img_create(p_local_disk, "qcow2", NULL, NULL, NULL, IMG_SIZE,
-                    BDRV_O_RDWR, true, &local_err);
-    g_assert(!local_err);
+                    BDRV_O_RDWR, true, &error_abort);
 
     /* Secondary */
     bdrv_img_create(s_local_disk, "qcow2", NULL, NULL, NULL, IMG_SIZE,
-                    BDRV_O_RDWR, true, &local_err);
-    g_assert(!local_err);
+                    BDRV_O_RDWR, true, &error_abort);
     bdrv_img_create(s_active_disk, "qcow2", NULL, NULL, NULL, IMG_SIZE,
-                    BDRV_O_RDWR, true, &local_err);
-    g_assert(!local_err);
+                    BDRV_O_RDWR, true, &error_abort);
     bdrv_img_create(s_hidden_disk, "qcow2", NULL, NULL, NULL, IMG_SIZE,
-                    BDRV_O_RDWR, true, &local_err);
-    g_assert(!local_err);
+                    BDRV_O_RDWR, true, &error_abort);
 }
 
 static void cleanup_imgs(void)
@@ -179,7 +173,6 @@ static BlockBackend *start_primary(void)
     BlockBackend *blk;
     QemuOpts *opts;
     QDict *qdict;
-    Error *local_err = NULL;
     char *cmdline;
 
     cmdline = g_strdup_printf("driver=replication,mode=primary,node-name=xxx,"
@@ -193,12 +186,10 @@ static BlockBackend *start_primary(void)
     qdict_set_default_str(qdict, BDRV_OPT_CACHE_DIRECT, "off");
     qdict_set_default_str(qdict, BDRV_OPT_CACHE_NO_FLUSH, "off");
 
-    blk = blk_new_open(NULL, NULL, qdict, BDRV_O_RDWR, &local_err);
+    blk = blk_new_open(NULL, NULL, qdict, BDRV_O_RDWR, &error_abort);
     g_assert(blk);
-    g_assert(!local_err);
 
-    monitor_add_blk(blk, P_ID, &local_err);
-    g_assert(!local_err);
+    monitor_add_blk(blk, P_ID, &error_abort);
 
     qemu_opts_del(opts);
 
@@ -248,12 +239,10 @@ static void test_primary_write(void)
 static void test_primary_start(void)
 {
     BlockBackend *blk = NULL;
-    Error *local_err = NULL;
 
     blk = start_primary();
 
-    replication_start_all(REPLICATION_MODE_PRIMARY, &local_err);
-    g_assert(!local_err);
+    replication_start_all(REPLICATION_MODE_PRIMARY, &error_abort);
 
     /* read from 0 to IMG_SIZE */
     test_blk_read(blk, 0, 0, IMG_SIZE, 0, IMG_SIZE, true);
@@ -266,46 +255,35 @@ static void test_primary_start(void)
 
 static void test_primary_stop(void)
 {
-    Error *local_err = NULL;
     bool failover = true;
 
     start_primary();
 
-    replication_start_all(REPLICATION_MODE_PRIMARY, &local_err);
-    g_assert(!local_err);
+    replication_start_all(REPLICATION_MODE_PRIMARY, &error_abort);
 
-    replication_stop_all(failover, &local_err);
-    g_assert(!local_err);
+    replication_stop_all(failover, &error_abort);
 
     teardown_primary();
 }
 
 static void test_primary_do_checkpoint(void)
 {
-    Error *local_err = NULL;
-
     start_primary();
 
-    replication_start_all(REPLICATION_MODE_PRIMARY, &local_err);
-    g_assert(!local_err);
+    replication_start_all(REPLICATION_MODE_PRIMARY, &error_abort);
 
-    replication_do_checkpoint_all(&local_err);
-    g_assert(!local_err);
+    replication_do_checkpoint_all(&error_abort);
 
     teardown_primary();
 }
 
 static void test_primary_get_error_all(void)
 {
-    Error *local_err = NULL;
-
     start_primary();
 
-    replication_start_all(REPLICATION_MODE_PRIMARY, &local_err);
-    g_assert(!local_err);
+    replication_start_all(REPLICATION_MODE_PRIMARY, &error_abort);
 
-    replication_get_error_all(&local_err);
-    g_assert(!local_err);
+    replication_get_error_all(&error_abort);
 
     teardown_primary();
 }
@@ -316,7 +294,6 @@ static BlockBackend *start_secondary(void)
     QDict *qdict;
     BlockBackend *blk;
     char *cmdline;
-    Error *local_err = NULL;
 
     /* add s_local_disk and forge S_LOCAL_DISK_ID */
     cmdline = g_strdup_printf("file.filename=%s,driver=qcow2,"
@@ -329,10 +306,9 @@ static BlockBackend *start_secondary(void)
     qdict_set_default_str(qdict, BDRV_OPT_CACHE_DIRECT, "off");
     qdict_set_default_str(qdict, BDRV_OPT_CACHE_NO_FLUSH, "off");
 
-    blk = blk_new_open(NULL, NULL, qdict, BDRV_O_RDWR, &local_err);
+    blk = blk_new_open(NULL, NULL, qdict, BDRV_O_RDWR, &error_abort);
     assert(blk);
-    monitor_add_blk(blk, S_LOCAL_DISK_ID, &local_err);
-    g_assert(!local_err);
+    monitor_add_blk(blk, S_LOCAL_DISK_ID, &error_abort);
 
     /* format s_local_disk with pattern "0x11" */
     test_blk_write(blk, 0x11, 0, IMG_SIZE, false);
@@ -356,10 +332,9 @@ static BlockBackend *start_secondary(void)
     qdict_set_default_str(qdict, BDRV_OPT_CACHE_DIRECT, "off");
     qdict_set_default_str(qdict, BDRV_OPT_CACHE_NO_FLUSH, "off");
 
-    blk = blk_new_open(NULL, NULL, qdict, BDRV_O_RDWR, &local_err);
+    blk = blk_new_open(NULL, NULL, qdict, BDRV_O_RDWR, &error_abort);
     assert(blk);
-    monitor_add_blk(blk, S_ID, &local_err);
-    g_assert(!local_err);
+    monitor_add_blk(blk, S_ID, &error_abort);
 
     qemu_opts_del(opts);
 
@@ -420,12 +395,10 @@ static void test_secondary_write(void)
 static void test_secondary_start(void)
 {
     BlockBackend *top_blk, *local_blk;
-    Error *local_err = NULL;
     bool failover = true;
 
     top_blk = start_secondary();
-    replication_start_all(REPLICATION_MODE_SECONDARY, &local_err);
-    g_assert(!local_err);
+    replication_start_all(REPLICATION_MODE_SECONDARY, &error_abort);
 
     /* read from s_local_disk (0, IMG_SIZE) */
     test_blk_read(top_blk, 0x11, 0, IMG_SIZE, 0, IMG_SIZE, false);
@@ -446,8 +419,7 @@ static void test_secondary_start(void)
                   0, IMG_SIZE / 2, false);
 
     /* unblock top_bs */
-    replication_stop_all(failover, &local_err);
-    g_assert(!local_err);
+    replication_stop_all(failover, &error_abort);
 
     teardown_secondary();
 }
@@ -456,12 +428,10 @@ static void test_secondary_start(void)
 static void test_secondary_stop(void)
 {
     BlockBackend *top_blk, *local_blk;
-    Error *local_err = NULL;
     bool failover = true;
 
     top_blk = start_secondary();
-    replication_start_all(REPLICATION_MODE_SECONDARY, &local_err);
-    g_assert(!local_err);
+    replication_start_all(REPLICATION_MODE_SECONDARY, &error_abort);
 
     /* write 0x22 to s_local_disk (IMG_SIZE / 2, IMG_SIZE) */
     local_blk = blk_by_name(S_LOCAL_DISK_ID);
@@ -475,8 +445,7 @@ static void test_secondary_stop(void)
     test_blk_write(top_blk, 0x33, 0, IMG_SIZE / 2, false);
 
     /* do active commit */
-    replication_stop_all(failover, &local_err);
-    g_assert(!local_err);
+    replication_stop_all(failover, &error_abort);
 
     /* read from s_local_disk (0, IMG_SIZE / 2) */
     test_blk_read(top_blk, 0x33, 0, IMG_SIZE / 2,
@@ -493,11 +462,9 @@ static void test_secondary_stop(void)
 static void test_secondary_continuous_replication(void)
 {
     BlockBackend *top_blk, *local_blk;
-    Error *local_err = NULL;
 
     top_blk = start_secondary();
-    replication_start_all(REPLICATION_MODE_SECONDARY, &local_err);
-    g_assert(!local_err);
+    replication_start_all(REPLICATION_MODE_SECONDARY, &error_abort);
 
     /* write 0x22 to s_local_disk (IMG_SIZE / 2, IMG_SIZE) */
     local_blk = blk_by_name(S_LOCAL_DISK_ID);
@@ -511,22 +478,18 @@ static void test_secondary_continuous_replication(void)
     test_blk_write(top_blk, 0x33, 0, IMG_SIZE / 2, false);
 
     /* do failover (active commit) */
-    replication_stop_all(true, &local_err);
-    g_assert(!local_err);
+    replication_stop_all(true, &error_abort);
 
     /* it should ignore all requests from now on */
 
     /* start after failover */
-    replication_start_all(REPLICATION_MODE_PRIMARY, &local_err);
-    g_assert(!local_err);
+    replication_start_all(REPLICATION_MODE_PRIMARY, &error_abort);
 
     /* checkpoint */
-    replication_do_checkpoint_all(&local_err);
-    g_assert(!local_err);
+    replication_do_checkpoint_all(&error_abort);
 
     /* stop */
-    replication_stop_all(true, &local_err);
-    g_assert(!local_err);
+    replication_stop_all(true, &error_abort);
 
     /* read from s_local_disk (0, IMG_SIZE / 2) */
     test_blk_read(top_blk, 0x33, 0, IMG_SIZE / 2,
@@ -543,12 +506,10 @@ static void test_secondary_continuous_replication(void)
 static void test_secondary_do_checkpoint(void)
 {
     BlockBackend *top_blk, *local_blk;
-    Error *local_err = NULL;
     bool failover = true;
 
     top_blk = start_secondary();
-    replication_start_all(REPLICATION_MODE_SECONDARY, &local_err);
-    g_assert(!local_err);
+    replication_start_all(REPLICATION_MODE_SECONDARY, &error_abort);
 
     /* write 0x22 to s_local_disk (IMG_SIZE / 2, IMG_SIZE) */
     local_blk = blk_by_name(S_LOCAL_DISK_ID);
@@ -559,35 +520,29 @@ static void test_secondary_do_checkpoint(void)
     test_blk_read(top_blk, 0x11, IMG_SIZE / 2,
                   IMG_SIZE / 2, 0, IMG_SIZE, false);
 
-    replication_do_checkpoint_all(&local_err);
-    g_assert(!local_err);
+    replication_do_checkpoint_all(&error_abort);
 
     /* after checkpoint, read pattern 0x22 from s_local_disk */
     test_blk_read(top_blk, 0x22, IMG_SIZE / 2,
                   IMG_SIZE / 2, 0, IMG_SIZE, false);
 
     /* unblock top_bs */
-    replication_stop_all(failover, &local_err);
-    g_assert(!local_err);
+    replication_stop_all(failover, &error_abort);
 
     teardown_secondary();
 }
 
 static void test_secondary_get_error_all(void)
 {
-    Error *local_err = NULL;
     bool failover = true;
 
     start_secondary();
-    replication_start_all(REPLICATION_MODE_SECONDARY, &local_err);
-    g_assert(!local_err);
+    replication_start_all(REPLICATION_MODE_SECONDARY, &error_abort);
 
-    replication_get_error_all(&local_err);
-    g_assert(!local_err);
+    replication_get_error_all(&error_abort);
 
     /* unblock top_bs */
-    replication_stop_all(failover, &local_err);
-    g_assert(!local_err);
+    replication_stop_all(failover, &error_abort);
 
     teardown_secondary();
 }
diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index 5418e085a4..249faafc9d 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -53,8 +53,7 @@ static void test_visitor_in_int(TestInputVisitorData *data,
 
     v = visitor_input_test_init(data, "-42");
 
-    visit_type_int(v, NULL, &res, &err);
-    g_assert(!err);
+    visit_type_int(v, NULL, &res, &error_abort);
     g_assert_cmpint(res, ==, value);
 
     v = visitor_input_test_init(data, "not an int");
@@ -327,44 +326,37 @@ static void test_visitor_in_uintList(TestInputVisitorData *data,
 static void test_visitor_in_bool(TestInputVisitorData *data,
                                  const void *unused)
 {
-    Error *err = NULL;
     bool res = false;
     Visitor *v;
 
     v = visitor_input_test_init(data, "true");
 
-    visit_type_bool(v, NULL, &res, &err);
-    g_assert(!err);
+    visit_type_bool(v, NULL, &res, &error_abort);
     g_assert_cmpint(res, ==, true);
 
     v = visitor_input_test_init(data, "yes");
 
-    visit_type_bool(v, NULL, &res, &err);
-    g_assert(!err);
+    visit_type_bool(v, NULL, &res, &error_abort);
     g_assert_cmpint(res, ==, true);
 
     v = visitor_input_test_init(data, "on");
 
-    visit_type_bool(v, NULL, &res, &err);
-    g_assert(!err);
+    visit_type_bool(v, NULL, &res, &error_abort);
     g_assert_cmpint(res, ==, true);
 
     v = visitor_input_test_init(data, "false");
 
-    visit_type_bool(v, NULL, &res, &err);
-    g_assert(!err);
+    visit_type_bool(v, NULL, &res, &error_abort);
     g_assert_cmpint(res, ==, false);
 
     v = visitor_input_test_init(data, "no");
 
-    visit_type_bool(v, NULL, &res, &err);
-    g_assert(!err);
+    visit_type_bool(v, NULL, &res, &error_abort);
     g_assert_cmpint(res, ==, false);
 
     v = visitor_input_test_init(data, "off");
 
-    visit_type_bool(v, NULL, &res, &err);
-    g_assert(!err);
+    visit_type_bool(v, NULL, &res, &error_abort);
     g_assert_cmpint(res, ==, false);
 }
 
@@ -377,8 +369,7 @@ static void test_visitor_in_number(TestInputVisitorData *data,
 
     v = visitor_input_test_init(data, "3.14");
 
-    visit_type_number(v, NULL, &res, &err);
-    g_assert(!err);
+    visit_type_number(v, NULL, &res, &error_abort);
     g_assert_cmpfloat(res, ==, value);
 
     /* NaN and infinity has to be rejected */
@@ -399,13 +390,11 @@ static void test_visitor_in_string(TestInputVisitorData *data,
                                    const void *unused)
 {
     char *res = NULL, *value = (char *) "Q E M U";
-    Error *err = NULL;
     Visitor *v;
 
     v = visitor_input_test_init(data, value);
 
-    visit_type_str(v, NULL, &res, &err);
-    g_assert(!err);
+    visit_type_str(v, NULL, &res, &error_abort);
     g_assert_cmpstr(res, ==, value);
 
     g_free(res);
@@ -414,7 +403,6 @@ static void test_visitor_in_string(TestInputVisitorData *data,
 static void test_visitor_in_enum(TestInputVisitorData *data,
                                  const void *unused)
 {
-    Error *err = NULL;
     Visitor *v;
     EnumOne i;
 
@@ -423,8 +411,7 @@ static void test_visitor_in_enum(TestInputVisitorData *data,
 
         v = visitor_input_test_init(data, EnumOne_str(i));
 
-        visit_type_EnumOne(v, NULL, &res, &err);
-        g_assert(!err);
+        visit_type_EnumOne(v, NULL, &res, &error_abort);
         g_assert_cmpint(i, ==, res);
     }
 }
diff --git a/tests/test-string-output-visitor.c b/tests/test-string-output-visitor.c
index 3bd732222c..9f6581439a 100644
--- a/tests/test-string-output-visitor.c
+++ b/tests/test-string-output-visitor.c
@@ -71,11 +71,9 @@ static void test_visitor_out_int(TestOutputVisitorData *data,
                                  const void *unused)
 {
     int64_t value = 42;
-    Error *err = NULL;
     char *str;
 
-    visit_type_int(data->ov, NULL, &value, &err);
-    g_assert(!err);
+    visit_type_int(data->ov, NULL, &value, &error_abort);
 
     str = visitor_get(data);
     if (data->human) {
@@ -120,12 +118,10 @@ static void test_visitor_out_intList(TestOutputVisitorData *data,
 static void test_visitor_out_bool(TestOutputVisitorData *data,
                                   const void *unused)
 {
-    Error *err = NULL;
     bool value = true;
     char *str;
 
-    visit_type_bool(data->ov, NULL, &value, &err);
-    g_assert(!err);
+    visit_type_bool(data->ov, NULL, &value, &error_abort);
 
     str = visitor_get(data);
     g_assert_cmpstr(str, ==, "true");
@@ -135,11 +131,9 @@ static void test_visitor_out_number(TestOutputVisitorData *data,
                                     const void *unused)
 {
     double value = 3.14;
-    Error *err = NULL;
     char *str;
 
-    visit_type_number(data->ov, NULL, &value, &err);
-    g_assert(!err);
+    visit_type_number(data->ov, NULL, &value, &error_abort);
 
     str = visitor_get(data);
     g_assert_cmpstr(str, ==, "3.140000");
@@ -150,11 +144,9 @@ static void test_visitor_out_string(TestOutputVisitorData *data,
 {
     char *string = (char *) "Q E M U";
     const char *string_human = "\"Q E M U\"";
-    Error *err = NULL;
     char *str;
 
-    visit_type_str(data->ov, NULL, &string, &err);
-    g_assert(!err);
+    visit_type_str(data->ov, NULL, &string, &error_abort);
 
     str = visitor_get(data);
     if (data->human) {
-- 
2.26.2


