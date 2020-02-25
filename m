Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC87AC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99BDB20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1Pwr7pY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99BDB20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZQ2-0003ET-P0
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:34:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlD-0001cb-Js
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlC-00010U-As
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:23 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:40410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlC-0000uK-39
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:22 -0500
Received: by mail-wr1-x42d.google.com with SMTP id t3so14354064wru.7
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lSFQaFhN+qAp/G2LZxELsn5XyL1xck7wejFaofuOvhg=;
 b=p1Pwr7pY76jWtn+Wr7f0E0JOAGOpLaI6PACaTncFytOW977Sq4SvTe90sCbmLS1XJM
 5XEcw6i3vXtHgzBeUd+DuEMpaXzeQKxOPRSg0ICk2t4mr7ZsSTGPNWpYFFx8SH3ups/q
 2gfGJ73z2gOdVQiQHgG5Xjj4nqrQBCK96kBOD+CHrGE+ck/GUeiW1UOVeAdhO2T4pZfR
 phrojU2mg6gJnroZUA2BNesxN/yXrFIALAshs0B8XZjzfeMLSZXSkO+SzQV8ZomF/mlc
 pdJOsbrIZWQ5YhBIOR2jICaM8yEc0IWdZ0z1wiiNYwMoV848m8ueda+I2qQlzjWJs0x9
 mpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=lSFQaFhN+qAp/G2LZxELsn5XyL1xck7wejFaofuOvhg=;
 b=c4VWBgox4Gp7j/6kxK3Tt4ffHZY45SHO1I+FtLrYrF/AUz3B41im8PmSgTJa5gqrxY
 LHLe3dVW63q0DyMO56rsmhpP3Bpj5/ipHpH0PuQ4gOiAZ9Z+YIiVzwaU2QLSJiJAt6Df
 gOsqTKO63lBimzMbBFiGthB8FIbIcMcIhFX4YnjDofqTcnKnjNgYKhcbdUS+UxyGj+wE
 gA5BFVzOjml6gLNRwkItCnC6nxwVrJbTyJgMWgDSTVkEaDWgzTfaHpNrNR4MFZt92IpC
 DiTOhH6YWhn2jNny6bc/LpxUDM/k3cR9az/QgF3cSfcduPPMSbeClLzyCGN8FVpMJUuu
 XRbg==
X-Gm-Message-State: APjAAAVvuG4Iqj6FczxEK8E8b72vews6Y1fw2+kLagHFbImb5l2nFEW4
 OSZk76RU8ugyh80GSukTkpeHHpqk
X-Google-Smtp-Source: APXvYqyrw4h296egFUS5wPqMe2FXyyLVRYGFthLM8TRreG8HpiOdL1AGqpg+GDO5rAx8cqcdozupqg==
X-Received: by 2002:adf:f288:: with SMTP id k8mr76995394wro.301.1582631539819; 
 Tue, 25 Feb 2020 03:52:19 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 079/136] tests:numa-test: use explicit memdev to specify node
 RAM
Date: Tue, 25 Feb 2020 12:50:09 +0100
Message-Id: <1582631466-13880-79-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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

Considering that legacy "mem" option is deprecated, use memdev
in tests and add an additional test for legacy "mem" option
on old machine type, to make sure it won't regress in the future.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200219160953.13771-80-imammedo@redhat.com>
---
 tests/qtest/numa-test.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
index 35999ea..2f9b7f6 100644
--- a/tests/qtest/numa-test.c
+++ b/tests/qtest/numa-test.c
@@ -25,9 +25,8 @@ static void test_mon_explicit(const void *data)
     g_autofree char *s = NULL;
     g_autofree char *cli = NULL;
 
-    cli = make_cli(data, "-smp 8 "
-                   "-numa node,nodeid=0,cpus=0-3 "
-                   "-numa node,nodeid=1,cpus=4-7 ");
+    cli = make_cli(data, "-smp 8 -numa node,nodeid=0,memdev=ram,cpus=0-3 "
+                         "-numa node,nodeid=1,cpus=4-7");
     qts = qtest_init(cli);
 
     s = qtest_hmp(qts, "info numa");
@@ -37,13 +36,13 @@ static void test_mon_explicit(const void *data)
     qtest_quit(qts);
 }
 
-static void test_mon_default(const void *data)
+static void test_def_cpu_split(const void *data)
 {
     QTestState *qts;
     g_autofree char *s = NULL;
     g_autofree char *cli = NULL;
 
-    cli = make_cli(data, "-smp 8 -numa node -numa node");
+    cli = make_cli(data, "-smp 8 -numa node,memdev=ram -numa node");
     qts = qtest_init(cli);
 
     s = qtest_hmp(qts, "info numa");
@@ -60,7 +59,7 @@ static void test_mon_partial(const void *data)
     g_autofree char *cli = NULL;
 
     cli = make_cli(data, "-smp 8 "
-                   "-numa node,nodeid=0,cpus=0-1 "
+                   "-numa node,nodeid=0,memdev=ram,cpus=0-1 "
                    "-numa node,nodeid=1,cpus=4-5 ");
     qts = qtest_init(cli);
 
@@ -87,7 +86,8 @@ static void test_query_cpus(const void *data)
     QTestState *qts;
     g_autofree char *cli = NULL;
 
-    cli = make_cli(data, "-smp 8 -numa node,cpus=0-3 -numa node,cpus=4-7");
+    cli = make_cli(data, "-smp 8 -numa node,memdev=ram,cpus=0-3 "
+                         "-numa node,cpus=4-7");
     qts = qtest_init(cli);
     cpus = get_cpus(qts, &resp);
     g_assert(cpus);
@@ -125,7 +125,7 @@ static void pc_numa_cpu(const void *data)
     g_autofree char *cli = NULL;
 
     cli = make_cli(data, "-cpu pentium -smp 8,sockets=2,cores=2,threads=2 "
-        "-numa node,nodeid=0 -numa node,nodeid=1 "
+        "-numa node,nodeid=0,memdev=ram -numa node,nodeid=1 "
         "-numa cpu,node-id=1,socket-id=0 "
         "-numa cpu,node-id=0,socket-id=1,core-id=0 "
         "-numa cpu,node-id=0,socket-id=1,core-id=1,thread-id=0 "
@@ -178,7 +178,7 @@ static void spapr_numa_cpu(const void *data)
     g_autofree char *cli = NULL;
 
     cli = make_cli(data, "-smp 4,cores=4 "
-        "-numa node,nodeid=0 -numa node,nodeid=1 "
+        "-numa node,nodeid=0,memdev=ram -numa node,nodeid=1 "
         "-numa cpu,node-id=0,core-id=0 "
         "-numa cpu,node-id=0,core-id=1 "
         "-numa cpu,node-id=0,core-id=2 "
@@ -223,7 +223,7 @@ static void aarch64_numa_cpu(const void *data)
     g_autofree char *cli = NULL;
 
     cli = make_cli(data, "-smp 2 "
-        "-numa node,nodeid=0 -numa node,nodeid=1 "
+        "-numa node,nodeid=0,memdev=ram -numa node,nodeid=1 "
         "-numa cpu,node-id=1,thread-id=0 "
         "-numa cpu,node-id=0,thread-id=1");
     qts = qtest_init(cli);
@@ -270,7 +270,7 @@ static void pc_dynamic_cpu_cfg(const void *data)
 
     /* create 2 numa nodes */
     g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
-        " 'arguments': { 'type': 'node', 'nodeid': 0 } }")));
+        " 'arguments': { 'type': 'node', 'nodeid': 0, 'memdev': 'ram' } }")));
     g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
         " 'arguments': { 'type': 'node', 'nodeid': 1 } }")));
 
@@ -542,13 +542,19 @@ int main(int argc, char **argv)
     g_autoptr(GString) args = g_string_new(NULL);
     const char *arch = qtest_get_arch();
 
+    if (g_str_equal(arch, "ppc64")) {
+        g_string_append(args, " -object memory-backend-ram,id=ram,size=512M");
+    } else {
+        g_string_append(args, " -object memory-backend-ram,id=ram,size=128M");
+    }
+
     if (g_str_equal(arch, "aarch64")) {
         g_string_append(args, " -machine virt");
     }
 
     g_test_init(&argc, &argv, NULL);
 
-    qtest_add_data_func("/numa/mon/default", args, test_mon_default);
+    qtest_add_data_func("/numa/mon/cpus/default", args, test_def_cpu_split);
     qtest_add_data_func("/numa/mon/cpus/explicit", args, test_mon_explicit);
     qtest_add_data_func("/numa/mon/cpus/partial", args, test_mon_partial);
     qtest_add_data_func("/numa/qmp/cpus/query-cpus", args, test_query_cpus);
-- 
1.8.3.1



