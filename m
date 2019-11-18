Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C7DC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C1C2068E
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C1C2068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWiim-0004md-M3
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 10:13:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iWihe-00040f-68
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iWihd-0005Xn-0c
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:12:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29042)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iWihc-0005XT-RD
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:12:32 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAIFCAwx042853
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 10:12:29 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wact5reps-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 10:12:23 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Mon, 18 Nov 2019 15:12:12 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 18 Nov 2019 15:12:09 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xAIFC8hH25559374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Nov 2019 15:12:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2C2B52078;
 Mon, 18 Nov 2019 15:12:07 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.70.126])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9CCA752050;
 Mon, 18 Nov 2019 15:12:07 +0000 (GMT)
Subject: [PATCH for-5.0] xive/kvm: Trigger interrupts from userspace
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Nov 2019 16:12:07 +0100
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111815-4275-0000-0000-00000380FB90
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111815-4276-0000-0000-000038946C07
Message-Id: <157408992731.494439.3405812941731584740.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_03:2019-11-15,2019-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1034 spamscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911180139
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using the XIVE KVM device, the trigger page is directly accessible
in QEMU. Unlike with XICS, no need to ask KVM to fire the interrupt. A
simple store on the trigger page does the job.

Just call xive_esb_trigger().

This may improve performance of emulated devices that go through
qemu_set_irq(), eg. virtio devices created with ioeventfd=off or
configured by the guest to use LSI interrupts, which aren't really
recommended setups.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive_kvm.c |   16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 08012ac7cd76..69e73552f1ef 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -354,32 +354,20 @@ static void kvmppc_xive_source_get_state(XiveSource *xsrc)
 void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
 {
     XiveSource *xsrc = opaque;
-    SpaprXive *xive = SPAPR_XIVE(xsrc->xive);
-    struct kvm_irq_level args;
-    int rc;
-
-    /* The KVM XIVE device should be in use */
-    assert(xive->fd != -1);
 
-    args.irq = srcno;
     if (!xive_source_irq_is_lsi(xsrc, srcno)) {
         if (!val) {
             return;
         }
-        args.level = KVM_INTERRUPT_SET;
     } else {
         if (val) {
             xsrc->status[srcno] |= XIVE_STATUS_ASSERTED;
-            args.level = KVM_INTERRUPT_SET_LEVEL;
         } else {
             xsrc->status[srcno] &= ~XIVE_STATUS_ASSERTED;
-            args.level = KVM_INTERRUPT_UNSET;
         }
     }
-    rc = kvm_vm_ioctl(kvm_state, KVM_IRQ_LINE, &args);
-    if (rc < 0) {
-        error_report("XIVE: kvm_irq_line() failed : %s", strerror(errno));
-    }
+
+    xive_esb_trigger(xsrc, srcno);
 }
 
 /*


