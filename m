Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4406EC4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 195D42081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195D42081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Q79-0001io-UN
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i8PUy-0007Ky-HI
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i8PUx-0003Hq-CG
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:51:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60981)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i8PUx-0003HN-4f
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:50:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 72DAC190C006;
 Thu, 12 Sep 2019 13:50:58 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21E445D704;
 Thu, 12 Sep 2019 13:50:56 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, ivanren@tencent.com, peterx@redhat.com,
 richardw.yang@linux.intel.com, yury-kotov@yandex-team.ru,
 quintela@redhat.com
Date: Thu, 12 Sep 2019 14:50:05 +0100
Message-Id: <20190912135006.14820-12-dgilbert@redhat.com>
In-Reply-To: <20190912135006.14820-1-dgilbert@redhat.com>
References: <20190912135006.14820-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Thu, 12 Sep 2019 13:50:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/12] migration/qemu-file: fix potential buf
 waste for extra buf_index adjustment
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

From: Wei Yang <richardw.yang@linux.intel.com>

In add_to_iovec(), qemu_fflush() will be called if iovec is full. If
this happens, buf_index is reset. Currently, this is not checked and
buf_index would always been adjust with buf size.

This is not harmful, but will waste some space in file buffer.

This patch make add_to_iovec() return 1 when it has flushed the file.
Then the caller could check the return value to see whether it is
necessary to adjust the buf_index any more.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Message-Id: <20190911132839.23336-3-richard.weiyang@gmail.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/qemu-file.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 66627088d4..26fb25ddc1 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -381,8 +381,16 @@ int qemu_fclose(QEMUFile *f)
     return ret;
 }
=20
-static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
-                         bool may_free)
+/*
+ * Add buf to iovec. Do flush if iovec is full.
+ *
+ * Return values:
+ * 1 iovec is full and flushed
+ * 0 iovec is not flushed
+ *
+ */
+static int add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
+                        bool may_free)
 {
     /* check for adjacent buffer and coalesce them */
     if (f->iovcnt > 0 && buf =3D=3D f->iov[f->iovcnt - 1].iov_base +
@@ -400,6 +408,19 @@ static void add_to_iovec(QEMUFile *f, const uint8_t =
*buf, size_t size,
=20
     if (f->iovcnt >=3D MAX_IOV_SIZE) {
         qemu_fflush(f);
+        return 1;
+    }
+
+    return 0;
+}
+
+static void add_buf_to_iovec(QEMUFile *f, size_t len)
+{
+    if (!add_to_iovec(f, f->buf + f->buf_index, len, false)) {
+        f->buf_index +=3D len;
+        if (f->buf_index =3D=3D IO_BUF_SIZE) {
+            qemu_fflush(f);
+        }
     }
 }
=20
@@ -429,11 +450,7 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf=
, size_t size)
         }
         memcpy(f->buf + f->buf_index, buf, l);
         f->bytes_xfer +=3D l;
-        add_to_iovec(f, f->buf + f->buf_index, l, false);
-        f->buf_index +=3D l;
-        if (f->buf_index =3D=3D IO_BUF_SIZE) {
-            qemu_fflush(f);
-        }
+        add_buf_to_iovec(f, l);
         if (qemu_file_get_error(f)) {
             break;
         }
@@ -450,11 +467,7 @@ void qemu_put_byte(QEMUFile *f, int v)
=20
     f->buf[f->buf_index] =3D v;
     f->bytes_xfer++;
-    add_to_iovec(f, f->buf + f->buf_index, 1, false);
-    f->buf_index++;
-    if (f->buf_index =3D=3D IO_BUF_SIZE) {
-        qemu_fflush(f);
-    }
+    add_buf_to_iovec(f, 1);
 }
=20
 void qemu_file_skip(QEMUFile *f, int size)
@@ -760,11 +773,7 @@ ssize_t qemu_put_compression_data(QEMUFile *f, z_str=
eam *stream,
     }
=20
     qemu_put_be32(f, blen);
-    add_to_iovec(f, f->buf + f->buf_index, blen, false);
-    f->buf_index +=3D blen;
-    if (f->buf_index =3D=3D IO_BUF_SIZE) {
-        qemu_fflush(f);
-    }
+    add_buf_to_iovec(f, blen);
     return blen + sizeof(int32_t);
 }
=20
--=20
2.21.0


