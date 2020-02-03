Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F51FC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E15572082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKqPiHsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15572082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iygZt-0004WK-3u
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 13:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iygWI-00085r-Py
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iygWH-0001tE-Cx
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31025
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iygWH-0001pT-5Y
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580754743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvHeRWBrLxpLh5CubflKqh/5Wa9JFfhXcBP4obYJe6k=;
 b=TKqPiHsOiOoG32f0sfr/RKu07Cnc1ybf0ehD+Fe3gLpgGNPagV2WHdtZMejY58XwvgQBJZ
 Fu09IXylAmOz+t4Yj9ijBWhUWXWd0xuiAGnGrbHX7iWGqqnU4g2qhG7ofsBjJL4jRGCMjr
 3DMr5bJ2hUNSkB5RCd01Y+WNmDWFf0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-fg9lsnfdOPu6brdhN-Beiw-1; Mon, 03 Feb 2020 13:32:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9501B800D48;
 Mon,  3 Feb 2020 18:32:15 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-77.ams2.redhat.com [10.36.117.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11B965D9CA;
 Mon,  3 Feb 2020 18:32:05 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 08/13] util/mmap-alloc: Prepare for resizable mmaps
Date: Mon,  3 Feb 2020 19:31:20 +0100
Message-Id: <20200203183125.164879-9-david@redhat.com>
In-Reply-To: <20200203183125.164879-1-david@redhat.com>
References: <20200203183125.164879-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: fg9lsnfdOPu6brdhN-Beiw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When shrinking a mmap we want to re-reserve the already populated area.
When growing a memory region, we want to populate starting with a given
fd_offset. Prepare by allowing to pass these parameters.

Also, let's make sure we always process full pages, to avoid
unmapping/remapping pages that are already in use when
growing/shrinking. (existing callers seem to guarantee this, but that's
not obvious)

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Greg Kurz <groug@kaod.org>
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 util/mmap-alloc.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index f043ccb0ab..63ad6893b7 100644
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
     void *new_ptr;
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
     new_ptr =3D mmap(ptr, size, PROT_READ | PROT_WRITE, flags | map_sync_f=
lags,
-                   fd, 0);
+                   fd, fd_offset);
     if (new_ptr =3D=3D MAP_FAILED && map_sync_flags) {
         if (errno =3D=3D ENOTSUP) {
             char *proc_link =3D g_strdup_printf("/proc/self/fd/%d", fd);
@@ -153,7 +157,7 @@ static void *mmap_populate(void *ptr, size_t size, int =
fd, bool shared,
          * If mmap failed with MAP_SHARED_VALIDATE | MAP_SYNC, we will try
          * again without these flags to handle backwards compatibility.
          */
-        new_ptr =3D mmap(ptr, size, PROT_READ | PROT_WRITE, flags, fd, 0);
+        new_ptr =3D mmap(ptr, size, PROT_READ | PROT_WRITE, flags, fd, fd_=
offset);
     }
     return new_ptr;
 }
@@ -178,13 +182,16 @@ void *qemu_ram_mmap(int fd,
     size_t offset, total;
     void *ptr, *guardptr;
=20
+    /* we can only map whole pages */
+    size =3D QEMU_ALIGN_UP(size, pagesize);
+
     /*
      * Note: this always allocates at least one extra page of virtual addr=
ess
      * space, even if size is already aligned.
      */
     total =3D size + align;
=20
-    guardptr =3D mmap_reserve(total, fd);
+    guardptr =3D mmap_reserve(0, total, fd);
     if (guardptr =3D=3D MAP_FAILED) {
         return MAP_FAILED;
     }
@@ -195,7 +202,7 @@ void *qemu_ram_mmap(int fd,
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
@@ -221,6 +228,9 @@ void qemu_ram_munmap(int fd, void *ptr, size_t size)
 {
     const size_t pagesize =3D mmap_pagesize(fd);
=20
+    /* we can only map whole pages */
+    size =3D QEMU_ALIGN_UP(size, pagesize);
+
     if (ptr) {
         /* Unmap both the RAM block and the guard page */
         munmap(ptr, size + pagesize);
--=20
2.24.1


