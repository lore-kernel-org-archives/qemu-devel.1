Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B2DC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8834A20753
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PLvgyKxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8834A20753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWYmd-00008k-1l
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 01:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYhy-0007fG-4s; Thu, 07 May 2020 01:04:30 -0400
Received: from ozlabs.org ([203.11.71.1]:52825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYhw-0007ek-M4; Thu, 07 May 2020 01:04:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49HhFp24wKz9sTC; Thu,  7 May 2020 15:04:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588827854;
 bh=yJJUaRpryaOGasKwSmwxd8+LVwAoZKFoeJZaTcdzxnk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PLvgyKxlfWNjUUtpA0ZO5kfYIeMQSbt419DL9dcZBo8NRBtzdNNuG45XFKayruGFW
 BXO6wFG0btuw1btMpbGcL8Nl8fias0t4uIr4kNi8qwEB3n2wLguyCvbHlSbjCD+E4k
 JGCCKfBG3LHKD1y7BkH1FV47BJvD/s2XxTJIrf9s=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 10/18] target/ppc: Assert if HV mode is set when running under
 a pseries machine
Date: Thu,  7 May 2020 15:02:20 +1000
Message-Id: <20200507050228.802395-11-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507050228.802395-1-david@gibson.dropbear.id.au>
References: <20200507050228.802395-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 01:04:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, npiggin@gmail.com, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cédric Le Goater <clg@kaod.org>

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20200330094946.24678-4-clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-radix64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index f6007e9565..d2422d1c54 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -231,6 +231,7 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
     ppc_v3_pate_t pate;
     bool relocation;
 
+    assert(!(msr_hv && cpu->vhyp));
     assert((rwx == 0) || (rwx == 1) || (rwx == 2));
 
     relocation = ((rwx == 2) && (msr_ir == 1)) || ((rwx != 2) && (msr_dr == 1));
-- 
2.26.2


