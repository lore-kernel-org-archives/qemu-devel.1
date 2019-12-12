Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E91C00454
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:25:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE8721556
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrh4kpzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE8721556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifWtN-000214-3h
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 17:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ifWpA-0005TN-NX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ifWp8-00072j-IC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20178
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ifWp8-0006zt-CX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576189241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i+W+SQAH4sUESDyCploIK0GiEUJo5xrSHvHZ6VJfePY=;
 b=hrh4kpzH982XJCBrzz9UuM/rIjaLLQDOJnBb0mKBYLJkjBQxxvPZ6yBus481+yqN6EL5rT
 NZi9f1FcoFTkkXsebbW8BqNGHO77NsCjRhRmSWsO832LbYbeOITthxUE1KbMQxV4Ux/IcY
 mqG4romthZBEAD4xvV1gyyh/uwp//r4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-cXl3SluAO6KUZC-CPuOI5w-1; Thu, 12 Dec 2019 17:20:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA047107ACC7
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 22:20:38 +0000 (UTC)
Received: from secure.mitica (ovpn-116-25.ams2.redhat.com [10.36.116.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04DC810013A1;
 Thu, 12 Dec 2019 22:20:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/10] migration-test: Create cmd_soure and cmd_target
Date: Thu, 12 Dec 2019 23:20:24 +0100
Message-Id: <20191212222033.1026-2-quintela@redhat.com>
In-Reply-To: <20191212222033.1026-1-quintela@redhat.com>
References: <20191212222033.1026-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: cXl3SluAO6KUZC-CPuOI5w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are repeating almost everything for each machine while creating the
command line for migration.  And once for source and another for
destination.  We start putting there opts_src and opts_dst.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 44 ++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index ebd77a581a..9573861ede 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -557,6 +557,7 @@ static int test_migrate_start(QTestState **from, QTestS=
tate **to,
                                const char *opts_dst)
 {
     gchar *cmd_src, *cmd_dst;
+    gchar *cmd_source, *cmd_target;
     char *bootpath =3D NULL;
     char *extra_opts =3D NULL;
     char *shmem_path =3D NULL;
@@ -584,16 +585,16 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         cmd_src =3D g_strdup_printf("-machine accel=3D%s -m 150M"
                                   " -name source,debug-threads=3Don"
                                   " -serial file:%s/src_serial"
-                                  " -drive file=3D%s,format=3Draw %s %s",
+                                  " -drive file=3D%s,format=3Draw %s",
                                   accel, tmpfs, bootpath,
-                                  extra_opts ? extra_opts : "", opts_src);
+                                  extra_opts ? extra_opts : "");
         cmd_dst =3D g_strdup_printf("-machine accel=3D%s -m 150M"
                                   " -name target,debug-threads=3Don"
                                   " -serial file:%s/dest_serial"
                                   " -drive file=3D%s,format=3Draw"
-                                  " -incoming %s %s %s",
+                                  " -incoming %s %s",
                                   accel, tmpfs, bootpath, uri,
-                                  extra_opts ? extra_opts : "", opts_dst);
+                                  extra_opts ? extra_opts : "");
         start_address =3D X86_TEST_MEM_START;
         end_address =3D X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
@@ -601,15 +602,15 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         extra_opts =3D use_shmem ? get_shmem_opts("128M", shmem_path) : NU=
LL;
         cmd_src =3D g_strdup_printf("-machine accel=3D%s -m 128M"
                                   " -name source,debug-threads=3Don"
-                                  " -serial file:%s/src_serial -bios %s %s=
 %s",
+                                  " -serial file:%s/src_serial -bios %s %s=
",
                                   accel, tmpfs, bootpath,
-                                  extra_opts ? extra_opts : "", opts_src);
+                                  extra_opts ? extra_opts : "");
         cmd_dst =3D g_strdup_printf("-machine accel=3D%s -m 128M"
                                   " -name target,debug-threads=3Don"
                                   " -serial file:%s/dest_serial -bios %s"
-                                  " -incoming %s %s %s",
+                                  " -incoming %s %s",
                                   accel, tmpfs, bootpath, uri,
-                                  extra_opts ? extra_opts : "", opts_dst);
+                                  extra_opts ? extra_opts : "");
         start_address =3D S390_TEST_MEM_START;
         end_address =3D S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") =3D=3D 0) {
@@ -620,15 +621,14 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
                                   " -prom-env 'use-nvramrc?=3Dtrue' -prom-=
env "
                                   "'nvramrc=3Dhex .\" _\" begin %x %x "
                                   "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
-                                  "until' %s %s",  accel, tmpfs, end_addre=
ss,
-                                  start_address, extra_opts ? extra_opts :=
 "",
-                                  opts_src);
+                                  "until' %s",  accel, tmpfs, end_address,
+                                  start_address, extra_opts ? extra_opts :=
 "");
         cmd_dst =3D g_strdup_printf("-machine accel=3D%s,vsmt=3D8 -m 256M"
                                   " -name target,debug-threads=3Don"
                                   " -serial file:%s/dest_serial"
-                                  " -incoming %s %s %s",
+                                  " -incoming %s %s",
                                   accel, tmpfs, uri,
-                                  extra_opts ? extra_opts : "", opts_dst);
+                                  extra_opts ? extra_opts : "");
=20
         start_address =3D PPC_TEST_MEM_START;
         end_address =3D PPC_TEST_MEM_END;
@@ -638,16 +638,16 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         cmd_src =3D g_strdup_printf("-machine virt,accel=3D%s,gic-version=
=3Dmax "
                                   "-name vmsource,debug-threads=3Don -cpu =
max "
                                   "-m 150M -serial file:%s/src_serial "
-                                  "-kernel %s %s %s",
+                                  "-kernel %s %s",
                                   accel, tmpfs, bootpath,
-                                  extra_opts ? extra_opts : "", opts_src);
+                                  extra_opts ? extra_opts : "");
         cmd_dst =3D g_strdup_printf("-machine virt,accel=3D%s,gic-version=
=3Dmax "
                                   "-name vmdest,debug-threads=3Don -cpu ma=
x "
                                   "-m 150M -serial file:%s/dest_serial "
                                   "-kernel %s "
-                                  "-incoming %s %s %s",
+                                  "-incoming %s %s",
                                   accel, tmpfs, bootpath, uri,
-                                  extra_opts ? extra_opts : "", opts_dst);
+                                  extra_opts ? extra_opts : "");
=20
         start_address =3D ARM_TEST_MEM_START;
         end_address =3D ARM_TEST_MEM_END;
@@ -671,11 +671,17 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         cmd_dst =3D tmp;
     }
=20
-    *from =3D qtest_init(cmd_src);
+    cmd_source =3D g_strdup_printf("%s %s",
+                                 cmd_src, opts_src);
     g_free(cmd_src);
+    *from =3D qtest_init(cmd_source);
+    g_free(cmd_source);
=20
-    *to =3D qtest_init(cmd_dst);
+    cmd_target =3D g_strdup_printf("%s %s",
+                                 cmd_dst, opts_dst);
     g_free(cmd_dst);
+    *to =3D qtest_init(cmd_target);
+    g_free(cmd_target);
=20
     /*
      * Remove shmem file immediately to avoid memory leak in test failed c=
ase.
--=20
2.21.0


