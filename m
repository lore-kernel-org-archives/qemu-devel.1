Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B201C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 21:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6DF82072D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 21:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OLzGfxoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DF82072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeQDA-0004y7-3A
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 17:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.vnet.ibm.com>)
 id 1jePUq-0006qV-BZ
 for qemu-devel@nongnu.org; Thu, 28 May 2020 16:51:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7937
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.vnet.ibm.com>)
 id 1jePUo-0000xC-GM
 for qemu-devel@nongnu.org; Thu, 28 May 2020 16:51:23 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04SKbvgj019268
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 16:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6cvev0gSoPqxKyyckq7pr/bP+yh/jJMaYEpgscBkYj0=;
 b=OLzGfxoL+wS336bWSYqM2mFbQg+BDaI+uyoxrOeAy+G2NYRNvSKzFVeLHjfpLwNKbd82
 QU1P/GUICuyRcbl+u6RbX9ziIrWeHAtzw9ihx8YEExwRiRzcgF6XsEFTj2+0Li7qTnAH
 cz7NvpDtkg7rWZYNtxRHAC4RgcQIhSaM/LLLPaEhEJctFC1lZd0vcA9B7Ocx7M59zTmf
 33o+dGD1sm82i35kTHBdXoowjcV+mnXm3ld7VDJwz/yeP6WDOWYkGJvZ75ZWM2lOZ8le
 n/zz8bdafYGx9aez/lGcC3fMpAkNfTFbVlTZizATEj/2a/plU4m84knl+6ai8cK2Y+pO QA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 319wt1p13d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 16:51:19 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04SKfGlo029157
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 20:51:18 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma01dal.us.ibm.com with ESMTP id 316ufb19at-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 20:51:18 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04SKpF6410093076
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 May 2020 20:51:15 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 81D9578066;
 Thu, 28 May 2020 20:51:16 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2327078064;
 Thu, 28 May 2020 20:51:16 +0000 (GMT)
Received: from Tobins-MBP-2.fios-router.home (unknown [9.80.221.203])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 28 May 2020 20:51:16 +0000 (GMT)
From: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>
To: jejb@linux.ibm.com, qemu-devel@nongnu.org
Subject: [PATCH 2/2] sev: scan guest ROM for launch secret address
Date: Thu, 28 May 2020 16:51:14 -0400
Message-Id: <20200528205114.42078-3-tobin@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200528205114.42078-1-tobin@linux.vnet.ibm.com>
References: <20200528205114.42078-1-tobin@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-28_07:2020-05-28,
 2020-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005280131
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=tobin@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 16:51:19
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 28 May 2020 17:35:50 -0400
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
Cc: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>, tobin@ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tobin Feldman-Fitzthum <tobin@ibm.com>

In addition to using QMP to provide the guest memory address
that the launch secret blob will be injected into, the
secret address can also be specified in the guest ROM. This
patch adds sev_find_secret_gpa, which scans the ROM page by
page to find a launch secret table identified by a GUID. If
the table is found, the address it contains will be used
in place of any address specified via QMP.

Signed-off-by: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>
---
 target/i386/sev.c      | 34 ++++++++++++++++++++++++++++++++--
 target/i386/sev_i386.h | 16 ++++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 774e47d9d1..4adc56d7e3 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -706,6 +706,8 @@ sev_guest_init(const char *id)
     s->api_major = status.api_major;
     s->api_minor = status.api_minor;
 
+    s->secret_gpa = 0;
+
     trace_kvm_sev_init();
     ret = sev_ioctl(s->sev_fd, KVM_SEV_INIT, NULL, &fw_error);
     if (ret) {
@@ -731,6 +733,28 @@ err:
     return NULL;
 }
 
+static void
+sev_find_secret_gpa(uint8_t *ptr, uint64_t len)
+{
+    uint64_t offset;
+
+    SevROMSecretTable *secret_table;
+    QemuUUID secret_table_guid;
+
+    qemu_uuid_parse(SEV_ROM_SECRET_GUID,&secret_table_guid);
+    secret_table_guid = qemu_uuid_bswap(secret_table_guid);
+
+    offset = len - 0x1000;
+    while(offset > 0) {
+        secret_table = (SevROMSecretTable *)(ptr + offset);
+        if(qemu_uuid_is_equal(&secret_table_guid, (QemuUUID *) secret_table)){
+            sev_state->secret_gpa = (long unsigned int) secret_table->base;
+            break;
+        }
+        offset -= 0x1000;
+    }
+}
+
 int
 sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
 {
@@ -738,6 +762,9 @@ sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
 
     /* if SEV is in update state then encrypt the data else do nothing */
     if (sev_check_state(SEV_STATE_LAUNCH_UPDATE)) {
+        if(!sev_state->secret_gpa) {
+            sev_find_secret_gpa(ptr, len);
+	    }
         return sev_launch_update_data(ptr, len);
     }
 
@@ -776,8 +803,8 @@ int sev_inject_launch_secret(const char *packet_hdr,
 
     /* secret can be inject only in this state */
     if (!sev_check_state(SEV_STATE_LAUNCH_SECRET)) {
-	error_report("Not in correct state. %x",sev_state->state);
-	return 1;
+        error_report("Not in correct state. %x",sev_state->state);
+        return 1;
     }
 
     hdr = g_base64_decode(packet_hdr, &hdr_sz);
@@ -792,6 +819,9 @@ int sev_inject_launch_secret(const char *packet_hdr,
         goto err;
     }
 
+    if(sev_state->secret_gpa)
+        gpa = sev_state->secret_gpa;
+
     hva = gpa2hva(gpa, data_sz);
     if (!hva) {
         goto err;
diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
index 8ada9d385d..b1f9ab93bb 100644
--- a/target/i386/sev_i386.h
+++ b/target/i386/sev_i386.h
@@ -19,6 +19,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sev.h"
 #include "qemu/error-report.h"
+#include "qemu/uuid.h"
 #include "qapi/qapi-types-misc-target.h"
 
 #define SEV_POLICY_NODBG        0x1
@@ -28,6 +29,8 @@
 #define SEV_POLICY_DOMAIN       0x10
 #define SEV_POLICY_SEV          0x20
 
+#define SEV_ROM_SECRET_GUID "adf956ad-e98c-484c-ae11-b51c7d336447"
+
 #define TYPE_QSEV_GUEST_INFO "sev-guest"
 #define QSEV_GUEST_INFO(obj)                  \
     OBJECT_CHECK(QSevGuestInfo, (obj), TYPE_QSEV_GUEST_INFO)
@@ -42,6 +45,18 @@ extern SevCapability *sev_get_capabilities(void);
 
 typedef struct QSevGuestInfo QSevGuestInfo;
 typedef struct QSevGuestInfoClass QSevGuestInfoClass;
+typedef struct SevROMSecretTable SevROMSecretTable;
+
+/**
+ * If guest physical address for the launch secret is
+ * provided in the ROM, it should be in the following
+ * page-aligned structure.
+ */
+struct SevROMSecretTable {
+    QemuUUID guid;
+    unsigned int base;
+    unsigned int size;
+};
 
 /**
  * QSevGuestInfo:
@@ -78,6 +93,7 @@ struct SEVState {
     uint32_t cbitpos;
     uint32_t reduced_phys_bits;
     uint32_t handle;
+    uint64_t secret_gpa;
     int sev_fd;
     SevState state;
     gchar *measurement;
-- 
2.20.1 (Apple Git-117)


