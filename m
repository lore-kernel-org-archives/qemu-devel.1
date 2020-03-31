Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3286FC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 07:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F062072A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 07:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F062072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJB7n-0005U1-50
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 03:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jJB76-0004rb-VP
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jJB75-00031g-PP
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:15:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jJB75-000312-IK
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:15:07 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02V73eOO022428
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 03:15:06 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3023382rcs-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 03:15:06 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 31 Mar 2020 08:14:57 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 31 Mar 2020 08:14:55 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02V7F0vP55705774
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Mar 2020 07:15:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D94652059;
 Tue, 31 Mar 2020 07:15:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.158.226])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 189A15204E;
 Tue, 31 Mar 2020 07:14:58 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [kvm-unit-tests PATCH v3] s390x: Add stsi 3.2.2 tests
Date: Tue, 31 Mar 2020 03:14:56 -0400
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2ebc49ff-479a-351d-36f9-cb79fe4b9804@redhat.com>
References: <2ebc49ff-479a-351d-36f9-cb79fe4b9804@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20033107-0012-0000-0000-0000039B7160
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20033107-0013-0000-0000-000021D87C54
Message-Id: <20200331071456.3302-1-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-31_02:2020-03-30,
 2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=1
 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310062
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Subcode 3.2.2 is handled by KVM/QEMU and should therefore be tested
a bit more thorough.

In this test we set a custom name and uuid through the QEMU command
line. Both parameters will be passed to the guest on a stsi subcode
3.2.2 call and will then be checked.

We also compare the configured cpu numbers against the smp reported
numbers and if the reserved + configured add up to the total number
reported.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---

* Tabify on struct
* Moved prefix_push up a bit
* Replaced returns with goto out to pop prefix

---
 s390x/stsi.c        | 73 +++++++++++++++++++++++++++++++++++++++++++++
 s390x/unittests.cfg |  1 +
 2 files changed, 74 insertions(+)

diff --git a/s390x/stsi.c b/s390x/stsi.c
index e9206bca137d2edb..17ad33eefb9c948a 100644
--- a/s390x/stsi.c
+++ b/s390x/stsi.c
@@ -14,7 +14,28 @@
 #include <asm/page.h>
 #include <asm/asm-offsets.h>
 #include <asm/interrupt.h>
+#include <smp.h>
 
+struct stsi_322 {
+    uint8_t reserved[31];
+    uint8_t count;
+    struct {
+	uint8_t reserved2[4];
+	uint16_t total_cpus;
+	uint16_t conf_cpus;
+	uint16_t standby_cpus;
+	uint16_t reserved_cpus;
+	uint8_t name[8];
+	uint32_t caf;
+	uint8_t cpi[16];
+	uint8_t reserved5[3];
+	uint8_t ext_name_encoding;
+	uint32_t reserved3;
+	uint8_t uuid[16];
+    } vm[8];
+    uint8_t reserved4[1504];
+    uint8_t ext_names[8][256];
+};
 static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZE * 2)));
 
 static void test_specs(void)
@@ -76,11 +97,63 @@ static void test_fc(void)
 	report(stsi_get_fc(pagebuf) >= 2, "query fc >= 2");
 }
 
+static void test_3_2_2(void)
+{
+	int rc;
+	/* EBCDIC for "kvm-unit" */
+	const uint8_t vm_name[] = { 0x92, 0xa5, 0x94, 0x60, 0xa4, 0x95, 0x89,
+				    0xa3 };
+	const uint8_t uuid[] = { 0x0f, 0xb8, 0x4a, 0x86, 0x72, 0x7c,
+				 0x11, 0xea, 0xbc, 0x55, 0x02, 0x42, 0xac, 0x13,
+				 0x00, 0x03 };
+	/* EBCDIC for "KVM/" */
+	const uint8_t cpi_kvm[] = { 0xd2, 0xe5, 0xd4, 0x61 };
+	const char *vm_name_ext = "kvm-unit-test";
+	struct stsi_322 *data = (void *)pagebuf;
+
+	report_prefix_push("3.2.2");
+
+	/* Is the function code available at all? */
+	if (stsi_get_fc(pagebuf) < 3) {
+		report_skip("Running under lpar, no level 3 to test.");
+		goto out;
+	}
+
+	rc = stsi(pagebuf, 3, 2, 2);
+	report(!rc, "call");
+
+	/* For now we concentrate on KVM/QEMU */
+	if (memcmp(&data->vm[0].cpi, cpi_kvm, sizeof(cpi_kvm))) {
+		report_skip("Not running under KVM/QEMU.");
+		goto out;
+	}
+
+	report(!memcmp(data->vm[0].uuid, uuid, sizeof(uuid)), "uuid");
+	report(data->vm[0].conf_cpus == smp_query_num_cpus(), "cpu # configured");
+	report(data->vm[0].total_cpus ==
+	       data->vm[0].reserved_cpus + data->vm[0].conf_cpus,
+	       "cpu # total == conf + reserved");
+	report(data->vm[0].standby_cpus == 0, "cpu # standby");
+	report(!memcmp(data->vm[0].name, vm_name, sizeof(data->vm[0].name)),
+	       "VM name == kvm-unit-test");
+
+	if (data->vm[0].ext_name_encoding != 2) {
+		report_skip("Extended VM names are not UTF-8.");
+		goto out;
+	}
+	report(!memcmp(data->ext_names[0], vm_name_ext, sizeof(vm_name_ext)),
+		       "ext VM name == kvm-unit-test");
+
+out:
+	report_prefix_pop();
+}
+
 int main(void)
 {
 	report_prefix_push("stsi");
 	test_priv();
 	test_specs();
 	test_fc();
+	test_3_2_2();
 	return report_summary();
 }
diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
index 12d46c5b402328bb..06e556836c102a14 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -71,6 +71,7 @@ extra_params=-device diag288,id=watchdog0 --watchdog-action inject-nmi
 
 [stsi]
 file = stsi.elf
+extra_params=-name kvm-unit-test --uuid 0fb84a86-727c-11ea-bc55-0242ac130003 -smp 1,maxcpus=8
 
 [smp]
 file = smp.elf
-- 
2.25.1


