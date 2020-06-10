Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8908CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54347206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hf0hgFPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54347206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj2JG-0004lW-Ag
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 11:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jj2GZ-0002Gs-3X; Wed, 10 Jun 2020 11:03:47 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:58076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jj2GW-0006w1-SO; Wed, 10 Jun 2020 11:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=3TcxrFGVkCtUtsIcvfPDHVNJ3SGTTueaU2gMyJDgFo0=; 
 b=hf0hgFPg4+cvB5RAm2eQIiOk7f/jreIuLu/HovOBI86dpmPewieRVJ+BNQzp1SSjqJFOMjci+xLXjfenCWhPJkeZ6ESFvKgCYyfTdz4Fbuy9rrASdAOXlsrFBZwkcUFP1adNvTuyio7S/soknyMZ7mN1FN2RbGFBlYvbeUm/UtamPeZRZ2GIW+KXLISjjXnXZEZqUZ/m+GxFIQzM77qrZy4XEF3wGKEjvTAP2xq8yEPGkxGsIolHH6YogQINeLjwmQ4VoGQosq4Wz37EkGAEQjedP6x+wGDqN/m2MDzg/FDE4e2Bq0h2ZK/GkiIhusiMKEXu8wIQ7+YJ2QZwUppA4Q==;
Received: from [81.0.38.199] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jj2GR-0007gt-CR; Wed, 10 Jun 2020 17:03:39 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jj2GC-0007My-1f; Wed, 10 Jun 2020 17:03:24 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 13/34] qcow2: Update get/set_l2_entry() and add
 get/set_l2_bitmap()
Date: Wed, 10 Jun 2020 17:02:51 +0200
Message-Id: <5373a508b5a8b9a961d1aa79833de988dc370666.1591801197.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1591801197.git.berto@igalia.com>
References: <cover.1591801197.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 11:03:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Derek Su <dereksu@qnap.com>, Max Reitz <mreitz@redhat.com>
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index 46b351229a..82b86f6cec 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -533,15 +533,36 @@ static inline size_t l2_entry_size(BDRVQcow2State *s)
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


