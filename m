Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CF0C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB0E21556
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdVEyEAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB0E21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifWuw-0003xI-Ni
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 17:26:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ifWpE-0005WN-K6
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ifWpD-0007Cz-A3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48959
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ifWpD-0007BJ-4x
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576189246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNgGrvFkmNVLZfL7+3vmULK8u7KYJbz6WnGVPnNlMbU=;
 b=DdVEyEAkA8mycpKlovFHeso65sh0nXH9/Pj4g9w1/l1luj+0wJoIKXLwLVvVRttBYDlS8Q
 mwIHYWAt4vWEBDN20HsnIiZHSUQbLKIVeaW98sh7tPH/wBoQRmqMQXJwPnMeGZOUnWF5rd
 m/2UCpX65+sR5L9DcK8haHNtAalsyo0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-5fOPxKwsM4-l112dZRv8ow-1; Thu, 12 Dec 2019 17:20:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BE80800D48
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 22:20:44 +0000 (UTC)
Received: from secure.mitica (ovpn-116-25.ams2.redhat.com [10.36.116.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B402310013A1;
 Thu, 12 Dec 2019 22:20:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/10] migration-test: Move memory size to common commandline
Date: Thu, 12 Dec 2019 23:20:27 +0100
Message-Id: <20191212222033.1026-5-quintela@redhat.com>
In-Reply-To: <20191212222033.1026-1-quintela@redhat.com>
References: <20191212222033.1026-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 5fOPxKwsM4-l112dZRv8ow-1
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 44 ++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 39203f6d46..18857f08f4 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -565,6 +565,7 @@ static int test_migrate_start(QTestState **from, QTestS=
tate **to,
     const char *arch =3D qtest_get_arch();
     const char *machine_type;
     const char *machine_args;
+    const char *memory_size;
=20
     opts_src =3D opts_src ? opts_src : "";
     opts_dst =3D opts_dst ? opts_dst : "";
@@ -585,15 +586,14 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         init_bootfile(bootpath, x86_bootsect, sizeof(x86_bootsect));
         machine_type =3D "";
         machine_args =3D "";
-        extra_opts =3D use_shmem ? get_shmem_opts("150M", shmem_path) : NU=
LL;
-        cmd_src =3D g_strdup_printf("-m 150M"
-                                  " -name source,debug-threads=3Don"
+        memory_size =3D "150M";
+        extra_opts =3D use_shmem ? get_shmem_opts(memory_size, shmem_path)=
 : NULL;
+        cmd_src =3D g_strdup_printf(" -name source,debug-threads=3Don"
                                   " -serial file:%s/src_serial"
                                   " -drive file=3D%s,format=3Draw %s",
                                   tmpfs, bootpath,
                                   extra_opts ? extra_opts : "");
-        cmd_dst =3D g_strdup_printf("-m 150M"
-                                  " -name target,debug-threads=3Don"
+        cmd_dst =3D g_strdup_printf(" -name target,debug-threads=3Don"
                                   " -serial file:%s/dest_serial"
                                   " -drive file=3D%s,format=3Draw"
                                   " -incoming %s %s",
@@ -605,14 +605,13 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         init_bootfile(bootpath, s390x_elf, sizeof(s390x_elf));
         machine_type =3D "";
         machine_args =3D "";
-        extra_opts =3D use_shmem ? get_shmem_opts("128M", shmem_path) : NU=
LL;
-        cmd_src =3D g_strdup_printf("-m 128M"
-                                  " -name source,debug-threads=3Don"
+        memory_size =3D "128M";
+        extra_opts =3D use_shmem ? get_shmem_opts(memory_size, shmem_path)=
 : NULL;
+        cmd_src =3D g_strdup_printf(" -name source,debug-threads=3Don"
                                   " -serial file:%s/src_serial -bios %s %s=
",
                                   tmpfs, bootpath,
                                   extra_opts ? extra_opts : "");
-        cmd_dst =3D g_strdup_printf("-m 128M"
-                                  " -name target,debug-threads=3Don"
+        cmd_dst =3D g_strdup_printf(" -name target,debug-threads=3Don"
                                   " -serial file:%s/dest_serial -bios %s"
                                   " -incoming %s %s",
                                   tmpfs, bootpath, uri,
@@ -622,8 +621,9 @@ static int test_migrate_start(QTestState **from, QTestS=
tate **to,
     } else if (strcmp(arch, "ppc64") =3D=3D 0) {
         machine_type =3D "";
         machine_args =3D ",vsmt=3D8";
-        extra_opts =3D use_shmem ? get_shmem_opts("256M", shmem_path) : NU=
LL;
-        cmd_src =3D g_strdup_printf("-m 256M -nodefaults"
+        memory_size =3D "256M";
+        extra_opts =3D use_shmem ? get_shmem_opts(memory_size, shmem_path)=
 : NULL;
+        cmd_src =3D g_strdup_printf("-nodefaults"
                                   " -name source,debug-threads=3Don"
                                   " -serial file:%s/src_serial"
                                   " -prom-env 'use-nvramrc?=3Dtrue' -prom-=
env "
@@ -631,8 +631,7 @@ static int test_migrate_start(QTestState **from, QTestS=
tate **to,
                                   "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
                                   "until' %s", tmpfs, end_address,
                                   start_address, extra_opts ? extra_opts :=
 "");
-        cmd_dst =3D g_strdup_printf("-m 256M"
-                                  " -name target,debug-threads=3Don"
+        cmd_dst =3D g_strdup_printf(" -name target,debug-threads=3Don"
                                   " -serial file:%s/dest_serial"
                                   " -incoming %s %s",
                                   tmpfs, uri,
@@ -644,14 +643,15 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         init_bootfile(bootpath, aarch64_kernel, sizeof(aarch64_kernel));
         machine_type =3D "virt,";
         machine_args =3D "gic-version=3Dmax";
-        extra_opts =3D use_shmem ? get_shmem_opts("150M", shmem_path) : NU=
LL;
+        memory_size =3D "150M";
+        extra_opts =3D use_shmem ? get_shmem_opts(memory_size, shmem_path)=
 : NULL;
         cmd_src =3D g_strdup_printf("-name vmsource,debug-threads=3Don -cp=
u max "
-                                  "-m 150M -serial file:%s/src_serial "
+                                  "-serial file:%s/src_serial "
                                   "-kernel %s %s",
                                   tmpfs, bootpath,
                                   extra_opts ? extra_opts : "");
         cmd_dst =3D g_strdup_printf("-name vmdest,debug-threads=3Don -cpu =
max "
-                                  "-m 150M -serial file:%s/dest_serial "
+                                  "-serial file:%s/dest_serial "
                                   "-kernel %s "
                                   "-incoming %s %s",
                                   tmpfs, bootpath, uri,
@@ -674,15 +674,21 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         ignore_stderr =3D "";
     }
=20
-    cmd_source =3D g_strdup_printf("-machine %saccel=3Dkvm:tcg%s %s %s %s"=
,
+    cmd_source =3D g_strdup_printf("-machine %saccel=3Dkvm:tcg%s "
+                                 "-m %s "
+                                 "%s %s %s",
                                  machine_type, machine_args,
+                                 memory_size,
                                  cmd_src, opts_src, ignore_stderr);
     g_free(cmd_src);
     *from =3D qtest_init(cmd_source);
     g_free(cmd_source);
=20
-    cmd_target =3D g_strdup_printf("-machine %saccel=3Dkvm:tcg%s %s %s %s"=
,
+    cmd_target =3D g_strdup_printf("-machine %saccel=3Dkvm:tcg%s "
+                                 "-m %s "
+                                 "%s %s %s",
                                  machine_type, machine_args,
+                                 memory_size,
                                  cmd_dst, opts_dst, ignore_stderr);
     g_free(cmd_dst);
     *to =3D qtest_init(cmd_target);
--=20
2.21.0


