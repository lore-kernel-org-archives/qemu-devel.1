Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21254C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C4A2086A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHxVOwAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C4A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iygZf-00047M-3t
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 13:35:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iygWI-00085b-LY
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iygWG-0001q4-4Z
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29400
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iygWF-0001nU-Vg
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580754742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yiFlwfNNxg1lbxKs5NIEPv1MehTMQy7VN8Wu+aD6HJk=;
 b=QHxVOwAekrzW1dcSQyp+x+X+fF1HN9CIeJqmOXYWAqh62XOqkIO/rrjf5AI4UiKtvFNyjl
 tdTOQH4ijt6QrveZw8S8b7w6HkNhaux8seb4va4zADHJIZ6YBX7t8BzwfKIaq3ZydkxeGQ
 1l8AL3cwR7toNwX2/+yik7NIN3v1dok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-asMZ0xMGPcqcRBB7iWYjgw-1; Mon, 03 Feb 2020 13:32:19 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C49041084433;
 Mon,  3 Feb 2020 18:32:17 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-77.ams2.redhat.com [10.36.117.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E02C85DAB0;
 Mon,  3 Feb 2020 18:32:15 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 09/13] util/mmap-alloc: Implement resizable mmaps
Date: Mon,  3 Feb 2020 19:31:21 +0100
Message-Id: <20200203183125.164879-10-david@redhat.com>
In-Reply-To: <20200203183125.164879-1-david@redhat.com>
References: <20200203183125.164879-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: asMZ0xMGPcqcRBB7iWYjgw-1
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

Implement resizable mmaps. For now, the actual resizing is not wired up.
Introduce qemu_ram_mmap_resizable() and qemu_ram_mmap_resize(). Make
qemu_ram_mmap() a wrapper of qemu_ram_mmap_resizable().

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Greg Kurz <groug@kaod.org>
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/qemu/mmap-alloc.h | 21 ++++++++++++-------
 util/mmap-alloc.c         | 44 ++++++++++++++++++++++++++++-----------
 2 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
index e786266b92..70bc8e9637 100644
--- a/include/qemu/mmap-alloc.h
+++ b/include/qemu/mmap-alloc.h
@@ -7,11 +7,13 @@ size_t qemu_fd_getpagesize(int fd);
 size_t qemu_mempath_getpagesize(const char *mem_path);
=20
 /**
- * qemu_ram_mmap: mmap the specified file or device.
+ * qemu_ram_mmap_resizable: reserve a memory region of @max_size to mmap t=
he
+ *                          specified file or device and mmap @size of it.
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
+void *qemu_ram_mmap_resizable(int fd, size_t size, size_t max_size,
+                              size_t align, bool shared, bool is_pmem);
+void *qemu_ram_mmap_resize(void *ptr, int fd, size_t old_size, size_t new_=
size,
+                           bool shared, bool is_pmem);
+static inline void *qemu_ram_mmap(int fd, size_t size, size_t align,
+                                  bool shared, bool is_pmem)
+{
+    return qemu_ram_mmap_resizable(fd, size, size, align, shared, is_pmem)=
;
+}
+void qemu_ram_munmap(int fd, void *ptr, size_t max_size);
=20
 #endif
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 63ad6893b7..2d562145e9 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -172,11 +172,8 @@ static inline size_t mmap_pagesize(int fd)
 #endif
 }
=20
-void *qemu_ram_mmap(int fd,
-                    size_t size,
-                    size_t align,
-                    bool shared,
-                    bool is_pmem)
+void *qemu_ram_mmap_resizable(int fd, size_t size, size_t max_size,
+                              size_t align, bool shared, bool is_pmem)
 {
     const size_t pagesize =3D mmap_pagesize(fd);
     size_t offset, total;
@@ -184,12 +181,14 @@ void *qemu_ram_mmap(int fd,
=20
     /* we can only map whole pages */
     size =3D QEMU_ALIGN_UP(size, pagesize);
+    max_size =3D QEMU_ALIGN_UP(max_size, pagesize);
=20
     /*
      * Note: this always allocates at least one extra page of virtual addr=
ess
-     * space, even if size is already aligned.
+     * space, even if the size is already aligned. We will reserve an area=
 of
+     * at least max_size, but only populate the requested part of it.
      */
-    total =3D size + align;
+    total =3D max_size + align;
=20
     guardptr =3D mmap_reserve(0, total, fd);
     if (guardptr =3D=3D MAP_FAILED) {
@@ -217,22 +216,43 @@ void *qemu_ram_mmap(int fd,
      * a guard page guarding against potential buffer overflows.
      */
     total -=3D offset;
-    if (total > size + pagesize) {
-        munmap(ptr + size + pagesize, total - size - pagesize);
+    if (total > max_size + pagesize) {
+        munmap(ptr + max_size + pagesize, total - max_size - pagesize);
     }
=20
     return ptr;
 }
=20
-void qemu_ram_munmap(int fd, void *ptr, size_t size)
+void *qemu_ram_mmap_resize(void *ptr, int fd, size_t old_size, size_t new_=
size,
+                           bool shared, bool is_pmem)
 {
     const size_t pagesize =3D mmap_pagesize(fd);
=20
     /* we can only map whole pages */
-    size =3D QEMU_ALIGN_UP(size, pagesize);
+    old_size =3D QEMU_ALIGN_UP(old_size, pagesize);
+    new_size =3D QEMU_ALIGN_UP(new_size, pagesize);
+
+    /* we support actually resizable memory regions only on Linux */
+    if (old_size < new_size) {
+        /* populate the missing piece into the reserved area */
+        ptr =3D mmap_populate(ptr + old_size, new_size - old_size, fd, old=
_size,
+                            shared, is_pmem);
+    } else if (old_size > new_size) {
+        /* discard this piece, keeping the area reserved (should never fai=
l) */
+        ptr =3D mmap_reserve(ptr + new_size, old_size - new_size, fd);
+    }
+    return ptr;
+}
+
+void qemu_ram_munmap(int fd, void *ptr, size_t max_size)
+{
+    const size_t pagesize =3D mmap_pagesize(fd);
+
+    /* we can only map whole pages */
+    max_size =3D QEMU_ALIGN_UP(max_size, pagesize);
=20
     if (ptr) {
         /* Unmap both the RAM block and the guard page */
-        munmap(ptr, size + pagesize);
+        munmap(ptr, max_size + pagesize);
     }
 }
--=20
2.24.1


