Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EC0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086BC20708
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086BC20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYt3k-0004Ic-SK
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 11:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jYt2p-0002nt-AQ
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:11:39 -0400
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:47341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jYt2o-0005JQ-Bb
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:11:39 -0400
Received: from player791.ha.ovh.net (unknown [10.108.42.192])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 0474279EA0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 17:11:35 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player791.ha.ovh.net (Postfix) with ESMTPSA id 21EFA1244BB3D;
 Wed, 13 May 2020 15:11:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/9] ppc/xive: Export PQ get/set routines
Date: Wed, 13 May 2020 17:11:01 +0200
Message-Id: <20200513151109.453530-2-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200513151109.453530-1-clg@kaod.org>
References: <20200513151109.453530-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1019783841871072230
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrleeggdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgfeitedvfedugeehvdevjeduiefhieetffejteejueekhffggfevudegudegudfgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeluddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=188.165.52.203; envelope-from=clg@kaod.org;
 helo=3.mo69.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 11:11:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These will be shared with the XIVE2 router.

Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h    | 4 ++++
 hw/intc/spapr_xive_kvm.c | 8 ++++----
 hw/intc/xive.c           | 6 +++---
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 705cf48176fc..112fb6fb6dbe 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -255,6 +255,10 @@ static inline hwaddr xive_source_esb_mgmt(XiveSource *xsrc, int srcno)
 #define XIVE_ESB_QUEUED       (XIVE_ESB_VAL_P | XIVE_ESB_VAL_Q)
 #define XIVE_ESB_OFF          XIVE_ESB_VAL_Q
 
+bool xive_esb_trigger(uint8_t *pq);
+bool xive_esb_eoi(uint8_t *pq);
+uint8_t xive_esb_set(uint8_t *pq, uint8_t value);
+
 /*
  * "magic" Event State Buffer (ESB) MMIO offsets.
  *
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index edb7ee0e74f1..43f4d56b958c 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -308,7 +308,7 @@ static uint8_t xive_esb_read(XiveSource *xsrc, int srcno, uint32_t offset)
     return xive_esb_rw(xsrc, srcno, offset, 0, 0) & 0x3;
 }
 
-static void xive_esb_trigger(XiveSource *xsrc, int srcno)
+static void kvmppc_xive_esb_trigger(XiveSource *xsrc, int srcno)
 {
     uint64_t *addr = xsrc->esb_mmap + xive_source_esb_page(xsrc, srcno);
 
@@ -331,7 +331,7 @@ uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int srcno, uint32_t offset,
         offset == XIVE_ESB_LOAD_EOI) {
         xive_esb_read(xsrc, srcno, XIVE_ESB_SET_PQ_00);
         if (xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
-            xive_esb_trigger(xsrc, srcno);
+            kvmppc_xive_esb_trigger(xsrc, srcno);
         }
         return 0;
     } else {
@@ -375,7 +375,7 @@ void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
         }
     }
 
-    xive_esb_trigger(xsrc, srcno);
+    kvmppc_xive_esb_trigger(xsrc, srcno);
 }
 
 /*
@@ -544,7 +544,7 @@ static void kvmppc_xive_change_state_handler(void *opaque, int running,
              * generate a trigger.
              */
             if (pq == XIVE_ESB_RESET && old_pq == XIVE_ESB_QUEUED) {
-                xive_esb_trigger(xsrc, i);
+                kvmppc_xive_esb_trigger(xsrc, i);
             }
         }
 
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index d6183f8ae40a..b8825577f719 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -789,7 +789,7 @@ void xive_tctx_destroy(XiveTCTX *tctx)
  * XIVE ESB helpers
  */
 
-static uint8_t xive_esb_set(uint8_t *pq, uint8_t value)
+uint8_t xive_esb_set(uint8_t *pq, uint8_t value)
 {
     uint8_t old_pq = *pq & 0x3;
 
@@ -799,7 +799,7 @@ static uint8_t xive_esb_set(uint8_t *pq, uint8_t value)
     return old_pq;
 }
 
-static bool xive_esb_trigger(uint8_t *pq)
+bool xive_esb_trigger(uint8_t *pq)
 {
     uint8_t old_pq = *pq & 0x3;
 
@@ -819,7 +819,7 @@ static bool xive_esb_trigger(uint8_t *pq)
     }
 }
 
-static bool xive_esb_eoi(uint8_t *pq)
+bool xive_esb_eoi(uint8_t *pq)
 {
     uint8_t old_pq = *pq & 0x3;
 
-- 
2.25.4


