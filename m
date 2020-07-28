Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A501C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 01:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58F3720714
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 01:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aJhYidgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F3720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0E7W-0004sm-LJ
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 21:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <krish.sadhukhan@oracle.com>)
 id 1k0DD3-0003jT-6A
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 20:11:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <krish.sadhukhan@oracle.com>)
 id 1k0DD0-0003Sf-MW
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 20:11:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06S098BN046564;
 Tue, 28 Jul 2020 00:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=V7WMCBrSZ6HfjHK+KspJqk0BoQ25m/xsnx1QvbrhVlY=;
 b=aJhYidgmty1PWqM0Mc/1fqeqAZJk8i7MMC4CY+DxJbmB7nyFYNeGWidBy3W4p/T9+Q2w
 wngxgyhUNbJVbW+8eiqKKkNpIaaTbe1kVDi45rZqmFko1zpq7GOTaeWE+6fDCrGOOYKi
 wMS9xlyO8ghMHs+bSjVrmLmMICXgIm9lN8sDvqfB7qkzYNrZWrPhYBkTXJsLufQ2q8R1
 ED2LpohLVS86r7ThWM5QLDSq9pI0MfB8yuxkcCAF2dydBQ0TLTo/DTNqaLOfww768xyk
 3xZu6pTBb2MNprdnr2H+7EuuHBEBvs8whr/BEnz1TcP/s6RtFyHU86WQK0ncc+8gzq8/ Zw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 32hu1j4g70-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 Jul 2020 00:11:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06S08XC6157192;
 Tue, 28 Jul 2020 00:11:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 32hu5rvkm8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2020 00:11:00 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06S0AxmL030981;
 Tue, 28 Jul 2020 00:10:59 GMT
Received: from nsvm-sadhukhan.osdevelopmeniad.oraclevcn.com (/100.100.231.196)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 27 Jul 2020 17:10:59 -0700
From: Krish Sadhukhan <krish.sadhukhan@oracle.com>
To: kvm@vger.kernel.org
Subject: [PATCH 0/6 v3] KVM: x86: Fill in conforming {vmx|svm}_x86_ops and
 {vmx|svm}_nested_ops via macros
Date: Tue, 28 Jul 2020 00:10:44 +0000
Message-Id: <1595895050-105504-1-git-send-email-krish.sadhukhan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=1 spamscore=0 mlxlogscore=618 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=634
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=1 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270165
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=krish.sadhukhan@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 20:11:04
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 27 Jul 2020 21:08:13 -0400
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

v2 -> v3:
	1. kvm_arch_hardware_unsetup() is changed to
	   kvm_arch_hardware_teardown() on non-x86 arches as well.

	2. The following #defines

		KVM_MEMORY_ENCRYPT_OP
		KVM_MEMORY_ENCRYPT_REG_REGION
	   	KVM_MEMORY_ENCRYPT_UNREG_REGION

	   have been changed to:

		KVM_MEM_ENC_OP
		KVM_MEM_ENC_REGISTER_REGION
		KVM_MEM_ENC_UNREGISTER_REGION

	3. Patch# 6 is new. It changes the KVM_MEMORY_ENCRYPT_* #defines in
	   QEMU to make them conformant to those in the kernel.


[PATCH 1/6 v3] KVM: x86: Change names of some of the kvm_x86_ops
[PATCH 2/6 v3] KVM: SVM: Fill in conforming svm_x86_ops via macro
[PATCH 3/6 v3] KVM: nSVM: Fill in conforming svm_nested_ops via macro
[PATCH 4/6 v3] KVM: VMX: Fill in conforming vmx_x86_ops via macro
[PATCH 5/6 v3] KVM: nVMX: Fill in conforming vmx_nested_ops via macro
[PATCH 6/6 v3] QEMU: x86: Change KVM_MEMORY_ENCRYPT_*  #defines to make them

 arch/arm64/include/asm/kvm_host.h   |   2 +-
 arch/mips/include/asm/kvm_host.h    |   2 +-
 arch/powerpc/include/asm/kvm_host.h |   2 +-
 arch/s390/kvm/kvm-s390.c            |   2 +-
 arch/x86/include/asm/kvm_host.h     |  12 +-
 arch/x86/kvm/svm/avic.c             |   4 +-
 arch/x86/kvm/svm/nested.c           |  18 +--
 arch/x86/kvm/svm/sev.c              |   6 +-
 arch/x86/kvm/svm/svm.c              | 218 +++++++++++++++++----------------
 arch/x86/kvm/svm/svm.h              |   8 +-
 arch/x86/kvm/vmx/nested.c           |  26 ++--
 arch/x86/kvm/vmx/nested.h           |   2 +-
 arch/x86/kvm/vmx/vmx.c              | 238 ++++++++++++++++++------------------
 arch/x86/kvm/vmx/vmx.h              |   2 +-
 arch/x86/kvm/x86.c                  |  28 ++---
 include/linux/kvm_host.h            |   2 +-
 include/uapi/linux/kvm.h            |   6 +-
 tools/include/uapi/linux/kvm.h      |   6 +-
 virt/kvm/kvm_main.c                 |   4 +-
 19 files changed, 298 insertions(+), 290 deletions(-)

Krish Sadhukhan (5):
      KVM: x86: Change names of some of the kvm_x86_ops functions to make them m
      KVM: SVM: Fill in conforming svm_x86_ops via macro
      KVM: nSVM: Fill in conforming svm_nested_ops via macro
      KVM: VMX: Fill in conforming vmx_x86_ops via macro
      KVM: nVMX: Fill in conforming vmx_nested_ops via macro

 target/i386/sev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Krish Sadhukhan (1):
      QEMU: x86: Change KVM_MEMORY_ENCRYPT_*  #defines to make them conformant t

