Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C251C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678B42468D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQfpf1pE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678B42468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7GHE-00019D-JN
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:20:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j7GBI-0003YR-89
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:14:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j7GBG-00088R-Tt
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:14:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51420
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j7GBG-00086O-PS
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582798450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m/8TwOF2Sia+Gjod6JfWjCPGtrFF4CPZ36Jyrg9pzx0=;
 b=jQfpf1pEW1R/UVhPm2z5kf52Mi3fxvVnOYnLQ4ZICaolmzjDCDn0YsdcymkfpQYFXiSxMb
 hd3bSN4HyMG4Ae5mYjqyFJCZa2GaUJfCPl7/DKfyKF8E3Y2IF6gtvd8vWcaPogUXtbNQBI
 1t9aupUu6nJrXvLGrCSD6erZZgwf10w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143--T1rH1jlM2GgK7K_NigEhQ-1; Thu, 27 Feb 2020 05:14:08 -0500
X-MC-Unique: -T1rH1jlM2GgK7K_NigEhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61AA718A5507;
 Thu, 27 Feb 2020 10:14:07 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9239E6E3EE;
 Thu, 27 Feb 2020 10:14:01 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/15] util/mmap-alloc: Factor out populating of memory to
 mmap_populate()
Date: Thu, 27 Feb 2020 11:11:59 +0100
Message-Id: <20200227101205.5616-10-david@redhat.com>
In-Reply-To: <20200227101205.5616-1-david@redhat.com>
References: <20200227101205.5616-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

We want to populate memory within a reserved memory region. Let's factor
that out.

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
 util/mmap-alloc.c | 89 +++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 42 deletions(-)

diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 9e9534a07e..73179f36d6 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -114,6 +114,50 @@ static void *mmap_reserve(size_t size, int fd)
     return mmap(0, size, PROT_NONE, flags, fd, 0);
 }
=20
+/*
+ * Populate memory in a reserved region from the given fd (if any).
+ */
+static void *mmap_populate(void *ptr, size_t size, int fd, bool shared,
+                           bool is_pmem)
+{
+    int map_sync_flags =3D 0;
+    int flags =3D MAP_FIXED;
+    void *populated_ptr;
+
+    flags |=3D fd =3D=3D -1 ? MAP_ANONYMOUS : 0;
+    flags |=3D shared ? MAP_SHARED : MAP_PRIVATE;
+    if (shared && is_pmem) {
+        map_sync_flags =3D MAP_SYNC | MAP_SHARED_VALIDATE;
+    }
+
+    populated_ptr =3D mmap(ptr, size, PROT_READ | PROT_WRITE,
+                         flags | map_sync_flags, fd, 0);
+    if (populated_ptr =3D=3D MAP_FAILED && map_sync_flags) {
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
+        populated_ptr =3D mmap(ptr, size, PROT_READ | PROT_WRITE, flags, f=
d, 0);
+    }
+    return populated_ptr;
+}
+
 static inline size_t mmap_guard_pagesize(int fd)
 {
 #if defined(__powerpc64__) && defined(__linux__)
@@ -131,12 +175,8 @@ void *qemu_ram_mmap(int fd,
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
@@ -153,44 +193,9 @@ void *qemu_ram_mmap(int fd,
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
+    ptr =3D mmap_populate(guardptr + offset, size, fd, shared, is_pmem);
     if (ptr =3D=3D MAP_FAILED) {
         munmap(guardptr, total);
         return MAP_FAILED;
--=20
2.24.1


