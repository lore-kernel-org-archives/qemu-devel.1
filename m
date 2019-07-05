Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FE4C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 21:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1BF920449
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 21:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2H2Sg3VC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BF920449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjVbY-0002hT-0Y
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 17:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43117)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hjVQJ-0001Nx-DZ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 17:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hjVQG-00005B-KK
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 17:07:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hjVQ9-0008J4-40
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 17:07:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x65L3vH1025588;
 Fri, 5 Jul 2019 21:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=sSX5aIb6pbrZni5vNE5EzSGZsrAPvnkvicgxxh+1deg=;
 b=2H2Sg3VC4gyG44Hc9EYoACCOWiSas3tNxNak7pFM/GjtmLcn4NaP+lF7Gi5gUUiRpFcV
 BNgFRxOz3dMuDHW9u9ov6E3HeBKMakwGHIMY+aPXNZY8jZMutGv5QS60V8TfLeWC10wM
 OiG4jCx0h8+wu8Xgz0U4SlUF0rz74fpq+tF8jUk/T1RIa5dkBr80v2PD7Du/FPeJRiSL
 9NsjjvSnY2brUcu+pO0qy7NT71quMm15aofCwtqzyK3tlgqD0QXW5AxLc3zIFhFVFlzt
 CGF/xzHtIs0LjhCv4nSyIYdD+B6PTJiiqcxt09Bqr9ecAW/kmZgoa1Nt9lC/k4vtg5ST bQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2te5tc4j6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Jul 2019 21:07:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x65L2ULs175825;
 Fri, 5 Jul 2019 21:07:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2th5qmx76h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Jul 2019 21:07:01 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x65L70ax030850;
 Fri, 5 Jul 2019 21:07:00 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 05 Jul 2019 14:07:00 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Date: Sat,  6 Jul 2019 00:06:34 +0300
Message-Id: <20190705210636.3095-3-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705210636.3095-1-liran.alon@oracle.com>
References: <20190705210636.3095-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9309
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=827
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907050266
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9309
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=871 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907050266
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [PATCH 2/4] target/i386: kvm: Init nested-state for
 vCPU exposed with SVM
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
Cc: pbonzini@redhat.com, Joao Martins <joao.m.martins@oracle.com>,
 Liran Alon <liran.alon@oracle.com>, ehabkost@redhat.com, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 target/i386/cpu.h | 5 +++++
 target/i386/kvm.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 93345792f4cb..cdb0e43676a9 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1867,6 +1867,11 @@ static inline bool cpu_has_vmx(CPUX86State *env)
     return env->features[FEAT_1_ECX] & CPUID_EXT_VMX;
 }
 
+static inline bool cpu_has_svm(CPUX86State *env)
+{
+    return env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM;
+}
+
 /* fpu_helper.c */
 void update_fp_status(CPUX86State *env);
 void update_mxcsr_status(CPUX86State *env);
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index b57f873ec9e8..4e2c8652168f 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1721,6 +1721,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
             env->nested_state->format = KVM_STATE_NESTED_FORMAT_VMX;
             vmx_hdr->vmxon_pa = -1ull;
             vmx_hdr->vmcs12_pa = -1ull;
+        } else if (cpu_has_svm(env)) {
+            env->nested_state->format = KVM_STATE_NESTED_FORMAT_SVM;
         }
     }
 
-- 
2.20.1


