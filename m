Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F92C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD34220721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMf2jpOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD34220721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyggc-000609-0I
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 13:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iygWQ-0008LB-K6
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iygWP-00029o-5b
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23202
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iygWO-00028L-Vq
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580754752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pvpRP4j40p+bep+sPtrcb2kETzpSStuVctnhP/5qKq8=;
 b=XMf2jpOm3WfbzX5/WeA0YUouI8uS+m6nytrYJ0Ma+NtYWIkVllmsUNCBz0d2r7ZAYmU9bh
 6s5D7/2/NXwwizbH6tkZlp/MGrU+7MAcZNPK2A02iAwbIfGkEaZS55gwZqUkxiiBICfois
 HTOWUcPA25QCnjzXbVRI6u6tD+86jzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-46IHe5muO7aZykon3JLYSg-1; Mon, 03 Feb 2020 13:32:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E16EF800D4C;
 Mon,  3 Feb 2020 18:32:27 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-77.ams2.redhat.com [10.36.117.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B19EA5D9CA;
 Mon,  3 Feb 2020 18:32:24 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 12/13] util: oslib: Resizable anonymous allocations under
 POSIX
Date: Mon,  3 Feb 2020 19:31:24 +0100
Message-Id: <20200203183125.164879-13-david@redhat.com>
In-Reply-To: <20200203183125.164879-1-david@redhat.com>
References: <20200203183125.164879-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 46IHe5muO7aZykon3JLYSg-1
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
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce qemu_anon_ram_alloc_resizable() and qemu_anon_ram_resize().
Implement them under POSIX and make them return NULL under WIN32.

Under POSIX, we make use of resizable mmaps. An implementation under
WIN32 is theoretically possible AFAIK and can be added later.

In qemu_anon_ram_free(), rename the size parameter to max_size, to make
it clearer that we have to use the maximum size when freeing resizable
anonymous allocations.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Stefan Weil <sw@weilnetz.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/qemu/osdep.h |  6 +++++-
 util/oslib-posix.c   | 37 ++++++++++++++++++++++++++++++++++---
 util/oslib-win32.c   | 14 ++++++++++++++
 util/trace-events    |  4 +++-
 4 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 9bd3dcfd13..57b7f40f56 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -311,8 +311,12 @@ int qemu_daemon(int nochdir, int noclose);
 void *qemu_try_memalign(size_t alignment, size_t size);
 void *qemu_memalign(size_t alignment, size_t size);
 void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared);
+void *qemu_anon_ram_alloc_resizable(size_t size, size_t max_size,
+                                    uint64_t *align, bool shared);
+void *qemu_anon_ram_resize(void *ptr, size_t old_size, size_t new_size,
+                           bool shared);
 void qemu_vfree(void *ptr);
-void qemu_anon_ram_free(void *ptr, size_t size);
+void qemu_anon_ram_free(void *ptr, size_t max_size);
=20
 #define QEMU_MADV_INVALID -1
=20
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 5a291cc982..e487a0e2c2 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -219,16 +219,47 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t *alig=
nment, bool shared)
     return ptr;
 }
=20
+void *qemu_anon_ram_alloc_resizable(size_t size, size_t max_size,
+                                    uint64_t *alignment, bool shared)
+{
+    size_t align =3D QEMU_VMALLOC_ALIGN;
+    void *ptr =3D qemu_ram_mmap_resizable(-1, size, max_size, align, share=
d,
+                                        false);
+
+    if (ptr =3D=3D MAP_FAILED) {
+        return NULL;
+    }
+
+    if (alignment) {
+        *alignment =3D align;
+    }
+
+    trace_qemu_anon_ram_alloc_resizable(size, max_size, ptr);
+    return ptr;
+}
+
+void *qemu_anon_ram_resize(void *ptr, size_t old_size, size_t new_size,
+                           bool shared)
+{
+    ptr =3D qemu_ram_mmap_resize(ptr, -1, old_size, new_size, shared, fals=
e);
+    if (ptr =3D=3D MAP_FAILED) {
+        return NULL;
+    }
+
+    trace_qemu_anon_ram_resize(old_size, new_size, ptr);
+    return ptr;
+}
+
 void qemu_vfree(void *ptr)
 {
     trace_qemu_vfree(ptr);
     free(ptr);
 }
=20
-void qemu_anon_ram_free(void *ptr, size_t size)
+void qemu_anon_ram_free(void *ptr, size_t max_size)
 {
-    trace_qemu_anon_ram_free(ptr, size);
-    qemu_ram_munmap(-1, ptr, size);
+    trace_qemu_anon_ram_free(ptr, max_size);
+    qemu_ram_munmap(-1, ptr, max_size);
 }
=20
 void qemu_set_block(int fd)
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index e9b14ab178..caec028041 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -90,6 +90,20 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t *align, =
bool shared)
     return ptr;
 }
=20
+void *qemu_anon_ram_alloc_resizable(size_t size, size_t max_size,
+                                    uint64_t *align, bool shared)
+{
+    /* resizable ram not implemented yet */
+    return NULL;
+}
+
+void *qemu_anon_ram_resize(void *ptr, size_t old_size, size_t new_size,
+                           bool shared)
+{
+    /* resizable ram not implemented yet */
+    return NULL;
+}
+
 void qemu_vfree(void *ptr)
 {
     trace_qemu_vfree(ptr);
diff --git a/util/trace-events b/util/trace-events
index 226f406c46..05ec1eb9f3 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -46,8 +46,10 @@ qemu_co_mutex_unlock_return(void *mutex, void *self) "mu=
tex %p self %p"
 # oslib-posix.c
 qemu_memalign(size_t alignment, size_t size, void *ptr) "alignment %zu siz=
e %zu ptr %p"
 qemu_anon_ram_alloc(size_t size, void *ptr) "size %zu ptr %p"
+qemu_anon_ram_alloc_resizable(size_t size, size_t max_size, void *ptr) "si=
ze %zu max_size %zu ptr %p"
+qemu_anon_ram_resize(size_t old_size, size_t new_size, void *ptr) "old_siz=
e %zu new_size %zu ptr %p"
 qemu_vfree(void *ptr) "ptr %p"
-qemu_anon_ram_free(void *ptr, size_t size) "ptr %p size %zu"
+qemu_anon_ram_free(void *ptr, size_t max_size) "ptr %p max_size %zu"
=20
 # hbitmap.c
 hbitmap_iter_skip_words(const void *hb, void *hbi, uint64_t pos, unsigned =
long cur) "hb %p hbi %p pos %"PRId64" cur 0x%lx"
--=20
2.24.1


