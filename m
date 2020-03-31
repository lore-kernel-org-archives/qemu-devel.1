Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349B2C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 00:17:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C19206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 00:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="dAIL7JGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C19206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ4b6-0006f7-VX
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 20:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1jJ4Ze-0005Ry-JL
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1jJ4Zd-0008Um-Ih
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:16:10 -0400
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:57186)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1jJ4Zd-0008Sg-BT
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:16:09 -0400
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
 by nwk-aaemail-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 02V01uWv063745; Mon, 30 Mar 2020 17:16:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : in-reply-to : references : mime-version
 : content-transfer-encoding; s=20180706;
 bh=i0UWfbqTTJaqXS5ypihnho6aF0K/Ven9FgjltMu0xhg=;
 b=dAIL7JGPtfIqr5+g8674UZFoTX5do2CNok275sT6ac/uTFu0RllNlA1fLXlFi+RH0f9T
 MYwJkeQ2bI2uMUX6wZZ4DbFLlFg1DT31J/MdSJJ2JEXf0LCRS1ZzQDKPYSBTR0YK89xY
 uUrOA5zN+oVX55ZAbVDLV5wCTM5/a6Sa6Ojw+QiEK2VvcdFab+fYJHr/I00U+JWI1dHa
 TFHq5ZO5q3MBJdA8EDni1H4Pi09soUKFLCCP+BTIiC+tP/EcNKkDDE7tMBOkdlgtqJHi
 wLdKndmAUV6cn/AWEG/CgRXSFz70mOeBBU5FqcBN4yjkcH7W1BlnLe1G0SHoFw5dZdw9 gg== 
Received: from rn-mailsvcp-mta-lapp03.rno.apple.com
 (rn-mailsvcp-mta-lapp03.rno.apple.com [10.225.203.151])
 by nwk-aaemail-lapp02.apple.com with ESMTP id 30235h8qa2-12
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 30 Mar 2020 17:16:07 -0700
Received: from rn-mailsvcp-mmp-lapp01.rno.apple.com
 (rn-mailsvcp-mmp-lapp01.rno.apple.com [17.179.253.14])
 by rn-mailsvcp-mta-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) with ESMTPS id <0Q8100BQ07EVOJ80@rn-mailsvcp-mta-lapp03.rno.apple.com>; 
 Mon, 30 Mar 2020 17:16:07 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp01.rno.apple.com by
 rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) id <0Q8100B007DUTS00@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Mon,
 30 Mar 2020 17:16:07 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: c56cc4374afe9162bf6a337f3d661529
X-Va-E-CD: c0a3b6d4fb4e4a6ada9709224be578eb
X-Va-R-CD: 5f6f252ea7428529f3fa7d2c07b9b447
X-Va-CD: 0
X-Va-ID: a062693a-a3c6-4e5b-a663-aa46cff46929
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: c0a3b6d4fb4e4a6ada9709224be578eb
X-V-R-CD: 5f6f252ea7428529f3fa7d2c07b9b447
X-V-CD: 0
X-V-ID: bf4f28c4-8ec9-4862-96a2-14581ac3e80a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-30_07:2020-03-30,
 2020-03-30 signatures=0
Received: from pontoon.com (unknown [17.234.84.168])
 by rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020))
 with ESMTPSA id <0Q81010CS7EU8N70@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Mon,
 30 Mar 2020 17:16:07 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, r.bolshakov@yadro.com
Subject: [PATCH v1 2/3] hvf: Make long mode enter and exit code clearer.
Date: Mon, 30 Mar 2020 17:16:05 -0700
Message-id: <17777cc82122d29903bad7268b4c33e83b27d9a6.1585607927.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
In-reply-to: <cover.1585607927.git.dirty@apple.com>
References: <cover.1585607927.git.dirty@apple.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-30_07:2020-03-30,
 2020-03-30 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 17.151.62.67
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Cameron Esfahani <dirty@apple.com>
From: Cameron Esfahani via <qemu-devel@nongnu.org>

Signed-off-by: Cameron Esfahani <dirty@apple.com>
---
 target/i386/hvf/vmx.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 8ec2e6414e..1a1b150c97 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -121,6 +121,7 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
     uint64_t pdpte[4] = {0, 0, 0, 0};
     uint64_t efer = rvmcs(vcpu, VMCS_GUEST_IA32_EFER);
     uint64_t old_cr0 = rvmcs(vcpu, VMCS_GUEST_CR0);
+    uint64_t changed_cr0 = old_cr0 ^ cr0;
     uint64_t mask = CR0_PG_MASK | CR0_CD_MASK | CR0_NW_MASK |
                     CR0_NE_MASK | CR0_ET_MASK;
 
@@ -139,11 +140,12 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
     wvmcs(vcpu, VMCS_CR0_SHADOW, cr0);
 
     if (efer & MSR_EFER_LME) {
-        if (!(old_cr0 & CR0_PG_MASK) && (cr0 & CR0_PG_MASK)) {
-            enter_long_mode(vcpu, cr0, efer);
-        }
-        if (!(cr0 & CR0_PG_MASK)) {
-            exit_long_mode(vcpu, cr0, efer);
+        if (changed_cr0 & CR0_PG_MASK) {
+            if (cr0 & CR0_PG_MASK) {
+                enter_long_mode(vcpu, cr0, efer);
+            } else {
+                exit_long_mode(vcpu, cr0, efer);
+            }
         }
     }
 
-- 
2.24.0


