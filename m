Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B84FC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A611720870
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="l5zbdNKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A611720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5C7y-0006sC-JG
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i5BaD-0007T6-V0
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i5BaA-00039o-Vt
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:23:04 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:45060)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1i5BaA-00038I-Fu
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:23:02 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 72EEE2E1538;
 Tue,  3 Sep 2019 19:23:00 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net
 [2a02:6b8:0:1619::137])
 by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 4LtsEkoopx-N0qC66Wv; Tue, 03 Sep 2019 19:23:00 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1567527780; bh=JfuMd+/Yot5leMCLjVBdpl9YoUahGa/NgcaY5RbW98Q=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=l5zbdNKl9awwiVhMBqiVTQsNDLicpHhkff2hWmLxV8FHJPEolb7xApuCkEpzbKLXR
 qH6gTAt27BubBkRifW1xrags+f39S9jV2NvxMFjm7tGEdS25wgoBU6s+Ztvf+7U2ID
 GWl1HUomomW0KL6isKKuxZxDLhLeXTpekk8+kIzE=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:c43c:5d37:585c:b5d6])
 by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 YFfYaDvJaP-Mxfa81J0; Tue, 03 Sep 2019 19:23:00 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Date: Tue,  3 Sep 2019 19:22:46 +0300
Message-Id: <20190903162246.18524-4-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190903162246.18524-1-yury-kotov@yandex-team.ru>
References: <20190903162246.18524-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.45.199.163
Subject: [Qemu-devel] [PATCH v2 3/3] tests/migration: Add a test for
 validate-uuid capability
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 tests/migration-test.c | 140 ++++++++++++++++++++++++++++++++---------
 1 file changed, 110 insertions(+), 30 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index b87ba99a9e..524caf773f 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -512,7 +512,8 @@ static void migrate_postcopy_start(QTestState *from, =
QTestState *to)
=20
 static int test_migrate_start(QTestState **from, QTestState **to,
                                const char *uri, bool hide_stderr,
-                               bool use_shmem)
+                               bool use_shmem, const char *opts_src,
+                               const char *opts_dst)
 {
     gchar *cmd_src, *cmd_dst;
     char *bootpath =3D NULL;
@@ -521,6 +522,9 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
     const char *arch =3D qtest_get_arch();
     const char *accel =3D "kvm:tcg";
=20
+    opts_src =3D opts_src ? opts_src : "";
+    opts_dst =3D opts_dst ? opts_dst : "";
+
     if (use_shmem) {
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
             g_test_skip("/dev/shm is not supported");
@@ -539,16 +543,16 @@ static int test_migrate_start(QTestState **from, QT=
estState **to,
         cmd_src =3D g_strdup_printf("-machine accel=3D%s -m 150M"
                                   " -name source,debug-threads=3Don"
                                   " -serial file:%s/src_serial"
-                                  " -drive file=3D%s,format=3Draw %s",
+                                  " -drive file=3D%s,format=3Draw %s %s"=
,
                                   accel, tmpfs, bootpath,
-                                  extra_opts ? extra_opts : "");
+                                  extra_opts ? extra_opts : "", opts_src=
);
         cmd_dst =3D g_strdup_printf("-machine accel=3D%s -m 150M"
                                   " -name target,debug-threads=3Don"
                                   " -serial file:%s/dest_serial"
                                   " -drive file=3D%s,format=3Draw"
-                                  " -incoming %s %s",
+                                  " -incoming %s %s %s",
                                   accel, tmpfs, bootpath, uri,
-                                  extra_opts ? extra_opts : "");
+                                  extra_opts ? extra_opts : "", opts_dst=
);
         start_address =3D X86_TEST_MEM_START;
         end_address =3D X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
@@ -556,15 +560,15 @@ static int test_migrate_start(QTestState **from, QT=
estState **to,
         extra_opts =3D use_shmem ? get_shmem_opts("128M", shmem_path) : =
NULL;
         cmd_src =3D g_strdup_printf("-machine accel=3D%s -m 128M"
                                   " -name source,debug-threads=3Don"
-                                  " -serial file:%s/src_serial -bios %s =
%s",
+                                  " -serial file:%s/src_serial -bios %s =
%s %s",
                                   accel, tmpfs, bootpath,
-                                  extra_opts ? extra_opts : "");
+                                  extra_opts ? extra_opts : "", opts_src=
);
         cmd_dst =3D g_strdup_printf("-machine accel=3D%s -m 128M"
                                   " -name target,debug-threads=3Don"
                                   " -serial file:%s/dest_serial -bios %s=
"
-                                  " -incoming %s %s",
+                                  " -incoming %s %s %s",
                                   accel, tmpfs, bootpath, uri,
-                                  extra_opts ? extra_opts : "");
+                                  extra_opts ? extra_opts : "", opts_dst=
);
         start_address =3D S390_TEST_MEM_START;
         end_address =3D S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") =3D=3D 0) {
@@ -575,14 +579,15 @@ static int test_migrate_start(QTestState **from, QT=
estState **to,
                                   " -prom-env 'use-nvramrc?=3Dtrue' -pro=
m-env "
                                   "'nvramrc=3Dhex .\" _\" begin %x %x "
                                   "do i c@ 1 + i c! 1000 +loop .\" B\" 0=
 "
-                                  "until' %s",  accel, tmpfs, end_addres=
s,
-                                  start_address, extra_opts ? extra_opts=
 : "");
+                                  "until' %s %s",  accel, tmpfs, end_add=
ress,
+                                  start_address, extra_opts ? extra_opts=
 : "",
+                                  opts_src);
         cmd_dst =3D g_strdup_printf("-machine accel=3D%s -m 256M"
                                   " -name target,debug-threads=3Don"
                                   " -serial file:%s/dest_serial"
-                                  " -incoming %s %s",
+                                  " -incoming %s %s %s",
                                   accel, tmpfs, uri,
-                                  extra_opts ? extra_opts : "");
+                                  extra_opts ? extra_opts : "", opts_dst=
);
=20
         start_address =3D PPC_TEST_MEM_START;
         end_address =3D PPC_TEST_MEM_END;
@@ -592,16 +597,16 @@ static int test_migrate_start(QTestState **from, QT=
estState **to,
         cmd_src =3D g_strdup_printf("-machine virt,accel=3D%s,gic-versio=
n=3Dmax "
                                   "-name vmsource,debug-threads=3Don -cp=
u max "
                                   "-m 150M -serial file:%s/src_serial "
-                                  "-kernel %s %s",
+                                  "-kernel %s %s %s",
                                   accel, tmpfs, bootpath,
-                                  extra_opts ? extra_opts : "");
+                                  extra_opts ? extra_opts : "", opts_src=
);
         cmd_dst =3D g_strdup_printf("-machine virt,accel=3D%s,gic-versio=
n=3Dmax "
                                   "-name vmdest,debug-threads=3Don -cpu =
max "
                                   "-m 150M -serial file:%s/dest_serial "
                                   "-kernel %s "
-                                  "-incoming %s %s",
+                                  "-incoming %s %s %s",
                                   accel, tmpfs, bootpath, uri,
-                                  extra_opts ? extra_opts : "");
+                                  extra_opts ? extra_opts : "", opts_dst=
);
=20
         start_address =3D ARM_TEST_MEM_START;
         end_address =3D ARM_TEST_MEM_END;
@@ -731,7 +736,7 @@ static int migrate_postcopy_prepare(QTestState **from=
_ptr,
     char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
=20
-    if (test_migrate_start(&from, &to, uri, hide_error, false)) {
+    if (test_migrate_start(&from, &to, uri, hide_error, false, NULL, NUL=
L)) {
         return -1;
     }
=20
@@ -841,20 +846,16 @@ static void test_postcopy_recovery(void)
     migrate_postcopy_complete(from, to);
 }
=20
-static void test_baddest(void)
+static void wait_for_migration_fail(QTestState *from, bool allow_active)
 {
-    QTestState *from, *to;
     QDict *rsp_return;
     char *status;
     bool failed;
=20
-    if (test_migrate_start(&from, &to, "tcp:0:0", true, false)) {
-        return;
-    }
-    migrate(from, "tcp:0:0", "{}");
     do {
         status =3D migrate_query_status(from);
-        g_assert(!strcmp(status, "setup") || !(strcmp(status, "failed"))=
);
+        g_assert(!strcmp(status, "setup") || !strcmp(status, "failed") |=
|
+                 (allow_active && !strcmp(status, "active")));
         failed =3D !strcmp(status, "failed");
         g_free(status);
     } while (!failed);
@@ -864,7 +865,17 @@ static void test_baddest(void)
     g_assert(qdict_haskey(rsp_return, "running"));
     g_assert(qdict_get_bool(rsp_return, "running"));
     qobject_unref(rsp_return);
+}
+
+static void test_baddest(void)
+{
+    QTestState *from, *to;
=20
+    if (test_migrate_start(&from, &to, "tcp:0:0", true, false, NULL, NUL=
L)) {
+        return;
+    }
+    migrate(from, "tcp:0:0", "{}");
+    wait_for_migration_fail(from, false);
     test_migrate_end(from, to, false);
 }
=20
@@ -873,7 +884,7 @@ static void test_precopy_unix(void)
     char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
=20
-    if (test_migrate_start(&from, &to, uri, false, false)) {
+    if (test_migrate_start(&from, &to, uri, false, false, NULL, NULL)) {
         return;
     }
=20
@@ -916,7 +927,7 @@ static void test_ignore_shared(void)
     char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
=20
-    if (test_migrate_start(&from, &to, uri, false, true)) {
+    if (test_migrate_start(&from, &to, uri, false, true, NULL, NULL)) {
         return;
     }
=20
@@ -951,7 +962,7 @@ static void test_xbzrle(const char *uri)
 {
     QTestState *from, *to;
=20
-    if (test_migrate_start(&from, &to, uri, false, false)) {
+    if (test_migrate_start(&from, &to, uri, false, false, NULL, NULL)) {
         return;
     }
=20
@@ -1003,7 +1014,8 @@ static void test_precopy_tcp(void)
     char *uri;
     QTestState *from, *to;
=20
-    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", false, false))=
 {
+    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", false, false,
+                           NULL, NULL)) {
         return;
     }
=20
@@ -1049,7 +1061,7 @@ static void test_migrate_fd_proto(void)
     QDict *rsp;
     const char *error_desc;
=20
-    if (test_migrate_start(&from, &to, "defer", false, false)) {
+    if (test_migrate_start(&from, &to, "defer", false, false, NULL, NULL=
)) {
         return;
     }
=20
@@ -1125,6 +1137,68 @@ static void test_migrate_fd_proto(void)
     test_migrate_end(from, to, true);
 }
=20
+static void do_test_validate_uuid(const char *uuid_arg_src,
+                                  const char *uuid_arg_dst,
+                                  bool should_fail, bool hide_stderr)
+{
+    char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+
+    if (test_migrate_start(&from, &to, uri, hide_stderr, false,
+                           uuid_arg_src, uuid_arg_dst)) {
+        return;
+    }
+
+    /*
+     * UUID validation is at the begin of migration. So, the main proces=
s of
+     * migration is not interesting for us here. Thus, set huge downtime=
 for
+     * very fast migration.
+     */
+    migrate_set_parameter_int(from, "downtime-limit", 1000000);
+    migrate_set_capability(from, "validate-uuid", true);
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    migrate(from, uri, "{}");
+
+    if (should_fail) {
+        qtest_set_expected_status(to, 1);
+        wait_for_migration_fail(from, true);
+    } else {
+        wait_for_migration_complete(from);
+    }
+
+    test_migrate_end(from, to, false);
+    g_free(uri);
+}
+
+static void test_validate_uuid(void)
+{
+    do_test_validate_uuid("-uuid 11111111-1111-1111-1111-111111111111",
+                          "-uuid 11111111-1111-1111-1111-111111111111",
+                          false, false);
+}
+
+static void test_validate_uuid_error(void)
+{
+    do_test_validate_uuid("-uuid 11111111-1111-1111-1111-111111111111",
+                          "-uuid 22222222-2222-2222-2222-222222222222",
+                          true, true);
+}
+
+static void test_validate_uuid_src_not_set(void)
+{
+    do_test_validate_uuid(NULL, "-uuid 11111111-1111-1111-1111-111111111=
111",
+                          false, true);
+}
+
+static void test_validate_uuid_dst_not_set(void)
+{
+    do_test_validate_uuid("-uuid 11111111-1111-1111-1111-111111111111", =
NULL,
+                          false, true);
+}
+
 int main(int argc, char **argv)
 {
     char template[] =3D "/tmp/migration-test-XXXXXX";
@@ -1180,6 +1254,12 @@ int main(int argc, char **argv)
     /* qtest_add_func("/migration/ignore_shared", test_ignore_shared); *=
/
     qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
     qtest_add_func("/migration/fd_proto", test_migrate_fd_proto);
+    qtest_add_func("/migration/validate_uuid", test_validate_uuid);
+    qtest_add_func("/migration/validate_uuid_error", test_validate_uuid_=
error);
+    qtest_add_func("/migration/validate_uuid_src_not_set",
+                   test_validate_uuid_src_not_set);
+    qtest_add_func("/migration/validate_uuid_dst_not_set",
+                   test_validate_uuid_dst_not_set);
=20
     ret =3D g_test_run();
=20
--=20
2.17.1


