Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921E0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573C721835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1tokhBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573C721835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iubjn-0006uQ-7W
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 07:37:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iub8M-0001PE-8P
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iub8K-0004fW-Vi
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:58:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28456
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iub8K-0004fN-SF
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iwZEYBBew8lo3lmUNJWPGzVep9D+rbOYQ2y34LZoLwU=;
 b=K1tokhBWxs+Tn8YYxN+4fb9QVFPRYi3yZY5MFHGz7cJ3RCeHBD7av9SzwhVH/ggZ0jfUIt
 muNK/CuctMj+8J9Tg30XbPc4YcDh3GHeAVT7DiTXUvLdHGM5/AOM4W/thbr0eanfLsNZXs
 cHg/GOhC5/pPdM1Asw0td1muMffv7aw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-DkoFpFiLPVS2z_mbH79HAw-1; Thu, 23 Jan 2020 06:58:46 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66941477
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:58:45 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A20219C69;
 Thu, 23 Jan 2020 11:58:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/21] migration-test: Make sure that multifd and cancel
 works
Date: Thu, 23 Jan 2020 12:58:14 +0100
Message-Id: <20200123115831.36842-5-quintela@redhat.com>
In-Reply-To: <20200123115831.36842-1-quintela@redhat.com>
References: <20200123115831.36842-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: DkoFpFiLPVS2z_mbH79HAw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>

---

- Wait for 1st trhead to move to cancelled before launching second
  migration
- Add 'to2' parameter to diferentiate 1st and second target.
- Use g_free() instead of free()
---
 tests/qtest/migration-test.c | 112 ++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b6a74a05ce..cf27ebbc9d 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -424,6 +424,14 @@ static void migrate_recover(QTestState *who, const cha=
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
@@ -456,6 +464,8 @@ static void migrate_postcopy_start(QTestState *from, QT=
estState *to)
 typedef struct {
     bool hide_stderr;
     bool use_shmem;
+    /* only launch the target process */
+    bool only_target;
     char *opts_source;
     char *opts_target;
 } MigrateStart;
@@ -571,7 +581,9 @@ static int test_migrate_start(QTestState **from, QTestS=
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
     cmd_target =3D g_strdup_printf("-accel kvm -accel tcg%s%s "
@@ -1294,6 +1306,103 @@ static void test_multifd_tcp(void)
     g_free(uri);
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
+    QTestState *from, *to, *to2;
+    QDict *rsp;
+    char *uri;
+
+    args->hide_stderr =3D true;
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
+    /* 300MB/s */
+    migrate_set_parameter_int(from, "max-bandwidth", 30000000);
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
+    migrate_qmp(from, uri, "{}");
+
+    wait_for_migration_pass(from);
+
+    migrate_cancel(from);
+
+    args =3D migrate_start_new();
+    args->only_target =3D true;
+
+    if (test_migrate_start(&from, &to2, "defer", args)) {
+        return;
+    }
+
+    migrate_set_parameter_int(to2, "multifd-channels", 16);
+
+    migrate_set_capability(to2, "multifd", "true");
+
+    /* Start incoming migration from the 1st socket */
+    rsp =3D wait_command(to2, "{ 'execute': 'migrate-incoming',"
+                            "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}"=
);
+    qobject_unref(rsp);
+
+    uri =3D migrate_get_socket_address(to2, "socket-address");
+
+    wait_for_migration_status(from, "cancelled", NULL);
+
+    /* 300ms it should converge */
+    migrate_set_parameter_int(from, "downtime-limit", 300);
+    /* 1GB/s */
+    migrate_set_parameter_int(from, "max-bandwidth", 1000000000);
+
+    migrate_qmp(from, uri, "{}");
+
+    wait_for_migration_pass(from);
+
+    if (!got_stop) {
+        qtest_qmp_eventwait(from, "STOP");
+    }
+    qtest_qmp_eventwait(to2, "RESUME");
+
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+    test_migrate_end(from, to2, true);
+    g_free(uri);
+}
+
 int main(int argc, char **argv)
 {
     char template[] =3D "/tmp/migration-test-XXXXXX";
@@ -1359,6 +1468,7 @@ int main(int argc, char **argv)
=20
     qtest_add_func("/migration/auto_converge", test_migrate_auto_converge)=
;
     qtest_add_func("/migration/multifd/tcp", test_multifd_tcp);
+    qtest_add_func("/migration/multifd/tcp/cancel", test_multifd_tcp_cance=
l);
=20
     ret =3D g_test_run();
=20
--=20
2.24.1


