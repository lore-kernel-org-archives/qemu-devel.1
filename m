Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01011C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC3224672
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZnzfpOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC3224672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7GIV-0002Jo-0B
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j7GBF-0003VA-ML
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j7GBE-0007wn-Gs
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:14:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26460
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j7GBE-0007p0-CS
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:14:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582798446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0M+moTdl0qV7+Qhg/JRf45CFzQnG475adDlEdMRPHAI=;
 b=YZnzfpOgTLLGcaJdyHBdepLDuoC9YVD6rayMsIh+FoU5H9KQNQeCIU1CmcI0iiPUTVxqC2
 XIT8Y6oU80TLIU0Cbq9HObYHH1ecR8zXPFjmZf95T85IhJi1wKHQ4TNf2B9pfuNW0+RNGU
 nAPaqsuvA87imACWnt9bfUNvkfSIaGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-atXLREa4MFGqPwq_dOlFQQ-1; Thu, 27 Feb 2020 05:14:02 -0500
X-MC-Unique: atXLREa4MFGqPwq_dOlFQQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F27D800D53;
 Thu, 27 Feb 2020 10:14:01 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82A6E6E3EE;
 Thu, 27 Feb 2020 10:13:49 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/15] util/mmap-alloc: Factor out reserving of a memory
 region to mmap_reserve()
Date: Thu, 27 Feb 2020 11:11:58 +0100
Message-Id: <20200227101205.5616-9-david@redhat.com>
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

We want to reserve a memory region without actually populating memory.
Let's factor that out.

Reviewed-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
Acked-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Greg Kurz <groug@kaod.org>
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 util/mmap-alloc.c | 58 +++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index f0277f9fad..9e9534a07e 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -82,6 +82,38 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
     return qemu_real_host_page_size;
 }
=20
+/*
+ * Reserve a new memory region of the requested size to be used for mappin=
g
+ * from the given fd (if any).
+ */
+static void *mmap_reserve(size_t size, int fd)
+{
+    int flags =3D MAP_PRIVATE;
+
+#if defined(__powerpc64__) && defined(__linux__)
+    /*
+     * On ppc64 mappings in the same segment (aka slice) must share the sa=
me
+     * page size. Since we will be re-allocating part of this segment
+     * from the supplied fd, we should make sure to use the same page size=
, to
+     * this end we mmap the supplied fd.  In this case, set MAP_NORESERVE =
to
+     * avoid allocating backing store memory.
+     * We do this unless we are using the system page size, in which case
+     * anonymous memory is OK.
+     */
+    if (fd =3D=3D -1 || qemu_fd_getpagesize(fd) =3D=3D qemu_real_host_page=
_size) {
+        fd =3D -1;
+        flags |=3D MAP_ANONYMOUS;
+    } else {
+        flags |=3D MAP_NORESERVE;
+    }
+#else
+    fd =3D -1;
+    flags |=3D MAP_ANONYMOUS;
+#endif
+
+    return mmap(0, size, PROT_NONE, flags, fd, 0);
+}
+
 static inline size_t mmap_guard_pagesize(int fd)
 {
 #if defined(__powerpc64__) && defined(__linux__)
@@ -101,7 +133,6 @@ void *qemu_ram_mmap(int fd,
     const size_t guard_pagesize =3D mmap_guard_pagesize(fd);
     int flags;
     int map_sync_flags =3D 0;
-    int guardfd;
     size_t offset;
     size_t total;
     void *guardptr;
@@ -113,30 +144,7 @@ void *qemu_ram_mmap(int fd,
      */
     total =3D size + align;
=20
-#if defined(__powerpc64__) && defined(__linux__)
-    /* On ppc64 mappings in the same segment (aka slice) must share the sa=
me
-     * page size. Since we will be re-allocating part of this segment
-     * from the supplied fd, we should make sure to use the same page size=
, to
-     * this end we mmap the supplied fd.  In this case, set MAP_NORESERVE =
to
-     * avoid allocating backing store memory.
-     * We do this unless we are using the system page size, in which case
-     * anonymous memory is OK.
-     */
-    flags =3D MAP_PRIVATE;
-    if (fd =3D=3D -1 || guard_pagesize =3D=3D qemu_real_host_page_size) {
-        guardfd =3D -1;
-        flags |=3D MAP_ANONYMOUS;
-    } else {
-        guardfd =3D fd;
-        flags |=3D MAP_NORESERVE;
-    }
-#else
-    guardfd =3D -1;
-    flags =3D MAP_PRIVATE | MAP_ANONYMOUS;
-#endif
-
-    guardptr =3D mmap(0, total, PROT_NONE, flags, guardfd, 0);
-
+    guardptr =3D mmap_reserve(total, fd);
     if (guardptr =3D=3D MAP_FAILED) {
         return MAP_FAILED;
     }
--=20
2.24.1


