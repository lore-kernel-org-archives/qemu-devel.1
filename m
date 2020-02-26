Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URG_BIZ autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B5BC4BA13
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DCE321556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MtRXZZEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCE321556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6z2k-0007R3-M6
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 10:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j6z0N-0002ji-TV
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j6z0M-0002s8-Du
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:53:47 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47211
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j6z0M-0002q5-8X
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582732425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wb2tpZhcNHuK86Bu9rarf6gO7w2/fY5IC7TQBrIOsrs=;
 b=MtRXZZExh5uFpieDDGMY94YwXNIXeCdFbzAdUPsThsoaUdBd3ulk9Lk8/OemVqRIkQqg9u
 xbWlQ/L9rQrfobAz+toGeKducU+XBr2+DmMyUIdDjL9/3qouP6Xpcl4+24eFDETO7W7FaT
 JGH12reXfgkVki1ETUjquzwKjyHCu+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-1YkChqa4PeKK6jC8JBcsKA-1; Wed, 26 Feb 2020 10:53:44 -0500
X-MC-Unique: 1YkChqa4PeKK6jC8JBcsKA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B69B8018CE;
 Wed, 26 Feb 2020 15:53:43 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-196.ams2.redhat.com [10.36.117.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EA4A100E7E3;
 Wed, 26 Feb 2020 15:53:40 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/13] migration/ram: Handle RAM block resizes during
 precopy
Date: Wed, 26 Feb 2020 16:52:56 +0100
Message-Id: <20200226155304.60219-6-david@redhat.com>
In-Reply-To: <20200226155304.60219-1-david@redhat.com>
References: <20200226155304.60219-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
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
index 3ee1498761..d30a5d297a 100644
--- a/exec.c
+++ b/exec.c
@@ -2069,8 +2069,9 @@ static int memory_try_enable_merging(void *addr, size=
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
index 1614d9a02c..b9b9470a56 100644
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
index 8fb68795dc..ac9751dbe5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -175,13 +175,18 @@ void migration_object_init(void)
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
@@ -2019,7 +2024,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
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
index 8473ddfc88..79fd74afa5 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -343,5 +343,6 @@ int foreach_not_ignored_block(RAMBlockIterFunc func, vo=
id *opaque);
 void migration_make_urgent_request(void);
 void migration_consume_urgent_request(void);
 bool migration_rate_limit(void);
+void migration_cancel(void);
=20
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index ed23ed1c7c..39c7d1c4a6 100644
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
@@ -3710,8 +3711,38 @@ static SaveVMHandlers savevm_ram_handlers =3D {
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
2.24.1


