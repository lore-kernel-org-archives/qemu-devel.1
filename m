Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA6CC2D0C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C7E2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RV2EP3VN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C7E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37905 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifWuw-0003xU-Ns
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 17:26:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ifWpJ-0005dr-OG
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ifWpI-0007MD-HB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32731
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ifWpI-0007LB-CI
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576189251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6/0Q3j2l+4PNvSN8GNivdWEfANnGpdF14b3fgeO7Io=;
 b=RV2EP3VNSmt/9HopcPAFdNhVYmF9OWmVJOtwwNS4Gi673fr8Y18Ze4pIi+OIFMWtdNYP81
 aRlnXBy4/v/EjQc7f5YmIFS8hP5p13NNSZE9zpsg+cbr/Mdg0xTtccQnE3iKqv1sXA7pA7
 VnpxR1Uy3KszmyuA5WTqoeX3VpPoFQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-pjC52Ux4OyyZT5SnLLEhBw-1; Thu, 12 Dec 2019 17:20:50 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2E57800053
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 22:20:49 +0000 (UTC)
Received: from secure.mitica (ovpn-116-25.ams2.redhat.com [10.36.116.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4686910013A1;
 Thu, 12 Dec 2019 22:20:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/10] migration-test: Move -serial handling to common
 commandline
Date: Thu, 12 Dec 2019 23:20:30 +0100
Message-Id: <20191212222033.1026-8-quintela@redhat.com>
In-Reply-To: <20191212222033.1026-1-quintela@redhat.com>
References: <20191212222033.1026-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: pjC52Ux4OyyZT5SnLLEhBw-1
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
 tests/migration-test.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index a83e43b7b6..85e270ca39 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -579,13 +579,10 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         machine_type =3D "";
         machine_args =3D "";
         memory_size =3D "150M";
-        cmd_src =3D g_strdup_printf(" -serial file:%s/src_serial"
-                                  " -drive file=3D%s,format=3Draw",
-                                  tmpfs, bootpath);
-        cmd_dst =3D g_strdup_printf(" -serial file:%s/dest_serial"
-                                  " -drive file=3D%s,format=3Draw"
+        cmd_src =3D g_strdup_printf("-drive file=3D%s,format=3Draw", bootp=
ath);
+        cmd_dst =3D g_strdup_printf("-drive file=3D%s,format=3Draw"
                                   " -incoming %s",
-                                  tmpfs, bootpath, uri);
+                                  bootpath, uri);
         start_address =3D X86_TEST_MEM_START;
         end_address =3D X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
@@ -593,28 +590,22 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         machine_type =3D "";
         machine_args =3D "";
         memory_size =3D "128M";
-        cmd_src =3D g_strdup_printf(" -serial file:%s/src_serial -bios %s"=
,
-                                  tmpfs, bootpath);
-        cmd_dst =3D g_strdup_printf(" -serial file:%s/dest_serial -bios %s=
"
+        cmd_src =3D g_strdup_printf("-bios %s", bootpath);
+        cmd_dst =3D g_strdup_printf("-bios %s"
                                   " -incoming %s",
-                                  tmpfs, bootpath, uri);
+                                  bootpath, uri);
         start_address =3D S390_TEST_MEM_START;
         end_address =3D S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") =3D=3D 0) {
         machine_type =3D "";
         machine_args =3D ",vsmt=3D8";
         memory_size =3D "256M";
-        cmd_src =3D g_strdup_printf("-nodefaults"
-                                  " -serial file:%s/src_serial"
-                                  " -prom-env 'use-nvramrc?=3Dtrue' -prom-=
env "
+        cmd_src =3D g_strdup_printf("-nodefaults "
+                                  "-prom-env 'use-nvramrc?=3Dtrue' -prom-e=
nv "
                                   "'nvramrc=3Dhex .\" _\" begin %x %x "
                                   "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
-                                  "until'", tmpfs, end_address,
-                                  start_address);
-        cmd_dst =3D g_strdup_printf(" -serial file:%s/dest_serial"
-                                  " -incoming %s",
-                                  tmpfs, uri);
-
+                                  "until'", end_address, start_address);
+        cmd_dst =3D g_strdup_printf(" -incoming %s", uri);
         start_address =3D PPC_TEST_MEM_START;
         end_address =3D PPC_TEST_MEM_END;
     } else if (strcmp(arch, "aarch64") =3D=3D 0) {
@@ -623,14 +614,12 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         machine_args =3D "gic-version=3Dmax";
         memory_size =3D "150M";
         cmd_src =3D g_strdup_printf("-cpu max "
-                                  "-serial file:%s/src_serial "
                                   "-kernel %s",
-                                  tmpfs, bootpath);
+                                  bootpath);
         cmd_dst =3D g_strdup_printf("-cpu max "
-                                  "-serial file:%s/dest_serial "
                                   "-kernel %s "
                                   "-incoming %s",
-                                  tmpfs, bootpath, uri);
+                                  bootpath, uri);
=20
         start_address =3D ARM_TEST_MEM_START;
         end_address =3D ARM_TEST_MEM_END;
@@ -661,10 +650,11 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
=20
     cmd_source =3D g_strdup_printf("-machine %saccel=3Dkvm:tcg%s "
                                  "-name source,debug-threads=3Don "
+                                 "-serial file:%s/src_serial "
                                  "-m %s "
                                  "%s %s %s %s",
                                  machine_type, machine_args,
-                                 memory_size,
+                                 tmpfs, memory_size,
                                  cmd_src, shmem_opts, opts_src, ignore_std=
err);
     g_free(cmd_src);
     *from =3D qtest_init(cmd_source);
@@ -673,9 +663,10 @@ static int test_migrate_start(QTestState **from, QTest=
State **to,
     cmd_target =3D g_strdup_printf("-machine %saccel=3Dkvm:tcg%s "
                                  "-name target,debug-threads=3Don "
                                  "-m %s "
+                                 "-serial file:%s/dest_serial "
                                  "%s %s %s %s",
                                  machine_type, machine_args,
-                                 memory_size,
+                                 tmpfs, memory_size,
                                  cmd_dst, shmem_opts, opts_dst, ignore_std=
err);
     g_free(cmd_dst);
     *to =3D qtest_init(cmd_target);
--=20
2.21.0


