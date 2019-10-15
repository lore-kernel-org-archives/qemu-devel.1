Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ED3ECE58F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 21:39:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2988E214AE
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 21:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2988E214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKUXQ-0006Lq-Nl
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 17:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iKUVu-0004pG-5m
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iKUVs-0006g3-PR
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:37:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iKUVs-0006fm-HB
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:37:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BCC2830860D7;
 Tue, 15 Oct 2019 21:37:51 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5985F5C541;
 Tue, 15 Oct 2019 21:37:51 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org
Subject: [PULL 02/18] tests: cpu-plug-test: fix device_add for pc/q35 machines
Date: Tue, 15 Oct 2019 18:37:29 -0300
Message-Id: <20191015213745.22174-3-ehabkost@redhat.com>
In-Reply-To: <20191015213745.22174-1-ehabkost@redhat.com>
References: <20191015213745.22174-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 15 Oct 2019 21:37:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

From: Igor Mammedov <imammedo@redhat.com>

Commit bc1fb850a3 silently broke device_add test for CPU hotplug which
resulted in test successfully passing though it wasn't actually run.
Fix it by making sure that all non present CPUs reported
by "query-hotpluggable-cpus" are hotplugged instead of making up
and hardcoding values.

Use of query-hotpluggable-cpus also allows consolidatiate device_add
cpu testcases and reuse the same test function for all targets.

While at it also add a check that at least one CPU was hotplugged,
to avoid silent breakage in the future.

Fixes: bc1fb850a3 (vl.c deprecate incorrect CPUs topology)
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20190830110723.15096-3-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/cpu-plug-test.c | 62 ++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
index 776407e1b6..058cef5ac1 100644
--- a/tests/cpu-plug-test.c
+++ b/tests/cpu-plug-test.c
@@ -12,6 +12,7 @@
 #include "qemu-common.h"
 #include "libqtest-single.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qlist.h"
=20
 struct PlugTestData {
     char *machine;
@@ -72,12 +73,15 @@ static void test_plug_without_cpu_add(gconstpointer d=
ata)
     g_free(args);
 }
=20
-static void test_plug_with_device_add_x86(gconstpointer data)
+static void test_plug_with_device_add(gconstpointer data)
 {
     const PlugTestData *td =3D data;
     char *args;
-    unsigned int s, c, t;
     QTestState *qts;
+    QDict *resp;
+    QList *cpus;
+    QObject *e;
+    int hotplugged =3D 0;
=20
     args =3D g_strdup_printf("-machine %s -cpu %s "
                            "-smp 1,sockets=3D%u,cores=3D%u,threads=3D%u,=
maxcpus=3D%u",
@@ -85,43 +89,29 @@ static void test_plug_with_device_add_x86(gconstpoint=
er data)
                            td->sockets, td->cores, td->threads, td->maxc=
pus);
     qts =3D qtest_init(args);
=20
-    for (s =3D 1; s < td->sockets; s++) {
-        for (c =3D 0; c < td->cores; c++) {
-            for (t =3D 0; t < td->threads; t++) {
-                char *id =3D g_strdup_printf("id-%i-%i-%i", s, c, t);
-                qtest_qmp_device_add(qts, td->device_model, id,
-                                     "{'socket-id':%u, 'core-id':%u,"
-                                     " 'thread-id':%u}",
-                                     s, c, t);
-                g_free(id);
-            }
-        }
-    }
+    resp =3D qtest_qmp(qts, "{ 'execute': 'query-hotpluggable-cpus'}");
+    g_assert(qdict_haskey(resp, "return"));
+    cpus =3D qdict_get_qlist(resp, "return");
+    g_assert(cpus);
=20
-    qtest_quit(qts);
-    g_free(args);
-}
+    while ((e =3D qlist_pop(cpus))) {
+        const QDict *cpu, *props;
=20
-static void test_plug_with_device_add_coreid(gconstpointer data)
-{
-    const PlugTestData *td =3D data;
-    char *args;
-    unsigned int c;
-    QTestState *qts;
+        cpu =3D qobject_to(QDict, e);
+        if (qdict_haskey(cpu, "qom-path")) {
+            continue;
+        }
=20
-    args =3D g_strdup_printf("-machine %s -cpu %s "
-                           "-smp 1,sockets=3D%u,cores=3D%u,threads=3D%u,=
maxcpus=3D%u",
-                           td->machine, td->cpu_model,
-                           td->sockets, td->cores, td->threads, td->maxc=
pus);
-    qts =3D qtest_init(args);
+        g_assert(qdict_haskey(cpu, "props"));
+        props =3D qdict_get_qdict(cpu, "props");
=20
-    for (c =3D 1; c < td->cores; c++) {
-        char *id =3D g_strdup_printf("id-%i", c);
-        qtest_qmp_device_add(qts, td->device_model, id,
-                             "{'core-id':%u}", c);
-        g_free(id);
+        qtest_qmp_device_add_qdict(qts, td->device_model, props);
+        hotplugged++;
     }
=20
+    /* make sure that there were hotplugged CPUs */
+    g_assert(hotplugged);
+    qobject_unref(resp);
     qtest_quit(qts);
     g_free(args);
 }
@@ -182,7 +172,7 @@ static void add_pc_test_case(const char *mname)
         path =3D g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpu=
s=3D%u",
                                mname, data2->sockets, data2->cores,
                                data2->threads, data2->maxcpus);
-        qtest_add_data_func_full(path, data2, test_plug_with_device_add_=
x86,
+        qtest_add_data_func_full(path, data2, test_plug_with_device_add,
                                  test_data_free);
         g_free(path);
     }
@@ -209,7 +199,7 @@ static void add_pseries_test_case(const char *mname)
     path =3D g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=3D=
%u",
                            mname, data->sockets, data->cores,
                            data->threads, data->maxcpus);
-    qtest_add_data_func_full(path, data, test_plug_with_device_add_corei=
d,
+    qtest_add_data_func_full(path, data, test_plug_with_device_add,
                              test_data_free);
     g_free(path);
 }
@@ -246,7 +236,7 @@ static void add_s390x_test_case(const char *mname)
     path =3D g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=3D=
%u",
                            mname, data2->sockets, data2->cores,
                            data2->threads, data2->maxcpus);
-    qtest_add_data_func_full(path, data2, test_plug_with_device_add_core=
id,
+    qtest_add_data_func_full(path, data2, test_plug_with_device_add,
                              test_data_free);
     g_free(path);
 }
--=20
2.21.0


