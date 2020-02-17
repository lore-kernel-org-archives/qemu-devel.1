Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0124C34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C2820801
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2lbGu9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C2820801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kmQ-0001Ih-S2
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kK7-0004Em-Ha
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kK6-0002mU-6h
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33955
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kK6-0002mG-2d
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581961005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C1rQtEFE0T2D1DVnx5qJt3zzo5C6lVaBidKgVyMKQ4Y=;
 b=S2lbGu9vjvSIg+925ABs6PKWGEQATrEOChIu/AqpdatjIYVR2AGb//OjEbNGAiNRGHWH8e
 DUbNDiCGHhxkXHfUKEX9Crh3rukQlNYIPicIfbT8ZGnvh/ie+oAPEP6EdCw3iOnDjFVhAv
 4MLjvMIjjZi2nwanWEAYgld9jpLSrfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-CWR0QveINwuXkqTy-jyhFQ-1; Mon, 17 Feb 2020 12:36:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED064800D50
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 17:36:42 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44D6090526;
 Mon, 17 Feb 2020 17:36:42 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 79/79] tests:numa-test: use explicit memdev to specify node
 RAM
Date: Mon, 17 Feb 2020 12:34:52 -0500
Message-Id: <20200217173452.15243-80-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: CWR0QveINwuXkqTy-jyhFQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Follow up patches will remove automatic RAM distribution
between nodes and will make default machine types require
"memdev" option instead of legacy "mem" option.

Make tests to follow new rules and add an additional test
for legacy "mem" option on old machine type, to make sure
it won't regress in the future.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
v3:
   * s/strcmp/g_str_equal/
   * put -object lines before -m
     (Thomas Huth <thuth@redhat.com>)
   * drop new test_pc_legacy_mem(), due to dropping
      "numa: forbid '-numa node,mem' for 5.0 and newer machine types"
     it will be posted later, when libvirt side is prepared for
     disabled '-numa node,mem' (hopefully 5.1)
---
 tests/qtest/numa-test.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
index 35999ea28f..2f9b7f663a 100644
--- a/tests/qtest/numa-test.c
+++ b/tests/qtest/numa-test.c
@@ -25,9 +25,8 @@ static void test_mon_explicit(const void *data)
     g_autofree char *s =3D NULL;
     g_autofree char *cli =3D NULL;
=20
-    cli =3D make_cli(data, "-smp 8 "
-                   "-numa node,nodeid=3D0,cpus=3D0-3 "
-                   "-numa node,nodeid=3D1,cpus=3D4-7 ");
+    cli =3D make_cli(data, "-smp 8 -numa node,nodeid=3D0,memdev=3Dram,cpus=
=3D0-3 "
+                         "-numa node,nodeid=3D1,cpus=3D4-7");
     qts =3D qtest_init(cli);
=20
     s =3D qtest_hmp(qts, "info numa");
@@ -37,13 +36,13 @@ static void test_mon_explicit(const void *data)
     qtest_quit(qts);
 }
=20
-static void test_mon_default(const void *data)
+static void test_def_cpu_split(const void *data)
 {
     QTestState *qts;
     g_autofree char *s =3D NULL;
     g_autofree char *cli =3D NULL;
=20
-    cli =3D make_cli(data, "-smp 8 -numa node -numa node");
+    cli =3D make_cli(data, "-smp 8 -numa node,memdev=3Dram -numa node");
     qts =3D qtest_init(cli);
=20
     s =3D qtest_hmp(qts, "info numa");
@@ -60,7 +59,7 @@ static void test_mon_partial(const void *data)
     g_autofree char *cli =3D NULL;
=20
     cli =3D make_cli(data, "-smp 8 "
-                   "-numa node,nodeid=3D0,cpus=3D0-1 "
+                   "-numa node,nodeid=3D0,memdev=3Dram,cpus=3D0-1 "
                    "-numa node,nodeid=3D1,cpus=3D4-5 ");
     qts =3D qtest_init(cli);
=20
@@ -87,7 +86,8 @@ static void test_query_cpus(const void *data)
     QTestState *qts;
     g_autofree char *cli =3D NULL;
=20
-    cli =3D make_cli(data, "-smp 8 -numa node,cpus=3D0-3 -numa node,cpus=
=3D4-7");
+    cli =3D make_cli(data, "-smp 8 -numa node,memdev=3Dram,cpus=3D0-3 "
+                         "-numa node,cpus=3D4-7");
     qts =3D qtest_init(cli);
     cpus =3D get_cpus(qts, &resp);
     g_assert(cpus);
@@ -125,7 +125,7 @@ static void pc_numa_cpu(const void *data)
     g_autofree char *cli =3D NULL;
=20
     cli =3D make_cli(data, "-cpu pentium -smp 8,sockets=3D2,cores=3D2,thre=
ads=3D2 "
-        "-numa node,nodeid=3D0 -numa node,nodeid=3D1 "
+        "-numa node,nodeid=3D0,memdev=3Dram -numa node,nodeid=3D1 "
         "-numa cpu,node-id=3D1,socket-id=3D0 "
         "-numa cpu,node-id=3D0,socket-id=3D1,core-id=3D0 "
         "-numa cpu,node-id=3D0,socket-id=3D1,core-id=3D1,thread-id=3D0 "
@@ -178,7 +178,7 @@ static void spapr_numa_cpu(const void *data)
     g_autofree char *cli =3D NULL;
=20
     cli =3D make_cli(data, "-smp 4,cores=3D4 "
-        "-numa node,nodeid=3D0 -numa node,nodeid=3D1 "
+        "-numa node,nodeid=3D0,memdev=3Dram -numa node,nodeid=3D1 "
         "-numa cpu,node-id=3D0,core-id=3D0 "
         "-numa cpu,node-id=3D0,core-id=3D1 "
         "-numa cpu,node-id=3D0,core-id=3D2 "
@@ -223,7 +223,7 @@ static void aarch64_numa_cpu(const void *data)
     g_autofree char *cli =3D NULL;
=20
     cli =3D make_cli(data, "-smp 2 "
-        "-numa node,nodeid=3D0 -numa node,nodeid=3D1 "
+        "-numa node,nodeid=3D0,memdev=3Dram -numa node,nodeid=3D1 "
         "-numa cpu,node-id=3D1,thread-id=3D0 "
         "-numa cpu,node-id=3D0,thread-id=3D1");
     qts =3D qtest_init(cli);
@@ -270,7 +270,7 @@ static void pc_dynamic_cpu_cfg(const void *data)
=20
     /* create 2 numa nodes */
     g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
-        " 'arguments': { 'type': 'node', 'nodeid': 0 } }")));
+        " 'arguments': { 'type': 'node', 'nodeid': 0, 'memdev': 'ram' } }"=
)));
     g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
         " 'arguments': { 'type': 'node', 'nodeid': 1 } }")));
=20
@@ -542,13 +542,19 @@ int main(int argc, char **argv)
     g_autoptr(GString) args =3D g_string_new(NULL);
     const char *arch =3D qtest_get_arch();
=20
+    if (g_str_equal(arch, "ppc64")) {
+        g_string_append(args, " -object memory-backend-ram,id=3Dram,size=
=3D512M");
+    } else {
+        g_string_append(args, " -object memory-backend-ram,id=3Dram,size=
=3D128M");
+    }
+
     if (g_str_equal(arch, "aarch64")) {
         g_string_append(args, " -machine virt");
     }
=20
     g_test_init(&argc, &argv, NULL);
=20
-    qtest_add_data_func("/numa/mon/default", args, test_mon_default);
+    qtest_add_data_func("/numa/mon/cpus/default", args, test_def_cpu_split=
);
     qtest_add_data_func("/numa/mon/cpus/explicit", args, test_mon_explicit=
);
     qtest_add_data_func("/numa/mon/cpus/partial", args, test_mon_partial);
     qtest_add_data_func("/numa/qmp/cpus/query-cpus", args, test_query_cpus=
);
--=20
2.18.1


