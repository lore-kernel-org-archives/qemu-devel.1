Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AA8C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B8072081C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8072081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1Qq-0001TL-6M
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54079)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hn1P9-0002Wp-8S
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hn1P8-0003Uf-5D
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:52:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50162)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hn1P7-0003UO-W2
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:52:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4D98E30842AC;
 Mon, 15 Jul 2019 13:52:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 355615D772;
 Mon, 15 Jul 2019 13:52:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 15:51:15 +0200
Message-Id: <20190715135125.17770-12-quintela@redhat.com>
In-Reply-To: <20190715135125.17770-1-quintela@redhat.com>
References: <20190715135125.17770-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 15 Jul 2019 13:52:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/21] memory: Pass mr into
 snapshot_and_clear_dirty
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm@vger.kernel.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

Also we change the 2nd parameter of it to be the relative offset
within the memory region. This is to be used in follow up patches.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20190603065056.25211-6-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 exec.c                  | 3 ++-
 include/exec/ram_addr.h | 2 +-
 memory.c                | 3 +--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index 50ea9c5aaa..3a00698cc0 100644
--- a/exec.c
+++ b/exec.c
@@ -1390,9 +1390,10 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_=
addr_t start,
 }
=20
 DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
-     (ram_addr_t start, ram_addr_t length, unsigned client)
+    (MemoryRegion *mr, hwaddr offset, hwaddr length, unsigned client)
 {
     DirtyMemoryBlocks *blocks;
+    ram_addr_t start =3D memory_region_get_ram_addr(mr) + offset;
     unsigned long align =3D 1UL << (TARGET_PAGE_BITS + BITS_PER_LEVEL);
     ram_addr_t first =3D QEMU_ALIGN_DOWN(start, align);
     ram_addr_t last  =3D QEMU_ALIGN_UP(start + length, align);
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 0a532c3963..1843b6f2d3 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -404,7 +404,7 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_add=
r_t start,
                                               unsigned client);
=20
 DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
-    (ram_addr_t start, ram_addr_t length, unsigned client);
+    (MemoryRegion *mr, hwaddr offset, hwaddr length, unsigned client);
=20
 bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
                                             ram_addr_t start,
diff --git a/memory.c b/memory.c
index 93486a71d7..71fcaf2d00 100644
--- a/memory.c
+++ b/memory.c
@@ -2071,8 +2071,7 @@ DirtyBitmapSnapshot *memory_region_snapshot_and_cle=
ar_dirty(MemoryRegion *mr,
 {
     assert(mr->ram_block);
     memory_region_sync_dirty_bitmap(mr);
-    return cpu_physical_memory_snapshot_and_clear_dirty(
-                memory_region_get_ram_addr(mr) + addr, size, client);
+    return cpu_physical_memory_snapshot_and_clear_dirty(mr, addr, size, =
client);
 }
=20
 bool memory_region_snapshot_get_dirty(MemoryRegion *mr, DirtyBitmapSnaps=
hot *snap,
--=20
2.21.0


