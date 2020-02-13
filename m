Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E16AC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 17:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4966D206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 17:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1rG5SJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4966D206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2IB9-0007eZ-Gj
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 12:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j2IAI-000724-Nx
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:20:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j2IAE-0007m6-VR
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:20:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33141
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j2IAE-0007hF-Ev
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581614432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TyKS8NmY79nY+30otfP1CmwSxMaLKzfk5QbHs4u8f+k=;
 b=Q1rG5SJgpvA6j5AJzDROI7tT0nGUUcCOi7eZkox67dJo5Jhci0c5EQ66U2qdbmbV6nzfnV
 wTHKQKESOauTjpJxFdmS9jEJ2lMmNeHGpEICvUgptMmMpWCBrtRysureglnctKbrWeUH4e
 9x0E21ajp+iZvs01WelIDs19FviKGeg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243--8UAPMSVMZKVMM3TMzN07Q-1; Thu, 13 Feb 2020 12:20:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4375800D41;
 Thu, 13 Feb 2020 17:20:29 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-120.ams2.redhat.com [10.36.117.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 373645D9E5;
 Thu, 13 Feb 2020 17:20:17 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC] memory: Don't allow to resize RAM while migrating
Date: Thu, 13 Feb 2020 18:20:16 +0100
Message-Id: <20200213172016.196609-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: -8UAPMSVMZKVMM3TMzN07Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Juan Quintela <quintela@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Resizing while migrating is dangerous and does not work as expected.
The whole migration code works on the usable_length of ram blocks and does
not expect this to change at random points in time.

Precopy: The ram block size must not change on the source, after
ram_save_setup(), so as long as the guest is still running on the source.

Postcopy: The ram block size must not change on the target, after
synchronizing the RAM block list (ram_load_precopy()).

AFAIKS, resizing can be trigger *after* (but not during) a reset in
ACPI code by the guest
- hw/arm/virt-acpi-build.c:acpi_ram_update()
- hw/i386/acpi-build.c:acpi_ram_update()

I see no easy way to work around this. Fail hard instead of failing
somewhere in migration code due to strange other reasons. AFAIKs, the
rebuilts will be triggered during reboot, so this should not affect
running guests, but only guests that reboot at a very bad time and
actually require size changes.

Let's further limit the impact by checking if an actual resize of the
RAM (in number of pages) is required.

Don't perform the checks in qemu_ram_resize(), as that's called during
migration when syncing the used_length. Update documentation.

Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Shannon Zhao <shannon.zhao@linaro.org>
Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Juan Quintela <quintela@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

Any idea how to avoid killing the guest? Anything obvious I am missing?

---
 exec.c                |  6 ++++--
 include/exec/memory.h | 11 +++++++----
 memory.c              | 12 ++++++++++++
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/exec.c b/exec.c
index 67e520d18e..faa6708414 100644
--- a/exec.c
+++ b/exec.c
@@ -2116,8 +2116,10 @@ static int memory_try_enable_merging(void *addr, siz=
e_t len)
     return qemu_madvise(addr, len, QEMU_MADV_MERGEABLE);
 }
=20
-/* Only legal before guest might have detected the memory size: e.g. on
- * incoming migration, or right after reset.
+/*
+ * RAM must not be resized while migration is active (except from migratio=
n
+ * code). Care has to be taken if the guest might have already detected
+ * the memory.
  *
  * As memory core doesn't know how is memory accessed, it is up to
  * resize callback to update device state and/or add assertions to detect
diff --git a/include/exec/memory.h b/include/exec/memory.h
index e85b7de99a..1e5bfbe805 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -113,7 +113,8 @@ typedef struct IOMMUNotifier IOMMUNotifier;
 #define RAM_SHARED     (1 << 1)
=20
 /* Only a portion of RAM (used_length) is actually used, and migrated.
- * This used_length size can change across reboots.
+ * RAM must not be resized while migration is active (except from migratio=
n
+ * code).
  */
 #define RAM_RESIZEABLE (1 << 2)
=20
@@ -843,7 +844,8 @@ void memory_region_init_ram_shared_nomigrate(MemoryRegi=
on *mr,
  *                                     RAM.  Accesses into the region will
  *                                     modify memory directly.  Only an in=
itial
  *                                     portion of this RAM is actually use=
d.
- *                                     The used size can change across reb=
oots.
+ *                                     The size must not change while migr=
ation
+ *                                     is active.
  *
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
@@ -1464,8 +1466,9 @@ void *memory_region_get_ram_ptr(MemoryRegion *mr);
=20
 /* memory_region_ram_resize: Resize a RAM region.
  *
- * Only legal before guest might have detected the memory size: e.g. on
- * incoming migration, or right after reset.
+ * RAM must not be resized while migration is active (except from migratio=
n
+ * code). Care has to be taken if the guest might have already detected
+ * the memory.
  *
  * @mr: a memory region created with @memory_region_init_resizeable_ram.
  * @newsize: the new size the region
diff --git a/memory.c b/memory.c
index aeaa8dcc9e..7fa048aa3a 100644
--- a/memory.c
+++ b/memory.c
@@ -34,6 +34,7 @@
 #include "sysemu/accel.h"
 #include "hw/boards.h"
 #include "migration/vmstate.h"
+#include "migration/misc.h"
=20
 //#define DEBUG_UNASSIGNED
=20
@@ -2204,6 +2205,17 @@ void memory_region_ram_resize(MemoryRegion *mr, ram_=
addr_t newsize, Error **errp
 {
     assert(mr->ram_block);
=20
+    /*
+     * Resizing RAM while migrating is not possible, as the used_length of
+     * RAM blocks must neither change on the source (precopy), nor on the
+     * target (postcopy) as long as migration code is active.
+     */
+    if (HOST_PAGE_ALIGN(newsize) !=3D mr->ram_block->used_length &&
+        !migration_is_idle()) {
+        error_setg(errp, "Cannot resize RAM while migrating.");
+        return;
+    }
+
     qemu_ram_resize(mr->ram_block, newsize, errp);
 }
=20
--=20
2.24.1


