Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CA8C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D010720637
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M49PHC2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D010720637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZZn-00089M-1V
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlB-0001Xi-WE
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlA-0000sS-Bj
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:21 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:39098)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlA-0000lm-1e
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:20 -0500
Received: by mail-wm1-x32d.google.com with SMTP id c84so2835194wme.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=99RA6jfV1kf8VQc1QXnhsS3y36Cu1/dvU0W32b0hYKE=;
 b=M49PHC2+yYA0bKxph2A/femLN/vOBuFppEYDcxRX7uJQb0YW67WgcP9x/S5wDr4d/J
 KiVLTIh+odCFZOA+Wal1sq0Gz8quISpj4DQhn0l5A6DWxcP2brppjhoPgvkk97EX37Nk
 dsm4GcQtYaz6L9ht+H5vJhEhFSbXtTaNMN3cH4LSxUZdX37zcPAn5rln6YPH/WYTSmty
 zhv37bw1UGPj3GyakD6lJBlKccoWho+QiG43vu+QNnMVaTzrLsjBWTRvgjV1GM81iKp2
 dZpy4NM9o2oZr45U23gmaU6NFu5jTTLObsJx7aQqN3xZnliaIPWgvDaJ8lRARDBpqqBu
 SUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=99RA6jfV1kf8VQc1QXnhsS3y36Cu1/dvU0W32b0hYKE=;
 b=I6Tl6gN1TL4nwwAbY70TMRW8C5TS5FgwgWXoHP3gWteCbV2aLyXKnlb7rWEkC9Tj0h
 thIjkzv7bfzj3uqwHLZ4DjWv4JMCWeI1uxkpa6GOK47htMaUCKgK/XGNTRao3dgqRLU8
 qeB/WNNBWCa61ejIcVTW+tpK8XVw/ZdLP+T+rK05PZivSfGukVniou3dLAvq2Y+2L4NJ
 Zpx9qpEuWEXo806Xm7L/WyNncsCPbXVy0T822PsXQ/7B4ntCFvKWXP+fTliLhmF1J6mN
 yfGcJ6AFRBqXVl1FOKlQW6A0VE2hoOE2xSqbxVYRbS1FVd/AJoOZJ/TWbDSW8SYdzQAb
 4UVQ==
X-Gm-Message-State: APjAAAU+oYVNXI8JHdQtLeP3hrjd78vg/imeCslnW5KTi78TtLvSNxQD
 ojUDSciqNADgNJkz6HKHESCRuhlP
X-Google-Smtp-Source: APXvYqwSqWhwEhX0dVx0tI9qzcHsTlGFojt+aoZ/ErE+dRitNYroc0zIizMld/6CJpvz5wuhLL7bAQ==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr5073358wmi.116.1582631538283; 
 Tue, 25 Feb 2020 03:52:18 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 078/136] tests/numa-test: make top level args dynamic and
 g_autofree(cli) cleanups
Date: Tue, 25 Feb 2020 12:50:08 +0100
Message-Id: <1582631466-13880-78-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Use GString to pass argument to make_cli() so that it would be easy
to dynamically change test case arguments from main(). The follow up
patch will use it to change RAM size options depending on target.

While at it cleanup 'cli' freeing, using g_autofree annotation.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200219160953.13771-79-imammedo@redhat.com>
---
 tests/qtest/numa-test.c | 108 ++++++++++++++++++++++++------------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
index 17dd807..35999ea 100644
--- a/tests/qtest/numa-test.c
+++ b/tests/qtest/numa-test.c
@@ -14,16 +14,16 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 
-static char *make_cli(const char *generic_cli, const char *test_cli)
+static char *make_cli(const GString *generic_cli, const char *test_cli)
 {
-    return g_strdup_printf("%s %s", generic_cli ? generic_cli : "", test_cli);
+    return g_strdup_printf("%s %s", generic_cli->str, test_cli);
 }
 
 static void test_mon_explicit(const void *data)
 {
-    char *s;
-    char *cli;
     QTestState *qts;
+    g_autofree char *s = NULL;
+    g_autofree char *cli = NULL;
 
     cli = make_cli(data, "-smp 8 "
                    "-numa node,nodeid=0,cpus=0-3 "
@@ -33,17 +33,15 @@ static void test_mon_explicit(const void *data)
     s = qtest_hmp(qts, "info numa");
     g_assert(strstr(s, "node 0 cpus: 0 1 2 3"));
     g_assert(strstr(s, "node 1 cpus: 4 5 6 7"));
-    g_free(s);
 
     qtest_quit(qts);
-    g_free(cli);
 }
 
 static void test_mon_default(const void *data)
 {
-    char *s;
-    char *cli;
     QTestState *qts;
+    g_autofree char *s = NULL;
+    g_autofree char *cli = NULL;
 
     cli = make_cli(data, "-smp 8 -numa node -numa node");
     qts = qtest_init(cli);
@@ -51,17 +49,15 @@ static void test_mon_default(const void *data)
     s = qtest_hmp(qts, "info numa");
     g_assert(strstr(s, "node 0 cpus: 0 2 4 6"));
     g_assert(strstr(s, "node 1 cpus: 1 3 5 7"));
-    g_free(s);
 
     qtest_quit(qts);
-    g_free(cli);
 }
 
 static void test_mon_partial(const void *data)
 {
-    char *s;
-    char *cli;
     QTestState *qts;
+    g_autofree char *s = NULL;
+    g_autofree char *cli = NULL;
 
     cli = make_cli(data, "-smp 8 "
                    "-numa node,nodeid=0,cpus=0-1 "
@@ -71,10 +67,8 @@ static void test_mon_partial(const void *data)
     s = qtest_hmp(qts, "info numa");
     g_assert(strstr(s, "node 0 cpus: 0 1 2 3 6 7"));
     g_assert(strstr(s, "node 1 cpus: 4 5"));
-    g_free(s);
 
     qtest_quit(qts);
-    g_free(cli);
 }
 
 static QList *get_cpus(QTestState *qts, QDict **resp)
@@ -87,11 +81,11 @@ static QList *get_cpus(QTestState *qts, QDict **resp)
 
 static void test_query_cpus(const void *data)
 {
-    char *cli;
     QDict *resp;
     QList *cpus;
     QObject *e;
     QTestState *qts;
+    g_autofree char *cli = NULL;
 
     cli = make_cli(data, "-smp 8 -numa node,cpus=0-3 -numa node,cpus=4-7");
     qts = qtest_init(cli);
@@ -120,16 +114,15 @@ static void test_query_cpus(const void *data)
 
     qobject_unref(resp);
     qtest_quit(qts);
-    g_free(cli);
 }
 
 static void pc_numa_cpu(const void *data)
 {
-    char *cli;
     QDict *resp;
     QList *cpus;
     QObject *e;
     QTestState *qts;
+    g_autofree char *cli = NULL;
 
     cli = make_cli(data, "-cpu pentium -smp 8,sockets=2,cores=2,threads=2 "
         "-numa node,nodeid=0 -numa node,nodeid=1 "
@@ -174,16 +167,15 @@ static void pc_numa_cpu(const void *data)
 
     qobject_unref(resp);
     qtest_quit(qts);
-    g_free(cli);
 }
 
 static void spapr_numa_cpu(const void *data)
 {
-    char *cli;
     QDict *resp;
     QList *cpus;
     QObject *e;
     QTestState *qts;
+    g_autofree char *cli = NULL;
 
     cli = make_cli(data, "-smp 4,cores=4 "
         "-numa node,nodeid=0 -numa node,nodeid=1 "
@@ -220,16 +212,15 @@ static void spapr_numa_cpu(const void *data)
 
     qobject_unref(resp);
     qtest_quit(qts);
-    g_free(cli);
 }
 
 static void aarch64_numa_cpu(const void *data)
 {
-    char *cli;
     QDict *resp;
     QList *cpus;
     QObject *e;
     QTestState *qts;
+    g_autofree char *cli = NULL;
 
     cli = make_cli(data, "-smp 2 "
         "-numa node,nodeid=0 -numa node,nodeid=1 "
@@ -264,7 +255,6 @@ static void aarch64_numa_cpu(const void *data)
 
     qobject_unref(resp);
     qtest_quit(qts);
-    g_free(cli);
 }
 
 static void pc_dynamic_cpu_cfg(const void *data)
@@ -273,9 +263,10 @@ static void pc_dynamic_cpu_cfg(const void *data)
     QDict *resp;
     QList *cpus;
     QTestState *qs;
+    g_autofree char *cli = NULL;
 
-    qs = qtest_initf("%s -nodefaults --preconfig -smp 2",
-                     data ? (char *)data : "");
+    cli = make_cli(data, "-nodefaults --preconfig -smp 2");
+    qs = qtest_init(cli);
 
     /* create 2 numa nodes */
     g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
@@ -329,16 +320,19 @@ static void pc_dynamic_cpu_cfg(const void *data)
 
 static void pc_hmat_build_cfg(const void *data)
 {
-    QTestState *qs = qtest_initf("%s -nodefaults --preconfig -machine hmat=on "
-                     "-smp 2,sockets=2 "
-                     "-m 128M,slots=2,maxmem=1G "
-                     "-object memory-backend-ram,size=64M,id=m0 "
-                     "-object memory-backend-ram,size=64M,id=m1 "
-                     "-numa node,nodeid=0,memdev=m0 "
-                     "-numa node,nodeid=1,memdev=m1,initiator=0 "
-                     "-numa cpu,node-id=0,socket-id=0 "
-                     "-numa cpu,node-id=0,socket-id=1",
-                     data ? (char *)data : "");
+    QTestState *qs;
+    g_autofree char *cli = NULL;
+
+    cli = make_cli(data, "-nodefaults --preconfig -machine hmat=on "
+                         "-smp 2,sockets=2 "
+                         "-m 128M,slots=2,maxmem=1G "
+                         "-object memory-backend-ram,size=64M,id=m0 "
+                         "-object memory-backend-ram,size=64M,id=m1 "
+                         "-numa node,nodeid=0,memdev=m0 "
+                         "-numa node,nodeid=1,memdev=m1,initiator=0 "
+                         "-numa cpu,node-id=0,socket-id=0 "
+                         "-numa cpu,node-id=0,socket-id=1");
+    qs = qtest_init(cli);
 
     /* Fail: Initiator should be less than the number of nodes */
     g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
@@ -455,13 +449,16 @@ static void pc_hmat_build_cfg(const void *data)
 
 static void pc_hmat_off_cfg(const void *data)
 {
-    QTestState *qs = qtest_initf("%s -nodefaults --preconfig "
-                     "-smp 2,sockets=2 "
-                     "-m 128M,slots=2,maxmem=1G "
-                     "-object memory-backend-ram,size=64M,id=m0 "
-                     "-object memory-backend-ram,size=64M,id=m1 "
-                     "-numa node,nodeid=0,memdev=m0",
-                     data ? (char *)data : "");
+    QTestState *qs;
+    g_autofree char *cli = NULL;
+
+    cli = make_cli(data, "-nodefaults --preconfig "
+                         "-smp 2,sockets=2 "
+                         "-m 128M,slots=2,maxmem=1G "
+                         "-object memory-backend-ram,size=64M,id=m0 "
+                         "-object memory-backend-ram,size=64M,id=m1 "
+                         "-numa node,nodeid=0,memdev=m0");
+    qs = qtest_init(cli);
 
     /*
      * Fail: Enable HMAT with -machine hmat=on
@@ -491,16 +488,19 @@ static void pc_hmat_off_cfg(const void *data)
 
 static void pc_hmat_erange_cfg(const void *data)
 {
-    QTestState *qs = qtest_initf("%s -nodefaults --preconfig -machine hmat=on "
-                     "-smp 2,sockets=2 "
-                     "-m 128M,slots=2,maxmem=1G "
-                     "-object memory-backend-ram,size=64M,id=m0 "
-                     "-object memory-backend-ram,size=64M,id=m1 "
-                     "-numa node,nodeid=0,memdev=m0 "
-                     "-numa node,nodeid=1,memdev=m1,initiator=0 "
-                     "-numa cpu,node-id=0,socket-id=0 "
-                     "-numa cpu,node-id=0,socket-id=1",
-                     data ? (char *)data : "");
+    QTestState *qs;
+    g_autofree char *cli = NULL;
+
+    cli = make_cli(data, "-nodefaults --preconfig -machine hmat=on "
+                         "-smp 2,sockets=2 "
+                         "-m 128M,slots=2,maxmem=1G "
+                         "-object memory-backend-ram,size=64M,id=m0 "
+                         "-object memory-backend-ram,size=64M,id=m1 "
+                         "-numa node,nodeid=0,memdev=m0 "
+                         "-numa node,nodeid=1,memdev=m1,initiator=0 "
+                         "-numa cpu,node-id=0,socket-id=0 "
+                         "-numa cpu,node-id=0,socket-id=1");
+    qs = qtest_init(cli);
 
     /* Can't store the compressed latency */
     g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
@@ -539,11 +539,11 @@ static void pc_hmat_erange_cfg(const void *data)
 
 int main(int argc, char **argv)
 {
-    const char *args = NULL;
+    g_autoptr(GString) args = g_string_new(NULL);
     const char *arch = qtest_get_arch();
 
-    if (strcmp(arch, "aarch64") == 0) {
-        args = "-machine virt";
+    if (g_str_equal(arch, "aarch64")) {
+        g_string_append(args, " -machine virt");
     }
 
     g_test_init(&argc, &argv, NULL);
-- 
1.8.3.1



