Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0018CC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 15:29:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BECA321787
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 15:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyOb+Vsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECA321787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaLjw-0007QF-TB
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 10:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iaKaJ-0003ca-GA
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iaKaB-0000gu-34
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:15:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37116
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iaKaA-0000Zc-Tp
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574950545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bydEE1qnKs+JVZUR+AXSzVH6gywXJ4tlI8Hls5A/xa0=;
 b=FyOb+VsrGBGQI4oBKFKXsOBlL9bY9Yi7d4H5aLNntiaXNNANQeY0imVMhi9gLhoJiq86LZ
 crkxuAOSWvUvKBd+UXqpjDTUmqxYCE1CbmVaGJnU0GRvw4mnKdLUUIBLODnHJ7hFvrjeBm
 aaIGTON/idvvuWGFb3y0hNglR6+XVwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-nrqXq9XFNL60ksPtM-kCbw-1; Thu, 28 Nov 2019 09:15:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E1CB8017CC;
 Thu, 28 Nov 2019 14:15:43 +0000 (UTC)
Received: from localhost (ovpn-112-17.ams2.redhat.com [10.36.112.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79D65600CC;
 Thu, 28 Nov 2019 14:15:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] memfd: add qemu_memfd_open()
Date: Thu, 28 Nov 2019 18:15:17 +0400
Message-Id: <20191128141518.628245-2-marcandre.lureau@redhat.com>
In-Reply-To: <20191128141518.628245-1-marcandre.lureau@redhat.com>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: nrqXq9XFNL60ksPtM-kCbw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Refactor qemu_memfd_alloc() to simply return the opened fd.

mmap() can be done later by the caller.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/memfd.h |  3 +++
 util/memfd.c         | 39 +++++++++++++++++++++++++--------------
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
index 975b6bdb77..1642af9459 100644
--- a/include/qemu/memfd.h
+++ b/include/qemu/memfd.h
@@ -44,4 +44,7 @@ void *qemu_memfd_alloc(const char *name, size_t size, uns=
igned int seals,
 void qemu_memfd_free(void *ptr, size_t size, int fd);
 bool qemu_memfd_check(unsigned int flags);
=20
+int qemu_memfd_open(const char *name, size_t size,
+                    unsigned int seals, Error **errp);
+
 #endif /* QEMU_MEMFD_H */
diff --git a/util/memfd.c b/util/memfd.c
index 4a3c07e0be..523b943b62 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -104,10 +104,9 @@ err:
  * memfd with sealing, but may fallback on other methods without
  * sealing.
  */
-void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals,
-                       int *fd, Error **errp)
+int qemu_memfd_open(const char *name, size_t size, unsigned int seals,
+                    Error **errp)
 {
-    void *ptr;
     int mfd =3D qemu_memfd_create(name, size, false, 0, seals, NULL);
=20
     /* some systems have memfd without sealing */
@@ -124,26 +123,38 @@ void *qemu_memfd_alloc(const char *name, size_t size,=
 unsigned int seals,
         unlink(fname);
         g_free(fname);
=20
-        if (mfd =3D=3D -1 ||
-            ftruncate(mfd, size) =3D=3D -1) {
-            goto err;
+        if (mfd !=3D -1 && ftruncate(mfd, size) =3D=3D -1) {
+            close(mfd);
+            mfd =3D -1;
         }
     }
=20
+    if (mfd =3D=3D -1) {
+        error_setg_errno(errp, errno, "qemu_memfd_open() failed");
+    }
+
+    return mfd;
+}
+
+void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals,
+                       int *fd, Error **errp)
+{
+    int mfd =3D qemu_memfd_open(name, size, seals, errp);
+    void *ptr;
+
+    if (mfd =3D=3D -1) {
+        return NULL;
+    }
+
     ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
     if (ptr =3D=3D MAP_FAILED) {
-        goto err;
+        error_setg_errno(errp, errno, "failed to allocate shared memory");
+        close(mfd);
+        return NULL;
     }
=20
     *fd =3D mfd;
     return ptr;
-
-err:
-    error_setg_errno(errp, errno, "failed to allocate shared memory");
-    if (mfd >=3D 0) {
-        close(mfd);
-    }
-    return NULL;
 }
=20
 void qemu_memfd_free(void *ptr, size_t size, int fd)
--=20
2.24.0


