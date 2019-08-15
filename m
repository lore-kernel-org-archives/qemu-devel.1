Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59244C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C97320578
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C97320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyIwC-0000O8-IG
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hyIjU-0002Iy-Uh
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hyIjQ-0002x4-VY
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hyIjQ-0002wq-QY
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 271C7308404E;
 Thu, 15 Aug 2019 16:36:08 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-19.ams2.redhat.com
 [10.36.117.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82DEE3737;
 Thu, 15 Aug 2019 16:36:00 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 17:34:46 +0100
Message-Id: <20190815163504.18937-16-dgilbert@redhat.com>
In-Reply-To: <20190815163504.18937-1-dgilbert@redhat.com>
References: <20190815163504.18937-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 15 Aug 2019 16:36:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 15/33] migration: just pass RAMBlock is enough
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
Cc: quintela@redhat.com, yury-kotov@yandex-team.ru,
 richardw.yang@linux.intel.com, marcandre.lureau@redhat.com,
 ivanren@tencent.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

RAMBlock->used_length is always passed to migration_bitmap_sync_range(),
which could be retrieved from RAMBlock.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190718012547.16373-1-richardw.yang@linux.intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 255f289bbb..97f241d6d9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1748,11 +1748,10 @@ static inline bool migration_bitmap_clear_dirty(R=
AMState *rs,
 }
=20
 /* Called with RCU critical section */
-static void migration_bitmap_sync_range(RAMState *rs, RAMBlock *rb,
-                                        ram_addr_t length)
+static void migration_bitmap_sync_range(RAMState *rs, RAMBlock *rb)
 {
     rs->migration_dirty_pages +=3D
-        cpu_physical_memory_sync_dirty_bitmap(rb, 0, length,
+        cpu_physical_memory_sync_dirty_bitmap(rb, 0, rb->used_length,
                                               &rs->num_dirty_pages_perio=
d);
 }
=20
@@ -1841,7 +1840,7 @@ static void migration_bitmap_sync(RAMState *rs)
     qemu_mutex_lock(&rs->bitmap_mutex);
     rcu_read_lock();
     RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-        migration_bitmap_sync_range(rs, block, block->used_length);
+        migration_bitmap_sync_range(rs, block);
     }
     ram_counters.remaining =3D ram_bytes_remaining();
     rcu_read_unlock();
@@ -4293,7 +4292,7 @@ static void colo_flush_ram_cache(void)
     memory_global_dirty_log_sync();
     rcu_read_lock();
     RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-        migration_bitmap_sync_range(ram_state, block, block->used_length=
);
+        migration_bitmap_sync_range(ram_state, block);
     }
     rcu_read_unlock();
=20
--=20
2.21.0


