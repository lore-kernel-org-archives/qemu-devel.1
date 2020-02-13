Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45F4C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FFC320873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIM83V7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FFC320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ESv-0001ws-Q2
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2EQd-0006VP-Gj
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2EQc-0007rd-BU
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:21:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41944
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2EQc-0007rD-7P
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581600073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kKg2syVySPTKKTaxIlMZ4/nfHaH90SGJTpSM4vIU9JY=;
 b=LIM83V7A9LA5GDu9ixspUI22KtQk2PbIrYzZLeO1xaYOB1kyUAty1lY0aTewR6FWQBRYCp
 TXImdv2mTOujtCBuArzvN5Mbo3BRM3W4MdM/GCmLts5IvFRx4IOq0i931oFHUWACxj5ZuV
 HBUL8vMTF+yBzv3utTwUqCIFIIlFDx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-_ZdXER3DOBKYrXwZ6_SEcg-1; Thu, 13 Feb 2020 08:21:11 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 021F389A09B;
 Thu, 13 Feb 2020 13:21:10 +0000 (UTC)
Received: from secure.mitica (ovpn-116-211.ams2.redhat.com [10.36.116.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 341A45C1D8;
 Thu, 13 Feb 2020 13:21:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/6] migration-test: fix some memleaks in migration-test
Date: Thu, 13 Feb 2020 14:20:29 +0100
Message-Id: <20200213132030.57757-6-quintela@redhat.com>
In-Reply-To: <20200213132030.57757-1-quintela@redhat.com>
References: <20200213132030.57757-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: _ZdXER3DOBKYrXwZ6_SEcg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Juan Quintela <quintela@redhat.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

spotted by asan, 'check-qtest-aarch64' runs fail if sanitizers is enabled.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index a78ac0c7da..ccf313f288 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -498,11 +498,13 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
     const char *arch =3D qtest_get_arch();
     const char *machine_opts =3D NULL;
     const char *memory_size;
+    int ret =3D 0;
=20
     if (args->use_shmem) {
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
             g_test_skip("/dev/shm is not supported");
-            return -1;
+            ret =3D -1;
+            goto out;
         }
     }
=20
@@ -611,8 +613,9 @@ static int test_migrate_start(QTestState **from, QTestS=
tate **to,
         g_free(shmem_path);
     }
=20
+out:
     migrate_start_destroy(args);
-    return 0;
+    return ret;
 }
=20
 static void test_migrate_end(QTestState *from, QTestState *to, bool test_d=
est)
@@ -1134,6 +1137,8 @@ static void test_validate_uuid(void)
 {
     MigrateStart *args =3D migrate_start_new();
=20
+    g_free(args->opts_source);
+    g_free(args->opts_target);
     args->opts_source =3D g_strdup("-uuid 11111111-1111-1111-1111-11111111=
1111");
     args->opts_target =3D g_strdup("-uuid 11111111-1111-1111-1111-11111111=
1111");
     do_test_validate_uuid(args, false);
@@ -1143,6 +1148,8 @@ static void test_validate_uuid_error(void)
 {
     MigrateStart *args =3D migrate_start_new();
=20
+    g_free(args->opts_source);
+    g_free(args->opts_target);
     args->opts_source =3D g_strdup("-uuid 11111111-1111-1111-1111-11111111=
1111");
     args->opts_target =3D g_strdup("-uuid 22222222-2222-2222-2222-22222222=
2222");
     args->hide_stderr =3D true;
@@ -1153,6 +1160,7 @@ static void test_validate_uuid_src_not_set(void)
 {
     MigrateStart *args =3D migrate_start_new();
=20
+    g_free(args->opts_target);
     args->opts_target =3D g_strdup("-uuid 22222222-2222-2222-2222-22222222=
2222");
     args->hide_stderr =3D true;
     do_test_validate_uuid(args, false);
@@ -1162,6 +1170,7 @@ static void test_validate_uuid_dst_not_set(void)
 {
     MigrateStart *args =3D migrate_start_new();
=20
+    g_free(args->opts_source);
     args->opts_source =3D g_strdup("-uuid 11111111-1111-1111-1111-11111111=
1111");
     args->hide_stderr =3D true;
     do_test_validate_uuid(args, false);
@@ -1380,6 +1389,7 @@ static void test_multifd_tcp_cancel(void)
                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}"=
);
     qobject_unref(rsp);
=20
+    g_free(uri);
     uri =3D migrate_get_socket_address(to2, "socket-address");
=20
     wait_for_migration_status(from, "cancelled", NULL);
--=20
2.24.1


