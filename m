Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E48C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F8E20706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dt0fHTUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F8E20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUTq-0005RV-AH
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUOw-000448-Np
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:33:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUOu-0000cu-MI
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598344431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8B7SKqqJSMBjP0ELm9wSnZJeCmsuhrnaBBAsOjU5eyo=;
 b=dt0fHTUSxBnbLs5RXBsmIuNgsiGmg32UGnJguiTNMs6YYDidTWqb3eWBqvyzSVVOehhhxQ
 tD2c0imMl1YmA8FWHpGOt76awByu9oNr/0k51Um0WPuyfe7oEckAy3Rtmtz2xkwtWlpohA
 IcwMy5PxUaYIlGT1nCwPK+3C3yGVPgk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-bEhcX3w4NxehPdC_sGYRdQ-1; Tue, 25 Aug 2020 04:33:49 -0400
X-MC-Unique: bEhcX3w4NxehPdC_sGYRdQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69F021074666;
 Tue, 25 Aug 2020 08:33:48 +0000 (UTC)
Received: from localhost (ovpn-113-72.ams2.redhat.com [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08D9B5D9CA;
 Tue, 25 Aug 2020 08:33:47 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 15/34] qcow2: Add qcow2_get_subcluster_range_type()
Date: Tue, 25 Aug 2020 10:32:52 +0200
Message-Id: <20200825083311.1098442-16-mreitz@redhat.com>
In-Reply-To: <20200825083311.1098442-1-mreitz@redhat.com>
References: <20200825083311.1098442-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

There are situations in which we want to know how many contiguous
subclusters of the same type there are in a given cluster. This can be
done by simply iterating over the subclusters and repeatedly calling
qcow2_get_subcluster_type() for each one of them.

However once we determined the type of a subcluster we can check the
rest efficiently by counting the number of adjacent ones (or zeroes)
in the bitmap. This is what this function does.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <db917263d568ec6ffb4a41cac3c9100f96bf6c18.1594396418.git.berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 51 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 0b762502f6..2fe7a0f79c 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -375,6 +375,57 @@ fail:
     return ret;
 }
 
+/*
+ * For a given L2 entry, count the number of contiguous subclusters of
+ * the same type starting from @sc_from. Compressed clusters are
+ * treated as if they were divided into subclusters of size
+ * s->subcluster_size.
+ *
+ * Return the number of contiguous subclusters and set @type to the
+ * subcluster type.
+ *
+ * If the L2 entry is invalid return -errno and set @type to
+ * QCOW2_SUBCLUSTER_INVALID.
+ */
+G_GNUC_UNUSED
+static int qcow2_get_subcluster_range_type(BlockDriverState *bs,
+                                           uint64_t l2_entry,
+                                           uint64_t l2_bitmap,
+                                           unsigned sc_from,
+                                           QCow2SubclusterType *type)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint32_t val;
+
+    *type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc_from);
+
+    if (*type == QCOW2_SUBCLUSTER_INVALID) {
+        return -EINVAL;
+    } else if (!has_subclusters(s) || *type == QCOW2_SUBCLUSTER_COMPRESSED) {
+        return s->subclusters_per_cluster - sc_from;
+    }
+
+    switch (*type) {
+    case QCOW2_SUBCLUSTER_NORMAL:
+        val = l2_bitmap | QCOW_OFLAG_SUB_ALLOC_RANGE(0, sc_from);
+        return cto32(val) - sc_from;
+
+    case QCOW2_SUBCLUSTER_ZERO_PLAIN:
+    case QCOW2_SUBCLUSTER_ZERO_ALLOC:
+        val = (l2_bitmap | QCOW_OFLAG_SUB_ZERO_RANGE(0, sc_from)) >> 32;
+        return cto32(val) - sc_from;
+
+    case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
+    case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
+        val = ((l2_bitmap >> 32) | l2_bitmap)
+            & ~QCOW_OFLAG_SUB_ALLOC_RANGE(0, sc_from);
+        return ctz32(val) - sc_from;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /*
  * Checks how many clusters in a given L2 slice are contiguous in the image
  * file. As soon as one of the flags in the bitmask stop_flags changes compared
-- 
2.26.2


