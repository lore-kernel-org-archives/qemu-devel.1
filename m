Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32C7C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD5420732
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvwrFpjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD5420732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rbR-0006na-L1
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:35:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j9rXy-0000Sd-7N
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j9rXw-0003Oq-NU
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:32:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34147
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j9rXw-0003O9-Hj
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583418740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MVaLnjXvJg6zL4YkvtGMVqzRgwjU5unEthNhKZGounY=;
 b=ZvwrFpjnrezPkQnlYmpPpwccCx7/V20I0jy2DyYgSA9N5Ws38WJPSRNmQk+OvsPK7tHY/t
 AzuIar20LngzjiJE/TjPJVRsZLkHPMSXK7WrRiSLLcVuyRfkLp+8NS9qWKccGnQt+oZQ0j
 bQUZPEdJpbZLNW3rkNhzGlklhSSutmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-xdx8g9ajNhOd9JEkwZUm-w-1; Thu, 05 Mar 2020 09:32:18 -0500
X-MC-Unique: xdx8g9ajNhOd9JEkwZUm-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DB9013EA;
 Thu,  5 Mar 2020 14:32:17 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-120-166.rdu2.redhat.com [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 086BF90538;
 Thu,  5 Mar 2020 14:32:14 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/15] util/mmap-alloc: Implement resizeable mmaps
Date: Thu,  5 Mar 2020 15:29:41 +0100
Message-Id: <20200305142945.216465-12-david@redhat.com>
In-Reply-To: <20200305142945.216465-1-david@redhat.com>
References: <20200305142945.216465-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Greg Kurz <groug@kaod.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement resizeable mmaps. For now, the actual resizing is not wired up.
Introduce qemu_ram_mmap_resizeable() and qemu_ram_mmap_resize(). Make
qemu_ram_mmap() a wrapper of qemu_ram_mmap_resizeable().

Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Greg Kurz <groug@kaod.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/qemu/mmap-alloc.h | 21 +++++++++++--------
 util/mmap-alloc.c         | 43 ++++++++++++++++++++++++++++-----------
 2 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
index e786266b92..ca8f7edf70 100644
--- a/include/qemu/mmap-alloc.h
+++ b/include/qemu/mmap-alloc.h
@@ -7,11 +7,13 @@ size_t qemu_fd_getpagesize(int fd);
 size_t qemu_mempath_getpagesize(const char *mem_path);
=20
 /**
- * qemu_ram_mmap: mmap the specified file or device.
+ * qemu_ram_mmap_resizeable: reserve a memory region of @max_size to mmap =
the
+ *                           specified file or device and mmap @size of it=
.
  *
  * Parameters:
  *  @fd: the file or the device to mmap
  *  @size: the number of bytes to be mmaped
+ *  @max_size: the number of bytes to be reserved
  *  @align: if not zero, specify the alignment of the starting mapping add=
ress;
  *          otherwise, the alignment in use will be determined by QEMU.
  *  @shared: map has RAM_SHARED flag.
@@ -21,12 +23,15 @@ size_t qemu_mempath_getpagesize(const char *mem_path);
  *  On success, return a pointer to the mapped area.
  *  On failure, return MAP_FAILED.
  */
-void *qemu_ram_mmap(int fd,
-                    size_t size,
-                    size_t align,
-                    bool shared,
-                    bool is_pmem);
-
-void qemu_ram_munmap(int fd, void *ptr, size_t size);
+void *qemu_ram_mmap_resizeable(int fd, size_t size, size_t max_size,
+                              size_t align, bool shared, bool is_pmem);
+bool qemu_ram_mmap_resize(void *ptr, int fd, size_t old_size, size_t new_s=
ize,
+                          bool shared, bool is_pmem);
+static inline void *qemu_ram_mmap(int fd, size_t size, size_t align,
+                                  bool shared, bool is_pmem)
+{
+    return qemu_ram_mmap_resizeable(fd, size, size, align, shared, is_pmem=
);
+}
+void qemu_ram_munmap(int fd, void *ptr, size_t max_size);
=20
 #endif
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 2767caa33b..7ed85f16d3 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -174,11 +174,8 @@ static inline size_t mmap_guard_pagesize(int fd)
 #endif
 }
=20
-void *qemu_ram_mmap(int fd,
-                    size_t size,
-                    size_t align,
-                    bool shared,
-                    bool is_pmem)
+void *qemu_ram_mmap_resizeable(int fd, size_t size, size_t max_size,
+                               size_t align, bool shared, bool is_pmem)
 {
     const size_t guard_pagesize =3D mmap_guard_pagesize(fd);
     const size_t pagesize =3D qemu_fd_getpagesize(fd);
@@ -186,12 +183,14 @@ void *qemu_ram_mmap(int fd,
     void *ptr, *guardptr;
=20
     g_assert(QEMU_IS_ALIGNED(size, pagesize));
+    g_assert(QEMU_IS_ALIGNED(max_size, pagesize));
=20
     /*
      * Note: this always allocates at least one extra page of virtual addr=
ess
-     * space, even if size is already aligned.
+     * space, even if the size is already aligned. We will reserve an area=
 of
+     * at least max_size, but only activate the requested part of it.
      */
-    total =3D size + align;
+    total =3D max_size + align;
=20
     guardptr =3D mmap_reserve(NULL, total, fd);
     if (guardptr =3D=3D MAP_FAILED) {
@@ -219,21 +218,41 @@ void *qemu_ram_mmap(int fd,
      * a guard page guarding against potential buffer overflows.
      */
     total -=3D offset;
-    if (total > size + guard_pagesize) {
-        munmap(ptr + size + guard_pagesize, total - size - guard_pagesize)=
;
+    if (total > max_size + guard_pagesize) {
+        munmap(ptr + max_size + guard_pagesize,
+               total - max_size - guard_pagesize);
     }
=20
     return ptr;
 }
=20
-void qemu_ram_munmap(int fd, void *ptr, size_t size)
+bool qemu_ram_mmap_resize(void *ptr, int fd, size_t old_size, size_t new_s=
ize,
+                          bool shared, bool is_pmem)
 {
     const size_t pagesize =3D qemu_fd_getpagesize(fd);
=20
-    g_assert(QEMU_IS_ALIGNED(size, pagesize));
+    g_assert(QEMU_IS_ALIGNED(old_size, pagesize));
+    g_assert(QEMU_IS_ALIGNED(new_size, pagesize));
+
+    if (old_size < new_size) {
+        /* activate the missing piece in the reserved area */
+        ptr =3D mmap_activate(ptr + old_size, new_size - old_size, fd, old=
_size,
+                            shared, is_pmem);
+    } else if (old_size > new_size) {
+        /* discard this piece, marking it reserved */
+        ptr =3D mmap_reserve(ptr + new_size, old_size - new_size, fd);
+    }
+    return ptr !=3D MAP_FAILED;
+}
+
+void qemu_ram_munmap(int fd, void *ptr, size_t max_size)
+{
+    const size_t pagesize =3D qemu_fd_getpagesize(fd);
+
+    g_assert(QEMU_IS_ALIGNED(max_size, pagesize));
=20
     if (ptr) {
         /* Unmap both the RAM block and the guard page */
-        munmap(ptr, size + mmap_guard_pagesize(fd));
+        munmap(ptr, max_size + mmap_guard_pagesize(fd));
     }
 }
--=20
2.24.1


