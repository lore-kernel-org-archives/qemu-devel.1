Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EC3C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A475520872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZdDtiuxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A475520872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKOtz-0001FA-DO
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 11:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iKOhI-0003H3-Q3
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iKOhH-0003qQ-Pd
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:25:16 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:47106)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iKOhH-0003ZG-Gr; Tue, 15 Oct 2019 11:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=E3ZU1iFbE5HW1AIiBPqXlRoGatUOAMOrN4ipcn9TfgY=; 
 b=ZdDtiuxMd1JdhWPQgT5IRKEtIITUgFIqBm/PRsGyhIq3YWq17SGQj4Ekbz48btSzglFr8EOHSr0Hpqhh6Bd64oM4cg4u755wt5dNOOeAK145uHBqJOTENLZwi8zZNKv2jpYmeVVej+oTqHfFRjvNooa41zwhpxuUmx+NNgJS5E9kyVcya97gK1na5dn305TWe5kUW4+6L2LaG5zaUrzTmbXB0LBYE1qm+xvmKJIuGOvYY3CTeAhxwbKI6xdsI+eDZBmXaUKIvaAIKTOvgTFKegKXZPt7er3djQAPg+r43uIYL5zK4hqE1TOOoBmLYOBVzhEQETiddY7NuXNm5OOGiw==;
Received: from 82-181-115-92.bb.dnainternet.fi ([82.181.115.92]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iKOge-0003aV-1i; Tue, 15 Oct 2019 17:24:36 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iKOfm-00061M-Oa; Tue, 15 Oct 2019 18:23:42 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 08/23] qcow2: Add offset_to_sc_index()
Date: Tue, 15 Oct 2019 18:23:19 +0300
Message-Id: <9fce39a724a96ddd217ef2bed26eb9c4a6ef30df.1571152571.git.berto@igalia.com>
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

For a given offset, return the subcluster number within its cluster
(i.e. with 32 subclusters per cluster it returns a number between 0
and 31).

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index e6486a2cf8..c450267c88 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -556,6 +556,11 @@ static inline int offset_to_l2_slice_index(BDRVQcow2State *s, int64_t offset)
     return (offset >> s->cluster_bits) & (s->l2_slice_size - 1);
 }
 
+static inline int offset_to_sc_index(BDRVQcow2State *s, int64_t offset)
+{
+    return (offset >> s->subcluster_bits) & (s->subclusters_per_cluster - 1);
+}
+
 static inline int64_t qcow2_vm_state_offset(BDRVQcow2State *s)
 {
     return (int64_t)s->l1_vm_state_index << (s->cluster_bits + s->l2_bits);
-- 
2.20.1


