Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CDAC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 19:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 340172073B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 19:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340172073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icakm-0007QJ-Az
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 14:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1icaZ7-0000el-Pb
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1icaZ6-0008OH-BR
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:44:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60844)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1icaZ6-0008AE-35
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:44:00 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB4JcnSL083091
 for <qemu-devel@nongnu.org>; Wed, 4 Dec 2019 14:43:54 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wpd128trh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 14:43:54 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 4 Dec 2019 19:43:52 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 4 Dec 2019 19:43:50 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xB4Jhnsb8847526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Dec 2019 19:43:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 399DBA4053;
 Wed,  4 Dec 2019 19:43:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF8C2A4051;
 Wed,  4 Dec 2019 19:43:48 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.42.200])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  4 Dec 2019 19:43:48 +0000 (GMT)
Subject: [for-5.0 PATCH 3/4] ppc: Don't use CPUPPCState::irq_input_state
 with modern Book3s CPU models
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 04 Dec 2019 20:43:48 +0100
In-Reply-To: <157548861171.3650476.14824062174573272058.stgit@bahia.lan>
References: <157548861171.3650476.14824062174573272058.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120419-0008-0000-0000-0000033D2DD1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120419-0009-0000-0000-00004A5C4ECE
Message-Id: <157548862861.3650476.16622818876928044450.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1034 bulkscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912040158
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The power7_set_irq() and power9_set_irq() functions set this but it is
never used actually. Modern Book3s compatible CPUs are only supported
by the pnv and spapr machines. They have an interrupt controller, XICS
for POWER7/8 and XIVE for POWER9, whose models don't require to track
IRQ input states at the CPU level.

Drop these lines to avoid confusion.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/ppc.c     |   16 ++--------------
 target/ppc/cpu.h |    4 +++-
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index fab73f1b1fc9..45834f98d176 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -275,10 +275,9 @@ void ppc970_irq_init(PowerPCCPU *cpu)
 static void power7_set_irq(void *opaque, int pin, int level)
 {
     PowerPCCPU *cpu = opaque;
-    CPUPPCState *env = &cpu->env;
 
     LOG_IRQ("%s: env %p pin %d level %d\n", __func__,
-                env, pin, level);
+            &cpu->env, pin, level);
 
     switch (pin) {
     case POWER7_INPUT_INT:
@@ -292,11 +291,6 @@ static void power7_set_irq(void *opaque, int pin, int level)
         LOG_IRQ("%s: unknown IRQ pin %d\n", __func__, pin);
         return;
     }
-    if (level) {
-        env->irq_input_state |= 1 << pin;
-    } else {
-        env->irq_input_state &= ~(1 << pin);
-    }
 }
 
 void ppcPOWER7_irq_init(PowerPCCPU *cpu)
@@ -311,10 +305,9 @@ void ppcPOWER7_irq_init(PowerPCCPU *cpu)
 static void power9_set_irq(void *opaque, int pin, int level)
 {
     PowerPCCPU *cpu = opaque;
-    CPUPPCState *env = &cpu->env;
 
     LOG_IRQ("%s: env %p pin %d level %d\n", __func__,
-                env, pin, level);
+            &cpu->env, pin, level);
 
     switch (pin) {
     case POWER9_INPUT_INT:
@@ -334,11 +327,6 @@ static void power9_set_irq(void *opaque, int pin, int level)
         LOG_IRQ("%s: unknown IRQ pin %d\n", __func__, pin);
         return;
     }
-    if (level) {
-        env->irq_input_state |= 1 << pin;
-    } else {
-        env->irq_input_state &= ~(1 << pin);
-    }
 }
 
 void ppcPOWER9_irq_init(PowerPCCPU *cpu)
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index e3e82327b723..f9528fc29d98 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1090,7 +1090,9 @@ struct CPUPPCState {
 #if !defined(CONFIG_USER_ONLY)
     /*
      * This is the IRQ controller, which is implementation dependent
-     * and only relevant when emulating a complete machine.
+     * and only relevant when emulating a complete machine. Note that
+     * this isn't used by recent Book3s compatible CPUs (POWER7 and
+     * newer).
      */
     uint32_t irq_input_state;
     void **irq_inputs;


