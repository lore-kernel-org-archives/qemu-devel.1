Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC57C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 11:58:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF892070A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 11:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YHzGwart"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF892070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iizsb-0007Tg-19
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 06:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iizZ9-0003Mn-J0
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 06:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iizZ8-0006qx-FG
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 06:38:31 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:34943)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iizZ8-0004Oj-27; Sun, 22 Dec 2019 06:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=IVBAlyVPifyO1dOQL27WASmPqtIuzSy/kdIJ89D+GVQ=; 
 b=YHzGwartUlNd0tmyum2aO+cTZ7w6vxWrPAc9bkHEo1ugWPgSNUlDADgcIx+Q48lX3PxM7PlwLyRTq2r66ooJSFJFBTHL8ALfQIuAhSWljbgGKOqUSw9Q3ZDJNGPd15EmHyGCJAaqj/mtyHwuma8pk3fJjj/9ebuV9462U3o+F4Smvk2a55oESVdtMpzlK56cC/YdChN5jJDke2D1Y2t0qh2IJuxrtW0Dm9tVMl8n4wktdRmen6GoKPiZJS1oXLVUO5YxBHJVXGWBUWlT5ZalmAM+TEKkjaLo/O6MS93eZyD4s8Nibw3ZXF97Fa3ebYG+MlpZ8jNWnNv/eRPZdfo+Ig==;
Received: from [80.30.182.172] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iizYU-0005d8-IW; Sun, 22 Dec 2019 12:37:50 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iizXu-0001Ve-D2; Sun, 22 Dec 2019 12:37:14 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 06/27] qcow2: Add dummy has_subclusters() function
Date: Sun, 22 Dec 2019 12:36:47 +0100
Message-Id: <bebe4058df5210ac3293e917ad6b61abac398f60.1577014346.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1577014346.git.berto@igalia.com>
References: <cover.1577014346.git.berto@igalia.com>
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
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function will be used by the qcow2 code to check if an image has
subclusters or not.

At the moment this simply returns false. Once all patches needed for
subcluster support are ready then QEMU will be able to create and
read images with subclusters and this function will return the actual
value.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index 6823d3f68f..1db3fc5dbc 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -495,6 +495,12 @@ typedef enum QCow2MetadataOverlap {
 
 #define INV_OFFSET (-1ULL)
 
+static inline bool has_subclusters(BDRVQcow2State *s)
+{
+    /* FIXME: Return false until this feature is complete */
+    return false;
+}
+
 static inline uint64_t get_l2_entry(BDRVQcow2State *s, uint64_t *l2_slice,
                                     int idx)
 {
-- 
2.20.1


