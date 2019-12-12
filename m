Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10269C2D0C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E7D2253D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJG78EEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E7D2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifS1Q-0000LW-8S
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVi-0005t2-Lq
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVh-0002Hp-HT
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:18 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39113
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRVh-0002H4-CS
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WG+Al5te8uqZSlxkLLc9k3C99FeovJnhxsjdX0wcZlg=;
 b=TJG78EEVU4t1mNHKKv49P0SdL9SVddqXbrFhCaM25HcD+8cEUW4wqGpQS+aQvjnPW93yfy
 SglUtPt33Sxb78V0IIJuJt3I5WIB/08d7w/qd1toMBkxUH+W0BsO5GCiptziYR7LVN1pnE
 EVNqU5uvgoqq/C42P6aS5vrOAo4pBg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-nd6nUNfSNjuPXYOw0flkMQ-1; Thu, 12 Dec 2019 11:40:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B6BD8017DF
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:14 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99A0C60BE1;
 Thu, 12 Dec 2019 16:40:13 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 041/104] virtiofsd: add fuse_mbuf_iter API
Date: Thu, 12 Dec 2019 16:38:01 +0000
Message-Id: <20191212163904.159893-42-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: nd6nUNfSNjuPXYOw0flkMQ-1
X-Mimecast-Spam-Score: 0
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Introduce an API for consuming bytes from a buffer with size checks.
All FUSE operations will be converted to use this safe API instead of
void *inarg.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/buffer.c      | 28 ++++++++++++++++++++
 tools/virtiofsd/fuse_common.h | 49 ++++++++++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/tools/virtiofsd/buffer.c b/tools/virtiofsd/buffer.c
index 1d7e6d2439..f59d8d72eb 100644
--- a/tools/virtiofsd/buffer.c
+++ b/tools/virtiofsd/buffer.c
@@ -338,3 +338,31 @@ ssize_t fuse_buf_copy(struct fuse_bufvec *dstv, struct=
 fuse_bufvec *srcv,
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
index 7bed38b436..147c043bd9 100644
--- a/tools/virtiofsd/fuse_common.h
+++ b/tools/virtiofsd/fuse_common.h
@@ -771,10 +771,57 @@ size_t fuse_buf_size(const struct fuse_bufvec *bufv);
 ssize_t fuse_buf_copy(struct fuse_bufvec *dst, struct fuse_bufvec *src,
                       enum fuse_buf_copy_flags flags);
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
2.23.0


