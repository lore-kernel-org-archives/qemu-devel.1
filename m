Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DF5C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 16:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5555A2177B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 16:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yVlGhYH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5555A2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40273 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hddRe-0006I5-Hy
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 12:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58911)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hddLw-0002fs-Vq
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 12:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hddLv-0006pa-Ls
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 12:22:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hddLv-0006lE-EI
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 12:22:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JGDhnv030761;
 Wed, 19 Jun 2019 16:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=7JwQ662wv964waE5io4PviuPTvJ3njoDQMuOoUYwh78=;
 b=yVlGhYH9s4cju6A+RfLtAizkhN3IAtnIvsI1mE9YF2txcACfSChxOvw0ZCBrPCLD+20P
 pBQNeN+Vmd7A/ICbklTWjqwz2Aetm73duDv8Q+Oi2UifJmHr7/edRpla4ZBhZLpuecrn
 iVmCI2nSNQlVx26mgsgHkWxSvpSORbXqzTiEBF4aOT/KMpI21imUa5uQJBr/+rUliwgv
 li5Sq4dYeFGStH4ePHvHJNBwcfrjRtEVMSAvLaV35eZvOnjyVzybkjOvram9FQaeNGd/
 CuhxEiBuMZit/VqIHRZs5/qwTbRKGM3oMPoFT/gqdFLxVcOpuhIFpUfoTzFScWG9o5RX AA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2t7809cem9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 16:22:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JGLbw1132953;
 Wed, 19 Jun 2019 16:22:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2t77yn6pxn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 16:22:18 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5JGMHmV024699;
 Wed, 19 Jun 2019 16:22:17 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 19 Jun 2019 09:22:16 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 19:21:36 +0300
Message-Id: <20190619162140.133674-7-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619162140.133674-1-liran.alon@oracle.com>
References: <20190619162140.133674-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=798
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=847 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190131
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [QEMU PATCH v4 06/10] linux-headers: i386: Modify
 struct kvm_nested_state to have explicit fields for data
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, maran.wilson@oracle.com,
 mtosatti@redhat.com, dgilbert@redhat.com, Liran Alon <liran.alon@oracle.com>,
 pbonzini@redhat.com, rth@twiddle.net, jmattson@google.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Improve the KVM_{GET,SET}_NESTED_STATE structs by detailing the format
of VMX nested state data in a struct.

In order to avoid changing the ioctl values of
KVM_{GET,SET}_NESTED_STATE, there is a need to preserve
sizeof(struct kvm_nested_state). This is done by defining the data
struct as "data.vmx[0]". It was the most elegant way I found to
preserve struct size while still keeping struct readable and easy to
maintain. It does have a misfortunate side-effect that now it has to be
accessed as "data.vmx[0]" rather than just "data.vmx".

Because we are already modifying these structs, I also modified the
following:
* Define the "format" field values as macros.
* Rename vmcs_pa to vmcs12_pa for better readability.

Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 linux-headers/asm-x86/kvm.h | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 7a0e64ccd6ff..6e7dd792e448 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -383,16 +383,26 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	(1 << 2)
 #define KVM_X86_QUIRK_OUT_7E_INC_RIP	(1 << 3)
 
+#define KVM_STATE_NESTED_FORMAT_VMX	0
+#define KVM_STATE_NESTED_FORMAT_SVM	1
+
 #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
 #define KVM_STATE_NESTED_EVMCS		0x00000004
 
+#define KVM_STATE_NESTED_VMX_VMCS_SIZE	0x1000
+
 #define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_SMM_VMXON	0x00000002
 
-struct kvm_vmx_nested_state {
+struct kvm_vmx_nested_state_data {
+	__u8 vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
+	__u8 shadow_vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
+};
+
+struct kvm_vmx_nested_state_hdr {
 	__u64 vmxon_pa;
-	__u64 vmcs_pa;
+	__u64 vmcs12_pa;
 
 	struct {
 		__u16 flags;
@@ -401,24 +411,25 @@ struct kvm_vmx_nested_state {
 
 /* for KVM_CAP_NESTED_STATE */
 struct kvm_nested_state {
-	/* KVM_STATE_* flags */
 	__u16 flags;
-
-	/* 0 for VMX, 1 for SVM.  */
 	__u16 format;
-
-	/* 128 for SVM, 128 + VMCS size for VMX.  */
 	__u32 size;
 
 	union {
-		/* VMXON, VMCS */
-		struct kvm_vmx_nested_state vmx;
+		struct kvm_vmx_nested_state_hdr vmx;
 
 		/* Pad the header to 128 bytes.  */
 		__u8 pad[120];
-	};
+	} hdr;
 
-	__u8 data[0];
+	/*
+	 * Define data region as 0 bytes to preserve backwards-compatability
+	 * to old definition of kvm_nested_state in order to avoid changing
+	 * KVM_{GET,PUT}_NESTED_STATE ioctl values.
+	 */
+	union {
+		struct kvm_vmx_nested_state_data vmx[0];
+	} data;
 };
 
 #endif /* _ASM_X86_KVM_H */
-- 
2.20.1


