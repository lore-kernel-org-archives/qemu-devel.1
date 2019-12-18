Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DA0C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 01:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 450922176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 01:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eT1E18MM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450922176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihOaC-0005Yy-Bq
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 20:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ihOYu-0004LT-4c
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 20:55:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ihOYs-0004Wp-Jo
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 20:55:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46267
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ihOYq-0004S2-Nn
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 20:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576634135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e6M9ZYPAd5b2ngSaOUhCXNlAyhIB+hjXtewLr2+i5ak=;
 b=eT1E18MMpDROPIptFxXs1UuidY2izr4Pxh1H5atvVxvQbYSfZ3vVUegK8ZpLz7b+FFGWQY
 hjxdULtsggyac6Gj8AS0lFUIF/luv23cBT7RaXAUnugNGzfZCi/Hn+9dur3dbMWuaGARv/
 1FMnBpx6JH3JVPbglM1Bt4TUGqXmxoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-jo5znXNnOqOpIv_3G8o1nQ-1; Tue, 17 Dec 2019 20:55:33 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B399010054E3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 01:55:32 +0000 (UTC)
Received: from secure.mitica (ovpn-116-32.ams2.redhat.com [10.36.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3823868880;
 Wed, 18 Dec 2019 01:55:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/10] migration-test: Move shmem handling to common
 commandline
Date: Wed, 18 Dec 2019 02:55:15 +0100
Message-Id: <20191218015520.2881-6-quintela@redhat.com>
In-Reply-To: <20191218015520.2881-1-quintela@redhat.com>
References: <20191218015520.2881-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: jo5znXNnOqOpIv_3G8o1nQ-1
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 76 +++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 42 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 9d40f2d30c..e17d432043 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -380,13 +380,6 @@ static void cleanup(const char *filename)
     g_free(path);
 }
=20
-static char *get_shmem_opts(const char *mem_size, const char *shmem_path)
-{
-    return g_strdup_printf("-object memory-backend-file,id=3Dmem0,size=3D%=
s"
-                           ",mem-path=3D%s,share=3Don -numa node,memdev=3D=
mem0",
-                           mem_size, shmem_path);
-}
-
 static char *SocketAddress_to_str(SocketAddress *addr)
 {
     switch (addr->type) {
@@ -560,8 +553,8 @@ static int test_migrate_start(QTestState **from, QTestS=
tate **to,
     gchar *cmd_source, *cmd_target;
     const gchar *ignore_stderr;
     char *bootpath =3D NULL;
-    char *extra_opts =3D NULL;
-    char *shmem_path =3D NULL;
+    char *shmem_opts;
+    char *shmem_path;
     const char *arch =3D qtest_get_arch();
     const char *machine_type;
     const char *machine_args;
@@ -575,7 +568,6 @@ static int test_migrate_start(QTestState **from, QTestS=
tate **to,
             g_test_skip("/dev/shm is not supported");
             return -1;
         }
-        shmem_path =3D g_strdup_printf("/dev/shm/qemu-%d", getpid());
     }
=20
     got_stop =3D false;
@@ -587,18 +579,15 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         machine_type =3D "";
         machine_args =3D "";
         memory_size =3D "150M";
-        extra_opts =3D use_shmem ? get_shmem_opts(memory_size, shmem_path)=
 : NULL;
         cmd_src =3D g_strdup_printf(" -name source,debug-threads=3Don"
                                   " -serial file:%s/src_serial"
-                                  " -drive file=3D%s,format=3Draw %s",
-                                  tmpfs, bootpath,
-                                  extra_opts ? extra_opts : "");
+                                  " -drive file=3D%s,format=3Draw",
+                                  tmpfs, bootpath);
         cmd_dst =3D g_strdup_printf(" -name target,debug-threads=3Don"
                                   " -serial file:%s/dest_serial"
                                   " -drive file=3D%s,format=3Draw"
-                                  " -incoming %s %s",
-                                  tmpfs, bootpath, uri,
-                                  extra_opts ? extra_opts : "");
+                                  " -incoming %s",
+                                  tmpfs, bootpath, uri);
         start_address =3D X86_TEST_MEM_START;
         end_address =3D X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
@@ -606,36 +595,31 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         machine_type =3D "";
         machine_args =3D "";
         memory_size =3D "128M";
-        extra_opts =3D use_shmem ? get_shmem_opts(memory_size, shmem_path)=
 : NULL;
         cmd_src =3D g_strdup_printf(" -name source,debug-threads=3Don"
-                                  " -serial file:%s/src_serial -bios %s %s=
",
-                                  tmpfs, bootpath,
-                                  extra_opts ? extra_opts : "");
+                                  " -serial file:%s/src_serial -bios %s",
+                                  tmpfs, bootpath);
         cmd_dst =3D g_strdup_printf(" -name target,debug-threads=3Don"
                                   " -serial file:%s/dest_serial -bios %s"
-                                  " -incoming %s %s",
-                                  tmpfs, bootpath, uri,
-                                  extra_opts ? extra_opts : "");
+                                  " -incoming %s",
+                                  tmpfs, bootpath, uri);
         start_address =3D S390_TEST_MEM_START;
         end_address =3D S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") =3D=3D 0) {
         machine_type =3D "";
         machine_args =3D ",vsmt=3D8";
         memory_size =3D "256M";
-        extra_opts =3D use_shmem ? get_shmem_opts(memory_size, shmem_path)=
 : NULL;
         cmd_src =3D g_strdup_printf("-nodefaults"
                                   " -name source,debug-threads=3Don"
                                   " -serial file:%s/src_serial"
                                   " -prom-env 'use-nvramrc?=3Dtrue' -prom-=
env "
                                   "'nvramrc=3Dhex .\" _\" begin %x %x "
                                   "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
-                                  "until' %s", tmpfs, end_address,
-                                  start_address, extra_opts ? extra_opts :=
 "");
+                                  "until'", tmpfs, end_address,
+                                  start_address);
         cmd_dst =3D g_strdup_printf(" -name target,debug-threads=3Don"
                                   " -serial file:%s/dest_serial"
-                                  " -incoming %s %s",
-                                  tmpfs, uri,
-                                  extra_opts ? extra_opts : "");
+                                  " -incoming %s",
+                                  tmpfs, uri);
=20
         start_address =3D PPC_TEST_MEM_START;
         end_address =3D PPC_TEST_MEM_END;
@@ -644,18 +628,15 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         machine_type =3D "virt,";
         machine_args =3D "gic-version=3Dmax";
         memory_size =3D "150M";
-        extra_opts =3D use_shmem ? get_shmem_opts(memory_size, shmem_path)=
 : NULL;
         cmd_src =3D g_strdup_printf("-name vmsource,debug-threads=3Don -cp=
u max "
                                   "-serial file:%s/src_serial "
-                                  "-kernel %s %s",
-                                  tmpfs, bootpath,
-                                  extra_opts ? extra_opts : "");
+                                  "-kernel %s",
+                                  tmpfs, bootpath);
         cmd_dst =3D g_strdup_printf("-name vmdest,debug-threads=3Don -cpu =
max "
                                   "-serial file:%s/dest_serial "
                                   "-kernel %s "
-                                  "-incoming %s %s",
-                                  tmpfs, bootpath, uri,
-                                  extra_opts ? extra_opts : "");
+                                  "-incoming %s",
+                                  tmpfs, bootpath, uri);
=20
         start_address =3D ARM_TEST_MEM_START;
         end_address =3D ARM_TEST_MEM_END;
@@ -666,7 +647,6 @@ static int test_migrate_start(QTestState **from, QTestS=
tate **to,
     }
=20
     g_free(bootpath);
-    g_free(extra_opts);
=20
     if (hide_stderr) {
         ignore_stderr =3D "2>/dev/null";
@@ -674,26 +654,38 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         ignore_stderr =3D "";
     }
=20
+    if (use_shmem) {
+        shmem_path =3D g_strdup_printf("/dev/shm/qemu-%d", getpid());
+        shmem_opts =3D g_strdup_printf(
+            "-object memory-backend-file,id=3Dmem0,size=3D%s"
+            ",mem-path=3D%s,share=3Don -numa node,memdev=3Dmem0",
+            memory_size, shmem_path);
+    } else {
+        shmem_path =3D NULL;
+        shmem_opts =3D g_strdup("");
+    }
+
     cmd_source =3D g_strdup_printf("-machine %saccel=3Dkvm:tcg%s "
                                  "-m %s "
-                                 "%s %s %s",
+                                 "%s %s %s %s",
                                  machine_type, machine_args,
                                  memory_size,
-                                 cmd_src, opts_src, ignore_stderr);
+                                 cmd_src, shmem_opts, opts_src, ignore_std=
err);
     g_free(cmd_src);
     *from =3D qtest_init(cmd_source);
     g_free(cmd_source);
=20
     cmd_target =3D g_strdup_printf("-machine %saccel=3Dkvm:tcg%s "
                                  "-m %s "
-                                 "%s %s %s",
+                                 "%s %s %s %s",
                                  machine_type, machine_args,
                                  memory_size,
-                                 cmd_dst, opts_dst, ignore_stderr);
+                                 cmd_dst, shmem_opts, opts_dst, ignore_std=
err);
     g_free(cmd_dst);
     *to =3D qtest_init(cmd_target);
     g_free(cmd_target);
=20
+    g_free(shmem_opts);
     /*
      * Remove shmem file immediately to avoid memory leak in test failed c=
ase.
      * It's valid becase QEMU has already opened this file
--=20
2.23.0


