Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385DAC1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC43020724
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqE63U5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC43020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQXA-0005er-34
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jCQTE-0003do-92
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jCQTC-0008V8-JF
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:14:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37590
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jCQTC-0008UC-Fo
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584029641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7Ux+hft2bjNmRhZXzv82rPU0Rif6f5eByKMYnOSff8=;
 b=RqE63U5of2v5diiwBTFXraDE1Sb8gNn6WXhMiKPc9LWXbifh0TfanPO0uoYv0/7PsLV9q+
 olXWwYzfuU/I403zSM2bzN5Ro5g7ohnI8xoEk9nGFKSgwobXXrNiNexbwKJUgGYfEEWdEV
 fImBbK/dOB3GhKxbpzLacYdYi9RK+KI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-3x4XsIjyO7-VY86DMSwXEQ-1; Thu, 12 Mar 2020 12:13:54 -0400
X-MC-Unique: 3x4XsIjyO7-VY86DMSwXEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA464109A5B1;
 Thu, 12 Mar 2020 16:13:53 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-131.ams2.redhat.com [10.36.117.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD55B5C1B5;
 Thu, 12 Mar 2020 16:13:34 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFCv2 3/4] memory: Add region_resize() callback to memory
 notifier
Date: Thu, 12 Mar 2020 17:12:16 +0100
Message-Id: <20200312161217.3590-4-david@redhat.com>
In-Reply-To: <20200312161217.3590-1-david@redhat.com>
References: <20200312161217.3590-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-s390x@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's provide a way for memory notifiers to get notified about a resize.
If the region_resize() callback is not implemented by a notifier, we
mimic the old behavior by removing the old section and adding the
new, resized section.

This callback is helpful when backends (like KVM) want to implement
atomic resizes of memory sections (e.g., resize while VCPUs are running and
using the section).

For now, we won't bother about a resize() callback for coalesced MMIO
regions. The main future use case is for virtio-mem to resize ram memory
regions while the guest is running.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/exec/memory.h | 18 +++++++++++
 memory.c              | 72 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 74805dd448..704eb64d75 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -492,6 +492,24 @@ struct MemoryListener {
      */
     void (*region_nop)(MemoryListener *listener, MemoryRegionSection *sect=
ion);
=20
+    /**
+     * @region_resize:
+     *
+     * Called during an address space update transaction,
+     * for a section of the address space that is in the same place in the
+     * address space as in the last transaction, however, the size changed=
.
+     * Dirty memory logging can change as well.
+     *
+     * Note: If this callback is not implemented, the resize is communicat=
ed
+     *       via a region_del(), followed by a region_add() instead.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The old #MemoryRegionSection.
+     * @new: The new size.
+     */
+    void (*region_resize)(MemoryListener *listener,
+                          MemoryRegionSection *section, Int128 new);
+
     /**
      * @log_start:
      *
diff --git a/memory.c b/memory.c
index 09be40edd2..097b0db0e4 100644
--- a/memory.c
+++ b/memory.c
@@ -246,6 +246,17 @@ static bool flatrange_equal(FlatRange *a, FlatRange *b=
)
         && a->nonvolatile =3D=3D b->nonvolatile;
 }
=20
+static bool flatrange_resized(FlatRange *a, FlatRange *b)
+{
+    return a->mr =3D=3D b->mr
+        && int128_eq(a->addr.start, b->addr.start)
+        && int128_ne(a->addr.size, b->addr.size)
+        && a->offset_in_region =3D=3D b->offset_in_region
+        && a->romd_mode =3D=3D b->romd_mode
+        && a->readonly =3D=3D b->readonly
+        && a->nonvolatile =3D=3D b->nonvolatile;
+}
+
 static FlatView *flatview_new(MemoryRegion *mr_root)
 {
     FlatView *view;
@@ -887,6 +898,45 @@ static void flat_range_coalesced_io_add(FlatRange *fr,=
 AddressSpace *as)
     }
 }
=20
+static void memory_listener_resize_region(FlatRange *fr, AddressSpace *as,
+                                          Int128 new, bool adding)
+{
+    FlatView *as_view =3D address_space_to_flatview(as);
+    MemoryRegionSection old_mrs =3D section_from_flat_range(fr, as_view);
+    MemoryRegionSection new_mrs =3D old_mrs;
+    MemoryListener *listener;
+
+    new_mrs.size =3D new;
+
+    if (adding) {
+        QTAILQ_FOREACH(listener, &as->listeners, link_as) {
+            if (listener->region_resize) {
+                /* Grow in the adding phase. */
+                if (int128_lt(fr->addr.size, new)) {
+                    listener->region_resize(listener, &old_mrs, new);
+                }
+                continue;
+            }
+            if (listener->region_add) {
+                listener->region_add(listener, &new_mrs);
+            }
+        }
+    } else {
+        QTAILQ_FOREACH_REVERSE(listener, &as->listeners, link_as) {
+            if (listener->region_resize) {
+                /* Shrink in the removal phase. */
+                if (int128_gt(fr->addr.size, new)) {
+                    listener->region_resize(listener, &old_mrs, new);
+                }
+                continue;
+            }
+            if (listener->region_del) {
+                listener->region_del(listener, &old_mrs);
+            }
+        }
+    }
+}
+
 static void address_space_update_topology_pass(AddressSpace *as,
                                                const FlatView *old_view,
                                                const FlatView *new_view,
@@ -911,11 +961,23 @@ static void address_space_update_topology_pass(Addres=
sSpace *as,
             frnew =3D NULL;
         }
=20
-        if (frold
-            && (!frnew
-                || int128_lt(frold->addr.start, frnew->addr.start)
-                || (int128_eq(frold->addr.start, frnew->addr.start)
-                    && !flatrange_equal(frold, frnew)))) {
+        if (frold && frnew && flatrange_resized(frold, frnew)) {
+            /* In both and only the size (+ eventually logging) changed. *=
/
+
+            memory_listener_resize_region(frold, as, frnew->addr.size,
+                                          adding);
+            if (adding) {
+                flat_range_coalesced_io_add(frnew, as);
+            } else {
+                flat_range_coalesced_io_del(frold, as);
+            }
+
+            ++iold;
+            ++inew;
+        } else if (frold && (!frnew
+                             || int128_lt(frold->addr.start, frnew->addr.s=
tart)
+                             || (int128_eq(frold->addr.start, frnew->addr.=
start)
+                                 && !flatrange_equal(frold, frnew)))) {
             /* In old but not in new, or in both but attributes changed. *=
/
=20
             if (!adding) {
--=20
2.24.1


