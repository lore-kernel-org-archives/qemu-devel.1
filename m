Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1FAC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCADB21941
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Sg8jX52M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCADB21941
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFzNd-0000JP-Vw
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 08:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kFzMV-0007iF-6n; Wed, 09 Sep 2020 08:38:07 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:56547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kFzMP-0007GS-Lq; Wed, 09 Sep 2020 08:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=AMJwvzwGTK3YNIl1yUoumDn66puxG6HRQDDcDamtgDY=; 
 b=Sg8jX52M3dP7kl6jdoY2uqdZ2ShUwYJB5ItMnRcBhtLkELbHoA4SNIvJlO9CgpOwtg9mStJylQ3g/PjQcGCcyVyrZeccbjl//ulJddWvuCz90ethNQrZUeisP4vZdAZHgQ9+rA8vxtEVr3lw+d7CwlLGapyu4oxqylkDvX1dssZJRU77xsdowFk74xHItGoI1MD8ud/mpQLbcT8kb+8we5m3fTpLLvxgYsy11AyRPVqySRqvNJ/YRjze9SIT3YbSHNpfv3muOHeUZMoly0KPxtXVkd08VXXs8blqF/hOV8LV093JECGsLHy6ZTed5sQhU0zyw7o0U5ctApb64M5meQ==;
Received: from [81.0.34.67] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kFzMK-0000N3-ET; Wed, 09 Sep 2020 14:37:56 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kFzM7-0000CT-Ft; Wed, 09 Sep 2020 14:37:43 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qcow2: Return the original error code in
 qcow2_co_pwrite_zeroes()
Date: Wed,  9 Sep 2020 14:37:39 +0200
Message-Id: <20200909123739.719-1-berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 08:37:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function checks the current status of a (sub)cluster in order to
see if an unaligned 'write zeroes' request can be done efficiently by
simply updating the L2 metadata and without having to write actual
zeroes to disk.

If the situation does not allow using the fast path then the function
returns -ENOTSUP and the caller falls back to writing zeroes.

If can happen however that the aforementioned check returns an actual
error code so in this case we should pass it to the caller.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index da56b1a4df..ca46cbd795 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3916,7 +3916,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
              type != QCOW2_SUBCLUSTER_ZERO_PLAIN &&
              type != QCOW2_SUBCLUSTER_ZERO_ALLOC)) {
             qemu_co_mutex_unlock(&s->lock);
-            return -ENOTSUP;
+            return ret < 0 ? ret : -ENOTSUP;
         }
     } else {
         qemu_co_mutex_lock(&s->lock);
-- 
2.20.1


