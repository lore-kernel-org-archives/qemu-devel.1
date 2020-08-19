Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A5FC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D811320882
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ono0FpzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D811320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8REV-0002cf-16
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 12:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1k8RCC-00084w-Ss; Wed, 19 Aug 2020 12:44:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46722
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1k8RCB-0002p5-77; Wed, 19 Aug 2020 12:44:16 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07JGUiOM169507; Wed, 19 Aug 2020 12:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ImfHbufiWEShYlyk8bCuzDxu0HKLaoGnoAzDATG6sGM=;
 b=Ono0FpzE7n23yJa5WSDe/RaH3SU/cfxhIVdSi+4LwCjKInGtb9F6DmUEG5fpffd03vc3
 7ZE60FMgtF5O59mciYR+HPTIj4SLGPgPa0Bor6HPIZ3VxumP4OabnuFcoNCXfkqIyejv
 khytJtnZS6w1T7V3Zx8Sl6K7WFYYYXqqNp8sybRUnnNB/HB0cA+PThNv5xdQ6giM5+zF
 ugX0SZcikMauIdx7XukoGaEwXaDpz5SY5GQ1LBD7s8mwdvgXFPH/DzQr/lRhT92ghXKq
 cm0s9bO3/gTxWNGzw+4VNtIiV55I3uVRbP1Y3eTo9Hz8VybNdNkLCV/VXsgv7UJHx2Tl 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3313qr17p7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2020 12:43:48 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07JGWcRw175233;
 Wed, 19 Aug 2020 12:43:47 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3313qr17nr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2020 12:43:47 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07JGPHab029310;
 Wed, 19 Aug 2020 16:43:46 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma04dal.us.ibm.com with ESMTP id 3304uqrns0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2020 16:43:46 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07JGhj5c51249518
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2020 16:43:45 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 505BCC6057;
 Wed, 19 Aug 2020 16:43:45 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B9DEC6055;
 Wed, 19 Aug 2020 16:43:40 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.211.41.171])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 19 Aug 2020 16:43:39 +0000 (GMT)
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v6 3/8] ppc/spapr: Use start-powered-off CPUState property
Date: Wed, 19 Aug 2020 13:43:01 -0300
Message-Id: <20200819164306.625357-4-bauerman@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200819164306.625357-1-bauerman@linux.ibm.com>
References: <20200819164306.625357-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-19_09:2020-08-19,
 2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=1
 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190135
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=bauerman@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 11:27:43
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PowerPC sPAPR CPUs start in the halted state, and spapr_reset_vcpu()
attempts to implement this by setting CPUState::halted to 1. But that's too
late for the case of hotplugged CPUs in a machine configure with 2 or more
threads per core.

By then, other parts of QEMU have already caused the vCPU to run in an
unitialized state a couple of times. For example, ppc_cpu_reset() calls
ppc_tlb_invalidate_all(), which ends up calling async_run_on_cpu(). This
kicks the new vCPU while it has CPUState::halted = 0, causing QEMU to issue
a KVM_RUN ioctl on the new vCPU before the guest is able to make the
start-cpu RTAS call to initialize its register state.

This problem doesn't seem to cause visible issues for regular guests, but
on a secure guest running under the Ultravisor it does. The Ultravisor
relies on being able to snoop on the start-cpu RTAS call to map vCPUs to
guests, and this issue causes it to see a stray vCPU that doesn't belong to
any guest.

Fix by setting the start-powered-off CPUState property in
spapr_create_vcpu(), which makes cpu_common_reset() initialize
CPUState::halted to 1 at an earlier moment.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 hw/ppc/spapr_cpu_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index c4f47dcc04..2125fdac34 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -36,11 +36,6 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
 
     cpu_reset(cs);
 
-    /* All CPUs start halted.  CPU0 is unhalted from the machine level
-     * reset code and the rest are explicitly started up by the guest
-     * using an RTAS call */
-    cs->halted = 1;
-
     env->spr[SPR_HIOR] = 0;
 
     lpcr = env->spr[SPR_LPCR];
@@ -274,6 +269,11 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
 
     cs = CPU(obj);
     cpu = POWERPC_CPU(obj);
+    /*
+     * All CPUs start halted. CPU0 is unhalted from the machine level reset code
+     * and the rest are explicitly started up by the guest using an RTAS call.
+     */
+    cs->start_powered_off = true;
     cs->cpu_index = cc->core_id + i;
     spapr_set_vcpu_id(cpu, cs->cpu_index, &local_err);
     if (local_err) {

