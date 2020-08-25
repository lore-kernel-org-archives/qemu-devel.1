Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E11C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1252720706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="qAUf+/e3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1252720706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAX1N-0007Go-9q
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 07:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kAWwU-00072d-GI; Tue, 25 Aug 2020 07:16:43 -0400
Received: from ozlabs.org ([203.11.71.1]:37189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kAWwS-000549-Be; Tue, 25 Aug 2020 07:16:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BbRJc6QMdz9sTh; Tue, 25 Aug 2020 21:16:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1598354192;
 bh=cK8YoyGiZN9VrJxqfMnqSwu4zPSmf74DMw9EA6+Z54Y=;
 h=From:To:Cc:Subject:Date:From;
 b=qAUf+/e3e63u7Tdfx4O5ZNfa2AejapYOcPXRV0emTrMKqFVgMbN/eGixMZGECNMau
 HQi7w9dgciv9LttSz7s0cr45BBpX+Dnb904AUOdHBQApO140qyFOBrh8BVvaruEe+S
 TD920pNrGp5l5jqfXAQx8XHUguSnncWlQlW8qSnY=
From: David Gibson <david@gibson.dropbear.id.au>
To: ehabkost@redhat.com
Subject: [PATCH 0/3] ppc: Fixes for class and instance size problems
Date: Tue, 25 Aug 2020 21:16:24 +1000
Message-Id: <20200825111627.2007820-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 07:16:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As requested, some fixes for the ppc things found by Eduardo's
scripts.

Cédric Le Goater (1):
  ppc/pnv: Fix TypeInfo of PnvLpcController abstract class

David Gibson (2):
  adb: Correct class size on TYPE_ADB_DEVICE
  spapr: Correct type for SPAPR_DRC_PCI

 hw/input/adb.c             | 1 +
 hw/ppc/pnv_lpc.c           | 3 +--
 include/hw/ppc/spapr_drc.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.26.2


