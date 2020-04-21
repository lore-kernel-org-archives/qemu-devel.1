Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1D0C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:04:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FC472070B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQGhlJ5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC472070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQopf-00053e-7Q
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 05:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jQofr-00081r-Cw
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:54:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jQofn-0001SV-FN
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:54:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51130
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jQofn-0001QY-2r
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587459270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J9A5ZoTaU0j1lTzJPOgWHNA44PHHOKwC0K9ma1Qy9y8=;
 b=CQGhlJ5upbLIPBhlWy5dPuazIHSM/jd0w6K8QWEaBAOpnZ44ULygV9lpNp/aB42nQEhVJd
 eKRF6ncFiPTydvXkZO8Hmeaz+lSJFp43t+IQLfT3X+kvccFwn9MBlKMb+q21KZv02bHtk9
 3t0TJ7UsVBPlFrrgrp0GjrTfBcMGnXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-fHfnHR-uOMSlolH7VsE3aw-1; Tue, 21 Apr 2020 04:54:28 -0400
X-MC-Unique: fHfnHR-uOMSlolH7VsE3aw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 500A413FB;
 Tue, 21 Apr 2020 08:54:27 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-245.ams2.redhat.com [10.36.113.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88E041001B30;
 Tue, 21 Apr 2020 08:54:24 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/13] migration/ram: Handle RAM block resizes during
 postcopy
Date: Tue, 21 Apr 2020 10:52:57 +0200
Message-Id: <20200421085300.7734-11-david@redhat.com>
In-Reply-To: <20200421085300.7734-1-david@redhat.com>
References: <20200421085300.7734-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 01:28:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

In the case of postcopy, relying on used_length is racy as soon as the
guest is running. Also, when used_length changes we might leave the
uffd handler registered for some memory regions, reject valid pages
when migrating and fail when sending the recv bitmap to the source.

Resizing can be trigger *after* (but not during) a reset in
ACPI code by the guest
- hw/arm/virt-acpi-build.c:acpi_ram_update()
- hw/i386/acpi-build.c:acpi_ram_update()

Let's remember the original used_length in a separate variable and
use it in relevant postcopy code. Make sure to update it when we resize
during precopy, when synchronizing the RAM block sizes with the source.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
 include/exec/ramblock.h  | 10 ++++++++++
 migration/postcopy-ram.c | 15 ++++++++++++---
 migration/ram.c          | 11 +++++++++--
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 07d50864d8..664701b759 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -59,6 +59,16 @@ struct RAMBlock {
      */
     unsigned long *clear_bmap;
     uint8_t clear_bmap_shift;
+
+    /*
+     * RAM block length that corresponds to the used_length on the migrati=
on
+     * source (after RAM block sizes were synchronized). Especially, after
+     * starting to run the guest, used_length and postcopy_length can diff=
er.
+     * Used to register/unregister uffd handlers and as the size of the re=
ceived
+     * bitmap. Receiving any page beyond this length will bail out, as it
+     * could not have been valid on the source.
+     */
+    ram_addr_t postcopy_length;
 };
 #endif
 #endif
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index a36402722b..c68caf4e42 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -17,6 +17,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/rcu.h"
 #include "exec/target_page.h"
 #include "migration.h"
 #include "qemu-file.h"
@@ -31,6 +32,7 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "hw/boards.h"
+#include "exec/ramblock.h"
=20
 /* Arbitrary limit on size of each discard command,
  * keeps them around ~200 bytes
@@ -456,6 +458,13 @@ static int init_range(RAMBlock *rb, void *opaque)
     ram_addr_t length =3D qemu_ram_get_used_length(rb);
     trace_postcopy_init_range(block_name, host_addr, offset, length);
=20
+    /*
+     * Save the used_length before running the guest. In case we have to
+     * resize RAM blocks when syncing RAM block sizes from the source duri=
ng
+     * precopy, we'll update it manually via the ram block notifier.
+     */
+    rb->postcopy_length =3D length;
+
     /*
      * We need the whole of RAM to be truly empty for postcopy, so things
      * like ROMs and any data tables built during init must be zero'd
@@ -478,7 +487,7 @@ static int cleanup_range(RAMBlock *rb, void *opaque)
     const char *block_name =3D qemu_ram_get_idstr(rb);
     void *host_addr =3D qemu_ram_get_host_addr(rb);
     ram_addr_t offset =3D qemu_ram_get_offset(rb);
-    ram_addr_t length =3D qemu_ram_get_used_length(rb);
+    ram_addr_t length =3D rb->postcopy_length;
     MigrationIncomingState *mis =3D opaque;
     struct uffdio_range range_struct;
     trace_postcopy_cleanup_range(block_name, host_addr, offset, length);
@@ -600,7 +609,7 @@ static int nhp_range(RAMBlock *rb, void *opaque)
     const char *block_name =3D qemu_ram_get_idstr(rb);
     void *host_addr =3D qemu_ram_get_host_addr(rb);
     ram_addr_t offset =3D qemu_ram_get_offset(rb);
-    ram_addr_t length =3D qemu_ram_get_used_length(rb);
+    ram_addr_t length =3D rb->postcopy_length;
     trace_postcopy_nhp_range(block_name, host_addr, offset, length);
=20
     /*
@@ -644,7 +653,7 @@ static int ram_block_enable_notify(RAMBlock *rb, void *=
opaque)
     struct uffdio_register reg_struct;
=20
     reg_struct.range.start =3D (uintptr_t)qemu_ram_get_host_addr(rb);
-    reg_struct.range.len =3D qemu_ram_get_used_length(rb);
+    reg_struct.range.len =3D rb->postcopy_length;
     reg_struct.mode =3D UFFDIO_REGISTER_MODE_MISSING;
=20
     /* Now tell our userfault_fd that it's responsible for this area */
diff --git a/migration/ram.c b/migration/ram.c
index 7eca3165c8..f03bc84692 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -244,7 +244,7 @@ int64_t ramblock_recv_bitmap_send(QEMUFile *file,
         return -1;
     }
=20
-    nbits =3D block->used_length >> TARGET_PAGE_BITS;
+    nbits =3D block->postcopy_length >> TARGET_PAGE_BITS;
=20
     /*
      * Make sure the tmp bitmap buffer is big enough, e.g., on 32bit
@@ -3184,7 +3184,13 @@ static int ram_load_postcopy(QEMUFile *f)
                 break;
             }
=20
-            if (!offset_in_ramblock(block, addr)) {
+            /*
+             * Relying on used_length is racy and can result in false posi=
tives.
+             * We might place pages beyond used_length in case RAM was shr=
unk
+             * while in postcopy, which is fine - trying to place via
+             * UFFDIO_COPY/UFFDIO_ZEROPAGE will never segfault.
+             */
+            if (!block->host || addr >=3D block->postcopy_length) {
                 error_report("Illegal RAM offset " RAM_ADDR_FMT, addr);
                 ret =3D -EINVAL;
                 break;
@@ -3799,6 +3805,7 @@ static void ram_mig_ram_block_resized(RAMBlockNotifie=
r *n, void *host,
                              rb->idstr);
             }
         }
+        rb->postcopy_length =3D new_size;
         break;
     case POSTCOPY_INCOMING_NONE:
     case POSTCOPY_INCOMING_RUNNING:
--=20
2.25.1


