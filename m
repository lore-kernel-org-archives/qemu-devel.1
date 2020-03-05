Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D7CC3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:45:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B162073B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B162073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9wRC-0001WV-NS
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 14:45:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1j9wKn-0007Pr-Na
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:39:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1j9wKj-0005IY-UQ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:39:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1j9wKj-0005Gr-Ge
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:39:01 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 025JMKt3104593; Thu, 5 Mar 2020 14:39:00 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yfmg413uc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2020 14:38:59 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 025JMbma105218;
 Thu, 5 Mar 2020 14:38:59 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yfmg413tq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2020 14:38:59 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 025JZGTC014794;
 Thu, 5 Mar 2020 19:38:58 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma02dal.us.ibm.com with ESMTP id 2yffk7h4kg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2020 19:38:58 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 025JcvuN48365932
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2020 19:38:57 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60AB0124052;
 Thu,  5 Mar 2020 19:38:57 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E5C9124058;
 Thu,  5 Mar 2020 19:38:57 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2020 19:38:57 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 09/10] test: tpm-tis: Get prepared to share tests between
 ISA and sysbus devices
Date: Thu,  5 Mar 2020 14:38:54 -0500
Message-Id: <20200305193855.278878-10-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305193855.278878-1-stefanb@linux.vnet.ibm.com>
References: <20200305193855.278878-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-05_06:2020-03-05,
 2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=1
 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050114
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id 025JMKt3104593
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

ISA and sysbus TPM-TIS devices will share their tests. Only
the main() will change (instantiation option is different).
Also the base address of the TPM-TIS device is going to be
different. on x86 it is located at 0xFED40000 while on ARM
it can be located at any location, discovered through the
device tree description.

So we put shared test functions in a new object module.
Each test needs to set tpm_tis_base_addr global variable.

Also take benefit of this move to fix "block comments using
a leading */ on a separate line" checkpatch warnings.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-id: 20200305165149.618-10-eric.auger@redhat.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/qtest/Makefile.include     |   2 +-
 tests/qtest/tpm-crb-swtpm-test.c |   4 +
 tests/qtest/tpm-crb-test.c       |   3 +
 tests/qtest/tpm-tis-swtpm-test.c |   3 +
 tests/qtest/tpm-tis-test.c       | 414 +---------------------------
 tests/qtest/tpm-tis-util.c       | 451 +++++++++++++++++++++++++++++++
 tests/qtest/tpm-tis-util.h       |  23 ++
 tests/qtest/tpm-util.c           |   3 -
 tests/qtest/tpm-util.h           |   5 +
 9 files changed, 493 insertions(+), 415 deletions(-)
 create mode 100644 tests/qtest/tpm-tis-util.c
 create mode 100644 tests/qtest/tpm-tis-util.h

diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index 028af5b782..44aac68b25 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -302,7 +302,7 @@ tests/qtest/tpm-crb-swtpm-test$(EXESUF): tests/qtest/=
tpm-crb-swtpm-test.o tests/
 tests/qtest/tpm-crb-test$(EXESUF): tests/qtest/tpm-crb-test.o tests/qtes=
t/tpm-emu.o $(test-io-obj-y)
 tests/qtest/tpm-tis-swtpm-test$(EXESUF): tests/qtest/tpm-tis-swtpm-test.=
o tests/qtest/tpm-emu.o \
 	tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
-tests/qtest/tpm-tis-test$(EXESUF): tests/qtest/tpm-tis-test.o tests/qtes=
t/tpm-emu.o $(test-io-obj-y)
+tests/qtest/tpm-tis-test$(EXESUF): tests/qtest/tpm-tis-test.o tests/qtes=
t/tpm-tis-util.o tests/qtest/tpm-emu.o $(test-io-obj-y)
=20
 # QTest rules
=20
diff --git a/tests/qtest/tpm-crb-swtpm-test.c b/tests/qtest/tpm-crb-swtpm=
-test.c
index 5228cb7af4..55fdb5657d 100644
--- a/tests/qtest/tpm-crb-swtpm-test.c
+++ b/tests/qtest/tpm-crb-swtpm-test.c
@@ -18,6 +18,10 @@
 #include "libqtest.h"
 #include "qemu/module.h"
 #include "tpm-tests.h"
+#include "hw/acpi/tpm.h"
+
+/* Not used but needed for linking */
+uint64_t tpm_tis_base_addr =3D TPM_TIS_ADDR_BASE;
=20
 typedef struct TestState {
     char *src_tpm_path;
diff --git a/tests/qtest/tpm-crb-test.c b/tests/qtest/tpm-crb-test.c
index 632fb7fbd8..ed533900d1 100644
--- a/tests/qtest/tpm-crb-test.c
+++ b/tests/qtest/tpm-crb-test.c
@@ -19,6 +19,9 @@
 #include "qemu/module.h"
 #include "tpm-emu.h"
=20
+/* Not used but needed for linking */
+uint64_t tpm_tis_base_addr =3D TPM_TIS_ADDR_BASE;
+
 #define TPM_CMD "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00"
=20
 static void tpm_crb_test(const void *data)
diff --git a/tests/qtest/tpm-tis-swtpm-test.c b/tests/qtest/tpm-tis-swtpm=
-test.c
index 9470f15751..90131cb3c4 100644
--- a/tests/qtest/tpm-tis-swtpm-test.c
+++ b/tests/qtest/tpm-tis-swtpm-test.c
@@ -18,6 +18,9 @@
 #include "libqtest.h"
 #include "qemu/module.h"
 #include "tpm-tests.h"
+#include "hw/acpi/tpm.h"
+
+uint64_t tpm_tis_base_addr =3D TPM_TIS_ADDR_BASE;
=20
 typedef struct TestState {
     char *src_tpm_path;
diff --git a/tests/qtest/tpm-tis-test.c b/tests/qtest/tpm-tis-test.c
index dcf30e05b7..79ffbc943e 100644
--- a/tests/qtest/tpm-tis-test.c
+++ b/tests/qtest/tpm-tis-test.c
@@ -1,5 +1,5 @@
 /*
- * QTest testcase for TPM TIS
+ * QTest testcase for ISA TPM TIS
  *
  * Copyright (c) 2018 Red Hat, Inc.
  * Copyright (c) 2018 IBM Corporation
@@ -20,417 +20,9 @@
 #include "libqtest-single.h"
 #include "qemu/module.h"
 #include "tpm-emu.h"
+#include "tpm-tis-util.h"
=20
-#define TIS_REG(LOCTY, REG) \
-    (TPM_TIS_ADDR_BASE + ((LOCTY) << 12) + REG)
-
-#define DEBUG_TIS_TEST 0
-
-#define DPRINTF(fmt, ...) do { \
-    if (DEBUG_TIS_TEST) { \
-        printf(fmt, ## __VA_ARGS__); \
-    } \
-} while (0)
-
-#define DPRINTF_ACCESS \
-    DPRINTF("%s: %d: locty=3D%d l=3D%d access=3D0x%02x pending_request_f=
lag=3D0x%x\n", \
-            __func__, __LINE__, locty, l, access, pending_request_flag)
-
-#define DPRINTF_STS \
-    DPRINTF("%s: %d: sts =3D 0x%08x\n", __func__, __LINE__, sts)
-
-static const uint8_t TPM_CMD[12] =3D
-    "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00";
-
-static void tpm_tis_test_check_localities(const void *data)
-{
-    uint8_t locty;
-    uint8_t access;
-    uint32_t ifaceid;
-    uint32_t capability;
-    uint32_t didvid;
-    uint32_t rid;
-
-    for (locty =3D 0; locty < TPM_TIS_NUM_LOCALITIES; locty++) {
-        access =3D readb(TIS_REG(0, TPM_TIS_REG_ACCESS));
-        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
-                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-        capability =3D readl(TIS_REG(locty, TPM_TIS_REG_INTF_CAPABILITY)=
);
-        g_assert_cmpint(capability, =3D=3D, TPM_TIS_CAPABILITIES_SUPPORT=
ED2_0);
-
-        ifaceid =3D readl(TIS_REG(locty, TPM_TIS_REG_INTERFACE_ID));
-        g_assert_cmpint(ifaceid, =3D=3D, TPM_TIS_IFACE_ID_SUPPORTED_FLAG=
S2_0);
-
-        didvid =3D readl(TIS_REG(locty, TPM_TIS_REG_DID_VID));
-        g_assert_cmpint(didvid, !=3D, 0);
-        g_assert_cmpint(didvid, !=3D, 0xffffffff);
-
-        rid =3D readl(TIS_REG(locty, TPM_TIS_REG_RID));
-        g_assert_cmpint(rid, !=3D, 0);
-        g_assert_cmpint(rid, !=3D, 0xffffffff);
-    }
-}
-
-static void tpm_tis_test_check_access_reg(const void *data)
-{
-    uint8_t locty;
-    uint8_t access;
-
-    /* do not test locality 4 (hw only) */
-    for (locty =3D 0; locty < TPM_TIS_NUM_LOCALITIES - 1; locty++) {
-        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
-        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
-                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-        /* request use of locality */
-        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUES=
T_USE);
-
-        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
-        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
-                                    TPM_TIS_ACCESS_ACTIVE_LOCALITY |
-                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-        /* release access */
-        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS),
-               TPM_TIS_ACCESS_ACTIVE_LOCALITY);
-        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
-        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
-                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-    }
-}
-
-/*
- * Test case for seizing access by a higher number locality
- */
-static void tpm_tis_test_check_access_reg_seize(const void *data)
-{
-    int locty, l;
-    uint8_t access;
-    uint8_t pending_request_flag;
-
-    /* do not test locality 4 (hw only) */
-    for (locty =3D 0; locty < TPM_TIS_NUM_LOCALITIES - 1; locty++) {
-        pending_request_flag =3D 0;
-
-        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
-        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
-                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-        /* request use of locality */
-        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUES=
T_USE);
-        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
-        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
-                                    TPM_TIS_ACCESS_ACTIVE_LOCALITY |
-                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-        /* lower localities cannot seize access */
-        for (l =3D 0; l < locty; l++) {
-            /* lower locality is not active */
-            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
-
-            /* try to request use from 'l' */
-            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUES=
T_USE);
-
-            /* requesting use from 'l' was not possible;
-               we must see REQUEST_USE and possibly PENDING_REQUEST */
-            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
-                                        TPM_TIS_ACCESS_REQUEST_USE |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
-
-            /* locality 'locty' must be unchanged;
-               we must see PENDING_REQUEST */
-            access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
-                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
-                                        TPM_TIS_ACCESS_PENDING_REQUEST |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
-
-            /* try to seize from 'l' */
-            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_SEIZE)=
;
-            /* seize from 'l' was not possible */
-            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
-                                        TPM_TIS_ACCESS_REQUEST_USE |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
-
-            /* locality 'locty' must be unchanged */
-            access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
-                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
-                                        TPM_TIS_ACCESS_PENDING_REQUEST |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
-
-            /* on the next loop we will have a PENDING_REQUEST flag
-               set for locality 'l' */
-            pending_request_flag =3D TPM_TIS_ACCESS_PENDING_REQUEST;
-        }
-
-        /* higher localities can 'seize' access but not 'request use';
-           note: this will activate first l+1, then l+2 etc. */
-        for (l =3D locty + 1; l < TPM_TIS_NUM_LOCALITIES - 1; l++) {
-            /* try to 'request use' from 'l' */
-            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUES=
T_USE);
-
-            /* requesting use from 'l' was not possible; we should see
-               REQUEST_USE and may see PENDING_REQUEST */
-            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
-                                        TPM_TIS_ACCESS_REQUEST_USE |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
-
-            /* locality 'l-1' must be unchanged; we should always
-               see PENDING_REQUEST from 'l' requesting access */
-            access =3D readb(TIS_REG(l - 1, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
-                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
-                                        TPM_TIS_ACCESS_PENDING_REQUEST |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
-
-            /* try to seize from 'l' */
-            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_SEIZE)=
;
-
-            /* seize from 'l' was possible */
-            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
-                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
-
-            /* l - 1 should show that it has BEEN_SEIZED */
-            access =3D readb(TIS_REG(l - 1, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
-                                        TPM_TIS_ACCESS_BEEN_SEIZED |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
-
-            /* clear the BEEN_SEIZED flag and make sure it's gone */
-            writeb(TIS_REG(l - 1, TPM_TIS_REG_ACCESS),
-                   TPM_TIS_ACCESS_BEEN_SEIZED);
-
-            access =3D readb(TIS_REG(l - 1, TPM_TIS_REG_ACCESS));
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
-        }
-
-        /* PENDING_REQUEST will not be set if locty =3D 0 since all loca=
lities
-           were active; in case of locty =3D 1, locality 0 will be activ=
e
-           but no PENDING_REQUEST anywhere */
-        if (locty <=3D 1) {
-            pending_request_flag =3D 0;
-        }
-
-        /* release access from l - 1; this activates locty - 1 */
-        l--;
-
-        access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-        DPRINTF_ACCESS;
-
-        DPRINTF("%s: %d: relinquishing control on l =3D %d\n",
-                __func__, __LINE__, l);
-        writeb(TIS_REG(l, TPM_TIS_REG_ACCESS),
-               TPM_TIS_ACCESS_ACTIVE_LOCALITY);
-
-        access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-        DPRINTF_ACCESS;
-        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
-                                    pending_request_flag |
-                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-        for (l =3D locty - 1; l >=3D 0; l--) {
-            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
-                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
-
-            /* release this locality */
-            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS),
-                   TPM_TIS_ACCESS_ACTIVE_LOCALITY);
-
-            if (l =3D=3D 1) {
-                pending_request_flag =3D 0;
-            }
-        }
-
-        /* no locality may be active now */
-        for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES - 1; l++) {
-            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
-        }
-    }
-}
-
-/*
- * Test case for getting access when higher number locality relinquishes=
 access
- */
-static void tpm_tis_test_check_access_reg_release(const void *data)
-{
-    int locty, l;
-    uint8_t access;
-    uint8_t pending_request_flag;
-
-    /* do not test locality 4 (hw only) */
-    for (locty =3D TPM_TIS_NUM_LOCALITIES - 2; locty >=3D 0; locty--) {
-        pending_request_flag =3D 0;
-
-        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
-        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
-                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-        /* request use of locality */
-        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUES=
T_USE);
-        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
-        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
-                                    TPM_TIS_ACCESS_ACTIVE_LOCALITY |
-                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-        /* request use of all other localities */
-        for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES - 1; l++) {
-            if (l =3D=3D locty) {
-                continue;
-            }
-            /* request use of locality 'l' -- we MUST see REQUEST USE an=
d
-               may see PENDING_REQUEST */
-            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUES=
T_USE);
-            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
-                                        TPM_TIS_ACCESS_REQUEST_USE |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
-            pending_request_flag =3D TPM_TIS_ACCESS_PENDING_REQUEST;
-        }
-        /* release locality 'locty' */
-        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS),
-               TPM_TIS_ACCESS_ACTIVE_LOCALITY);
-        /* highest locality should now be active; release it and make su=
re the
-           next higest locality is active afterwards */
-        for (l =3D TPM_TIS_NUM_LOCALITIES - 2; l >=3D 0; l--) {
-            if (l =3D=3D locty) {
-                continue;
-            }
-            /* 'l' should be active now */
-            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
-                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
-            /* 'l' relinquishes access */
-            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS),
-                   TPM_TIS_ACCESS_ACTIVE_LOCALITY);
-            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            if (l =3D=3D 1 || (locty <=3D 1 && l =3D=3D 2)) {
-                pending_request_flag =3D 0;
-            }
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
-        }
-    }
-}
-
-/*
- * Test case for transmitting packets
- */
-static void tpm_tis_test_check_transmit(const void *data)
-{
-    const TestState *s =3D data;
-    uint8_t access;
-    uint32_t sts;
-    uint16_t bcount;
-    size_t i;
-
-    /* request use of locality 0 */
-    writeb(TIS_REG(0, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUEST_USE);
-    access =3D readb(TIS_REG(0, TPM_TIS_REG_ACCESS));
-    g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
-                                TPM_TIS_ACCESS_ACTIVE_LOCALITY |
-                                TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-    sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
-    DPRINTF_STS;
-
-    g_assert_cmpint(sts & 0xff, =3D=3D, 0);
-    g_assert_cmpint(sts & TPM_TIS_STS_TPM_FAMILY_MASK, =3D=3D,
-                    TPM_TIS_STS_TPM_FAMILY2_0);
-
-    bcount =3D (sts >> 8) & 0xffff;
-    g_assert_cmpint(bcount, >=3D, 128);
-
-    writel(TIS_REG(0, TPM_TIS_REG_STS), TPM_TIS_STS_COMMAND_READY);
-    sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
-    DPRINTF_STS;
-    g_assert_cmpint(sts & 0xff, =3D=3D, TPM_TIS_STS_COMMAND_READY);
-
-    /* transmit command */
-    for (i =3D 0; i < sizeof(TPM_CMD); i++) {
-        writeb(TIS_REG(0, TPM_TIS_REG_DATA_FIFO), TPM_CMD[i]);
-        sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
-        DPRINTF_STS;
-        if (i < sizeof(TPM_CMD) - 1) {
-            g_assert_cmpint(sts & 0xff, =3D=3D,
-                            TPM_TIS_STS_EXPECT | TPM_TIS_STS_VALID);
-        } else {
-            g_assert_cmpint(sts & 0xff, =3D=3D, TPM_TIS_STS_VALID);
-        }
-        g_assert_cmpint((sts >> 8) & 0xffff, =3D=3D, --bcount);
-    }
-    /* start processing */
-    writeb(TIS_REG(0, TPM_TIS_REG_STS), TPM_TIS_STS_TPM_GO);
-
-    uint64_t end_time =3D g_get_monotonic_time() + 50 * G_TIME_SPAN_SECO=
ND;
-    do {
-        sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
-        if ((sts & TPM_TIS_STS_DATA_AVAILABLE) !=3D 0) {
-            break;
-        }
-    } while (g_get_monotonic_time() < end_time);
-
-    sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
-    DPRINTF_STS;
-    g_assert_cmpint(sts & 0xff, =3D=3D ,
-                    TPM_TIS_STS_VALID | TPM_TIS_STS_DATA_AVAILABLE);
-    bcount =3D (sts >> 8) & 0xffff;
-
-    /* read response */
-    uint8_t tpm_msg[sizeof(struct tpm_hdr)];
-    g_assert_cmpint(sizeof(tpm_msg), =3D=3D, bcount);
-
-    for (i =3D 0; i < sizeof(tpm_msg); i++) {
-        tpm_msg[i] =3D readb(TIS_REG(0, TPM_TIS_REG_DATA_FIFO));
-        sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
-        DPRINTF_STS;
-        if (sts & TPM_TIS_STS_DATA_AVAILABLE) {
-            g_assert_cmpint((sts >> 8) & 0xffff, =3D=3D, --bcount);
-        }
-    }
-    g_assert_cmpmem(tpm_msg, sizeof(tpm_msg), s->tpm_msg, sizeof(*s->tpm=
_msg));
-
-    /* relinquish use of locality 0 */
-    writeb(TIS_REG(0, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_ACTIVE_LOCALIT=
Y);
-    access =3D readb(TIS_REG(0, TPM_TIS_REG_ACCESS));
-}
+uint64_t tpm_tis_base_addr =3D TPM_TIS_ADDR_BASE;
=20
 int main(int argc, char **argv)
 {
diff --git a/tests/qtest/tpm-tis-util.c b/tests/qtest/tpm-tis-util.c
new file mode 100644
index 0000000000..9aff503fd8
--- /dev/null
+++ b/tests/qtest/tpm-tis-util.c
@@ -0,0 +1,451 @@
+/*
+ * QTest testcase for TPM TIS: common test functions used for both
+ * the ISA and SYSBUS devices
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ * Copyright (c) 2018 IBM Corporation
+ *
+ * Authors:
+ *   Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *   Stefan Berger <stefanb@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <glib/gstdio.h>
+
+#include "hw/acpi/tpm.h"
+#include "io/channel-socket.h"
+#include "libqtest-single.h"
+#include "qemu/module.h"
+#include "tpm-emu.h"
+#include "tpm-util.h"
+#include "tpm-tis-util.h"
+
+#define DEBUG_TIS_TEST 0
+
+#define DPRINTF(fmt, ...) do { \
+    if (DEBUG_TIS_TEST) { \
+        printf(fmt, ## __VA_ARGS__); \
+    } \
+} while (0)
+
+#define DPRINTF_ACCESS \
+    DPRINTF("%s: %d: locty=3D%d l=3D%d access=3D0x%02x pending_request_f=
lag=3D0x%x\n", \
+            __func__, __LINE__, locty, l, access, pending_request_flag)
+
+#define DPRINTF_STS \
+    DPRINTF("%s: %d: sts =3D 0x%08x\n", __func__, __LINE__, sts)
+
+static const uint8_t TPM_CMD[12] =3D
+    "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00";
+
+void tpm_tis_test_check_localities(const void *data)
+{
+    uint8_t locty;
+    uint8_t access;
+    uint32_t ifaceid;
+    uint32_t capability;
+    uint32_t didvid;
+    uint32_t rid;
+
+    for (locty =3D 0; locty < TPM_TIS_NUM_LOCALITIES; locty++) {
+        access =3D readb(TIS_REG(0, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        capability =3D readl(TIS_REG(locty, TPM_TIS_REG_INTF_CAPABILITY)=
);
+        g_assert_cmpint(capability, =3D=3D, TPM_TIS_CAPABILITIES_SUPPORT=
ED2_0);
+
+        ifaceid =3D readl(TIS_REG(locty, TPM_TIS_REG_INTERFACE_ID));
+        g_assert_cmpint(ifaceid, =3D=3D, TPM_TIS_IFACE_ID_SUPPORTED_FLAG=
S2_0);
+
+        didvid =3D readl(TIS_REG(locty, TPM_TIS_REG_DID_VID));
+        g_assert_cmpint(didvid, !=3D, 0);
+        g_assert_cmpint(didvid, !=3D, 0xffffffff);
+
+        rid =3D readl(TIS_REG(locty, TPM_TIS_REG_RID));
+        g_assert_cmpint(rid, !=3D, 0);
+        g_assert_cmpint(rid, !=3D, 0xffffffff);
+    }
+}
+
+void tpm_tis_test_check_access_reg(const void *data)
+{
+    uint8_t locty;
+    uint8_t access;
+
+    /* do not test locality 4 (hw only) */
+    for (locty =3D 0; locty < TPM_TIS_NUM_LOCALITIES - 1; locty++) {
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        /* request use of locality */
+        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUES=
T_USE);
+
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
+                                    TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        /* release access */
+        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS),
+               TPM_TIS_ACCESS_ACTIVE_LOCALITY);
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+    }
+}
+
+/*
+ * Test case for seizing access by a higher number locality
+ */
+void tpm_tis_test_check_access_reg_seize(const void *data)
+{
+    int locty, l;
+    uint8_t access;
+    uint8_t pending_request_flag;
+
+    /* do not test locality 4 (hw only) */
+    for (locty =3D 0; locty < TPM_TIS_NUM_LOCALITIES - 1; locty++) {
+        pending_request_flag =3D 0;
+
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        /* request use of locality */
+        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUES=
T_USE);
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
+                                    TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        /* lower localities cannot seize access */
+        for (l =3D 0; l < locty; l++) {
+            /* lower locality is not active */
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+
+            /* try to request use from 'l' */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUES=
T_USE);
+
+            /*
+             * requesting use from 'l' was not possible;
+             * we must see REQUEST_USE and possibly PENDING_REQUEST
+             */
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_REQUEST_USE |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+
+            /*
+             * locality 'locty' must be unchanged;
+             * we must see PENDING_REQUEST
+             */
+            access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                        TPM_TIS_ACCESS_PENDING_REQUEST |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+
+            /* try to seize from 'l' */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_SEIZE)=
;
+            /* seize from 'l' was not possible */
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_REQUEST_USE |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+
+            /* locality 'locty' must be unchanged */
+            access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                        TPM_TIS_ACCESS_PENDING_REQUEST |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+
+            /*
+             * on the next loop we will have a PENDING_REQUEST flag
+             * set for locality 'l'
+             */
+            pending_request_flag =3D TPM_TIS_ACCESS_PENDING_REQUEST;
+        }
+
+        /*
+         * higher localities can 'seize' access but not 'request use';
+         * note: this will activate first l+1, then l+2 etc.
+         */
+        for (l =3D locty + 1; l < TPM_TIS_NUM_LOCALITIES - 1; l++) {
+            /* try to 'request use' from 'l' */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUES=
T_USE);
+
+            /*
+             * requesting use from 'l' was not possible; we should see
+             * REQUEST_USE and may see PENDING_REQUEST
+             */
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_REQUEST_USE |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+
+            /*
+             * locality 'l-1' must be unchanged; we should always
+             * see PENDING_REQUEST from 'l' requesting access
+             */
+            access =3D readb(TIS_REG(l - 1, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                        TPM_TIS_ACCESS_PENDING_REQUEST |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+
+            /* try to seize from 'l' */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_SEIZE)=
;
+
+            /* seize from 'l' was possible */
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+
+            /* l - 1 should show that it has BEEN_SEIZED */
+            access =3D readb(TIS_REG(l - 1, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_BEEN_SEIZED |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+
+            /* clear the BEEN_SEIZED flag and make sure it's gone */
+            writeb(TIS_REG(l - 1, TPM_TIS_REG_ACCESS),
+                   TPM_TIS_ACCESS_BEEN_SEIZED);
+
+            access =3D readb(TIS_REG(l - 1, TPM_TIS_REG_ACCESS));
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+        }
+
+        /*
+         * PENDING_REQUEST will not be set if locty =3D 0 since all loca=
lities
+         * were active; in case of locty =3D 1, locality 0 will be activ=
e
+         * but no PENDING_REQUEST anywhere
+         */
+        if (locty <=3D 1) {
+            pending_request_flag =3D 0;
+        }
+
+        /* release access from l - 1; this activates locty - 1 */
+        l--;
+
+        access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+        DPRINTF_ACCESS;
+
+        DPRINTF("%s: %d: relinquishing control on l =3D %d\n",
+                __func__, __LINE__, l);
+        writeb(TIS_REG(l, TPM_TIS_REG_ACCESS),
+               TPM_TIS_ACCESS_ACTIVE_LOCALITY);
+
+        access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+        DPRINTF_ACCESS;
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
+                                    pending_request_flag |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        for (l =3D locty - 1; l >=3D 0; l--) {
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+
+            /* release this locality */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS),
+                   TPM_TIS_ACCESS_ACTIVE_LOCALITY);
+
+            if (l =3D=3D 1) {
+                pending_request_flag =3D 0;
+            }
+        }
+
+        /* no locality may be active now */
+        for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES - 1; l++) {
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+        }
+    }
+}
+
+/*
+ * Test case for getting access when higher number locality relinquishes=
 access
+ */
+void tpm_tis_test_check_access_reg_release(const void *data)
+{
+    int locty, l;
+    uint8_t access;
+    uint8_t pending_request_flag;
+
+    /* do not test locality 4 (hw only) */
+    for (locty =3D TPM_TIS_NUM_LOCALITIES - 2; locty >=3D 0; locty--) {
+        pending_request_flag =3D 0;
+
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        /* request use of locality */
+        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUES=
T_USE);
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
+                                    TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        /* request use of all other localities */
+        for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES - 1; l++) {
+            if (l =3D=3D locty) {
+                continue;
+            }
+            /*
+             * request use of locality 'l' -- we MUST see REQUEST USE an=
d
+             * may see PENDING_REQUEST
+             */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUES=
T_USE);
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_REQUEST_USE |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+            pending_request_flag =3D TPM_TIS_ACCESS_PENDING_REQUEST;
+        }
+        /* release locality 'locty' */
+        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS),
+               TPM_TIS_ACCESS_ACTIVE_LOCALITY);
+        /*
+         * highest locality should now be active; release it and make su=
re the
+         * next higest locality is active afterwards
+         */
+        for (l =3D TPM_TIS_NUM_LOCALITIES - 2; l >=3D 0; l--) {
+            if (l =3D=3D locty) {
+                continue;
+            }
+            /* 'l' should be active now */
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+            /* 'l' relinquishes access */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS),
+                   TPM_TIS_ACCESS_ACTIVE_LOCALITY);
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            if (l =3D=3D 1 || (locty <=3D 1 && l =3D=3D 2)) {
+                pending_request_flag =3D 0;
+            }
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+        }
+    }
+}
+
+/*
+ * Test case for transmitting packets
+ */
+void tpm_tis_test_check_transmit(const void *data)
+{
+    const TestState *s =3D data;
+    uint8_t access;
+    uint32_t sts;
+    uint16_t bcount;
+    size_t i;
+
+    /* request use of locality 0 */
+    writeb(TIS_REG(0, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUEST_USE);
+    access =3D readb(TIS_REG(0, TPM_TIS_REG_ACCESS));
+    g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
+                                TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+    sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
+    DPRINTF_STS;
+
+    g_assert_cmpint(sts & 0xff, =3D=3D, 0);
+    g_assert_cmpint(sts & TPM_TIS_STS_TPM_FAMILY_MASK, =3D=3D,
+                    TPM_TIS_STS_TPM_FAMILY2_0);
+
+    bcount =3D (sts >> 8) & 0xffff;
+    g_assert_cmpint(bcount, >=3D, 128);
+
+    writel(TIS_REG(0, TPM_TIS_REG_STS), TPM_TIS_STS_COMMAND_READY);
+    sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
+    DPRINTF_STS;
+    g_assert_cmpint(sts & 0xff, =3D=3D, TPM_TIS_STS_COMMAND_READY);
+
+    /* transmit command */
+    for (i =3D 0; i < sizeof(TPM_CMD); i++) {
+        writeb(TIS_REG(0, TPM_TIS_REG_DATA_FIFO), TPM_CMD[i]);
+        sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
+        DPRINTF_STS;
+        if (i < sizeof(TPM_CMD) - 1) {
+            g_assert_cmpint(sts & 0xff, =3D=3D,
+                            TPM_TIS_STS_EXPECT | TPM_TIS_STS_VALID);
+        } else {
+            g_assert_cmpint(sts & 0xff, =3D=3D, TPM_TIS_STS_VALID);
+        }
+        g_assert_cmpint((sts >> 8) & 0xffff, =3D=3D, --bcount);
+    }
+    /* start processing */
+    writeb(TIS_REG(0, TPM_TIS_REG_STS), TPM_TIS_STS_TPM_GO);
+
+    uint64_t end_time =3D g_get_monotonic_time() + 50 * G_TIME_SPAN_SECO=
ND;
+    do {
+        sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
+        if ((sts & TPM_TIS_STS_DATA_AVAILABLE) !=3D 0) {
+            break;
+        }
+    } while (g_get_monotonic_time() < end_time);
+
+    sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
+    DPRINTF_STS;
+    g_assert_cmpint(sts & 0xff, =3D=3D ,
+                    TPM_TIS_STS_VALID | TPM_TIS_STS_DATA_AVAILABLE);
+    bcount =3D (sts >> 8) & 0xffff;
+
+    /* read response */
+    uint8_t tpm_msg[sizeof(struct tpm_hdr)];
+    g_assert_cmpint(sizeof(tpm_msg), =3D=3D, bcount);
+
+    for (i =3D 0; i < sizeof(tpm_msg); i++) {
+        tpm_msg[i] =3D readb(TIS_REG(0, TPM_TIS_REG_DATA_FIFO));
+        sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
+        DPRINTF_STS;
+        if (sts & TPM_TIS_STS_DATA_AVAILABLE) {
+            g_assert_cmpint((sts >> 8) & 0xffff, =3D=3D, --bcount);
+        }
+    }
+    g_assert_cmpmem(tpm_msg, sizeof(tpm_msg), s->tpm_msg, sizeof(*s->tpm=
_msg));
+
+    /* relinquish use of locality 0 */
+    writeb(TIS_REG(0, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_ACTIVE_LOCALIT=
Y);
+    access =3D readb(TIS_REG(0, TPM_TIS_REG_ACCESS));
+}
diff --git a/tests/qtest/tpm-tis-util.h b/tests/qtest/tpm-tis-util.h
new file mode 100644
index 0000000000..d10efe86ae
--- /dev/null
+++ b/tests/qtest/tpm-tis-util.h
@@ -0,0 +1,23 @@
+/*
+ * QTest TPM TIS: Common test functions used for both the
+ * ISA and SYSBUS devices
+ *
+ * Copyright (c) 2018 IBM Corporation
+ *
+ * Authors:
+ *   Stefan Berger <stefanb@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef TESTS_TPM_TIS_UTIL_H
+#define TESTS_TPM_TIS_UTIL_H
+
+void tpm_tis_test_check_localities(const void *data);
+void tpm_tis_test_check_access_reg(const void *data);
+void tpm_tis_test_check_access_reg_seize(const void *data);
+void tpm_tis_test_check_access_reg_release(const void *data);
+void tpm_tis_test_check_transmit(const void *data);
+
+#endif /* TESTS_TPM_TIS_UTIL_H */
diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index 7ecdae2fc6..34efae8f18 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -19,9 +19,6 @@
 #include "tpm-util.h"
 #include "qapi/qmp/qdict.h"
=20
-#define TIS_REG(LOCTY, REG) \
-    (TPM_TIS_ADDR_BASE + ((LOCTY) << 12) + REG)
-
 void tpm_util_crb_transfer(QTestState *s,
                            const unsigned char *req, size_t req_size,
                            unsigned char *rsp, size_t rsp_size)
diff --git a/tests/qtest/tpm-util.h b/tests/qtest/tpm-util.h
index 15e3924942..3b97d69017 100644
--- a/tests/qtest/tpm-util.h
+++ b/tests/qtest/tpm-util.h
@@ -15,6 +15,11 @@
=20
 #include "io/channel-socket.h"
=20
+extern uint64_t tpm_tis_base_addr;
+
+#define TIS_REG(LOCTY, REG) \
+    (tpm_tis_base_addr + ((LOCTY) << 12) + REG)
+
 typedef void (tx_func)(QTestState *s,
                        const unsigned char *req, size_t req_size,
                        unsigned char *rsp, size_t rsp_size);
--=20
2.24.1


