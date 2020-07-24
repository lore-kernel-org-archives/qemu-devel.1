Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE17C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 03:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A8320737
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 03:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YAM+uwL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A8320737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyo0e-0008QM-UM
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 23:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jynuR-0007Ra-Pp; Thu, 23 Jul 2020 22:58:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42179 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jynuO-00061m-FB; Thu, 23 Jul 2020 22:58:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BCYlw1T28z9sTK; Fri, 24 Jul 2020 12:57:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595559468;
 bh=oUlu8u5TiukpYL5YY0i+HjSckV5d3NnHfXBN6cEFoNM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YAM+uwL/E+M/lqPo6JwEV3OirVdPwoH0YUjmphFtXRnwwwmqxPNOtpZXt6UKp+3y2
 kVvh0eEmXx8oPDzXuZjXDRfW1jIUhPJ/GeNmPPagmkoRSudKOBfc+1SUViCmyhbYOT
 k/e5svfcGURMKHpEqITtS1JU8RUB0oQRn4sjEifo=
From: David Gibson <david@gibson.dropbear.id.au>
To: dgilbert@redhat.com, frankja@linux.ibm.com, pair@us.ibm.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, brijesh.singh@amd.com
Subject: [for-5.2 v4 08/10] spapr: PEF: block migration
Date: Fri, 24 Jul 2020 12:57:42 +1000
Message-Id: <20200724025744.69644-9-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200724025744.69644-1-david@gibson.dropbear.id.au>
References: <20200724025744.69644-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 22:57:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 ehabkost@redhat.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 mdroth@linux.vnet.ibm.com, pasic@linux.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We haven't yet implemented the fairly involved handshaking that will be
needed to migrate PEF protected guests.  For now, just use a migration
blocker so we get a meaningful error if someone attempts this (this is the
same approach used by AMD SEV).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/pef.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/ppc/pef.c b/target/ppc/pef.c
index 53a6af0347..6a50efd580 100644
--- a/target/ppc/pef.c
+++ b/target/ppc/pef.c
@@ -36,6 +36,8 @@ struct PefGuestState {
     Object parent_obj;
 };
 
+static Error *pef_mig_blocker;
+
 static int pef_kvm_init(HostTrustLimitation *gmpo, Error **errp)
 {
     if (!kvm_check_extension(kvm_state, KVM_CAP_PPC_SECURE_GUEST)) {
@@ -52,6 +54,10 @@ static int pef_kvm_init(HostTrustLimitation *gmpo, Error **errp)
         }
     }
 
+    /* add migration blocker */
+    error_setg(&pef_mig_blocker, "PEF: Migration is not implemented");
+    migrate_add_blocker(pef_mig_blocker, &error_abort);
+
     return 0;
 }
 
-- 
2.26.2


