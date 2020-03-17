Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F0FC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A427020714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DlsQQ9RN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A427020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGru-0002ma-RC
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jEGma-0002oE-W4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jEGmZ-0007Ul-1R
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:17:40 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:57716)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jEGmX-0005Ux-An; Tue, 17 Mar 2020 14:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=7sHbHchVW1ZG6KSFzVDN96AUHkkExtfWiKVvhF1b2ew=; 
 b=DlsQQ9RNg/Btd8ks46DNOKBlT7EGXo14flT8mmprdlBH7nnEO+iAZtR51Z2JrO9ugiR2A7q+5/5BRlocyDeWgPSO2eWkxUwItpCy8UB2MV7/ILv4a+RgWxGAhkW3yj9u0kHngLIuwsROVw/MAuZyCcfIWIcDOefhMnKArVu3QuR01b6XOlMZB0HW+ip7paDuO89Jzr7qiYaoW+d0QxeS+KfGJUKd+gZ8VSiS7xediJIDj17jPgmbgDXd9JHRt07WUGI2NXh0M7GOosmNo44MCXGc/V8hlE2vVqY6v7jiFe8CMWLq3+zQZih8QS7y0E/N+jaqO82Bsr1WfD3gQk0DPg==;
Received: from [81.0.35.138] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jEGmD-00015X-0N; Tue, 17 Mar 2020 19:17:17 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jEGlw-0006OR-Ed; Tue, 17 Mar 2020 19:17:00 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/30] qcow2: Update get/set_l2_entry() and add
 get/set_l2_bitmap()
Date: Tue, 17 Mar 2020 19:16:09 +0100
Message-Id: <c3d6c8e03c353a694b6415d9f6ae253f22a620ea.1584468723.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1584468723.git.berto@igalia.com>
References: <cover.1584468723.git.berto@igalia.com>
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

This patch also adds the get/set_l2_bitmap() functions that are
used to access the bitmaps. For convenience we allow calling
get_l2_bitmap() on images without subclusters, although the caller
does not need and should ignore the returned value.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index 1eb4b46807..9611efbc52 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -518,15 +518,37 @@ static inline size_t l2_entry_size(BDRVQcow2State *s)
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
+        /* For convenience only; the caller should ignore this value. */
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
+    assert(has_subclusters(s));
+    idx *= l2_entry_size(s) / sizeof(uint64_t);
+    l2_slice[idx + 1] = cpu_to_be64(bitmap);
+}
+
 static inline bool has_data_file(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
-- 
2.20.1


