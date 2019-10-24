Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB6DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 399AC20679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdE1jLB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399AC20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNc3S-00065r-Ev
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHo-0003GS-J7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHn-0008TE-Dr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50524
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbHm-0008Sy-Sp
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+IxB5R0x4aUhCeuirwTc4hU5TPC0nIUl6huZc5Eur7A=;
 b=UdE1jLB+/UcZNsGPN7OmeoFtn6yz42Brr4zY44iZc6Ztnf7HL5jmXBsItFZXamKhV00faf
 l1ENPmN6CoP0wSS3DJEamUl1RAU2s4qrIqdu5vvGZgNYsBrdCBK2ZAtKNgHhMfut6M+gHB
 7JXH0xOGAB6vO4Az6ATQBWgnmCa+FAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-qPXe8UQsOJ6oyvQWoGTbvA-1; Thu, 24 Oct 2019 07:28:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81F99800D49;
 Thu, 24 Oct 2019 11:28:05 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0A11196B2;
 Thu, 24 Oct 2019 11:27:57 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 10/25] virtiofsd: add fuse_mbuf_iter API
Date: Thu, 24 Oct 2019 12:27:03 +0100
Message-Id: <20191024112718.34657-11-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: qPXe8UQsOJ6oyvQWoGTbvA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Introduce an API for consuming bytes from a buffer with size checks.
All FUSE operations will be converted to use this safe API instead of
void *inarg.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/buffer.c      | 28 +++++++++++++++++++
 contrib/virtiofsd/fuse_common.h | 48 +++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/contrib/virtiofsd/buffer.c b/contrib/virtiofsd/buffer.c
index 3c9b443fa0..2a0d123bde 100644
--- a/contrib/virtiofsd/buffer.c
+++ b/contrib/virtiofsd/buffer.c
@@ -316,3 +316,31 @@ ssize_t fuse_buf_copy(struct fuse_bufvec *dstv, struct=
 fuse_bufvec *srcv,
=20
 =09return copied;
 }
+
+void *fuse_mbuf_iter_advance(struct fuse_mbuf_iter *iter, size_t len)
+{
+=09void *ptr;
+
+=09if (len > iter->size - iter->pos) {
+=09=09return NULL;
+=09}
+
+=09ptr =3D iter->mem + iter->pos;
+=09iter->pos +=3D len;
+=09return ptr;
+}
+
+const char *fuse_mbuf_iter_advance_str(struct fuse_mbuf_iter *iter)
+{
+=09const char *str =3D iter->mem + iter->pos;
+=09size_t remaining =3D iter->size - iter->pos;
+=09size_t i;
+
+=09for (i =3D 0; i < remaining; i++) {
+=09=09if (str[i] =3D=3D '\0') {
+=09=09=09iter->pos +=3D i + 1;
+=09=09=09return str;
+=09=09}
+=09}
+=09return NULL;
+}
diff --git a/contrib/virtiofsd/fuse_common.h b/contrib/virtiofsd/fuse_commo=
n.h
index 2d686b2ac4..b5b6d270fe 100644
--- a/contrib/virtiofsd/fuse_common.h
+++ b/contrib/virtiofsd/fuse_common.h
@@ -760,6 +760,54 @@ size_t fuse_buf_size(const struct fuse_bufvec *bufv);
 ssize_t fuse_buf_copy(struct fuse_bufvec *dst, struct fuse_bufvec *src,
 =09=09      enum fuse_buf_copy_flags flags);
=20
+/**
+ * Memory buffer iterator
+ *
+ */
+struct fuse_mbuf_iter {
+=09/**
+=09 * Data pointer
+=09 */
+=09void *mem;
+
+=09/**
+=09 * Total length, in bytes
+=09 */
+=09size_t size;
+
+=09/**
+=09 * Offset from start of buffer
+=09 */
+=09size_t pos;
+};
+
+/* Initialize memory buffer iterator from a fuse_buf */
+#define FUSE_MBUF_ITER_INIT(fbuf) \
+=09((struct fuse_mbuf_iter) { \
+=09=09 .mem =3D fbuf->mem, \
+=09=09 .size =3D fbuf->size, \
+=09=09 .pos =3D 0, \
+=09})
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
 /* ----------------------------------------------------------- *
  * Signal handling=09=09=09=09=09       *
  * ----------------------------------------------------------- */
--=20
2.23.0


