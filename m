Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URG_BIZ,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A78EC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4623B206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFXt8OHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4623B206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQoiN-0002zY-Dz
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 04:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jQofN-0007R0-84
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jQofM-0000kO-GI
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:54:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20851
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jQofM-0000iE-1i
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587459243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0BUY+7AyduGiq5cIOvaaefFtBjl39KV3uCDOFF0Z35g=;
 b=TFXt8OHuzoS5Bt5k/r8fqn+tnwf4ZVkrLsECreP7jQ32vLlNEfjfi2Ve1A0XgZlThfxZx/
 6dctE3xWL/ynJehVcs8vhz+iiNoLcCaYAM7DOnqWqQ+6trwF+3o/dHd+JFdJPj0ogVg2WI
 r3GLomT61L2wY8GxsX2+ANiQYYAqTiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-yY0SrPaZNQWrccMZDPpslQ-1; Tue, 21 Apr 2020 04:54:01 -0400
X-MC-Unique: yY0SrPaZNQWrccMZDPpslQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68A15107ACC7;
 Tue, 21 Apr 2020 08:54:00 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-245.ams2.redhat.com [10.36.113.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97F1A100E7E3;
 Tue, 21 Apr 2020 08:53:57 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/13] migration/ram: Handle RAM block resizes during
 precopy
Date: Tue, 21 Apr 2020 10:52:52 +0200
Message-Id: <20200421085300.7734-6-david@redhat.com>
In-Reply-To: <20200421085300.7734-1-david@redhat.com>
References: <20200421085300.7734-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Shannon Zhao <shannon.zhao@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Resizing while migrating is dangerous and does not work as expected.
The whole migration code works on the usable_length of ram blocks and does
not expect this to change at random points in time.

In the case of precopy, the ram block size must not change on the source,
after syncing the RAM block list in ram_save_setup(), so as long as the
guest is still running on the source.

Resizing can be trigger *after* (but not during) a reset in
ACPI code by the guest
- hw/arm/virt-acpi-build.c:acpi_ram_update()
- hw/i386/acpi-build.c:acpi_ram_update()

Use the ram block notifier to get notified about resizes. Let's simply
cancel migration and indicate the reason. We'll continue running on the
source. No harm done.

Update the documentation. Postcopy will be handled separately.

Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Shannon Zhao <shannon.zhao@linaro.org>
Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 exec.c                |  5 +++--
 include/exec/memory.h | 10 ++++++----
 migration/migration.c |  9 +++++++--
 migration/migration.h |  1 +
 migration/ram.c       | 31 +++++++++++++++++++++++++++++++
 5 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/exec.c b/exec.c
index 83304e51c6..78dfab6ec6 100644
--- a/exec.c
+++ b/exec.c
@@ -2070,8 +2070,9 @@ static int memory_try_enable_merging(void *addr, size=
_t len)
     return qemu_madvise(addr, len, QEMU_MADV_MERGEABLE);
 }
=20
-/* Only legal before guest might have detected the memory size: e.g. on
- * incoming migration, or right after reset.
+/*
+ * Resizing RAM while migrating can result in the migration being canceled=
.
+ * Care has to be taken if the guest might have already detected the memor=
y.
  *
  * As memory core doesn't know how is memory accessed, it is up to
  * resize callback to update device state and/or add assertions to detect
diff --git a/include/exec/memory.h b/include/exec/memory.h
index e000bd2f97..23fe94d382 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -113,7 +113,7 @@ typedef struct IOMMUNotifier IOMMUNotifier;
 #define RAM_SHARED     (1 << 1)
=20
 /* Only a portion of RAM (used_length) is actually used, and migrated.
- * This used_length size can change across reboots.
+ * Resizing RAM while migrating can result in the migration being canceled=
.
  */
 #define RAM_RESIZEABLE (1 << 2)
=20
@@ -843,7 +843,9 @@ void memory_region_init_ram_shared_nomigrate(MemoryRegi=
on *mr,
  *                                     RAM.  Accesses into the region will
  *                                     modify memory directly.  Only an in=
itial
  *                                     portion of this RAM is actually use=
d.
- *                                     The used size can change across reb=
oots.
+ *                                     Changing the size while migrating
+ *                                     can result in the migration being
+ *                                     canceled.
  *
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
@@ -1464,8 +1466,8 @@ void *memory_region_get_ram_ptr(MemoryRegion *mr);
=20
 /* memory_region_ram_resize: Resize a RAM region.
  *
- * Only legal before guest might have detected the memory size: e.g. on
- * incoming migration, or right after reset.
+ * Resizing RAM while migrating can result in the migration being canceled=
.
+ * Care has to be taken if the guest might have already detected the memor=
y.
  *
  * @mr: a memory region created with @memory_region_init_resizeable_ram.
  * @newsize: the new size the region
diff --git a/migration/migration.c b/migration/migration.c
index 187ac0410c..8cc06488ed 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -181,13 +181,18 @@ void migration_object_init(void)
     }
 }
=20
+void migration_cancel(void)
+{
+    migrate_fd_cancel(current_migration);
+}
+
 void migration_shutdown(void)
 {
     /*
      * Cancel the current migration - that will (eventually)
      * stop the migration using this structure
      */
-    migrate_fd_cancel(current_migration);
+    migration_cancel();
     object_unref(OBJECT(current_migration));
 }
=20
@@ -2066,7 +2071,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
blk,
=20
 void qmp_migrate_cancel(Error **errp)
 {
-    migrate_fd_cancel(migrate_get_current());
+    migration_cancel();
 }
=20
 void qmp_migrate_continue(MigrationStatus state, Error **errp)
diff --git a/migration/migration.h b/migration/migration.h
index 507284e563..69d995a4b1 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -346,5 +346,6 @@ int foreach_not_ignored_block(RAMBlockIterFunc func, vo=
id *opaque);
 void migration_make_urgent_request(void);
 void migration_consume_urgent_request(void);
 bool migration_rate_limit(void);
+void migration_cancel(void);
=20
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index 04f13feb2e..d587ecbd92 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -52,6 +52,7 @@
 #include "migration/colo.h"
 #include "block.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "savevm.h"
 #include "qemu/iov.h"
 #include "multifd.h"
@@ -3752,8 +3753,38 @@ static SaveVMHandlers savevm_ram_handlers =3D {
     .resume_prepare =3D ram_resume_prepare,
 };
=20
+static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
+                                      size_t old_size, size_t new_size)
+{
+    ram_addr_t offset;
+    Error *err =3D NULL;
+    RAMBlock *rb =3D qemu_ram_block_from_host(host, false, &offset);
+
+    if (ramblock_is_ignored(rb)) {
+        return;
+    }
+
+    if (!migration_is_idle()) {
+        /*
+         * Precopy code on the source cannot deal with the size of RAM blo=
cks
+         * changing at random points in time - especially after sending th=
e
+         * RAM block sizes to the migration stream, they must no longer ch=
ange.
+         * Abort and indicate a proper reason.
+         */
+        error_setg(&err, "RAM block '%s' resized during precopy.", rb->ids=
tr);
+        migrate_set_error(migrate_get_current(), err);
+        error_free(err);
+        migration_cancel();
+    }
+}
+
+static RAMBlockNotifier ram_mig_ram_notifier =3D {
+    .ram_block_resized =3D ram_mig_ram_block_resized,
+};
+
 void ram_mig_init(void)
 {
     qemu_mutex_init(&XBZRLE.lock);
     register_savevm_live("ram", 0, 4, &savevm_ram_handlers, &ram_state);
+    ram_block_notifier_add(&ram_mig_ram_notifier);
 }
--=20
2.25.1


