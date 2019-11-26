Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0F2C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 06:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58CC72071A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 06:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="h1ek9pH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CC72071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZUG8-0007En-Cn
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 01:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iZU91-0007Ip-AS
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 01:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iZTvF-0004N5-Sy
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 01:02:03 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:39575 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iZTvE-0004KO-W3; Tue, 26 Nov 2019 01:02:01 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47MYFc2RSmz9sPW; Tue, 26 Nov 2019 17:01:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574748116;
 bh=DBWNlmEdXRBvV4bu8GympRzKtyJTqOVJKjfUJEgfyh0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h1ek9pH5qjU3bpzE4RCbtHRMi0rHSg0ypZIikEnBaSIOOW8bfcZX8VxKhYO6f2dmj
 /j/VPtVKau8b95drcRWdeB2JlthLqfFM/XSjF48R2f5mT5n+BdnWJ+Mkox7JLNhvYt
 kn4YJ/3haUbHMNPVnPDBPMEv7TVsEGmEZhrQSbWE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 1/8] pseries: fix migration-test and pxe-test
Date: Tue, 26 Nov 2019 17:01:44 +1100
Message-Id: <20191126060151.729845-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191126060151.729845-1-david@gibson.dropbear.id.au>
References: <20191126060151.729845-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

Commit 29cb4187497d ("spapr: Set VSMT to smp_threads by default")
has introduced a new default value for VSMT that is not supported
by old kernels (before 4.13 kernel) and this breaks "make check"
on these kernels.

To fix that, explicitly set in the involved tests the value that was
used as the default value before the change.

Cc: Greg Kurz <groug@kaod.org>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20191120142539.236279-1-lvivier@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Tested-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/migration-test.c | 4 ++--
 tests/pxe-test.c       | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index ac780dffda..ebd77a581a 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -614,7 +614,7 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
         end_address =3D S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") =3D=3D 0) {
         extra_opts =3D use_shmem ? get_shmem_opts("256M", shmem_path) : =
NULL;
-        cmd_src =3D g_strdup_printf("-machine accel=3D%s -m 256M -nodefa=
ults"
+        cmd_src =3D g_strdup_printf("-machine accel=3D%s,vsmt=3D8 -m 256=
M -nodefaults"
                                   " -name source,debug-threads=3Don"
                                   " -serial file:%s/src_serial"
                                   " -prom-env 'use-nvramrc?=3Dtrue' -pro=
m-env "
@@ -623,7 +623,7 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
                                   "until' %s %s",  accel, tmpfs, end_add=
ress,
                                   start_address, extra_opts ? extra_opts=
 : "",
                                   opts_src);
-        cmd_dst =3D g_strdup_printf("-machine accel=3D%s -m 256M"
+        cmd_dst =3D g_strdup_printf("-machine accel=3D%s,vsmt=3D8 -m 256=
M"
                                   " -name target,debug-threads=3Don"
                                   " -serial file:%s/dest_serial"
                                   " -incoming %s %s %s",
diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index 948b0fbdc7..aaae54f755 100644
--- a/tests/pxe-test.c
+++ b/tests/pxe-test.c
@@ -46,15 +46,15 @@ static testdef_t x86_tests_slow[] =3D {
=20
 static testdef_t ppc64_tests[] =3D {
     { "pseries", "spapr-vlan",
-      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken" },
+      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken,vsm=
t=3D8" },
     { "pseries", "virtio-net-pci",
-      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken" },
+      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken,vsm=
t=3D8" },
     { NULL },
 };
=20
 static testdef_t ppc64_tests_slow[] =3D {
     { "pseries", "e1000",
-      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken" },
+      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken,vsm=
t=3D8" },
     { NULL },
 };
=20
--=20
2.23.0


