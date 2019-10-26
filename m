Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808F3CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4553220863
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aZbpVYmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4553220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOUWJ-0004ij-8c
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 18:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iOTZj-00005V-Kf
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iOTZi-0005Lz-DB
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:19 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42494)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iOTZg-0005Eu-9C; Sat, 26 Oct 2019 17:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=JRoZMYOKHXsp3/0CS1YG5TDx/OhWsX+AkPTx4RJXlxA=; 
 b=aZbpVYmvZbDaxwAQpmvVucV8WnSbUoNwwnCFl+SZ7xh0pbianyZbfZz375Ry0d8zCxXkNyqBh+RrO0PdUOWywSw3eKKgFPOJXEeZ+Umv4vYCcxnFjpfIJAyJjxWHpjnuo8EF5c8in+Vh61UlwczRMGcLoQHkjs5w48rtmI8e7vsa8M7WVXsizo4i6yjEuzs6Z8U9JNo8Sfv7ubsyXu+RkiMUVot5jatQkmnboQcsydHd4etwfXIbKi9Ik3IExGMd4+6mUkz+QGnOVpVcuM6381FLH8qNEsHfNkkM+zRkmWz6GjC1ItWi9eYmfBDM570uXjauCoEB364i2lMuTHNmmw==;
Received: from 87-100-137-117.bb.dnainternet.fi ([87.100.137.117]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iOTZI-00045w-MR; Sat, 26 Oct 2019 23:25:52 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iOTZ0-0001PK-FK; Sun, 27 Oct 2019 00:25:34 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 10/26] qcow2: Update get/set_l2_entry() and add
 get/set_l2_bitmap()
Date: Sun, 27 Oct 2019 00:25:12 +0300
Message-Id: <2d4de1dee301cd772fce97c90e08a390edbe2830.1572125022.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1572125022.git.berto@igalia.com>
References: <cover.1572125022.git.berto@igalia.com>
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

Extended L2 entries are 128-bit wide: 64 bits for the entry itself and
64 bits for the subcluster allocation bitmap.

In order to support them correctly get/set_l2_entry() need to be
updated so they take the entry width into account in order to
calculate the correct offset.

This patch also adds the get/set_l2_bitmap() functions that are used
to access the bitmaps. For convenience, these functions are no-ops
when used in traditional qcow2 images.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index 29a253bfb9..741c41c80f 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -507,15 +507,37 @@ static inline size_t l2_entry_size(BDRVQcow2State *s)
 static inline uint64_t get_l2_entry(BDRVQcow2State *s, uint64_t *l2_slice,
                                     int idx)
 {
+    idx *= l2_entry_size(s) / sizeof(uint64_t);
     return be64_to_cpu(l2_slice[idx]);
 }
 
+static inline uint64_t get_l2_bitmap(BDRVQcow2State *s, uint64_t *l2_slice,
+                                     int idx)
+{
+    if (has_subclusters(s)) {
+        idx *= l2_entry_size(s) / sizeof(uint64_t);
+        return be64_to_cpu(l2_slice[idx + 1]);
+    } else {
+        return 0;
+    }
+}
+
 static inline void set_l2_entry(BDRVQcow2State *s, uint64_t *l2_slice,
                                 int idx, uint64_t entry)
 {
+    idx *= l2_entry_size(s) / sizeof(uint64_t);
     l2_slice[idx] = cpu_to_be64(entry);
 }
 
+static inline void set_l2_bitmap(BDRVQcow2State *s, uint64_t *l2_slice,
+                                 int idx, uint64_t bitmap)
+{
+    if (has_subclusters(s)) {
+        idx *= l2_entry_size(s) / sizeof(uint64_t);
+        l2_slice[idx + 1] = cpu_to_be64(bitmap);
+    }
+}
+
 static inline bool has_data_file(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
-- 
2.20.1


