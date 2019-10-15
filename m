Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56A9C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 816A9205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PFdGFuqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816A9205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKOz5-0008GJ-39
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 11:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iKOhL-0003Lt-Cr
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iKOhK-0003s5-3Y
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:25:19 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:47191)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iKOhJ-0003cQ-F0; Tue, 15 Oct 2019 11:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=WMEj70ZX2RLuhYE9pIQSlcYumVwSBk1BVgAACnG2Mkc=; 
 b=PFdGFuqteWPgavtyy/+6FUhFP8C7+nlkvJGB4E07hWZsLLDW+g+dlBuV1ZB0sP+4aFPYDG7+bQoq4JEFBq5O2ZFhhdFl4vWeCEhicS4ARTfDENo+DE5+hvBIj29voB/3Ap1IjA6l031hDdE+Fok2QCo+Dk0U7hM2R3HGMd6KtQCSPdZQjXYPLDCO8X75er0VPOpLpfXTxQddjlkQ+v0JT11xlZum5cfKc6B+XZU5yNj/ZsOE3N6eJKplPB8257sxEBLQsOi7SsPx0nox4xC68DIuw7lmUVNANhfVemoi9l47EHQMciyYwO3x+R0Bk4FmM5KycZnYOh1N9xZeaMHKSQ==;
Received: from 82-181-115-92.bb.dnainternet.fi ([82.181.115.92]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iKOge-0003aj-5j; Tue, 15 Oct 2019 17:24:36 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iKOfn-000622-6A; Tue, 15 Oct 2019 18:23:43 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 22/23] qcow2: Restrict qcow2_co_pwrite_zeroes() to full
 clusters only
Date: Tue, 15 Oct 2019 18:23:33 +0300
Message-Id: <a0098a6a28b64c709bd06c02e7603426b6a2992f.1571152571.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1571152571.git.berto@igalia.com>
References: <cover.1571152571.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ideally it should be possible to zero individual subclusters using
this function, but this is currently not implemented.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index c54278ab0b..2eb032aed7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3544,6 +3544,12 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
         bytes = s->cluster_size;
         nr = s->cluster_size;
         ret = qcow2_get_cluster_offset(bs, offset, &nr, &off);
+        /* TODO: allow zeroing separate subclusters, we only allow
+         * zeroing full clusters at the moment. */
+        if (nr != bytes) {
+            qemu_co_mutex_unlock(&s->lock);
+            return -ENOTSUP;
+        }
         if (ret != QCOW2_CLUSTER_UNALLOCATED &&
             ret != QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER &&
             ret != QCOW2_CLUSTER_ZERO_PLAIN &&
-- 
2.20.1


