Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583CAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:42:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2135B20706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aovwVDf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2135B20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUXY-0005Rf-Bq
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPU-00058C-Kh
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20310
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPG-0000gb-5C
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598344452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oo5bAV2uAzDaBjBb4hYGQWIO0cuVTr/ye2fx1mDnnwI=;
 b=aovwVDf+SZ0izg8xi8E+kMBKh3Y9PbbUNXJc4QJe1nnxwQ5lqUCDZczPtpa+FTYMZKvbib
 cwxGltZjgFF/LiRjtP7MyvETFre4G/RcrLgKeXNo3N5ZbBVPs+V+wtomKIrblRR14GFrup
 gZB1Q79SmUuzivp/al3Q1v6+ah0Uhvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-83Pbj0wEMGaiGiAU5YNwZA-1; Tue, 25 Aug 2020 04:34:10 -0400
X-MC-Unique: 83Pbj0wEMGaiGiAU5YNwZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E70618A2250;
 Tue, 25 Aug 2020 08:34:09 +0000 (UTC)
Received: from localhost (ovpn-113-72.ams2.redhat.com [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C425A808AB;
 Tue, 25 Aug 2020 08:34:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 24/34] qcow2: Add subcluster support to check_refcounts_l2()
Date: Tue, 25 Aug 2020 10:33:01 +0200
Message-Id: <20200825083311.1098442-25-mreitz@redhat.com>
In-Reply-To: <20200825083311.1098442-1-mreitz@redhat.com>
References: <20200825083311.1098442-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:36:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The offset field of an uncompressed cluster's L2 entry must be aligned
to the cluster size, otherwise it is invalid. If the cluster has no
data then it means that the offset points to a preallocation, so we
can clear the offset field without affecting the guest-visible data.
This is what 'qemu-img check' does when run in repair mode.

On traditional qcow2 images this can only happen when QCOW_OFLAG_ZERO
is set, and repairing such entries turns the clusters from ZERO_ALLOC
into ZERO_PLAIN.

Extended L2 entries have no ZERO_ALLOC clusters and no QCOW_OFLAG_ZERO
but the idea is the same: if none of the subclusters are allocated
then we can clear the offset field and leave the bitmap untouched.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <9f4ed1d0a34b0a545b032c31ecd8c14734065342.1594396418.git.berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-refcount.c     | 16 +++++++++++-----
 tests/qemu-iotests/060.out |  2 +-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 770c5dbc83..aae52607eb 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1669,12 +1669,18 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
 
             /* Correct offsets are cluster aligned */
             if (offset_into_cluster(s, offset)) {
+                bool contains_data;
                 res->corruptions++;
 
-                if (qcow2_get_cluster_type(bs, l2_entry) ==
-                    QCOW2_CLUSTER_ZERO_ALLOC)
-                {
-                    fprintf(stderr, "%s offset=%" PRIx64 ": Preallocated zero "
+                if (has_subclusters(s)) {
+                    uint64_t l2_bitmap = get_l2_bitmap(s, l2_table, i);
+                    contains_data = (l2_bitmap & QCOW_L2_BITMAP_ALL_ALLOC);
+                } else {
+                    contains_data = !(l2_entry & QCOW_OFLAG_ZERO);
+                }
+
+                if (!contains_data) {
+                    fprintf(stderr, "%s offset=%" PRIx64 ": Preallocated "
                             "cluster is not properly aligned; L2 entry "
                             "corrupted.\n",
                             fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR",
@@ -1686,7 +1692,7 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                         int ign = active ? QCOW2_OL_ACTIVE_L2 :
                                            QCOW2_OL_INACTIVE_L2;
 
-                        l2_entry = QCOW_OFLAG_ZERO;
+                        l2_entry = has_subclusters(s) ? 0 : QCOW_OFLAG_ZERO;
                         set_l2_entry(s, l2_table, i, l2_entry);
                         ret = qcow2_pre_write_overlap_check(bs, ign,
                                 l2e_offset, l2_entry_size(s), false);
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index e574c38797..b2804a0d07 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -320,7 +320,7 @@ discard 65536/65536 bytes at offset 0
 qcow2: Marking image as corrupt: Preallocated zero cluster offset 0x2a00 unaligned (guest offset: 0); further corruption events will be suppressed
 write failed: Input/output error
 --- Repairing ---
-Repairing offset=2a00: Preallocated zero cluster is not properly aligned; L2 entry corrupted.
+Repairing offset=2a00: Preallocated cluster is not properly aligned; L2 entry corrupted.
 The following inconsistencies were found and repaired:
 
     0 leaked clusters
-- 
2.26.2


