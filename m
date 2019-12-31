Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C62C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 14:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13DC22064B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 14:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGBJwds5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DC22064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imIBs-0002zS-Ny
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 09:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCq-0006Km-UX
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:05:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCm-0005cE-9e
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:05:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51111
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCm-0005Zk-3J
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Ni0xGBUhNILEbnzZX6suH7qxyEqdMvdJf/IW4fnvZE=;
 b=VGBJwds50gUW8vidVB5OtahSUerSuF/3bQZfw+UePIidzmp4vto3ZHN4lovqztgGe9XeMn
 P9D//buSzJkFCxCMNU3r9Rvjcc9aGI9YM5M5BUshuT5G0A+11Dy/A2wMWrOU5RhTsjlLrf
 tYuau0nvELOYHRZGDQx/xhab6OuJBfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-sXpRrWwTOCqLj3I6u9kllg-1; Tue, 31 Dec 2019 08:04:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 396328024D2
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:57 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3C3378E96
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:56 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 84/86] tests:numa-test: use explicit memdev to specify node RAM
Date: Tue, 31 Dec 2019 14:04:08 +0100
Message-Id: <1577797450-88458-85-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: sXpRrWwTOCqLj3I6u9kllg-1
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
---
 tests/numa-test.c | 52 ++++++++++++++++++++++++++++++++++++++-------------=
-
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/tests/numa-test.c b/tests/numa-test.c
index 6f7aab9..4d27220 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
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
@@ -53,6 +52,23 @@ static void test_mon_default(const void *data)
     qtest_quit(qts);
 }
=20
+static void test_pc_legacy_mem(const void *data)
+{
+    QTestState *qts;
+    g_autofree char *s =3D NULL;
+    g_autofree char *cli =3D NULL;
+
+    cli =3D make_cli(data, "-M pc-i440fx-4.2 -smp 8 "
+                         "-numa node,mem=3D64M -numa node,mem=3D64M");
+    qts =3D qtest_init(cli);
+
+    s =3D qtest_hmp(qts, "info numa");
+    g_assert(strstr(s, "node 0 size: 64 MB"));
+    g_assert(strstr(s, "node 1 size: 64 MB"));
+
+    qtest_quit(qts);
+}
+
 static void test_mon_partial(const void *data)
 {
     QTestState *qts;
@@ -60,7 +76,7 @@ static void test_mon_partial(const void *data)
     g_autofree char *cli =3D NULL;
=20
     cli =3D make_cli(data, "-smp 8 "
-                   "-numa node,nodeid=3D0,cpus=3D0-1 "
+                   "-numa node,nodeid=3D0,memdev=3Dram,cpus=3D0-1 "
                    "-numa node,nodeid=3D1,cpus=3D4-5 ");
     qts =3D qtest_init(cli);
=20
@@ -87,7 +103,8 @@ static void test_query_cpus(const void *data)
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
@@ -125,7 +142,7 @@ static void pc_numa_cpu(const void *data)
     g_autofree char *cli =3D NULL;
=20
     cli =3D make_cli(data, "-cpu pentium -smp 8,sockets=3D2,cores=3D2,thre=
ads=3D2 "
-        "-numa node,nodeid=3D0 -numa node,nodeid=3D1 "
+        "-numa node,nodeid=3D0,memdev=3Dram -numa node,nodeid=3D1 "
         "-numa cpu,node-id=3D1,socket-id=3D0 "
         "-numa cpu,node-id=3D0,socket-id=3D1,core-id=3D0 "
         "-numa cpu,node-id=3D0,socket-id=3D1,core-id=3D1,thread-id=3D0 "
@@ -178,7 +195,7 @@ static void spapr_numa_cpu(const void *data)
     g_autofree char *cli =3D NULL;
=20
     cli =3D make_cli(data, "-smp 4,cores=3D4 "
-        "-numa node,nodeid=3D0 -numa node,nodeid=3D1 "
+        "-numa node,nodeid=3D0,memdev=3Dram -numa node,nodeid=3D1 "
         "-numa cpu,node-id=3D0,core-id=3D0 "
         "-numa cpu,node-id=3D0,core-id=3D1 "
         "-numa cpu,node-id=3D0,core-id=3D2 "
@@ -223,7 +240,7 @@ static void aarch64_numa_cpu(const void *data)
     g_autofree char *cli =3D NULL;
=20
     cli =3D make_cli(data, "-smp 2 "
-        "-numa node,nodeid=3D0 -numa node,nodeid=3D1 "
+        "-numa node,nodeid=3D0,memdev=3Dram -numa node,nodeid=3D1 "
         "-numa cpu,node-id=3D1,thread-id=3D0 "
         "-numa cpu,node-id=3D0,thread-id=3D1");
     qts =3D qtest_init(cli);
@@ -263,13 +280,14 @@ static void pc_dynamic_cpu_cfg(const void *data)
     QDict *resp;
     QList *cpus;
     QTestState *qs;
+    g_autofree char *cli =3D NULL;
=20
-    qs =3D qtest_initf("%s -nodefaults --preconfig -smp 2",
-                     data ? (char *)data : "");
+    cli =3D make_cli(data, "-nodefaults --preconfig -smp 2");
+    qs =3D qtest_init(cli);
=20
     /* create 2 numa nodes */
     g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
-        " 'arguments': { 'type': 'node', 'nodeid': 0 } }")));
+        " 'arguments': { 'type': 'node', 'nodeid': 0, 'memdev': 'ram' } }"=
)));
     g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
         " 'arguments': { 'type': 'node', 'nodeid': 1 } }")));
=20
@@ -325,10 +343,15 @@ int main(int argc, char **argv)
     if (strcmp(arch, "aarch64") =3D=3D 0) {
         g_string_append(args, " -machine virt");
     }
+    if (!strcmp(arch, "ppc64")) {
+        g_string_append(args, " -object memory-backend-ram,id=3Dram,size=
=3D512M");
+    } else {
+        g_string_append(args, " -object memory-backend-ram,id=3Dram,size=
=3D128M");
+    }
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
@@ -336,6 +359,7 @@ int main(int argc, char **argv)
     if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64")) {
         qtest_add_data_func("/numa/pc/cpu/explicit", args, pc_numa_cpu);
         qtest_add_data_func("/numa/pc/dynamic/cpu", args, pc_dynamic_cpu_c=
fg);
+        qtest_add_data_func("/numa/pc/legacy/mem", args, test_pc_legacy_me=
m);
     }
=20
     if (!strcmp(arch, "ppc64")) {
--=20
2.7.4


