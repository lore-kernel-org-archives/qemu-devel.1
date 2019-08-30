Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6D5C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 11:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1598321897
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 11:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1598321897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3eov-0005HR-Sd
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 07:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1i3eks-0003bs-Hl
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 07:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1i3eko-0001k3-I3
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 07:07:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1i3ekj-0001XJ-UM; Fri, 30 Aug 2019 07:07:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3DDBDC04FFE0;
 Fri, 30 Aug 2019 11:07:33 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E91A25D772;
 Fri, 30 Aug 2019 11:07:31 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 30 Aug 2019 07:07:23 -0400
Message-Id: <20190830110723.15096-3-imammedo@redhat.com>
In-Reply-To: <20190830110723.15096-1-imammedo@redhat.com>
References: <20190830110723.15096-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 30 Aug 2019 11:07:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] tests: cpu-plug-test: fix device_add for
 pc/q35 machines
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
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, dhildenb@redhat.com,
 ehabkost@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 tests/cpu-plug-test.c | 62 ++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
index 3049620854..46e51dc07a 100644
--- a/tests/cpu-plug-test.c
+++ b/tests/cpu-plug-test.c
@@ -12,6 +12,7 @@
 #include "qemu-common.h"
 #include "libqtest.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qlist.h"
 
 struct PlugTestData {
     char *machine;
@@ -72,12 +73,15 @@ static void test_plug_without_cpu_add(gconstpointer data)
     g_free(args);
 }
 
-static void test_plug_with_device_add_x86(gconstpointer data)
+static void test_plug_with_device_add(gconstpointer data)
 {
     const PlugTestData *td = data;
     char *args;
-    unsigned int s, c, t;
     QTestState *qts;
+    QDict *resp;
+    QList *cpus;
+    QObject *e;
+    int hotplugged = 0;
 
     args = g_strdup_printf("-machine %s -cpu %s "
                            "-smp 1,sockets=%u,cores=%u,threads=%u,maxcpus=%u",
@@ -85,43 +89,29 @@ static void test_plug_with_device_add_x86(gconstpointer data)
                            td->sockets, td->cores, td->threads, td->maxcpus);
     qts = qtest_init(args);
 
-    for (s = 1; s < td->sockets; s++) {
-        for (c = 0; c < td->cores; c++) {
-            for (t = 0; t < td->threads; t++) {
-                char *id = g_strdup_printf("id-%i-%i-%i", s, c, t);
-                qtest_qmp_device_add(qts, td->device_model, id,
-                                     "{'socket-id':%u, 'core-id':%u,"
-                                     " 'thread-id':%u}",
-                                     s, c, t);
-                g_free(id);
-            }
-        }
-    }
+    resp = qtest_qmp(qts, "{ 'execute': 'query-hotpluggable-cpus'}");
+    g_assert(qdict_haskey(resp, "return"));
+    cpus = qdict_get_qlist(resp, "return");
+    g_assert(cpus);
 
-    qtest_quit(qts);
-    g_free(args);
-}
+    while ((e = qlist_pop(cpus))) {
+        const QDict *cpu, *props;
 
-static void test_plug_with_device_add_coreid(gconstpointer data)
-{
-    const PlugTestData *td = data;
-    char *args;
-    unsigned int c;
-    QTestState *qts;
+        cpu = qobject_to(QDict, e);
+        if (qdict_haskey(cpu, "qom-path")) {
+            continue;
+        }
 
-    args = g_strdup_printf("-machine %s -cpu %s "
-                           "-smp 1,sockets=%u,cores=%u,threads=%u,maxcpus=%u",
-                           td->machine, td->cpu_model,
-                           td->sockets, td->cores, td->threads, td->maxcpus);
-    qts = qtest_init(args);
+        g_assert(qdict_haskey(cpu, "props"));
+        props = qdict_get_qdict(cpu, "props");
 
-    for (c = 1; c < td->cores; c++) {
-        char *id = g_strdup_printf("id-%i", c);
-        qtest_qmp_device_add(qts, td->device_model, id,
-                             "{'core-id':%u}", c);
-        g_free(id);
+        qtest_qmp_device_add_qdict(qts, td->device_model, props);
+        hotplugged++;
     }
 
+    /* make sure that there were hotplugged CPUs */
+    g_assert(hotplugged);
+    qobject_unref(resp);
     qtest_quit(qts);
     g_free(args);
 }
@@ -182,7 +172,7 @@ static void add_pc_test_case(const char *mname)
         path = g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=%u",
                                mname, data2->sockets, data2->cores,
                                data2->threads, data2->maxcpus);
-        qtest_add_data_func_full(path, data2, test_plug_with_device_add_x86,
+        qtest_add_data_func_full(path, data2, test_plug_with_device_add,
                                  test_data_free);
         g_free(path);
     }
@@ -209,7 +199,7 @@ static void add_pseries_test_case(const char *mname)
     path = g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=%u",
                            mname, data->sockets, data->cores,
                            data->threads, data->maxcpus);
-    qtest_add_data_func_full(path, data, test_plug_with_device_add_coreid,
+    qtest_add_data_func_full(path, data, test_plug_with_device_add,
                              test_data_free);
     g_free(path);
 }
@@ -246,7 +236,7 @@ static void add_s390x_test_case(const char *mname)
     path = g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=%u",
                            mname, data2->sockets, data2->cores,
                            data2->threads, data2->maxcpus);
-    qtest_add_data_func_full(path, data2, test_plug_with_device_add_coreid,
+    qtest_add_data_func_full(path, data2, test_plug_with_device_add,
                              test_data_free);
     g_free(path);
 }
-- 
2.18.1


