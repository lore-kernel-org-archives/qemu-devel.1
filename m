Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB1DC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D21F520838
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21F520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9TqP-0001Dv-Tq
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 08:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1j9Tp1-00086c-RZ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1j9Tp0-00040V-87
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:12:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1j9Tp0-0003zB-0L
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:12:22 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 024D9dZi094079; Wed, 4 Mar 2020 08:12:20 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yhw6nyx7f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2020 08:12:20 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 024DAfV9097592;
 Wed, 4 Mar 2020 08:12:20 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yhw6nyx6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2020 08:12:20 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 024DAllc006346;
 Wed, 4 Mar 2020 13:12:18 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma01wdc.us.ibm.com with ESMTP id 2yffk6ayw0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2020 13:12:18 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 024DCIXQ35324294
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2020 13:12:18 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5870111206B;
 Wed,  4 Mar 2020 13:12:18 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B00D112067;
 Wed,  4 Mar 2020 13:12:18 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2020 13:12:18 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 08/10] test: tpm: pass optional machine options to swtpm
 test functions
Date: Wed,  4 Mar 2020 08:12:12 -0500
Message-Id: <20200304131214.179000-9-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200304131214.179000-1-stefanb@linux.vnet.ibm.com>
References: <20200304131214.179000-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-04_05:2020-03-04,
 2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=3 adultscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040101
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

We plan to use swtpm test functions on ARM for testing the
sysbus TPM-TIS device. However on ARM there is no default machine
type. So we need to explictly pass some machine options on startup.
Let's allow this by adding a new parameter to both swtpm test
functions and update all call sites.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-id: 20200226205942.11424-9-eric.auger@redhat.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/qtest/tpm-crb-swtpm-test.c |  5 +++--
 tests/qtest/tpm-tests.c          | 10 ++++++----
 tests/qtest/tpm-tests.h          |  5 +++--
 tests/qtest/tpm-tis-swtpm-test.c |  5 +++--
 tests/qtest/tpm-util.c           |  8 ++++++--
 tests/qtest/tpm-util.h           |  3 ++-
 6 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/tests/qtest/tpm-crb-swtpm-test.c b/tests/qtest/tpm-crb-swtpm-test.c
index 2c4fb8ae29..5228cb7af4 100644
--- a/tests/qtest/tpm-crb-swtpm-test.c
+++ b/tests/qtest/tpm-crb-swtpm-test.c
@@ -29,7 +29,8 @@ static void tpm_crb_swtpm_test(const void *data)
 {
     const TestState *ts = data;
 
-    tpm_test_swtpm_test(ts->src_tpm_path, tpm_util_crb_transfer, "tpm-crb");
+    tpm_test_swtpm_test(ts->src_tpm_path, tpm_util_crb_transfer,
+                        "tpm-crb", NULL);
 }
 
 static void tpm_crb_swtpm_migration_test(const void *data)
@@ -37,7 +38,7 @@ static void tpm_crb_swtpm_migration_test(const void *data)
     const TestState *ts = data;
 
     tpm_test_swtpm_migration_test(ts->src_tpm_path, ts->dst_tpm_path, ts->uri,
-                                  tpm_util_crb_transfer, "tpm-crb");
+                                  tpm_util_crb_transfer, "tpm-crb", NULL);
 }
 
 int main(int argc, char **argv)
diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
index 6e45a0ba85..a2f2838e15 100644
--- a/tests/qtest/tpm-tests.c
+++ b/tests/qtest/tpm-tests.c
@@ -30,7 +30,7 @@ tpm_test_swtpm_skip(void)
 }
 
 void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
-                         const char *ifmodel)
+                         const char *ifmodel, const char *machine_options)
 {
     char *args = NULL;
     QTestState *s;
@@ -47,10 +47,11 @@ void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
     g_assert_true(succ);
 
     args = g_strdup_printf(
+        "%s "
         "-chardev socket,id=chr,path=%s "
         "-tpmdev emulator,id=dev,chardev=chr "
         "-device %s,tpmdev=dev",
-        addr->u.q_unix.path, ifmodel);
+        machine_options ? : "", addr->u.q_unix.path, ifmodel);
 
     s = qtest_start(args);
     g_free(args);
@@ -78,7 +79,8 @@ void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
 void tpm_test_swtpm_migration_test(const char *src_tpm_path,
                                    const char *dst_tpm_path,
                                    const char *uri, tx_func *tx,
-                                   const char *ifmodel)
+                                   const char *ifmodel,
+                                   const char *machine_options)
 {
     gboolean succ;
     GPid src_tpm_pid, dst_tpm_pid;
@@ -100,7 +102,7 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_path,
 
     tpm_util_migration_start_qemu(&src_qemu, &dst_qemu,
                                   src_tpm_addr, dst_tpm_addr, uri,
-                                  ifmodel);
+                                  ifmodel, machine_options);
 
     tpm_util_startup(src_qemu, tx);
     tpm_util_pcrextend(src_qemu, tx);
diff --git a/tests/qtest/tpm-tests.h b/tests/qtest/tpm-tests.h
index b97688fe75..a5df35ab5b 100644
--- a/tests/qtest/tpm-tests.h
+++ b/tests/qtest/tpm-tests.h
@@ -16,11 +16,12 @@
 #include "tpm-util.h"
 
 void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
-                         const char *ifmodel);
+                         const char *ifmodel, const char *machine_options);
 
 void tpm_test_swtpm_migration_test(const char *src_tpm_path,
                                    const char *dst_tpm_path,
                                    const char *uri, tx_func *tx,
-                                   const char *ifmodel);
+                                   const char *ifmodel,
+                                   const char *machine_options);
 
 #endif /* TESTS_TPM_TESTS_H */
diff --git a/tests/qtest/tpm-tis-swtpm-test.c b/tests/qtest/tpm-tis-swtpm-test.c
index 9f58a3a92b..9470f15751 100644
--- a/tests/qtest/tpm-tis-swtpm-test.c
+++ b/tests/qtest/tpm-tis-swtpm-test.c
@@ -29,7 +29,8 @@ static void tpm_tis_swtpm_test(const void *data)
 {
     const TestState *ts = data;
 
-    tpm_test_swtpm_test(ts->src_tpm_path, tpm_util_tis_transfer, "tpm-tis");
+    tpm_test_swtpm_test(ts->src_tpm_path, tpm_util_tis_transfer,
+                        "tpm-tis", NULL);
 }
 
 static void tpm_tis_swtpm_migration_test(const void *data)
@@ -37,7 +38,7 @@ static void tpm_tis_swtpm_migration_test(const void *data)
     const TestState *ts = data;
 
     tpm_test_swtpm_migration_test(ts->src_tpm_path, ts->dst_tpm_path, ts->uri,
-                                  tpm_util_tis_transfer, "tpm-tis");
+                                  tpm_util_tis_transfer, "tpm-tis", NULL);
 }
 
 int main(int argc, char **argv)
diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index e08b137651..7ecdae2fc6 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -258,23 +258,27 @@ void tpm_util_migration_start_qemu(QTestState **src_qemu,
                                    SocketAddress *src_tpm_addr,
                                    SocketAddress *dst_tpm_addr,
                                    const char *miguri,
-                                   const char *ifmodel)
+                                   const char *ifmodel,
+                                   const char *machine_options)
 {
     char *src_qemu_args, *dst_qemu_args;
 
     src_qemu_args = g_strdup_printf(
+        "%s "
         "-chardev socket,id=chr,path=%s "
         "-tpmdev emulator,id=dev,chardev=chr "
         "-device %s,tpmdev=dev ",
-        src_tpm_addr->u.q_unix.path, ifmodel);
+        machine_options ? : "", src_tpm_addr->u.q_unix.path, ifmodel);
 
     *src_qemu = qtest_init(src_qemu_args);
 
     dst_qemu_args = g_strdup_printf(
+        "%s "
         "-chardev socket,id=chr,path=%s "
         "-tpmdev emulator,id=dev,chardev=chr "
         "-device %s,tpmdev=dev "
         "-incoming %s",
+        machine_options ? : "",
         dst_tpm_addr->u.q_unix.path,
         ifmodel, miguri);
 
diff --git a/tests/qtest/tpm-util.h b/tests/qtest/tpm-util.h
index 5755698ad2..15e3924942 100644
--- a/tests/qtest/tpm-util.h
+++ b/tests/qtest/tpm-util.h
@@ -44,7 +44,8 @@ void tpm_util_migration_start_qemu(QTestState **src_qemu,
                                    SocketAddress *src_tpm_addr,
                                    SocketAddress *dst_tpm_addr,
                                    const char *miguri,
-                                   const char *ifmodel);
+                                   const char *ifmodel,
+                                   const char *machine_options);
 
 void tpm_util_wait_for_migration_complete(QTestState *who);
 
-- 
2.24.1


