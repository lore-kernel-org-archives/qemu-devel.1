Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D650C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E4E21556
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1FQa3Ei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E4E21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifWrs-00007q-OO
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 17:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ifWpQ-0005oZ-HJ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ifWpO-0007X6-PY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:21:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42278
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ifWpO-0007Wb-KJ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576189258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ezd/o75sSmVagVVAklxwrBzSXdq547CjIFN74BDXvW8=;
 b=W1FQa3EiXFwNYXVPuwv5TDHwxlVNjPAhkVWqnSP8Iq6vRXeFIjLr6KtmJZDsnb0XhCAMKN
 EewcLZIMGygShv3yXZLfVcbWKBqkcDEVXShWsWkREFMG5qQxV3hq8o+LLwTpVamZsRSwIu
 fWbtaLCpHo17gorAUvbKwNPCwGqnjJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-kuo9fzjtPsqXNqQZhR2VGA-1; Thu, 12 Dec 2019 17:20:57 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C7C4593A1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 22:20:55 +0000 (UTC)
Received: from secure.mitica (ovpn-116-25.ams2.redhat.com [10.36.116.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D305310013A1;
 Thu, 12 Dec 2019 22:20:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/10] migration-test: Use a struct for test_migrate_start
 parameters
Date: Thu, 12 Dec 2019 23:20:33 +0100
Message-Id: <20191212222033.1026-11-quintela@redhat.com>
In-Reply-To: <20191212222033.1026-1-quintela@redhat.com>
References: <20191212222033.1026-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: kuo9fzjtPsqXNqQZhR2VGA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It has two bools and two strings, it is very difficult to remember
which does what.  And it makes very difficult to add new parameters as
we need to modify all the callers.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 118 +++++++++++++++++++++++++++--------------
 1 file changed, 78 insertions(+), 40 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 6c7c4163a4..4a192116ce 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -544,10 +544,31 @@ static void migrate_postcopy_start(QTestState *from, =
QTestState *to)
     qtest_qmp_eventwait(to, "RESUME");
 }
=20
+typedef struct {
+    bool hide_stderr;
+    bool use_shmem;
+    char *opts_source;
+    char *opts_target;
+} MigrateStart;
+
+static MigrateStart *migrate_start_new(void)
+{
+    MigrateStart *args =3D g_new0(MigrateStart, 1);
+
+    args->opts_source =3D g_strdup("");
+    args->opts_target =3D g_strdup("");
+    return args;
+}
+
+static void migrate_start_destroy(MigrateStart *args)
+{
+    g_free(args->opts_source);
+    g_free(args->opts_target);
+    g_free(args);
+}
+
 static int test_migrate_start(QTestState **from, QTestState **to,
-                               const char *uri, bool hide_stderr,
-                               bool use_shmem, const char *opts_src,
-                               const char *opts_dst)
+                              const char *uri, MigrateStart *args)
 {
     gchar *arch_source, *arch_target;
     gchar *cmd_source, *cmd_target;
@@ -560,10 +581,7 @@ static int test_migrate_start(QTestState **from, QTest=
State **to,
     const char *machine_args;
     const char *memory_size;
=20
-    opts_src =3D opts_src ? opts_src : "";
-    opts_dst =3D opts_dst ? opts_dst : "";
-
-    if (use_shmem) {
+    if (args->use_shmem) {
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
             g_test_skip("/dev/shm is not supported");
             return -1;
@@ -623,13 +641,13 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
=20
     g_free(bootpath);
=20
-    if (hide_stderr) {
+    if (args->hide_stderr) {
         ignore_stderr =3D "2>/dev/null";
     } else {
         ignore_stderr =3D "";
     }
=20
-    if (use_shmem) {
+    if (args->use_shmem) {
         shmem_path =3D g_strdup_printf("/dev/shm/qemu-%d", getpid());
         shmem_opts =3D g_strdup_printf(
             "-object memory-backend-file,id=3Dmem0,size=3D%s"
@@ -647,7 +665,7 @@ static int test_migrate_start(QTestState **from, QTestS=
tate **to,
                                  "%s %s %s %s",
                                  machine_type, machine_args,
                                  memory_size, tmpfs,
-                                 arch_source, shmem_opts, opts_src,
+                                 arch_source, shmem_opts, args->opts_sourc=
e,
                                  ignore_stderr);
     g_free(arch_source);
     *from =3D qtest_init(cmd_source);
@@ -661,18 +679,19 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
                                  "%s %s %s %s",
                                  machine_type, machine_args,
                                  memory_size, tmpfs, uri,
-                                 arch_target, shmem_opts, opts_dst,
-                                 ignore_stderr);
+                                 arch_target, shmem_opts,
+                                 args->opts_target, ignore_stderr);
     g_free(arch_target);
     *to =3D qtest_init(cmd_target);
     g_free(cmd_target);
=20
+    migrate_start_destroy(args);
     g_free(shmem_opts);
     /*
      * Remove shmem file immediately to avoid memory leak in test failed c=
ase.
      * It's valid becase QEMU has already opened this file
      */
-    if (use_shmem) {
+    if (args->use_shmem) {
         unlink(shmem_path);
         g_free(shmem_path);
     }
@@ -762,13 +781,13 @@ static void test_deprecated(void)
 }
=20
 static int migrate_postcopy_prepare(QTestState **from_ptr,
-                                     QTestState **to_ptr,
-                                     bool hide_error)
+                                    QTestState **to_ptr,
+                                    MigrateStart *args)
 {
     char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
=20
-    if (test_migrate_start(&from, &to, uri, hide_error, false, NULL, NULL)=
) {
+    if (test_migrate_start(&from, &to, uri, args)) {
         return -1;
     }
=20
@@ -813,9 +832,10 @@ static void migrate_postcopy_complete(QTestState *from=
, QTestState *to)
=20
 static void test_postcopy(void)
 {
+    MigrateStart *args =3D migrate_start_new();
     QTestState *from, *to;
=20
-    if (migrate_postcopy_prepare(&from, &to, false)) {
+    if (migrate_postcopy_prepare(&from, &to, args)) {
         return;
     }
     migrate_postcopy_start(from, to);
@@ -824,10 +844,13 @@ static void test_postcopy(void)
=20
 static void test_postcopy_recovery(void)
 {
+    MigrateStart *args =3D migrate_start_new();
     QTestState *from, *to;
     char *uri;
=20
-    if (migrate_postcopy_prepare(&from, &to, true)) {
+    args->hide_stderr =3D true;
+
+    if (migrate_postcopy_prepare(&from, &to, args)) {
         return;
     }
=20
@@ -910,9 +933,12 @@ static void wait_for_migration_fail(QTestState *from, =
bool allow_active)
=20
 static void test_baddest(void)
 {
+    MigrateStart *args =3D migrate_start_new();
     QTestState *from, *to;
=20
-    if (test_migrate_start(&from, &to, "tcp:0:0", true, false, NULL, NULL)=
) {
+    args->hide_stderr =3D true;
+
+    if (test_migrate_start(&from, &to, "tcp:0:0", args)) {
         return;
     }
     migrate(from, "tcp:0:0", "{}");
@@ -923,9 +949,10 @@ static void test_baddest(void)
 static void test_precopy_unix(void)
 {
     char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
+    MigrateStart *args =3D migrate_start_new();
     QTestState *from, *to;
=20
-    if (test_migrate_start(&from, &to, uri, false, false, NULL, NULL)) {
+    if (test_migrate_start(&from, &to, uri, args)) {
         return;
     }
=20
@@ -1001,9 +1028,10 @@ static void test_ignore_shared(void)
=20
 static void test_xbzrle(const char *uri)
 {
+    MigrateStart *args =3D migrate_start_new();
     QTestState *from, *to;
=20
-    if (test_migrate_start(&from, &to, uri, false, false, NULL, NULL)) {
+    if (test_migrate_start(&from, &to, uri, args)) {
         return;
     }
=20
@@ -1052,11 +1080,11 @@ static void test_xbzrle_unix(void)
=20
 static void test_precopy_tcp(void)
 {
+    MigrateStart *args =3D migrate_start_new();
     char *uri;
     QTestState *from, *to;
=20
-    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", false, false,
-                           NULL, NULL)) {
+    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", args)) {
         return;
     }
=20
@@ -1096,13 +1124,14 @@ static void test_precopy_tcp(void)
=20
 static void test_migrate_fd_proto(void)
 {
+    MigrateStart *args =3D migrate_start_new();
     QTestState *from, *to;
     int ret;
     int pair[2];
     QDict *rsp;
     const char *error_desc;
=20
-    if (test_migrate_start(&from, &to, "defer", false, false, NULL, NULL))=
 {
+    if (test_migrate_start(&from, &to, "defer", args)) {
         return;
     }
=20
@@ -1178,15 +1207,12 @@ static void test_migrate_fd_proto(void)
     test_migrate_end(from, to, true);
 }
=20
-static void do_test_validate_uuid(const char *uuid_arg_src,
-                                  const char *uuid_arg_dst,
-                                  bool should_fail, bool hide_stderr)
+static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
 {
     char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
=20
-    if (test_migrate_start(&from, &to, uri, hide_stderr, false,
-                           uuid_arg_src, uuid_arg_dst)) {
+    if (test_migrate_start(&from, &to, uri, args)) {
         return;
     }
=20
@@ -1216,33 +1242,45 @@ static void do_test_validate_uuid(const char *uuid_=
arg_src,
=20
 static void test_validate_uuid(void)
 {
-    do_test_validate_uuid("-uuid 11111111-1111-1111-1111-111111111111",
-                          "-uuid 11111111-1111-1111-1111-111111111111",
-                          false, false);
+    MigrateStart *args =3D migrate_start_new();
+
+    args->opts_source =3D g_strdup("-uuid 11111111-1111-1111-1111-11111111=
1111");
+    args->opts_target =3D g_strdup("-uuid 11111111-1111-1111-1111-11111111=
1111");
+    do_test_validate_uuid(args, false);
 }
=20
 static void test_validate_uuid_error(void)
 {
-    do_test_validate_uuid("-uuid 11111111-1111-1111-1111-111111111111",
-                          "-uuid 22222222-2222-2222-2222-222222222222",
-                          true, true);
+    MigrateStart *args =3D migrate_start_new();
+
+    args->opts_source =3D g_strdup("-uuid 11111111-1111-1111-1111-11111111=
1111");
+    args->opts_target =3D g_strdup("-uuid 22222222-2222-2222-2222-22222222=
2222");
+    args->hide_stderr =3D true;
+    do_test_validate_uuid(args, true);
 }
=20
 static void test_validate_uuid_src_not_set(void)
 {
-    do_test_validate_uuid(NULL, "-uuid 11111111-1111-1111-1111-11111111111=
1",
-                          false, true);
+    MigrateStart *args =3D migrate_start_new();
+
+    args->opts_target =3D g_strdup("-uuid 22222222-2222-2222-2222-22222222=
2222");
+    args->hide_stderr =3D true;
+    do_test_validate_uuid(args, false);
 }
=20
 static void test_validate_uuid_dst_not_set(void)
 {
-    do_test_validate_uuid("-uuid 11111111-1111-1111-1111-111111111111", NU=
LL,
-                          false, true);
+    MigrateStart *args =3D migrate_start_new();
+
+    args->opts_source =3D g_strdup("-uuid 11111111-1111-1111-1111-11111111=
1111");
+    args->hide_stderr =3D true;
+    do_test_validate_uuid(args, false);
 }
=20
 static void test_migrate_auto_converge(void)
 {
     char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
+    MigrateStart *args =3D migrate_start_new();
     QTestState *from, *to;
     int64_t remaining, percentage;
=20
@@ -1261,7 +1299,7 @@ static void test_migrate_auto_converge(void)
      */
     const int64_t expected_threshold =3D max_bandwidth * downtime_limit / =
1000;
=20
-    if (test_migrate_start(&from, &to, uri, false, false, NULL, NULL)) {
+    if (test_migrate_start(&from, &to, uri, args)) {
         return;
     }
=20
--=20
2.21.0


