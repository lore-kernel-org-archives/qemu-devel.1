Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD8EC35249
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F6220721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KclWinwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F6220721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iygb6-0006gB-Iz
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 13:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iygW3-0007p7-Fr
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iygW1-0001La-DD
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44616
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iygW0-0001II-19
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580754723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9L9xxZ9ZeBStGdB1kO0OkTwJU7PxXep2rUjWZkoEjvQ=;
 b=KclWinwTy0eD/2AsouMdXa+ZdeQm3aLKmz9dVD8ePcT96gVBdTx43M4gvcEh/ByGeIaqPb
 7cZYbtqDpnprzwLhZlKaCYtL2guv63PYBlrZ0BXVnNOneXbIK/jRt98h4gjfRbxpXBv0qI
 mNEs2i4mODgdmWhilkHlScGcji3NpMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-4ngYOA2oPT-TIHuunSrXgA-1; Mon, 03 Feb 2020 13:32:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CC33107ACC9;
 Mon,  3 Feb 2020 18:32:00 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-77.ams2.redhat.com [10.36.117.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C9045D9CA;
 Mon,  3 Feb 2020 18:31:58 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 05/13] util/mmap-alloc: Factor out calculation of pagesize
 to mmap_pagesize()
Date: Mon,  3 Feb 2020 19:31:17 +0100
Message-Id: <20200203183125.164879-6-david@redhat.com>
In-Reply-To: <20200203183125.164879-1-david@redhat.com>
References: <20200203183125.164879-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 4ngYOA2oPT-TIHuunSrXgA-1
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
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Factor it out and add a comment.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: Greg Kurz <groug@kaod.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 util/mmap-alloc.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 27dcccd8ec..82f02a2cec 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -82,17 +82,27 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
     return qemu_real_host_page_size;
 }
=20
+static inline size_t mmap_pagesize(int fd)
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
+    const size_t pagesize =3D mmap_pagesize(fd);
     int flags;
     int map_sync_flags =3D 0;
     int guardfd;
     size_t offset;
-    size_t pagesize;
     size_t total;
     void *guardptr;
     void *ptr;
@@ -113,7 +123,6 @@ void *qemu_ram_mmap(int fd,
      * anonymous memory is OK.
      */
     flags =3D MAP_PRIVATE;
-    pagesize =3D qemu_fd_getpagesize(fd);
     if (fd =3D=3D -1 || pagesize =3D=3D qemu_real_host_page_size) {
         guardfd =3D -1;
         flags |=3D MAP_ANONYMOUS;
@@ -123,7 +132,6 @@ void *qemu_ram_mmap(int fd,
     }
 #else
     guardfd =3D -1;
-    pagesize =3D qemu_real_host_page_size;
     flags =3D MAP_PRIVATE | MAP_ANONYMOUS;
 #endif
=20
@@ -198,15 +206,10 @@ void *qemu_ram_mmap(int fd,
=20
 void qemu_ram_munmap(int fd, void *ptr, size_t size)
 {
-    size_t pagesize;
+    const size_t pagesize =3D mmap_pagesize(fd);
=20
     if (ptr) {
         /* Unmap both the RAM block and the guard page */
-#if defined(__powerpc64__) && defined(__linux__)
-        pagesize =3D qemu_fd_getpagesize(fd);
-#else
-        pagesize =3D qemu_real_host_page_size;
-#endif
         munmap(ptr, size + pagesize);
     }
 }
--=20
2.24.1


