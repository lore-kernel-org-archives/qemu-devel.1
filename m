Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5EFC33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:35:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B65E12077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEbQyRHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65E12077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iucdd-0002Te-0k
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:35:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iub9B-0002XH-VE
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iub9A-0005G2-Lf
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35628
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iub9A-0005FI-I2
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IEGaL9aFkkAtsNAhoj+NL8XMOR+mvE9/kShd09JYqiA=;
 b=aEbQyRHGblLT54natn9EuTeUl3h992MUeQxzJ1zpN6aMsu3/dlgyCVRlsqj0G4x+oRVVeA
 4oXJwyzmmq4SaPbwmf8h8TD0hHdDqGD++zGgBKTSrb6pifgGMssh5pFqQjkraXq5nNwLjF
 4wm43t/R4ccSVhXwP71WU0ThYdAXVQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-Hkk3jagTNCi13xvHdM79lw-1; Thu, 23 Jan 2020 06:59:38 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64A96800D50
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:37 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B38F685754;
 Thu, 23 Jan 2020 11:59:36 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 043/111] virtiofsd: add fuse_mbuf_iter API
Date: Thu, 23 Jan 2020 11:57:33 +0000
Message-Id: <20200123115841.138849-44-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Hkk3jagTNCi13xvHdM79lw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Introduce an API for consuming bytes from a buffer with size checks.
All FUSE operations will be converted to use this safe API instead of
void *inarg.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/buffer.c      | 28 ++++++++++++++++++++
 tools/virtiofsd/fuse_common.h | 49 ++++++++++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/tools/virtiofsd/buffer.c b/tools/virtiofsd/buffer.c
index 772efa922d..42a608f6bd 100644
--- a/tools/virtiofsd/buffer.c
+++ b/tools/virtiofsd/buffer.c
@@ -267,3 +267,31 @@ ssize_t fuse_buf_copy(struct fuse_bufvec *dstv, struct=
 fuse_bufvec *srcv)
=20
     return copied;
 }
+
+void *fuse_mbuf_iter_advance(struct fuse_mbuf_iter *iter, size_t len)
+{
+    void *ptr;
+
+    if (len > iter->size - iter->pos) {
+        return NULL;
+    }
+
+    ptr =3D iter->mem + iter->pos;
+    iter->pos +=3D len;
+    return ptr;
+}
+
+const char *fuse_mbuf_iter_advance_str(struct fuse_mbuf_iter *iter)
+{
+    const char *str =3D iter->mem + iter->pos;
+    size_t remaining =3D iter->size - iter->pos;
+    size_t i;
+
+    for (i =3D 0; i < remaining; i++) {
+        if (str[i] =3D=3D '\0') {
+            iter->pos +=3D i + 1;
+            return str;
+        }
+    }
+    return NULL;
+}
diff --git a/tools/virtiofsd/fuse_common.h b/tools/virtiofsd/fuse_common.h
index 0cb33acc2f..f8f6433743 100644
--- a/tools/virtiofsd/fuse_common.h
+++ b/tools/virtiofsd/fuse_common.h
@@ -703,10 +703,57 @@ size_t fuse_buf_size(const struct fuse_bufvec *bufv);
  */
 ssize_t fuse_buf_copy(struct fuse_bufvec *dst, struct fuse_bufvec *src);
=20
+/**
+ * Memory buffer iterator
+ *
+ */
+struct fuse_mbuf_iter {
+    /**
+     * Data pointer
+     */
+    void *mem;
+
+    /**
+     * Total length, in bytes
+     */
+    size_t size;
+
+    /**
+     * Offset from start of buffer
+     */
+    size_t pos;
+};
+
+/* Initialize memory buffer iterator from a fuse_buf */
+#define FUSE_MBUF_ITER_INIT(fbuf) \
+    ((struct fuse_mbuf_iter){     \
+        .mem =3D fbuf->mem,         \
+        .size =3D fbuf->size,       \
+        .pos =3D 0,                 \
+    })
+
+/**
+ * Consume bytes from a memory buffer iterator
+ *
+ * @param iter memory buffer iterator
+ * @param len number of bytes to consume
+ * @return pointer to start of consumed bytes or
+ *         NULL if advancing beyond end of buffer
+ */
+void *fuse_mbuf_iter_advance(struct fuse_mbuf_iter *iter, size_t len);
+
+/**
+ * Consume a NUL-terminated string from a memory buffer iterator
+ *
+ * @param iter memory buffer iterator
+ * @return pointer to the string or
+ *         NULL if advancing beyond end of buffer or there is no NUL-termi=
nator
+ */
+const char *fuse_mbuf_iter_advance_str(struct fuse_mbuf_iter *iter);
+
 /*
  * Signal handling
  */
-
 /**
  * Exit session on HUP, TERM and INT signals and ignore PIPE signal
  *
--=20
2.24.1


