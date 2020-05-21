Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE2DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 03:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDEC320721
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 03:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AENwXPgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDEC320721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbcEP-0007QV-44
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 23:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jbc7J-00036r-L3; Wed, 20 May 2020 23:43:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59379 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jbc7I-0003Wl-7q; Wed, 20 May 2020 23:43:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49SFnr6g2mz9sTS; Thu, 21 May 2020 13:43:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590032592;
 bh=M+eXnJW1btziN4G5uNLQz37je7bEajAkkFSb+aa7K24=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AENwXPgM3o2mrp3sS7zPYmSBF/8anerUXVNQPs5uVXFDn8EyJJhXEqi4VkHd0KqOv
 6m/sMcCkNAFxRrKBOxheict5WSLXJh58UG4TXmTVRMmenMr3W73InyJ07jwtHgT0rR
 Sgt/OYUwSTN4V/5UmjcoBEudbhL31PQrN1kahEdM=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org, brijesh.singh@amd.com, frankja@linux.ibm.com,
 dgilbert@redhat.com, pair@us.ibm.com
Subject: [RFC v2 06/18] target/i386: sev: Remove redundant cbitpos and
 reduced_phys_bits fields
Date: Thu, 21 May 2020 13:42:52 +1000
Message-Id: <20200521034304.340040-7-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521034304.340040-1-david@gibson.dropbear.id.au>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SEVState structure has cbitpos and reduced_phys_bits fields which are
simply copied from the SevGuestState structure and never changed.  Now that
SEVState is embedded in SevGuestState we can just access the original copy
directly.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/i386/sev.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 9e8ab7b056..d25af37136 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -41,8 +41,6 @@ struct SEVState {
     uint8_t build_id;
     uint32_t policy;
     uint64_t me_mask;
-    uint32_t cbitpos;
-    uint32_t reduced_phys_bits;
     uint32_t handle;
     int sev_fd;
     SevState state;
@@ -378,13 +376,13 @@ sev_get_me_mask(void)
 uint32_t
 sev_get_cbit_position(void)
 {
-    return sev_guest ? sev_guest->state.cbitpos : 0;
+    return sev_guest ? sev_guest->cbitpos : 0;
 }
 
 uint32_t
 sev_get_reduced_phys_bits(void)
 {
-    return sev_guest ? sev_guest->state.reduced_phys_bits : 0;
+    return sev_guest ? sev_guest->reduced_phys_bits : 0;
 }
 
 SevInfo *
@@ -713,22 +711,19 @@ sev_guest_init(const char *id)
     host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
     host_cbitpos = ebx & 0x3f;
 
-    s->cbitpos = object_property_get_int(OBJECT(sev), "cbitpos", NULL);
-    if (host_cbitpos != s->cbitpos) {
+    if (host_cbitpos != sev->cbitpos) {
         error_report("%s: cbitpos check failed, host '%d' requested '%d'",
-                     __func__, host_cbitpos, s->cbitpos);
+                     __func__, host_cbitpos, sev->cbitpos);
         goto err;
     }
 
-    s->reduced_phys_bits = object_property_get_int(OBJECT(sev),
-                                        "reduced-phys-bits", NULL);
-    if (s->reduced_phys_bits < 1) {
+    if (sev->reduced_phys_bits < 1) {
         error_report("%s: reduced_phys_bits check failed, it should be >=1,"
-                     " requested '%d'", __func__, s->reduced_phys_bits);
+                     " requested '%d'", __func__, sev->reduced_phys_bits);
         goto err;
     }
 
-    s->me_mask = ~(1UL << s->cbitpos);
+    s->me_mask = ~(1UL << sev->cbitpos);
 
     devname = object_property_get_str(OBJECT(sev), "sev-device", NULL);
     s->sev_fd = open(devname, O_RDWR);
-- 
2.26.2


