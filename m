Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9E3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 21:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA47206DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 21:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gk4Y12jC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA47206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeQD9-0004xh-NE
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 17:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.vnet.ibm.com>)
 id 1jePUr-0006qc-30
 for qemu-devel@nongnu.org; Thu, 28 May 2020 16:51:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.vnet.ibm.com>)
 id 1jePUo-0000wt-FN
 for qemu-devel@nongnu.org; Thu, 28 May 2020 16:51:24 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04SKXClV089588
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 16:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6JDhkhk7Nrg1V6VKV4C84N1F+eWiRSwP7iOexVD6fyE=;
 b=gk4Y12jCsASNUwKs/uhxRoV9NIItkfsgXlzWYGzVWi/JT096HZLA7wJzMmJ1ygpedV8/
 FB9NbhRuxQqM3lzGdByswV6jbgC/KAVrI7gq13u3IRJxNRngTe7WUctSZ0c1deE02Nm6
 PN2IYE4X8DduMXuDHJzJufiTeXl7IRF8fFzNvGu68RjJ2DttyTvk+6kpoZc5GxXG36du
 CXtI988U8b29SCCTGoF0DiVw3kjEGNGWxR3OOTW6Gn7DA0m3suur7LwLG9S7j1Apvb/w
 CueUtEZchOoVlQ+Obd+sHUjn9lGbfhuB+IyAzkPgOpNax5q5wJNnHY3AqNNFUA3D8zrw JQ== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 319sqg7qam-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 16:51:19 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04SKdjfP011953
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 20:51:18 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma03dal.us.ibm.com with ESMTP id 316ufb953r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 20:51:18 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04SKpE9u10813796
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 May 2020 20:51:15 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09B0078063;
 Thu, 28 May 2020 20:51:16 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A33D37805E;
 Thu, 28 May 2020 20:51:15 +0000 (GMT)
Received: from Tobins-MBP-2.fios-router.home (unknown [9.80.221.203])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 28 May 2020 20:51:15 +0000 (GMT)
From: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>
To: jejb@linux.ibm.com, qemu-devel@nongnu.org
Subject: [PATCH 1/2] sev: add sev-inject-launch-secret
Date: Thu, 28 May 2020 16:51:13 -0400
Message-Id: <20200528205114.42078-2-tobin@linux.vnet.ibm.com>
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
 mlxlogscore=999
 suspectscore=2 bulkscore=0 phishscore=0 cotscore=-2147483648
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1011
 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280132
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=tobin@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 16:51:19
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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

AMD SEV allows a guest owner to inject a secret blob
into the memory of a virtual machine. The secret is
encrypted with the SEV Transport Encryption Key and
integrity is guaranteed with the Transport Integrity
Key. Although QEMU faciliates the injection of the
launch secret, it cannot access the secret.

Signed-off-by: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>
---
 include/sysemu/sev.h       |  2 +
 qapi/misc-target.json      | 20 +++++++++
 target/i386/monitor.c      |  8 ++++
 target/i386/sev-stub.c     |  5 +++
 target/i386/sev.c          | 83 ++++++++++++++++++++++++++++++++++++++
 target/i386/trace-events   |  1 +
 tests/qtest/qmp-cmd-test.c |  6 +--
 7 files changed, 122 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index 98c1ec8d38..313ee30fc8 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -18,4 +18,6 @@
 
 void *sev_guest_init(const char *id);
 int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
+int sev_inject_launch_secret(const char *hdr, const char *secret,
+		             uint64_t gpa);
 #endif
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index dee3b45930..27458b765b 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -200,6 +200,26 @@
 { 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
   'if': 'defined(TARGET_I386)' }
 
+##
+# @sev-inject-launch-secret:
+#
+# This command injects a secret blob into memory of SEV guest.
+#
+# @packet-header: the launch secret packet header encoded in base64
+#
+# @secret: the launch secret data to be injected encoded in base64
+#
+# @gpa: the guest physical address where secret will be injected.
+        GPA provided here will be ignored if guest ROM specifies 
+        the a launch secret GPA.
+#
+# Since: 5.0.0
+#
+##
+{ 'command': 'sev-inject-launch-secret',
+  'data': { 'packet_hdr': 'str', 'secret': 'str', 'gpa': 'uint64' },
+  'if': 'defined(TARGET_I386)' }
+
 ##
 # @dump-skeys:
 #
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 27ebfa3ad2..5c2b7d2c17 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -736,3 +736,11 @@ SevCapability *qmp_query_sev_capabilities(Error **errp)
 
     return data;
 }
+
+void qmp_sev_inject_launch_secret(const char *packet_hdr,
+                                  const char *secret, uint64_t gpa,
+                                  Error **errp)
+{
+    if (sev_inject_launch_secret(packet_hdr,secret,gpa) != 0)
+      error_setg(errp, "SEV inject secret failed");
+}
diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
index e5ee13309c..2b8c5f1f53 100644
--- a/target/i386/sev-stub.c
+++ b/target/i386/sev-stub.c
@@ -48,3 +48,8 @@ SevCapability *sev_get_capabilities(void)
 {
     return NULL;
 }
+int sev_inject_launch_secret(const char *hdr, const char *secret,
+		                             uint64_t gpa)
+{
+	    return 1;
+}
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 846018a12d..774e47d9d1 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -28,6 +28,7 @@
 #include "sysemu/runstate.h"
 #include "trace.h"
 #include "migration/blocker.h"
+#include "exec/address-spaces.h"
 
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
@@ -743,6 +744,88 @@ sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
     return 0;
 }
 
+
+static void *
+gpa2hva(hwaddr addr, uint64_t size)
+{
+    MemoryRegionSection mrs = memory_region_find(get_system_memory(),
+                                                 addr, size);
+
+    if (!mrs.mr) {
+        error_report("No memory is mapped at address 0x%" HWADDR_PRIx, addr);
+        return NULL;
+    }
+
+    if (!memory_region_is_ram(mrs.mr) && !memory_region_is_romd(mrs.mr)) {
+        error_report("Memory at address 0x%" HWADDR_PRIx "is not RAM", addr);
+        memory_region_unref(mrs.mr);
+        return NULL;
+    }
+
+    return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region);
+}
+
+int sev_inject_launch_secret(const char *packet_hdr,
+                             const char *secret, uint64_t gpa)
+{
+    struct kvm_sev_launch_secret *input = NULL;
+    guchar *data = NULL, *hdr = NULL;
+    int error, ret = 1;
+    void *hva;
+    gsize hdr_sz = 0, data_sz = 0;
+
+    /* secret can be inject only in this state */
+    if (!sev_check_state(SEV_STATE_LAUNCH_SECRET)) {
+	error_report("Not in correct state. %x",sev_state->state);
+	return 1;
+    }
+
+    hdr = g_base64_decode(packet_hdr, &hdr_sz);
+    if (!hdr || !hdr_sz) {
+        error_report("SEV: Failed to decode sequence header");
+        return 1;
+    }
+
+    data = g_base64_decode(secret, &data_sz);
+    if (!data || !data_sz) {
+        error_report("SEV: Failed to decode data");
+        goto err;
+    }
+
+    hva = gpa2hva(gpa, data_sz);
+    if (!hva) {
+        goto err;
+    }
+    input = g_new0(struct kvm_sev_launch_secret, 1);
+
+    input->hdr_uaddr = (unsigned long)hdr;
+    input->hdr_len = hdr_sz;
+
+    input->trans_uaddr = (unsigned long)data;
+    input->trans_len = data_sz;
+
+    input->guest_uaddr = (unsigned long)hva;
+    input->guest_len = data_sz;
+
+    trace_kvm_sev_launch_secret(gpa, input->guest_uaddr,
+                                input->trans_uaddr, input->trans_len);
+
+    ret = sev_ioctl(sev_state->sev_fd,KVM_SEV_LAUNCH_SECRET, input, &error);
+    if (ret) {
+        error_report("SEV: failed to inject secret ret=%d fw_error=%d '%s'",
+                     ret, error, fw_error_to_str(error));
+        goto err;
+    }
+
+    ret = 0;
+
+err:
+    g_free(data);
+    g_free(hdr);
+    g_free(input);
+    return ret;
+}
+
 static void
 sev_register_types(void)
 {
diff --git a/target/i386/trace-events b/target/i386/trace-events
index 789c700d4a..9f299e94a2 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -15,3 +15,4 @@ kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session
 kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRIu64
 kvm_sev_launch_measurement(const char *value) "data %s"
 kvm_sev_launch_finish(void) ""
+kvm_sev_launch_secret(uint64_t hpa, uint64_t hva, uint64_t secret, int len) "hpa 0x%" PRIx64 " hva 0x%" PRIx64 " data 0x%" PRIx64 " len %d"
diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index 9f5228cd99..50b2b42830 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -93,10 +93,10 @@ static bool query_is_blacklisted(const char *cmd)
         /* Success depends on target-specific build configuration: */
         "query-pci",              /* CONFIG_PCI */
         /* Success depends on launching SEV guest */
-        "query-sev-launch-measure",
+        // "query-sev-launch-measure",
         /* Success depends on Host or Hypervisor SEV support */
-        "query-sev",
-        "query-sev-capabilities",
+        // "query-sev",
+        // "query-sev-capabilities",
         NULL
     };
     int i;
-- 
2.20.1 (Apple Git-117)


