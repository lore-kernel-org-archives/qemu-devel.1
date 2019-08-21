Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC9FC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622E122D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622E122D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Ujk-0000g9-4A
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPi-00071v-6o
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPg-0005VR-U2
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30267)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0UPg-0005Un-OI
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 072FD180158C
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 17:28:48 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EEB960E1C;
 Wed, 21 Aug 2019 17:28:44 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 19:28:18 +0200
Message-Id: <1566408501-48680-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
References: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Wed, 21 Aug 2019 17:28:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/13] memory: Remove has_coalesced_range counter
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
Cc: Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

The has_coalesced_range could potentially be problematic in that it
only works for additions of coalesced mmio ranges but not deletions.
The reason is that has_coalesced_range information can be lost when
the FlatView updates the topology again when the updated region is not
covering the coalesced regions. When that happens, due to
flatrange_equal() is not checking against has_coalesced_range, the new
FlatRange will be seen as the same one as the old and the new
instance (whose has_coalesced_range will be zero) will replace the old
instance (whose has_coalesced_range _could_ be non-zero).

The counter was originally used to make sure every FlatRange will only
notify once for coalesced_io_{add|del} memory listeners, because each
FlatRange can be used by multiple address spaces, so logically
speaking it could be called multiple times.  However we should not
limit that, because memory listeners should will only be registered
with specific address space rather than multiple address spaces.

So let's fix this up by simply removing the whole has_coalesced_range.

Fixes: 3ac7d43a6fbb5d4a3
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190820141328.10009-3-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/memory.c b/memory.c
index 7124274..6e4b06e 100644
--- a/memory.c
+++ b/memory.c
@@ -217,7 +217,6 @@ struct FlatRange {
     bool romd_mode;
     bool readonly;
     bool nonvolatile;
-    int has_coalesced_range;
 };
 
 #define FOR_EACH_FLAT_RANGE(var, view)          \
@@ -654,7 +653,6 @@ static void render_memory_region(FlatView *view,
     fr.romd_mode = mr->romd_mode;
     fr.readonly = readonly;
     fr.nonvolatile = nonvolatile;
-    fr.has_coalesced_range = 0;
 
     /* Render the region itself into any gaps left by the current view. */
     for (i = 0; i < view->nr && int128_nz(remain); ++i) {
@@ -888,14 +886,6 @@ static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
 {
     CoalescedMemoryRange *cmr;
 
-    if (!fr->has_coalesced_range) {
-        return;
-    }
-
-    if (--fr->has_coalesced_range > 0) {
-        return;
-    }
-
     QTAILQ_FOREACH(cmr, &fr->mr->coalesced, link) {
         flat_range_coalesced_io_notify(fr, as, cmr, false);
     }
@@ -910,10 +900,6 @@ static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
         return;
     }
 
-    if (fr->has_coalesced_range++) {
-        return;
-    }
-
     QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
         flat_range_coalesced_io_notify(fr, as, cmr, true);
     }
-- 
1.8.3.1



