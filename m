Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FB2C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 17:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409FD206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 17:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="p42Xnb2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409FD206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW1hq-0005dG-6u
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 13:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jW1Xo-00070P-Ow; Tue, 05 May 2020 13:39:48 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:39025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jW1Xe-0008Qi-QF; Tue, 05 May 2020 13:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=30M0RfE54HixaeWp7Be+KUudA5Copix+KwIvitPtJBo=; 
 b=p42Xnb2KRwTHG5nWxytIkij3Cr0TpfFUTOh8nygwHAcjPkf/eLVN1Yjk72VBq2Xr08kUxlSdoCljtoUJ805vPsagwIN8KvrSzWyP5NKQSjDGEhE6vdOZDNQV517jemvYMfaMiaH1axXOi8PE02R4BSZhPCHjRLPhFOuCv88sIJMSrAmTO2rvAQwr7f4AlSNZZH2ipNnRkUv/9ml43fcsW3ZB9YwFCSUw4rdm91a6bVVElDq6GTbyN0hqCzBxBm7q+QyUQrO7RUj6TcY8KE1dgsaie4v1Yii5Pya2pYzqtgrcn93gfdLaT6XJRnPKhYsgQYBmxtq0mflVP1i4sYBWSA==;
Received: from static.160.43.0.81.ibercom.com ([81.0.43.160]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jW1Ws-00025K-DH; Tue, 05 May 2020 19:38:50 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jW1Wc-00043x-RT; Tue, 05 May 2020 19:38:34 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 13/31] qcow2: Update get/set_l2_entry() and add
 get/set_l2_bitmap()
Date: Tue,  5 May 2020 19:38:13 +0200
Message-Id: <30130e0f4662ea8ba705c5c54afc56bfb1ae70b6.1588699789.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1588699789.git.berto@igalia.com>
References: <cover.1588699789.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 13:38:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
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
get_l2_bitmap() on images without subclusters. In this case the
returned value is always 0 and has no meaning.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index 80ceb352c9..4ad93772b9 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -515,15 +515,36 @@ static inline size_t l2_entry_size(BDRVQcow2State *s)
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
+        return 0; /* For convenience only; this value has no meaning. */
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


