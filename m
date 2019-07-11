Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6010C74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 10:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BECFC206B8
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 10:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECFC206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlWi2-0000sx-1v
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 06:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45600)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hlWev-0004UE-8c
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hlWeu-0004Fu-2T
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:50:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hlWet-0004Ek-QT
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:50:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 038883082E46;
 Thu, 11 Jul 2019 10:44:45 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE4BF60600;
 Thu, 11 Jul 2019 10:44:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 12:44:03 +0200
Message-Id: <20190711104412.31233-11-quintela@redhat.com>
In-Reply-To: <20190711104412.31233-1-quintela@redhat.com>
References: <20190711104412.31233-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 11 Jul 2019 10:44:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/19] memory: Don't set migration bitmap when
 without migration
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

Similar to 9460dee4b2 ("memory: do not touch code dirty bitmap unless
TCG is enabled", 2015-06-05) but for the migration bitmap - we can
skip the MIGRATION bitmap update if migration not enabled.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190603065056.25211-4-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/exec/memory.h   |  2 ++
 include/exec/ram_addr.h | 12 +++++++++++-
 memory.c                |  2 +-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 2c5cdffa31..70d6f7e451 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -46,6 +46,8 @@
         OBJECT_GET_CLASS(IOMMUMemoryRegionClass, (obj), \
                          TYPE_IOMMU_MEMORY_REGION)
=20
+extern bool global_dirty_log;
+
 typedef struct MemoryRegionOps MemoryRegionOps;
 typedef struct MemoryRegionMmio MemoryRegionMmio;
=20
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 44dcc98de6..0a532c3963 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -349,8 +349,13 @@ static inline void cpu_physical_memory_set_dirty_leb=
itmap(unsigned long *bitmap,
             if (bitmap[k]) {
                 unsigned long temp =3D leul_to_cpu(bitmap[k]);
=20
-                atomic_or(&blocks[DIRTY_MEMORY_MIGRATION][idx][offset], =
temp);
                 atomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
+
+                if (global_dirty_log) {
+                    atomic_or(&blocks[DIRTY_MEMORY_MIGRATION][idx][offse=
t],
+                              temp);
+                }
+
                 if (tcg_enabled()) {
                     atomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset], t=
emp);
                 }
@@ -367,6 +372,11 @@ static inline void cpu_physical_memory_set_dirty_leb=
itmap(unsigned long *bitmap,
         xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
     } else {
         uint8_t clients =3D tcg_enabled() ? DIRTY_CLIENTS_ALL : DIRTY_CL=
IENTS_NOCODE;
+
+        if (!global_dirty_log) {
+            clients &=3D ~(1 << DIRTY_MEMORY_MIGRATION);
+        }
+
         /*
          * bitmap-traveling is faster than memory-traveling (for addr...=
)
          * especially when most of the memory is not dirty.
diff --git a/memory.c b/memory.c
index 480f3d989b..93486a71d7 100644
--- a/memory.c
+++ b/memory.c
@@ -38,7 +38,7 @@
 static unsigned memory_region_transaction_depth;
 static bool memory_region_update_pending;
 static bool ioeventfd_update_pending;
-static bool global_dirty_log =3D false;
+bool global_dirty_log;
=20
 static QTAILQ_HEAD(, MemoryListener) memory_listeners
     =3D QTAILQ_HEAD_INITIALIZER(memory_listeners);
--=20
2.21.0


