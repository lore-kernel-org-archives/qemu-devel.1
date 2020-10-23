Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949CFC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:49:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D44D820BED
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVC1P22E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44D820BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW28H-0007Ke-Qs
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 14:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kW1wV-0001Se-Ia
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:37:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kW1wS-0001aE-RN
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603478252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hjlyrNJBhtJZwARkJVhxkHL8wl5BqWygFehP0x3+fuk=;
 b=eVC1P22ELNVCGMa/5WTW/6kGq/n3eGTqGG7RtuYZ77vmPCYYTLv6TzB/NpatMEreOMRdw6
 vDmfZifzuKAtPOs+h1+9VLKcOEt7VdWV/Vb03lN0/1+DxkzBoq/M9mCikaRu8mHIbgLZzm
 QQutz+c+j+K62RW0xKeaERkENYU0z8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-7Bvj0BmgNUSdb_ZPRx-m2g-1; Fri, 23 Oct 2020 14:37:29 -0400
X-MC-Unique: 7Bvj0BmgNUSdb_ZPRx-m2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB37A10866B3;
 Fri, 23 Oct 2020 18:37:28 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-7.phx2.redhat.com [10.3.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C13A60BFA;
 Fri, 23 Oct 2020 18:37:28 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 11/12] nbd: Expose actual depth in qemu:allocation-depth
Date: Fri, 23 Oct 2020 13:36:51 -0500
Message-Id: <20201023183652.478921-12-eblake@redhat.com>
In-Reply-To: <20201023183652.478921-1-eblake@redhat.com>
References: <20201023183652.478921-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 rjones@redhat.com, Max Reitz <mreitz@redhat.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Preserve the tri-state encoding in the low bits, as that still remains
a valuable way to utilize qemu-img map with x-dirty-bitmap for
accessing quick information without needing a third-party NBD client.
But now that the block layer gives us an actual depth, we can easily
expose it in the remaining bits of our metadata context (leaving two
bits reserved, to make it easier to read depth out of a raw hex
number).  This assumes no one runs a backing chain larger than 256M
elements.

iotest 309 remains unchanged (an example of the above-mentioned
x-dirty-bitmap hack); actually testing the new bits requires libnbd or
a similar client, and I didn't want to make iotests depend on libnbd
at this point in time; rather, see the libnbd project for interop
tests that exercise this new feature.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/interop/nbd.txt |  6 +++++-
 include/block/nbd.h  |  2 ++
 nbd/server.c         | 27 +++++++++++++++------------
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
index 7e948bd42218..d90723ffe991 100644
--- a/docs/interop/nbd.txt
+++ b/docs/interop/nbd.txt
@@ -34,7 +34,8 @@ the image, with a single metadata context named:

     qemu:allocation-depth

-In the allocation depth context, bits 0 and 1 form a tri-state value:
+In the allocation depth context, bits 0 and 1 form a tri-state value,
+along with 28 bits giving an actual depth:

     bits 0-1: 00: NBD_STATE_DEPTH_UNALLOC, the extent is unallocated
               01: NBD_STATE_DEPTH_LOCAL, the extent is allocated in the
@@ -42,6 +43,9 @@ In the allocation depth context, bits 0 and 1 form a tri-state value:
               10: NBD_STATE_DEPTH_BACKING, the extent is inherited from a
                   backing layer
               11: invalid, never returned
+    bits 2-3: reserved, always 0
+    bits 4-31: NBD_STATE_DEPTH_RAW, the backing layer depth (0 if
+               UNALLOC, 1 for LOCAL, 2 or more for BACKING)

 For NBD_OPT_LIST_META_CONTEXT the following queries are supported
 in addition to the specific "qemu:allocation-depth" and
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 956687f5c368..3c0692aec642 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -264,6 +264,8 @@ enum {
 #define NBD_STATE_DEPTH_UNALLOC      0x0
 #define NBD_STATE_DEPTH_LOCAL        0x1
 #define NBD_STATE_DEPTH_BACKING      0x2
+#define NBD_STATE_DEPTH_RAW_MASK     0xfffffff0
+#define NBD_STATE_DEPTH_RAW_SHIFT    4

 static inline bool nbd_reply_type_is_error(int type)
 {
diff --git a/nbd/server.c b/nbd/server.c
index 53526090b0a2..afa79e63a7a6 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2037,22 +2037,25 @@ static int blockalloc_to_extents(BlockDriverState *bs, uint64_t offset,
     while (bytes) {
         uint32_t flags;
         int64_t num;
-        int ret = bdrv_is_allocated(bs, offset, bytes, &num);
+        int depth = bdrv_is_allocated_above(bs, NULL, false, offset, bytes,
+                                            &num);

-        if (ret < 0) {
-            return ret;
-        }
-
-        if (ret == 1) {
+        switch (depth) {
+        case 0:
+            flags = NBD_STATE_DEPTH_UNALLOC;
+            break;
+        case 1:
             flags = NBD_STATE_DEPTH_LOCAL;
-        } else {
-            ret = bdrv_is_allocated_above(bs, NULL, false, offset, num,
-                                          &num);
-            if (ret < 0) {
-                return ret;
+            break;
+        default:
+            if (depth < 0) {
+                return depth;
             }
-            flags = ret ? NBD_STATE_DEPTH_BACKING : NBD_STATE_DEPTH_UNALLOC;
+            flags = NBD_STATE_DEPTH_BACKING;
+            break;
         }
+        assert(depth <= UINT32_MAX >> NBD_STATE_DEPTH_RAW_SHIFT);
+        flags |= depth << NBD_STATE_DEPTH_RAW_SHIFT;

         if (nbd_extent_array_add(ea, num, flags) < 0) {
             return 0;
-- 
2.29.0


