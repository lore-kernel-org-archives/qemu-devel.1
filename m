Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D583C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 19:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CD8C2073C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 19:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD8C2073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icae3-0002dy-RI
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 14:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1icaZ7-0000eP-DJ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1icaZ5-0008MT-Ro
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:44:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1icaZ3-0007oC-S8
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:43:59 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB4JceBW053319
 for <qemu-devel@nongnu.org>; Wed, 4 Dec 2019 14:43:44 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wpdmk7v74-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 14:43:43 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 4 Dec 2019 19:43:41 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 4 Dec 2019 19:43:39 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xB4Jhc6i40829158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Dec 2019 19:43:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF8C052059;
 Wed,  4 Dec 2019 19:43:37 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.42.200])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B296852054;
 Wed,  4 Dec 2019 19:43:37 +0000 (GMT)
Subject: [for-5.0 PATCH 1/4] ppc: Deassert the external interrupt pin in KVM
 on reset
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 04 Dec 2019 20:43:37 +0100
In-Reply-To: <157548861171.3650476.14824062174573272058.stgit@bahia.lan>
References: <157548861171.3650476.14824062174573272058.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120419-4275-0000-0000-0000038B4FD4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120419-4276-0000-0000-0000389EF301
Message-Id: <157548861740.3650476.16879693165328764758.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 clxscore=1034 bulkscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=909
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912040158
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

When a CPU is reset, QEMU makes sure no interrupt is pending by clearing
CPUPPCstate::pending_interrupts in ppc_cpu_reset(). In the case of a
complete machine emulation, eg. a sPAPR machine, an external interrupt
request could still be pending in KVM though, eg. an IPI. It will be
eventually presented to the guest, which is supposed to acknowledge it at
the interrupt controller. If the interrupt controller is emulated in QEMU,
either XICS or XIVE, ppc_set_irq() won't deassert the external interrupt
pin in KVM since it isn't pending anymore for QEMU. When the vCPU re-enters
the guest, the interrupt request is still pending and the vCPU will try
again to acknowledge it. This causes an infinite loop and eventually hangs
the guest.

The code has been broken since the beginning. The issue wasn't hit before
because accel=kvm,kernel-irqchip=off is an awkward setup that never got
used until recently with the LC92x IBM systems (aka, Boston).

Add a ppc_irq_reset() function to do the necessary cleanup, ie. deassert
the IRQ pins of the CPU in QEMU and most importantly the external interrupt
pin for this vCPU in KVM.

Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/ppc.c                    |    8 ++++++++
 include/hw/ppc/ppc.h            |    2 ++
 target/ppc/translate_init.inc.c |    1 +
 3 files changed, 11 insertions(+)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 8dd982fc1e40..fab73f1b1fc9 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1515,3 +1515,11 @@ PowerPCCPU *ppc_get_vcpu_by_pir(int pir)
 
     return NULL;
 }
+
+void ppc_irq_reset(PowerPCCPU *cpu)
+{
+    CPUPPCState *env = &cpu->env;
+
+    env->irq_input_state = 0;
+    kvmppc_set_interrupt(cpu, PPC_INTERRUPT_EXT, 0);
+}
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 585be6ab98c5..89e1dd065af7 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -77,6 +77,7 @@ static inline void ppc970_irq_init(PowerPCCPU *cpu) {}
 static inline void ppcPOWER7_irq_init(PowerPCCPU *cpu) {}
 static inline void ppcPOWER9_irq_init(PowerPCCPU *cpu) {}
 static inline void ppce500_irq_init(PowerPCCPU *cpu) {}
+static inline void ppc_irq_reset(PowerPCCPU *cpu) {}
 #else
 void ppc40x_irq_init(PowerPCCPU *cpu);
 void ppce500_irq_init(PowerPCCPU *cpu);
@@ -84,6 +85,7 @@ void ppc6xx_irq_init(PowerPCCPU *cpu);
 void ppc970_irq_init(PowerPCCPU *cpu);
 void ppcPOWER7_irq_init(PowerPCCPU *cpu);
 void ppcPOWER9_irq_init(PowerPCCPU *cpu);
+void ppc_irq_reset(PowerPCCPU *cpu);
 #endif
 
 /* PPC machines for OpenBIOS */
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index ba726dec4d00..64a838095c7a 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10461,6 +10461,7 @@ static void ppc_cpu_reset(CPUState *s)
     env->pending_interrupts = 0;
     s->exception_index = POWERPC_EXCP_NONE;
     env->error_code = 0;
+    ppc_irq_reset(cpu);
 
     /* tininess for underflow is detected before rounding */
     set_float_detect_tininess(float_tininess_before_rounding,


