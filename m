Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9E9C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 01:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884AF20714
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 01:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sxUxM6FO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884AF20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0EAK-0000bf-NL
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 21:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <krish.sadhukhan@oracle.com>)
 id 1k0DDB-0003lP-NO
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 20:11:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <krish.sadhukhan@oracle.com>)
 id 1k0DD2-0003TR-Kt
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 20:11:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06S07Cla020949;
 Tue, 28 Jul 2020 00:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=Tgt0IXNU0U1SE8rNFf9vnXgmFBtrz6jbIxlr/BMqz+Y=;
 b=sxUxM6FO9FJd8IKEoKggLrRGMeLUE4WqPpR8EwzfSYsNm3w+FMG5FiKlxQ3sLgprEDtD
 2bgPQa2R2JBVviRThWBCFbfBXjsf90YmmZlj8yXLv8CUKSf3ULMkAG7Y4hfuiLKD4knb
 LOyrSAE0xMmCKxmVxIPcqKN3dD0iv/a2z7aLCvWPPWsNSShd/Ov6Tco5r6b+nDF5EUmj
 2aJvO1osto4yhMVnsUpHjdASYaaskWwPRn4RMC9SZQzru4YPwMKGV2JvQ2/Kg/ZjFi5Z
 x2hj03mOdNubtg2vr4dmKzaTaR7GfZfL1w93uLjfagOsegdQjD+Yoyrp8pBWpn/TL8+a nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 32hu1j4g3s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 Jul 2020 00:11:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06S08frR136391;
 Tue, 28 Jul 2020 00:11:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 32hu5tc69m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2020 00:11:02 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06S0B2TD031045;
 Tue, 28 Jul 2020 00:11:02 GMT
Received: from nsvm-sadhukhan.osdevelopmeniad.oraclevcn.com (/100.100.231.196)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 27 Jul 2020 17:11:02 -0700
From: Krish Sadhukhan <krish.sadhukhan@oracle.com>
To: kvm@vger.kernel.org
Subject: [PATCH 6/6 v3] QEMU: x86: Change KVM_MEMORY_ENCRYPT_* #defines to
 make them conformant to the kernel
Date: Tue, 28 Jul 2020 00:10:50 +0000
Message-Id: <1595895050-105504-7-git-send-email-krish.sadhukhan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595895050-105504-1-git-send-email-krish.sadhukhan@oracle.com>
References: <1595895050-105504-1-git-send-email-krish.sadhukhan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=1 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270165
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=krish.sadhukhan@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 20:11:06
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 27 Jul 2020 21:08:19 -0400
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
Cc: pbonzini@redhat.com, vkuznets@redhat.com, qemu-devel@nongnu.org,
 sean.j.christopherson@intel.com, jmattson@google.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
---
 target/i386/sev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index c3ecf86..0913782 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -113,7 +113,7 @@ sev_ioctl(int fd, int cmd, void *data, int *error)
     input.sev_fd = fd;
     input.data = (__u64)(unsigned long)data;
 
-    r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, &input);
+    r = kvm_vm_ioctl(kvm_state, KVM_MEM_ENC_OP, &input);
 
     if (error) {
         *error = input.error;
@@ -187,7 +187,7 @@ sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size)
     range.size = size;
 
     trace_kvm_memcrypt_register_region(host, size);
-    r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_REG_REGION, &range);
+    r = kvm_vm_ioctl(kvm_state, KVM_MEM_ENC_REGISTER_REGION, &range);
     if (r) {
         error_report("%s: failed to register region (%p+%#zx) error '%s'",
                      __func__, host, size, strerror(errno));
@@ -216,7 +216,7 @@ sev_ram_block_removed(RAMBlockNotifier *n, void *host, size_t size)
     range.size = size;
 
     trace_kvm_memcrypt_unregister_region(host, size);
-    r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_UNREG_REGION, &range);
+    r = kvm_vm_ioctl(kvm_state, KVM_MEM_ENC_UNREGISTER_REGION, &range);
     if (r) {
         error_report("%s: failed to unregister region (%p+%#zx)",
                      __func__, host, size);
@@ -454,7 +454,7 @@ sev_get_capabilities(Error **errp)
         error_setg(errp, "KVM not enabled");
         return NULL;
     }
-    if (kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, NULL) < 0) {
+    if (kvm_vm_ioctl(kvm_state, KVM_MEM_ENC_OP, NULL) < 0) {
         error_setg(errp, "SEV is not enabled in KVM");
         return NULL;
     }
-- 
1.8.3.1


