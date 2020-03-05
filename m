Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2450FC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00CC20732
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtwvBt3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00CC20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rej-0004Bc-2c
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:39:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j9rXi-0008TT-Va
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j9rXh-0003BT-LS
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:32:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24213
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j9rXh-0003BB-HG
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583418725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0M+moTdl0qV7+Qhg/JRf45CFzQnG475adDlEdMRPHAI=;
 b=QtwvBt3vVIvKJmS8s7tJlhEPDuEQPGGPVDNiaRLm3jhqi/zPHjSxmT3JweIsKgmgOriGb2
 SlP8AHf4EDlUBFM1UrF8jA6rc047b5XUpKMKQ0sF9mEC1pCtsn49LVHgUKxaEZTEBfgzdJ
 42dKWqjyxN7dWepNcBWmFPZBsJQgO1s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-MiGM3g_mMW-NoMMQTnF6Hg-1; Thu, 05 Mar 2020 09:32:03 -0500
X-MC-Unique: MiGM3g_mMW-NoMMQTnF6Hg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26945800D55;
 Thu,  5 Mar 2020 14:32:01 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-120-166.rdu2.redhat.com [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B51A790538;
 Thu,  5 Mar 2020 14:31:58 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 08/15] util/mmap-alloc: Factor out reserving of a memory
 region to mmap_reserve()
Date: Thu,  5 Mar 2020 15:29:38 +0100
Message-Id: <20200305142945.216465-9-david@redhat.com>
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


