Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA58C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 02:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ADA921775
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 02:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNwvLlMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADA921775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48425 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihOhY-0005nR-Pb
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 21:04:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ihOYy-0004Nb-5w
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 20:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ihOYw-0004cL-VY
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 20:55:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26419
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ihOYw-0004a9-Rb
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 20:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576634141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CSERinvXz0u7tspqLC1kgiqIWn45G+555/T5p3hqE90=;
 b=aNwvLlMhFRLrfPcKm4I8B9SAUGZl6WOa5hr5lclVrCfoYd2KLezfNQJAmCq3k8hfOFxv9L
 efBFEDwsEkT93MElomeWrD9th7HiHKzRP3IhkFTaBcbkiN1lBhc+FPFqAzLVrXICg+WZJd
 OJ6M987mho7var4Yj5GLTS8bfmkxaGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-ayyW3zK5PH6zo9mQtCcdhQ-1; Tue, 17 Dec 2019 20:55:39 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 478CB18C35A0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 01:55:38 +0000 (UTC)
Received: from secure.mitica (ovpn-116-32.ams2.redhat.com [10.36.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEE056886F;
 Wed, 18 Dec 2019 01:55:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/10] migration-test: Move -incomming handling to common
 commandline
Date: Wed, 18 Dec 2019 02:55:18 +0100
Message-Id: <20191218015520.2881-9-quintela@redhat.com>
In-Reply-To: <20191218015520.2881-1-quintela@redhat.com>
References: <20191218015520.2881-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ayyW3zK5PH6zo9mQtCcdhQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 tests/migration-test.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index e1304d70fc..14f2ce30fb 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -580,9 +580,7 @@ static int test_migrate_start(QTestState **from, QTestS=
tate **to,
         machine_args =3D "";
         memory_size =3D "150M";
         cmd_src =3D g_strdup_printf("-drive file=3D%s,format=3Draw", bootp=
ath);
-        cmd_dst =3D g_strdup_printf("-drive file=3D%s,format=3Draw"
-                                  " -incoming %s",
-                                  bootpath, uri);
+        cmd_dst =3D g_strdup(cmd_src);
         start_address =3D X86_TEST_MEM_START;
         end_address =3D X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
@@ -591,9 +589,7 @@ static int test_migrate_start(QTestState **from, QTestS=
tate **to,
         machine_args =3D "";
         memory_size =3D "128M";
         cmd_src =3D g_strdup_printf("-bios %s", bootpath);
-        cmd_dst =3D g_strdup_printf("-bios %s"
-                                  " -incoming %s",
-                                  bootpath, uri);
+        cmd_dst =3D g_strdup(cmd_src);
         start_address =3D S390_TEST_MEM_START;
         end_address =3D S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") =3D=3D 0) {
@@ -605,7 +601,7 @@ static int test_migrate_start(QTestState **from, QTestS=
tate **to,
                                   "'nvramrc=3Dhex .\" _\" begin %x %x "
                                   "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
                                   "until'", end_address, start_address);
-        cmd_dst =3D g_strdup_printf(" -incoming %s", uri);
+        cmd_dst =3D g_strdup("");
         start_address =3D PPC_TEST_MEM_START;
         end_address =3D PPC_TEST_MEM_END;
     } else if (strcmp(arch, "aarch64") =3D=3D 0) {
@@ -616,11 +612,7 @@ static int test_migrate_start(QTestState **from, QTest=
State **to,
         cmd_src =3D g_strdup_printf("-cpu max "
                                   "-kernel %s",
                                   bootpath);
-        cmd_dst =3D g_strdup_printf("-cpu max "
-                                  "-kernel %s "
-                                  "-incoming %s",
-                                  bootpath, uri);
-
+        cmd_dst =3D g_strdup(cmd_src);
         start_address =3D ARM_TEST_MEM_START;
         end_address =3D ARM_TEST_MEM_END;
=20
@@ -650,11 +642,11 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
=20
     cmd_source =3D g_strdup_printf("-machine %saccel=3Dkvm:tcg%s "
                                  "-name source,debug-threads=3Don "
-                                 "-serial file:%s/src_serial "
                                  "-m %s "
+                                 "-serial file:%s/src_serial "
                                  "%s %s %s %s",
                                  machine_type, machine_args,
-                                 tmpfs, memory_size,
+                                 memory_size, tmpfs,
                                  cmd_src, shmem_opts, opts_src, ignore_std=
err);
     g_free(cmd_src);
     *from =3D qtest_init(cmd_source);
@@ -664,9 +656,10 @@ static int test_migrate_start(QTestState **from, QTest=
State **to,
                                  "-name target,debug-threads=3Don "
                                  "-m %s "
                                  "-serial file:%s/dest_serial "
+                                 "-incoming %s "
                                  "%s %s %s %s",
                                  machine_type, machine_args,
-                                 tmpfs, memory_size,
+                                 memory_size, tmpfs, uri,
                                  cmd_dst, shmem_opts, opts_dst, ignore_std=
err);
     g_free(cmd_dst);
     *to =3D qtest_init(cmd_target);
--=20
2.23.0


