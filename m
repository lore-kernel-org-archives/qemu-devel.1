Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDFFC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DAAE2073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOa0dJ54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DAAE2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rZf-0003Lq-Ce
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j9rXp-0000GE-Li
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:32:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j9rXo-0003GV-Cw
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:32:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33026
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j9rXo-0003GK-9H
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583418732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5lGKktvpp3+XdkvJGg3g7hD+l344AtPs6h6RHl03TEQ=;
 b=BOa0dJ54G38m9d4UN7JtF8hn/cNNe+5U8wbNI8qrou3R+why31LowI58ccdxS2nGkaefEQ
 DEMIXIUCowvRJNbWkLHtn/7KiF/N5tazEffMHJWjAavO0viGBjv3LNs24xtjItJ33NPNWW
 x4d0tRepsj/ryOM3SXmWHFoJyRN2B6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-sLI3RBJYOAqwvftCriaCiQ-1; Thu, 05 Mar 2020 09:32:10 -0500
X-MC-Unique: sLI3RBJYOAqwvftCriaCiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54DD38017DF;
 Thu,  5 Mar 2020 14:32:09 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-120-166.rdu2.redhat.com [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E14090538;
 Thu,  5 Mar 2020 14:32:01 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/15] util/mmap-alloc: Factor out activating of memory to
 mmap_activate()
Date: Thu,  5 Mar 2020 15:29:39 +0100
Message-Id: <20200305142945.216465-10-david@redhat.com>
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

We want to activate memory within a reserved memory region, to make it
accessible. Let's factor that out.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Greg Kurz <groug@kaod.org>
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 util/mmap-alloc.c | 90 +++++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 42 deletions(-)

diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 9e9534a07e..8f40ef4fed 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -114,6 +114,51 @@ static void *mmap_reserve(size_t size, int fd)
     return mmap(0, size, PROT_NONE, flags, fd, 0);
 }
=20
+/*
+ * Activate memory in a reserved region from the given fd (if any), to mak=
e
+ * it accessible.
+ */
+static void *mmap_activate(void *ptr, size_t size, int fd, bool shared,
+                           bool is_pmem)
+{
+    int map_sync_flags =3D 0;
+    int flags =3D MAP_FIXED;
+    void *activated_ptr;
+
+    flags |=3D fd =3D=3D -1 ? MAP_ANONYMOUS : 0;
+    flags |=3D shared ? MAP_SHARED : MAP_PRIVATE;
+    if (shared && is_pmem) {
+        map_sync_flags =3D MAP_SYNC | MAP_SHARED_VALIDATE;
+    }
+
+    activated_ptr =3D mmap(ptr, size, PROT_READ | PROT_WRITE,
+                         flags | map_sync_flags, fd, 0);
+    if (activated_ptr =3D=3D MAP_FAILED && map_sync_flags) {
+        if (errno =3D=3D ENOTSUP) {
+            char *proc_link =3D g_strdup_printf("/proc/self/fd/%d", fd);
+            char *file_name =3D g_malloc0(PATH_MAX);
+            int len =3D readlink(proc_link, file_name, PATH_MAX - 1);
+
+            if (len < 0) {
+                len =3D 0;
+            }
+            file_name[len] =3D '\0';
+            fprintf(stderr, "Warning: requesting persistence across crashe=
s "
+                    "for backend file %s failed. Proceeding without "
+                    "persistence, data might become corrupted in case of h=
ost "
+                    "crash.\n", file_name);
+            g_free(proc_link);
+            g_free(file_name);
+        }
+        /*
+         * If mmap failed with MAP_SHARED_VALIDATE | MAP_SYNC, we will try
+         * again without these flags to handle backwards compatibility.
+         */
+        activated_ptr =3D mmap(ptr, size, PROT_READ | PROT_WRITE, flags, f=
d, 0);
+    }
+    return activated_ptr;
+}
+
 static inline size_t mmap_guard_pagesize(int fd)
 {
 #if defined(__powerpc64__) && defined(__linux__)
@@ -131,12 +176,8 @@ void *qemu_ram_mmap(int fd,
                     bool is_pmem)
 {
     const size_t guard_pagesize =3D mmap_guard_pagesize(fd);
-    int flags;
-    int map_sync_flags =3D 0;
-    size_t offset;
-    size_t total;
-    void *guardptr;
-    void *ptr;
+    size_t offset, total;
+    void *ptr, *guardptr;
=20
     /*
      * Note: this always allocates at least one extra page of virtual addr=
ess
@@ -153,44 +194,9 @@ void *qemu_ram_mmap(int fd,
     /* Always align to host page size */
     assert(align >=3D guard_pagesize);
=20
-    flags =3D MAP_FIXED;
-    flags |=3D fd =3D=3D -1 ? MAP_ANONYMOUS : 0;
-    flags |=3D shared ? MAP_SHARED : MAP_PRIVATE;
-    if (shared && is_pmem) {
-        map_sync_flags =3D MAP_SYNC | MAP_SHARED_VALIDATE;
-    }
-
     offset =3D QEMU_ALIGN_UP((uintptr_t)guardptr, align) - (uintptr_t)guar=
dptr;
=20
-    ptr =3D mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
-               flags | map_sync_flags, fd, 0);
-
-    if (ptr =3D=3D MAP_FAILED && map_sync_flags) {
-        if (errno =3D=3D ENOTSUP) {
-            char *proc_link, *file_name;
-            int len;
-            proc_link =3D g_strdup_printf("/proc/self/fd/%d", fd);
-            file_name =3D g_malloc0(PATH_MAX);
-            len =3D readlink(proc_link, file_name, PATH_MAX - 1);
-            if (len < 0) {
-                len =3D 0;
-            }
-            file_name[len] =3D '\0';
-            fprintf(stderr, "Warning: requesting persistence across crashe=
s "
-                    "for backend file %s failed. Proceeding without "
-                    "persistence, data might become corrupted in case of h=
ost "
-                    "crash.\n", file_name);
-            g_free(proc_link);
-            g_free(file_name);
-        }
-        /*
-         * if map failed with MAP_SHARED_VALIDATE | MAP_SYNC,
-         * we will remove these flags to handle compatibility.
-         */
-        ptr =3D mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
-                   flags, fd, 0);
-    }
-
+    ptr =3D mmap_activate(guardptr + offset, size, fd, shared, is_pmem);
     if (ptr =3D=3D MAP_FAILED) {
         munmap(guardptr, total);
         return MAP_FAILED;
--=20
2.24.1


