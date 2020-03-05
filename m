Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33841C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15A72146E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHfteZn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15A72146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rdJ-0002AC-47
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j9rXg-0008Og-Rw
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j9rXf-00038z-KR
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:32:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45764
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j9rXf-00038h-GG
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583418723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6BRQjN964Dr4w6axvvjVY5gJygw5QYBcf+sSZYLkYQo=;
 b=aHfteZn8LZaK9Rf95BGcSEQMlZBAYnx/sJYNL9l5xltLqrctHEcTwOFkjVyQV+a6tdF2aN
 mvAfRM+W59Oi79Qm1dscGpgnZaohdu6uC5Pr6nuWkz1WuPBO9wBciUohnLFGafRP0B4SaP
 Qx/BKi472UavW3cISkNr3QaxwVnFvwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-wPRTW4a-PxqCROMY29kVpQ-1; Thu, 05 Mar 2020 09:31:59 -0500
X-MC-Unique: wPRTW4a-PxqCROMY29kVpQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DEE913E4;
 Thu,  5 Mar 2020 14:31:58 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-120-166.rdu2.redhat.com [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E63790538;
 Thu,  5 Mar 2020 14:31:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/15] util/mmap-alloc: Factor out calculation of the
 pagesize for the guard page
Date: Thu,  5 Mar 2020 15:29:37 +0100
Message-Id: <20200305142945.216465-8-david@redhat.com>
In-Reply-To: <20200305142945.216465-1-david@redhat.com>
References: <20200305142945.216465-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Greg Kurz <groug@kaod.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's factor out calculating the size of the guard page and rename the
variable to make it clearer that this pagesize only applies to the
guard page.

Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: Greg Kurz <groug@kaod.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 util/mmap-alloc.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 27dcccd8ec..f0277f9fad 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -82,17 +82,27 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
     return qemu_real_host_page_size;
 }
=20
+static inline size_t mmap_guard_pagesize(int fd)
+{
+#if defined(__powerpc64__) && defined(__linux__)
+    /* Mappings in the same segment must share the same page size */
+    return qemu_fd_getpagesize(fd);
+#else
+    return qemu_real_host_page_size;
+#endif
+}
+
 void *qemu_ram_mmap(int fd,
                     size_t size,
                     size_t align,
                     bool shared,
                     bool is_pmem)
 {
+    const size_t guard_pagesize =3D mmap_guard_pagesize(fd);
     int flags;
     int map_sync_flags =3D 0;
     int guardfd;
     size_t offset;
-    size_t pagesize;
     size_t total;
     void *guardptr;
     void *ptr;
@@ -113,8 +123,7 @@ void *qemu_ram_mmap(int fd,
      * anonymous memory is OK.
      */
     flags =3D MAP_PRIVATE;
-    pagesize =3D qemu_fd_getpagesize(fd);
-    if (fd =3D=3D -1 || pagesize =3D=3D qemu_real_host_page_size) {
+    if (fd =3D=3D -1 || guard_pagesize =3D=3D qemu_real_host_page_size) {
         guardfd =3D -1;
         flags |=3D MAP_ANONYMOUS;
     } else {
@@ -123,7 +132,6 @@ void *qemu_ram_mmap(int fd,
     }
 #else
     guardfd =3D -1;
-    pagesize =3D qemu_real_host_page_size;
     flags =3D MAP_PRIVATE | MAP_ANONYMOUS;
 #endif
=20
@@ -135,7 +143,7 @@ void *qemu_ram_mmap(int fd,
=20
     assert(is_power_of_2(align));
     /* Always align to host page size */
-    assert(align >=3D pagesize);
+    assert(align >=3D guard_pagesize);
=20
     flags =3D MAP_FIXED;
     flags |=3D fd =3D=3D -1 ? MAP_ANONYMOUS : 0;
@@ -189,8 +197,8 @@ void *qemu_ram_mmap(int fd,
      * a guard page guarding against potential buffer overflows.
      */
     total -=3D offset;
-    if (total > size + pagesize) {
-        munmap(ptr + size + pagesize, total - size - pagesize);
+    if (total > size + guard_pagesize) {
+        munmap(ptr + size + guard_pagesize, total - size - guard_pagesize)=
;
     }
=20
     return ptr;
@@ -198,15 +206,8 @@ void *qemu_ram_mmap(int fd,
=20
 void qemu_ram_munmap(int fd, void *ptr, size_t size)
 {
-    size_t pagesize;
-
     if (ptr) {
         /* Unmap both the RAM block and the guard page */
-#if defined(__powerpc64__) && defined(__linux__)
-        pagesize =3D qemu_fd_getpagesize(fd);
-#else
-        pagesize =3D qemu_real_host_page_size;
-#endif
-        munmap(ptr, size + pagesize);
+        munmap(ptr, size + mmap_guard_pagesize(fd));
     }
 }
--=20
2.24.1


