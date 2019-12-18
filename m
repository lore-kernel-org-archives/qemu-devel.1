Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72C2C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 05:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A09FC20733
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 05:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ek9Iyssx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09FC20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihRYy-00028c-QE
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 00:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ihRW1-0006vY-Q7
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 00:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ihRVz-0003g6-7n
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 00:04:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37660
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ihRVz-0003e3-3s
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 00:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576645490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s1nkmlv34bXpJjjAp06LNzSqEhMoyMdeErSNU1L6v7M=;
 b=Ek9IyssxRw4vKFHol6lAv5XEdUhqb+PulQ0Ci3CcZCrTKmoZlULEX3WRTfMpC6c7Zo058g
 cZzJ1Nc4qp4KZitaikCVIhZZg2ZORFYr8DrGPhg1Z1Yvqpu/IFzyB6+GAxC2lxtlNYi7LJ
 zdDlpo15lsS5+niFi63CVguJY+xXSaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-KB_CbUnZNqeMISLBcKvR9w-1; Wed, 18 Dec 2019 00:04:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FCE18024E0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 05:04:48 +0000 (UTC)
Received: from secure.mitica (ovpn-116-32.ams2.redhat.com [10.36.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 89F045D9E1;
 Wed, 18 Dec 2019 05:04:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] migration-test: Make sure that multifd and cancel works
Date: Wed, 18 Dec 2019 06:04:38 +0100
Message-Id: <20191218050439.5989-4-quintela@redhat.com>
In-Reply-To: <20191218050439.5989-1-quintela@redhat.com>
References: <20191218050439.5989-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: KB_CbUnZNqeMISLBcKvR9w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

Test that this sequerce works:

- launch source
- launch target
- start migration
- cancel migration
- relaunch target
- do migration again

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 108 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 7588f50b9b..1c93b3e5bc 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -527,6 +527,14 @@ static void migrate_recover(QTestState *who, const cha=
r *uri)
     qobject_unref(rsp);
 }
=20
+static void migrate_cancel(QTestState *who)
+{
+    QDict *rsp;
+
+    rsp =3D wait_command(who, "{ 'execute': 'migrate_cancel' }");
+    qobject_unref(rsp);
+}
+
 static void migrate_set_capability(QTestState *who, const char *capability=
,
                                    bool value)
 {
@@ -583,6 +591,8 @@ static void migrate_postcopy_start(QTestState *from, QT=
estState *to)
 typedef struct {
     bool hide_stderr;
     bool use_shmem;
+    /* only launch the target process */
+    bool only_target;
     char *opts_source;
     char *opts_target;
 } MigrateStart;
@@ -704,7 +714,9 @@ static int test_migrate_start(QTestState **from, QTestS=
tate **to,
                                  arch_source, shmem_opts, args->opts_sourc=
e,
                                  ignore_stderr);
     g_free(arch_source);
-    *from =3D qtest_init(cmd_source);
+    if (!args->only_target) {
+        *from =3D qtest_init(cmd_source);
+    }
     g_free(cmd_source);
=20
     cmd_target =3D g_strdup_printf("-machine %saccel=3Dkvm:tcg%s "
@@ -1470,6 +1482,99 @@ static void test_multifd_tcp_zstd(void)
     test_multifd_tcp("zstd");
 }
=20
+/*
+ * This test does:
+ *  source               target
+ *                       migrate_incoming
+ *     migrate
+ *     migrate_cancel
+ *                       launch another target
+ *     migrate
+ *
+ *  And see that it works
+ */
+
+static void test_multifd_tcp_cancel(void)
+{
+    MigrateStart *args =3D migrate_start_new();
+    QTestState *from, *to;
+    QDict *rsp;
+    char *uri;
+
+    if (test_migrate_start(&from, &to, "defer", args)) {
+        return;
+    }
+
+    /*
+     * We want to pick a speed slow enough that the test completes
+     * quickly, but that it doesn't complete precopy even on a slow
+     * machine, so also set the downtime.
+     */
+    /* 1 ms should make it not converge*/
+    migrate_set_parameter_int(from, "downtime-limit", 1);
+    /* 1GB/s */
+    migrate_set_parameter_int(from, "max-bandwidth", 1000000000);
+
+    migrate_set_parameter_int(from, "multifd-channels", 16);
+    migrate_set_parameter_int(to, "multifd-channels", 16);
+
+    migrate_set_capability(from, "multifd", "true");
+    migrate_set_capability(to, "multifd", "true");
+
+    /* Start incoming migration from the 1st socket */
+    rsp =3D wait_command(to, "{ 'execute': 'migrate-incoming',"
+                           "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}")=
;
+    qobject_unref(rsp);
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    uri =3D migrate_get_socket_address(to, "socket-address");
+
+    migrate(from, uri, "{}");
+
+    wait_for_migration_pass(from);
+
+    printf("before cancel\n");
+    migrate_cancel(from);
+    printf("after cancel\n");
+
+    args =3D migrate_start_new();
+    args->only_target =3D true;
+
+    if (test_migrate_start(&from, &to, "defer", args)) {
+        return;
+    }
+
+    migrate_set_parameter_int(to, "multifd-channels", 16);
+
+    migrate_set_capability(to, "multifd", "true");
+
+    /* Start incoming migration from the 1st socket */
+    rsp =3D wait_command(to, "{ 'execute': 'migrate-incoming',"
+                           "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}")=
;
+    qobject_unref(rsp);
+
+    /* 300ms it should converge */
+    migrate_set_parameter_int(from, "downtime-limit", 600);
+
+    uri =3D migrate_get_socket_address(to, "socket-address");
+
+    migrate(from, uri, "{}");
+
+    wait_for_migration_pass(from);
+
+    if (!got_stop) {
+        qtest_qmp_eventwait(from, "STOP");
+    }
+    qtest_qmp_eventwait(to, "RESUME");
+
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+    test_migrate_end(from, to, true);
+    free(uri);
+}
+
 int main(int argc, char **argv)
 {
     char template[] =3D "/tmp/migration-test-XXXXXX";
@@ -1537,6 +1642,7 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/multifd/tcp/none", test_multifd_tcp_none);
     qtest_add_func("/migration/multifd/tcp/zlib", test_multifd_tcp_zlib);
     qtest_add_func("/migration/multifd/tcp/zstd", test_multifd_tcp_zstd);
+    qtest_add_func("/migration/multifd/tcp/cancel", test_multifd_tcp_cance=
l);
=20
     ret =3D g_test_run();
=20
--=20
2.23.0


