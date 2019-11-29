Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FDFC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC5B215F1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC5B215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iadQA-0001xe-Kc
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iactQ-0002uu-3B
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:48:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iactM-0004Fm-Nx
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:48:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22232)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iactM-00043w-FI
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:48:48 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAT9mQqD118027
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 04:48:45 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wjah7ft0n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 04:48:43 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 29 Nov 2019 09:48:39 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 29 Nov 2019 09:48:36 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAT9mZ3A50266122
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Nov 2019 09:48:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FFB8A4040;
 Fri, 29 Nov 2019 09:48:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C774A404D;
 Fri, 29 Nov 2019 09:48:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.188.128])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 29 Nov 2019 09:48:33 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/13] s390x: protvirt: SCLP interpretation
Date: Fri, 29 Nov 2019 04:48:03 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191129094809.26684-1-frankja@linux.ibm.com>
References: <20191129094809.26684-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112909-0028-0000-0000-000003C18C21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112909-0029-0000-0000-000024849A1A
Message-Id: <20191129094809.26684-8-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_02:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 mlxscore=0 suspectscore=1 impostorscore=0 clxscore=1015 bulkscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=709 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911290086
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SCLP for a protected guest is done over the SIDAD, so we need to use
the s390_cpu_virt_mem_* functions to access the SIDAD instead of guest
memory when reading/writing SCBs.

To not confuse the sclp emulation, we set 0x4000 as the SCCB address,
since the function that injects the sclp external interrupt would
reject a zero sccb address.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 hw/s390x/sclp.c         | 17 +++++++++++++++++
 include/hw/s390x/sclp.h |  2 ++
 target/s390x/kvm.c      |  5 +++++
 3 files changed, 24 insertions(+)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index f57ce7b739..ca71ace664 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -193,6 +193,23 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
     }
 }
 
+#define SCLP_PV_DUMMY_ADDR 0x4000
+int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
+                                uint32_t code)
+{
+    SCLPDevice *sclp = get_sclp_device();
+    SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
+    SCCB work_sccb;
+    hwaddr sccb_len = sizeof(SCCB);
+
+    s390_cpu_virt_mem_read(env_archcpu(env), 0, 0, &work_sccb, sccb_len);
+    sclp_c->execute(sclp, &work_sccb, code);
+    s390_cpu_virt_mem_write(env_archcpu(env), 0, 0, &work_sccb,
+                            be16_to_cpu(work_sccb.h.length));
+    sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
+    return 0;
+}
+
 int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
 {
     SCLPDevice *sclp = get_sclp_device();
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index c54413b78c..c0a3faa37d 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -217,5 +217,7 @@ void s390_sclp_init(void);
 void sclp_service_interrupt(uint32_t sccb);
 void raise_irq_cpu_hotplug(void);
 int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
+int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
+                                uint32_t code);
 
 #endif
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 3d9c44ba9d..b802d02ff5 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1174,6 +1174,11 @@ static void kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
     sccb = env->regs[ipbh0 & 0xf];
     code = env->regs[(ipbh0 & 0xf0) >> 4];
 
+    if (run->s390_sieic.icptcode == ICPT_PV_INSTR) {
+        sclp_service_call_protected(env, sccb, code);
+        return;
+    }
+
     r = sclp_service_call(env, sccb, code);
     if (r < 0) {
         kvm_s390_program_interrupt(cpu, -r);
-- 
2.20.1


