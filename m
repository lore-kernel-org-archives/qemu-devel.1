Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DC9C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E56B24672
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsUuKc7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E56B24672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7GLQ-0005qH-Dz
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j7GBz-0004Kv-MN
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j7GBw-0001RZ-Ck
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:14:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20265
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j7GBw-0001Ni-8d
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582798489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4RmxeN8/6nSqT/VuVrhD81d9IpRWztqLAUeB/YUff2U=;
 b=VsUuKc7snXbEAC9S7W9A8YhexbTR4jpgEp7fgZhfOsQ/i3rueU9glOH0etNM+eb+IeEh+6
 0lLUD5RoGaWEqSfMFTUPS5YpC9yvhSS4QELgt64bTW4l6UloauPcCa6z8X3CQgv+ga2CB3
 jlsPiy5c1f9bDIxxcdqCeMBYjzGo5H8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-sots047lMpe-UBmCEvl1vw-1; Thu, 27 Feb 2020 05:14:48 -0500
X-MC-Unique: sots047lMpe-UBmCEvl1vw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8242800053;
 Thu, 27 Feb 2020 10:14:46 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E873B6E3EE;
 Thu, 27 Feb 2020 10:14:33 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/15] util: oslib: Resizeable anonymous allocations under
 POSIX
Date: Thu, 27 Feb 2020 11:12:03 +0100
Message-Id: <20200227101205.5616-14-david@redhat.com>
In-Reply-To: <20200227101205.5616-1-david@redhat.com>
References: <20200227101205.5616-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce qemu_anon_ram_alloc_resizeable() and qemu_anon_ram_resize().
Implement them under POSIX and make them return NULL under WIN32.

Under POSIX, we make use of resizeable mmaps. An implementation under
WIN32 is theoretically possible AFAIK and can be added later.

In qemu_anon_ram_free(), rename the size parameter to max_size, to make
it clearer that we have to use the maximum size when freeing resizeable
anonymous allocations.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Stefan Weil <sw@weilnetz.de>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/qemu/osdep.h |  6 +++++-
 util/oslib-posix.c   | 37 ++++++++++++++++++++++++++++++++++---
 util/oslib-win32.c   | 14 ++++++++++++++
 util/trace-events    |  4 +++-
 4 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 9bd3dcfd13..a1ea9e043d 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -311,8 +311,12 @@ int qemu_daemon(int nochdir, int noclose);
 void *qemu_try_memalign(size_t alignment, size_t size);
 void *qemu_memalign(size_t alignment, size_t size);
 void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared);
+void *qemu_anon_ram_alloc_resizeable(size_t size, size_t max_size,
+                                     uint64_t *align, bool shared);
+bool qemu_anon_ram_resize(void *ptr, size_t old_size, size_t new_size,
+                          bool shared);
 void qemu_vfree(void *ptr);
-void qemu_anon_ram_free(void *ptr, size_t size);
+void qemu_anon_ram_free(void *ptr, size_t max_size);
=20
 #define QEMU_MADV_INVALID -1
=20
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 897e8f3ba6..34b1ce74b7 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -223,16 +223,47 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t *alig=
nment, bool shared)
     return ptr;
 }
=20
+void *qemu_anon_ram_alloc_resizeable(size_t size, size_t max_size,
+                                     uint64_t *alignment, bool shared)
+{
+    size_t align =3D QEMU_VMALLOC_ALIGN;
+    void *ptr =3D qemu_ram_mmap_resizeable(-1, size, max_size, align, shar=
ed,
+                                         false);
+
+    if (ptr =3D=3D MAP_FAILED) {
+        return NULL;
+    }
+
+    if (alignment) {
+        *alignment =3D align;
+    }
+
+    trace_qemu_anon_ram_alloc_resizeable(size, max_size, ptr);
+    return ptr;
+}
+
+bool qemu_anon_ram_resize(void *ptr, size_t old_size, size_t new_size,
+                          bool shared)
+{
+    bool resized =3D qemu_ram_mmap_resize(ptr, -1, old_size, new_size, sha=
red,
+                                        false);
+
+    if (resized) {
+        trace_qemu_anon_ram_resize(old_size, new_size, ptr);
+    }
+    return resized;
+}
+
 void qemu_vfree(void *ptr)
 {
     trace_qemu_vfree(ptr);
     free(ptr);
 }
=20
-void qemu_anon_ram_free(void *ptr, size_t size)
+void qemu_anon_ram_free(void *ptr, size_t max_size)
 {
-    trace_qemu_anon_ram_free(ptr, size);
-    qemu_ram_munmap(-1, ptr, size);
+    trace_qemu_anon_ram_free(ptr, max_size);
+    qemu_ram_munmap(-1, ptr, max_size);
 }
=20
 void qemu_set_block(int fd)
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index e9b14ab178..c034fdfe01 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -90,6 +90,20 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t *align, =
bool shared)
     return ptr;
 }
=20
+void *qemu_anon_ram_alloc_resizeable(size_t size, size_t max_size,
+                                     uint64_t *align, bool shared)
+{
+    /* resizeable ram not implemented yet */
+    return NULL;
+}
+
+bool qemu_anon_ram_resize(void *ptr, size_t old_size, size_t new_size,
+                          bool shared)
+{
+    /* resizeable ram not implemented yet */
+    return false;
+}
+
 void qemu_vfree(void *ptr)
 {
     trace_qemu_vfree(ptr);
diff --git a/util/trace-events b/util/trace-events
index 88b7dbf4a5..e4af970312 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -46,8 +46,10 @@ qemu_co_mutex_unlock_return(void *mutex, void *self) "mu=
tex %p self %p"
 # oslib-posix.c
 qemu_memalign(size_t alignment, size_t size, void *ptr) "alignment %zu siz=
e %zu ptr %p"
 qemu_anon_ram_alloc(size_t size, void *ptr) "size %zu ptr %p"
+qemu_anon_ram_alloc_resizeable(size_t size, size_t max_size, void *ptr) "s=
ize %zu max_size %zu ptr %p"
+qemu_anon_ram_resize(size_t old_size, size_t new_size, void *ptr) "old_siz=
e %zu new_size %zu ptr %p"
 qemu_vfree(void *ptr) "ptr %p"
-qemu_anon_ram_free(void *ptr, size_t size) "ptr %p size %zu"
+qemu_anon_ram_free(void *ptr, size_t max_size) "ptr %p max_size %zu"
=20
 # hbitmap.c
 hbitmap_iter_skip_words(const void *hb, void *hbi, uint64_t pos, unsigned =
long cur) "hb %p hbi %p pos %"PRId64" cur 0x%lx"
--=20
2.24.1


