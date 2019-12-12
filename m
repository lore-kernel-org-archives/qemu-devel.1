Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE44C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FA121556
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmM6w/rb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FA121556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifWxT-0006SG-Px
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 17:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ifWpK-0005eD-1O
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ifWpI-0007Mo-Og
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32300
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ifWpI-0007LS-Kh
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576189252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0w7WovLcGiIOEr3DtPfw0C/dgLJ5qTeFwH1j1g+SVgU=;
 b=gmM6w/rbBvcRY5tOwCFSnVqEM6dDJjAK+L8aRwY6n/dzALSMD/LUaNuSARMVq02HrQ+g37
 R3czJ1o8ZDMufSonMnGlXd+q+yjPtbq3WCJtrKsl85y3LDwU4KjPDHAXRU9dHs+EpB1NOp
 I+nBLqv5vdgikwGAOLDa6txAkJYFWsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-w9utus2qMj2GzvGhVxFQ7Q-1; Thu, 12 Dec 2019 17:20:48 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5BD11854CE0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 22:20:47 +0000 (UTC)
Received: from secure.mitica (ovpn-116-25.ams2.redhat.com [10.36.116.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B3E310013A1;
 Thu, 12 Dec 2019 22:20:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/10] migration-test: Move -name handling to common
 commandline
Date: Thu, 12 Dec 2019 23:20:29 +0100
Message-Id: <20191212222033.1026-7-quintela@redhat.com>
In-Reply-To: <20191212222033.1026-1-quintela@redhat.com>
References: <20191212222033.1026-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: w9utus2qMj2GzvGhVxFQ7Q-1
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 85c98f0f9c..a83e43b7b6 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -579,12 +579,10 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         machine_type =3D "";
         machine_args =3D "";
         memory_size =3D "150M";
-        cmd_src =3D g_strdup_printf(" -name source,debug-threads=3Don"
-                                  " -serial file:%s/src_serial"
+        cmd_src =3D g_strdup_printf(" -serial file:%s/src_serial"
                                   " -drive file=3D%s,format=3Draw",
                                   tmpfs, bootpath);
-        cmd_dst =3D g_strdup_printf(" -name target,debug-threads=3Don"
-                                  " -serial file:%s/dest_serial"
+        cmd_dst =3D g_strdup_printf(" -serial file:%s/dest_serial"
                                   " -drive file=3D%s,format=3Draw"
                                   " -incoming %s",
                                   tmpfs, bootpath, uri);
@@ -595,11 +593,9 @@ static int test_migrate_start(QTestState **from, QTest=
State **to,
         machine_type =3D "";
         machine_args =3D "";
         memory_size =3D "128M";
-        cmd_src =3D g_strdup_printf(" -name source,debug-threads=3Don"
-                                  " -serial file:%s/src_serial -bios %s",
+        cmd_src =3D g_strdup_printf(" -serial file:%s/src_serial -bios %s"=
,
                                   tmpfs, bootpath);
-        cmd_dst =3D g_strdup_printf(" -name target,debug-threads=3Don"
-                                  " -serial file:%s/dest_serial -bios %s"
+        cmd_dst =3D g_strdup_printf(" -serial file:%s/dest_serial -bios %s=
"
                                   " -incoming %s",
                                   tmpfs, bootpath, uri);
         start_address =3D S390_TEST_MEM_START;
@@ -609,15 +605,13 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         machine_args =3D ",vsmt=3D8";
         memory_size =3D "256M";
         cmd_src =3D g_strdup_printf("-nodefaults"
-                                  " -name source,debug-threads=3Don"
                                   " -serial file:%s/src_serial"
                                   " -prom-env 'use-nvramrc?=3Dtrue' -prom-=
env "
                                   "'nvramrc=3Dhex .\" _\" begin %x %x "
                                   "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
                                   "until'", tmpfs, end_address,
                                   start_address);
-        cmd_dst =3D g_strdup_printf(" -name target,debug-threads=3Don"
-                                  " -serial file:%s/dest_serial"
+        cmd_dst =3D g_strdup_printf(" -serial file:%s/dest_serial"
                                   " -incoming %s",
                                   tmpfs, uri);
=20
@@ -628,11 +622,11 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         machine_type =3D "virt,";
         machine_args =3D "gic-version=3Dmax";
         memory_size =3D "150M";
-        cmd_src =3D g_strdup_printf("-name vmsource,debug-threads=3Don -cp=
u max "
+        cmd_src =3D g_strdup_printf("-cpu max "
                                   "-serial file:%s/src_serial "
                                   "-kernel %s",
                                   tmpfs, bootpath);
-        cmd_dst =3D g_strdup_printf("-name vmdest,debug-threads=3Don -cpu =
max "
+        cmd_dst =3D g_strdup_printf("-cpu max "
                                   "-serial file:%s/dest_serial "
                                   "-kernel %s "
                                   "-incoming %s",
@@ -666,6 +660,7 @@ static int test_migrate_start(QTestState **from, QTestS=
tate **to,
     }
=20
     cmd_source =3D g_strdup_printf("-machine %saccel=3Dkvm:tcg%s "
+                                 "-name source,debug-threads=3Don "
                                  "-m %s "
                                  "%s %s %s %s",
                                  machine_type, machine_args,
@@ -676,6 +671,7 @@ static int test_migrate_start(QTestState **from, QTestS=
tate **to,
     g_free(cmd_source);
=20
     cmd_target =3D g_strdup_printf("-machine %saccel=3Dkvm:tcg%s "
+                                 "-name target,debug-threads=3Don "
                                  "-m %s "
                                  "%s %s %s %s",
                                  machine_type, machine_args,
--=20
2.21.0


