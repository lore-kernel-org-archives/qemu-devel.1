Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FAEC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE2024672
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYOH2ziz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE2024672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7GKQ-0004FQ-Hi
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j7GBW-0003qG-Cf
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:14:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j7GBT-0000VR-TW
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:14:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23104
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j7GBT-0000Su-P7
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582798463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4mZwnvyZhERJne67+bQOssfXKczt9eVEF1mwFB9tgoM=;
 b=gYOH2ziz+UPzecHZgJuepa/tcHp/QfIVmWn91CBn/L/u3bbbM75YaeAOMcEDUXEiJ4utHi
 0nTPl09cQfngCig5VhzDKLXW4RsyB+F6V7CBNPu93BC1FA7wXK400/Bq5y/ES+b+cQkk5q
 cirJbgcmqmvUQCWFXDf6FQaUYIhfRlw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-pNJ7hmV9Mcae-qUqDXsgjQ-1; Thu, 27 Feb 2020 05:14:22 -0500
X-MC-Unique: pNJ7hmV9Mcae-qUqDXsgjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF9DD107B7D7;
 Thu, 27 Feb 2020 10:14:20 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60B916E3EE;
 Thu, 27 Feb 2020 10:14:07 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/15] util/mmap-alloc: Prepare for resizeable mmaps
Date: Thu, 27 Feb 2020 11:12:00 +0100
Message-Id: <20200227101205.5616-11-david@redhat.com>
In-Reply-To: <20200227101205.5616-1-david@redhat.com>
References: <20200227101205.5616-1-david@redhat.com>
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

When shrinking a mmap we want to re-reserve the already populated area.
When growing a memory region, we want to populate starting with a given
fd_offset. Prepare by allowing to pass these parameters.

Also, let's make sure we always process full pages, to avoid
unmapping/remapping pages that are already in use when
growing/shrinking. Add some asserts.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Greg Kurz <groug@kaod.org>
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 util/mmap-alloc.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 73179f36d6..c6a6075215 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -83,12 +83,12 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
 }
=20
 /*
- * Reserve a new memory region of the requested size to be used for mappin=
g
- * from the given fd (if any).
+ * Reserve a new memory region of the requested size or re-reserve parts
+ * of an existing region to be used for mapping from the given fd (if any)=
.
  */
-static void *mmap_reserve(size_t size, int fd)
+static void *mmap_reserve(void *ptr, size_t size, int fd)
 {
-    int flags =3D MAP_PRIVATE;
+    int flags =3D MAP_PRIVATE | (ptr ? MAP_FIXED : 0);
=20
 #if defined(__powerpc64__) && defined(__linux__)
     /*
@@ -111,19 +111,23 @@ static void *mmap_reserve(size_t size, int fd)
     flags |=3D MAP_ANONYMOUS;
 #endif
=20
-    return mmap(0, size, PROT_NONE, flags, fd, 0);
+    return mmap(ptr, size, PROT_NONE, flags, fd, 0);
 }
=20
 /*
  * Populate memory in a reserved region from the given fd (if any).
  */
-static void *mmap_populate(void *ptr, size_t size, int fd, bool shared,
-                           bool is_pmem)
+static void *mmap_populate(void *ptr, size_t size, int fd, size_t fd_offse=
t,
+                           bool shared, bool is_pmem)
 {
     int map_sync_flags =3D 0;
     int flags =3D MAP_FIXED;
     void *populated_ptr;
=20
+    if (fd =3D=3D -1) {
+        fd_offset =3D 0;
+    }
+
     flags |=3D fd =3D=3D -1 ? MAP_ANONYMOUS : 0;
     flags |=3D shared ? MAP_SHARED : MAP_PRIVATE;
     if (shared && is_pmem) {
@@ -131,7 +135,7 @@ static void *mmap_populate(void *ptr, size_t size, int =
fd, bool shared,
     }
=20
     populated_ptr =3D mmap(ptr, size, PROT_READ | PROT_WRITE,
-                         flags | map_sync_flags, fd, 0);
+                         flags | map_sync_flags, fd, fd_offset);
     if (populated_ptr =3D=3D MAP_FAILED && map_sync_flags) {
         if (errno =3D=3D ENOTSUP) {
             char *proc_link =3D g_strdup_printf("/proc/self/fd/%d", fd);
@@ -153,7 +157,8 @@ static void *mmap_populate(void *ptr, size_t size, int =
fd, bool shared,
          * If mmap failed with MAP_SHARED_VALIDATE | MAP_SYNC, we will try
          * again without these flags to handle backwards compatibility.
          */
-        populated_ptr =3D mmap(ptr, size, PROT_READ | PROT_WRITE, flags, f=
d, 0);
+        populated_ptr =3D mmap(ptr, size, PROT_READ | PROT_WRITE, flags, f=
d,
+                             fd_offset);
     }
     return populated_ptr;
 }
@@ -175,16 +180,19 @@ void *qemu_ram_mmap(int fd,
                     bool is_pmem)
 {
     const size_t guard_pagesize =3D mmap_guard_pagesize(fd);
+    const size_t pagesize =3D qemu_fd_getpagesize(fd);
     size_t offset, total;
     void *ptr, *guardptr;
=20
+    g_assert(QEMU_IS_ALIGNED(size, pagesize));
+
     /*
      * Note: this always allocates at least one extra page of virtual addr=
ess
      * space, even if size is already aligned.
      */
     total =3D size + align;
=20
-    guardptr =3D mmap_reserve(total, fd);
+    guardptr =3D mmap_reserve(NULL, total, fd);
     if (guardptr =3D=3D MAP_FAILED) {
         return MAP_FAILED;
     }
@@ -195,7 +203,7 @@ void *qemu_ram_mmap(int fd,
=20
     offset =3D QEMU_ALIGN_UP((uintptr_t)guardptr, align) - (uintptr_t)guar=
dptr;
=20
-    ptr =3D mmap_populate(guardptr + offset, size, fd, shared, is_pmem);
+    ptr =3D mmap_populate(guardptr + offset, size, fd, 0, shared, is_pmem)=
;
     if (ptr =3D=3D MAP_FAILED) {
         munmap(guardptr, total);
         return MAP_FAILED;
@@ -219,6 +227,10 @@ void *qemu_ram_mmap(int fd,
=20
 void qemu_ram_munmap(int fd, void *ptr, size_t size)
 {
+    const size_t pagesize =3D qemu_fd_getpagesize(fd);
+
+    g_assert(QEMU_IS_ALIGNED(size, pagesize));
+
     if (ptr) {
         /* Unmap both the RAM block and the guard page */
         munmap(ptr, size + mmap_guard_pagesize(fd));
--=20
2.24.1


