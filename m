Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E3EC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E836D2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcUvN3tB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E836D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iygXz-0001Q7-5L
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 13:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iygWH-000848-2W
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iygWD-0001jk-Mf
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24087
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iygWD-0001fA-DQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580754738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iotoBDjapXBODfuOrmI0IiH4IjpUHAEYPrSI8vW5zX4=;
 b=YcUvN3tBQ6OaHRf1MyGXRlQsmoIlHpRXfv+RBVqDacdGAQtPYl+ItxAzfTLV/9sz4y63ef
 BMaD2W1piKgcrFNapbcfOaziSHevZfSbjB0btFOOhSnWXGuaW5y252IlG0PiUTjwdsiyz4
 +jidr44e1KMLZznmaMINl0xqqKQNg3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-dBTHPXKnNYetJeBZc9Skug-1; Mon, 03 Feb 2020 13:32:07 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8256800D4E;
 Mon,  3 Feb 2020 18:32:05 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-77.ams2.redhat.com [10.36.117.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D63345D9CA;
 Mon,  3 Feb 2020 18:32:02 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 07/13] util/mmap-alloc: Factor out populating of memory to
 mmap_populate()
Date: Mon,  3 Feb 2020 19:31:19 +0100
Message-Id: <20200203183125.164879-8-david@redhat.com>
In-Reply-To: <20200203183125.164879-1-david@redhat.com>
References: <20200203183125.164879-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: dBTHPXKnNYetJeBZc9Skug-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

We want to populate memory within a reserved memory region. Let's factor
that out.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Greg Kurz <groug@kaod.org>
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 util/mmap-alloc.c | 89 +++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 42 deletions(-)

diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 43a26f38a8..f043ccb0ab 100644
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
+    void *new_ptr;
+
+    flags |=3D fd =3D=3D -1 ? MAP_ANONYMOUS : 0;
+    flags |=3D shared ? MAP_SHARED : MAP_PRIVATE;
+    if (shared && is_pmem) {
+        map_sync_flags =3D MAP_SYNC | MAP_SHARED_VALIDATE;
+    }
+
+    new_ptr =3D mmap(ptr, size, PROT_READ | PROT_WRITE, flags | map_sync_f=
lags,
+                   fd, 0);
+    if (new_ptr =3D=3D MAP_FAILED && map_sync_flags) {
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
+        new_ptr =3D mmap(ptr, size, PROT_READ | PROT_WRITE, flags, fd, 0);
+    }
+    return new_ptr;
+}
+
 static inline size_t mmap_pagesize(int fd)
 {
 #if defined(__powerpc64__) && defined(__linux__)
@@ -131,12 +175,8 @@ void *qemu_ram_mmap(int fd,
                     bool is_pmem)
 {
     const size_t pagesize =3D mmap_pagesize(fd);
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
     assert(align >=3D pagesize);
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


