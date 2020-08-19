Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96BBC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C08E2065F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C08E2065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Ns3-0000qU-OC
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 09:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8Npo-0004vQ-7O; Wed, 19 Aug 2020 09:08:56 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:47949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8Npl-0006LZ-Kj; Wed, 19 Aug 2020 09:08:55 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.109])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id E7CD358A0B85;
 Wed, 19 Aug 2020 15:08:50 +0200 (CEST)
Received: from kaod.org (37.59.142.98) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 15:08:49 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002259375a7-0089-4f1c-b548-029e240ac414,
 56ABA3BD09B5898CED80C8E013D4E39E9C6048D1) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 3/8] spapr/xive: Query the characteristics of a source in KVM
Date: Wed, 19 Aug 2020 15:08:38 +0200
Message-ID: <20200819130843.2230799-4-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200819130843.2230799-1-clg@kaod.org>
References: <20200819130843.2230799-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 4720eae0-975a-4a7c-9ab2-40d0d91becbb
X-Ovh-Tracer-Id: 2621657936032860966
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddtkedggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheehfeegjeeitdfffeetjeduveejueefuefgtdefueelueetveeliefhhffgtdelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 09:08:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When running a guest with a kernel IRQ chip enabled, the XIVE
characteristics of the interrupts are advertised to the guest in the
H_INT_GET_SOURCE_INFO hcall. These characteristics depend on the
underlying HW interrupts but today, QEMU simply advertises its own
without checking what the host supports. It is not a problem for the
moment, but POWER10 will (re)add support for StoreEOI and we need a
way to in sync with the host.

The KVM_DEV_XIVE_GRP_SOURCE_INFO command lets QEMU query the XIVE
characteristics of the underlying HW interrupts and override any
previous setting done by QEMU. This allows the fallback mode, when the
XIVE device is emulated by QEMU, to use its own custom settings on the
sources but makes sure that we don't let a guest run with features
incompatible with KVM.

It only applies to the StoreEOI feature for the moment.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_xive.h |  2 ++
 hw/intc/spapr_xive.c        | 20 ++++++++++++++++++++
 hw/intc/spapr_xive_kvm.c    | 26 ++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 1dddcbcb9cdd..3f325723ea74 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -84,6 +84,8 @@ void kvmppc_xive_disconnect(SpaprInterruptController *intc);
 void kvmppc_xive_reset(SpaprXive *xive, Error **errp);
 int kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEAS *eas,
                                   Error **errp);
+int kvmppc_xive_get_source_info(SpaprXive *xive, uint32_t lisn, uint64_t *flags,
+                                 Error **errp);
 void kvmppc_xive_sync_source(SpaprXive *xive, uint32_t lisn, Error **errp);
 uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int srcno, uint32_t offset,
                             uint64_t data, bool write);
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 1fa09f287ac0..943b9958a68b 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -932,6 +932,26 @@ static target_ulong h_int_get_source_info(PowerPCCPU *cpu,
         args[0] |= SPAPR_XIVE_SRC_STORE_EOI;
     }
 
+    if (kvm_irqchip_in_kernel()) {
+        Error *local_err = NULL;
+        uint64_t flags = 0;
+
+        kvmppc_xive_get_source_info(xive, lisn, &flags, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return H_HARDWARE;
+        }
+
+        /*
+         * Override QEMU settings with KVM values
+         */
+        if (flags & XIVE_SRC_STORE_EOI) {
+            args[0] |= SPAPR_XIVE_SRC_STORE_EOI;
+        } else {
+            args[0] &= ~SPAPR_XIVE_SRC_STORE_EOI;
+        }
+    }
+
     /*
      * Force the use of the H_INT_ESB hcall in case of an LSI
      * interrupt. This is necessary under KVM to re-trigger the
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index e8667ce5f621..90f4509e6959 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -217,6 +217,32 @@ int kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEAS *eas,
                              &kvm_src, true, errp);
 }
 
+int kvmppc_xive_get_source_info(SpaprXive *xive, uint32_t lisn, uint64_t *flags,
+                                 Error **errp)
+{
+    struct kvm_ppc_xive_src kvm_src = { 0 };
+    int ret;
+
+    /*
+     * Check that KVM supports the new attribute to query source
+     * characteristics.
+     */
+    if (!kvm_device_check_attr(xive->fd, KVM_DEV_XIVE_GRP_SOURCE_INFO, 0)) {
+        return 0;
+    }
+
+    ret = kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE_INFO, lisn,
+                            &kvm_src, false, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (kvm_src.flags & KVM_XIVE_SOURCE_FLAG_STORE_EOI) {
+        *flags |= XIVE_SRC_STORE_EOI;
+    }
+    return 0;
+}
+
 void kvmppc_xive_sync_source(SpaprXive *xive, uint32_t lisn, Error **errp)
 {
     kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE_SYNC, lisn,
-- 
2.25.4


