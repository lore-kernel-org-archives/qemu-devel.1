Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE134C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41D620838
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41D620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Tqs-0002VC-Sz
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 08:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1j9Tp1-00086R-Ef
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1j9Toz-0003z2-Cm
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:12:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30028
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1j9Toz-0003v0-7j
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:12:21 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 024DB56H070522; Wed, 4 Mar 2020 08:12:20 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yhs0u3756-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2020 08:12:20 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 024DB9u5070856;
 Wed, 4 Mar 2020 08:12:19 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yhs0u374q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2020 08:12:19 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 024DAkAf006334;
 Wed, 4 Mar 2020 13:12:19 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma01wdc.us.ibm.com with ESMTP id 2yffk6ayw2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2020 13:12:19 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 024DCIbw52953452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2020 13:12:18 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A26FD112063;
 Wed,  4 Mar 2020 13:12:18 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89E23112064;
 Wed,  4 Mar 2020 13:12:18 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2020 13:12:18 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 10/10] test: tpm-tis: Add Sysbus TPM-TIS device test
Date: Wed,  4 Mar 2020 08:12:14 -0500
Message-Id: <20200304131214.179000-11-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200304131214.179000-1-stefanb@linux.vnet.ibm.com>
References: <20200304131214.179000-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-04_05:2020-03-04,
 2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=3
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040101
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id 024DB56H070522
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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

The tests themselves are the same as the ISA device ones.
Only the main() changes as the "tpm-tis-device" device gets
instantiated. Also the base address of the device is not
0xFED40000 anymore but matches the base address of the
ARM virt platform bus.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-id: 20200226205942.11424-11-eric.auger@redhat.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/qtest/Makefile.include            |  5 ++
 tests/qtest/tpm-tis-device-swtpm-test.c | 76 +++++++++++++++++++++
 tests/qtest/tpm-tis-device-test.c       | 87 +++++++++++++++++++++++++
 3 files changed, 168 insertions(+)
 create mode 100644 tests/qtest/tpm-tis-device-swtpm-test.c
 create mode 100644 tests/qtest/tpm-tis-device-test.c

diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index 44aac68b25..383b0ab217 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -130,6 +130,8 @@ check-qtest-arm-y +=3D hexloader-test
 check-qtest-arm-$(CONFIG_PFLASH_CFI02) +=3D pflash-cfi02-test
=20
 check-qtest-aarch64-y +=3D arm-cpu-features
+check-qtest-aarch64-$(CONFIG_TPM_TIS_SYSBUS) +=3D tpm-tis-device-test
+check-qtest-aarch64-$(CONFIG_TPM_TIS_SYSBUS) +=3D tpm-tis-device-swtpm-t=
est
 check-qtest-aarch64-y +=3D numa-test
 check-qtest-aarch64-y +=3D boot-serial-test
 check-qtest-aarch64-y +=3D migration-test
@@ -302,7 +304,10 @@ tests/qtest/tpm-crb-swtpm-test$(EXESUF): tests/qtest=
/tpm-crb-swtpm-test.o tests/
 tests/qtest/tpm-crb-test$(EXESUF): tests/qtest/tpm-crb-test.o tests/qtes=
t/tpm-emu.o $(test-io-obj-y)
 tests/qtest/tpm-tis-swtpm-test$(EXESUF): tests/qtest/tpm-tis-swtpm-test.=
o tests/qtest/tpm-emu.o \
 	tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
+tests/qtest/tpm-tis-device-swtpm-test$(EXESUF): tests/qtest/tpm-tis-devi=
ce-swtpm-test.o tests/qtest/tpm-emu.o \
+	tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
 tests/qtest/tpm-tis-test$(EXESUF): tests/qtest/tpm-tis-test.o tests/qtes=
t/tpm-tis-util.o tests/qtest/tpm-emu.o $(test-io-obj-y)
+tests/qtest/tpm-tis-device-test$(EXESUF): tests/qtest/tpm-tis-device-tes=
t.o tests/qtest/tpm-tis-util.o tests/qtest/tpm-emu.o $(test-io-obj-y)
=20
 # QTest rules
=20
diff --git a/tests/qtest/tpm-tis-device-swtpm-test.c b/tests/qtest/tpm-ti=
s-device-swtpm-test.c
new file mode 100644
index 0000000000..7b20035142
--- /dev/null
+++ b/tests/qtest/tpm-tis-device-swtpm-test.c
@@ -0,0 +1,76 @@
+/*
+ * QTest testcase for Sysbus TPM TIS talking to external swtpm and swtpm
+ * migration
+ *
+ * Copyright (c) 2018 IBM Corporation
+ *  with parts borrowed from migration-test.c that is:
+ *     Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
+ *
+ * Authors:
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
+#include "libqtest.h"
+#include "qemu/module.h"
+#include "tpm-tests.h"
+#include "hw/acpi/tpm.h"
+
+uint64_t tpm_tis_base_addr =3D 0xc000000;
+#define MACHINE_OPTIONS "-machine virt,gic-version=3Dmax -accel tcg"
+
+typedef struct TestState {
+    char *src_tpm_path;
+    char *dst_tpm_path;
+    char *uri;
+} TestState;
+
+static void tpm_tis_swtpm_test(const void *data)
+{
+    const TestState *ts =3D data;
+
+    tpm_test_swtpm_test(ts->src_tpm_path, tpm_util_tis_transfer,
+                        "tpm-tis-device", MACHINE_OPTIONS);
+}
+
+static void tpm_tis_swtpm_migration_test(const void *data)
+{
+    const TestState *ts =3D data;
+
+    tpm_test_swtpm_migration_test(ts->src_tpm_path, ts->dst_tpm_path, ts=
->uri,
+                                  tpm_util_tis_transfer, "tpm-tis-device=
",
+                                  MACHINE_OPTIONS);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+    TestState ts =3D { 0 };
+
+    ts.src_tpm_path =3D g_dir_make_tmp("qemu-tpm-tis-device-swtpm-test.X=
XXXXX",
+                                     NULL);
+    ts.dst_tpm_path =3D g_dir_make_tmp("qemu-tpm-tis-device-swtpm-test.X=
XXXXX",
+                                     NULL);
+    ts.uri =3D g_strdup_printf("unix:%s/migsocket", ts.src_tpm_path);
+
+    module_call_init(MODULE_INIT_QOM);
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_data_func("/tpm/tis-swtpm/test", &ts, tpm_tis_swtpm_test);
+    qtest_add_data_func("/tpm/tis-swtpm-migration/test", &ts,
+                        tpm_tis_swtpm_migration_test);
+    ret =3D g_test_run();
+
+    g_rmdir(ts.dst_tpm_path);
+    g_free(ts.dst_tpm_path);
+    g_rmdir(ts.src_tpm_path);
+    g_free(ts.src_tpm_path);
+    g_free(ts.uri);
+
+    return ret;
+}
diff --git a/tests/qtest/tpm-tis-device-test.c b/tests/qtest/tpm-tis-devi=
ce-test.c
new file mode 100644
index 0000000000..63ed36440f
--- /dev/null
+++ b/tests/qtest/tpm-tis-device-test.c
@@ -0,0 +1,87 @@
+/*
+ * QTest testcase for SYSBUS TPM TIS
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
+#include "io/channel-socket.h"
+#include "libqtest-single.h"
+#include "qemu/module.h"
+#include "tpm-emu.h"
+#include "tpm-util.h"
+#include "tpm-tis-util.h"
+
+/*
+ * As the Sysbus tpm-tis-device is instantiated on the ARM virt
+ * platform bus and it is the only sysbus device dynamically
+ * instantiated, it gets plugged at its base address
+ */
+uint64_t tpm_tis_base_addr =3D 0xc000000;
+
+int main(int argc, char **argv)
+{
+    char *tmp_path =3D g_dir_make_tmp("qemu-tpm-tis-device-test.XXXXXX",=
 NULL);
+    GThread *thread;
+    TestState test;
+    char *args;
+    int ret;
+
+    module_call_init(MODULE_INIT_QOM);
+    g_test_init(&argc, &argv, NULL);
+
+    test.addr =3D g_new0(SocketAddress, 1);
+    test.addr->type =3D SOCKET_ADDRESS_TYPE_UNIX;
+    test.addr->u.q_unix.path =3D g_build_filename(tmp_path, "sock", NULL=
);
+    g_mutex_init(&test.data_mutex);
+    g_cond_init(&test.data_cond);
+    test.data_cond_signal =3D false;
+
+    thread =3D g_thread_new(NULL, tpm_emu_ctrl_thread, &test);
+    tpm_emu_test_wait_cond(&test);
+
+    args =3D g_strdup_printf(
+        "-machine virt,gic-version=3Dmax -accel tcg "
+        "-chardev socket,id=3Dchr,path=3D%s "
+        "-tpmdev emulator,id=3Ddev,chardev=3Dchr "
+        "-device tpm-tis-device,tpmdev=3Ddev",
+        test.addr->u.q_unix.path);
+    qtest_start(args);
+
+    qtest_add_data_func("/tpm-tis/test_check_localities", &test,
+                        tpm_tis_test_check_localities);
+
+    qtest_add_data_func("/tpm-tis/test_check_access_reg", &test,
+                        tpm_tis_test_check_access_reg);
+
+    qtest_add_data_func("/tpm-tis/test_check_access_reg_seize", &test,
+                        tpm_tis_test_check_access_reg_seize);
+
+    qtest_add_data_func("/tpm-tis/test_check_access_reg_release", &test,
+                        tpm_tis_test_check_access_reg_release);
+
+    qtest_add_data_func("/tpm-tis/test_check_transmit", &test,
+                        tpm_tis_test_check_transmit);
+
+    ret =3D g_test_run();
+
+    qtest_end();
+
+    g_thread_join(thread);
+    g_unlink(test.addr->u.q_unix.path);
+    qapi_free_SocketAddress(test.addr);
+    g_rmdir(tmp_path);
+    g_free(tmp_path);
+    g_free(args);
+    return ret;
+}
--=20
2.24.1


