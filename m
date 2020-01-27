Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC145C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 22:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5B124656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 22:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESBWI0hU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5B124656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51783 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwD03-0004xi-Oe
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 17:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iwCww-0000BH-RI
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:33:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iwCwv-00033p-HC
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:33:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28220
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iwCwv-00032s-Cu
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580164420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Xt14BMrzYdnBAxqbGU3xzJeKtKwXL0sIRXnuxGHwEc=;
 b=ESBWI0hUvxO5hd0qsnI6tImOgDrXghoe7CcgwTkblYhqRhgGHAsqvyzb/8faYkrR+6f4Ba
 IZfU17al6FfKHpXyeQMJVzTO/zaD0+Y0dk/BjKja7FXc7zoDLKXpYXrOs+fQ9fm+Bq+ngc
 fxXtMaqDmcEwMWw7yWQLKJd/IScy8Us=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-oKgO4mwEN7ODkFQUQ-i9FQ-1; Mon, 27 Jan 2020 17:33:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F4EA800D4C
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 22:33:38 +0000 (UTC)
Received: from secure.mitica (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26EE2165D3;
 Mon, 27 Jan 2020 22:33:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/19] qemu-file: Don't do IO after shutdown
Date: Mon, 27 Jan 2020 23:33:05 +0100
Message-Id: <20200127223321.2742-4-quintela@redhat.com>
In-Reply-To: <20200127223321.2742-1-quintela@redhat.com>
References: <20200127223321.2742-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: oKgO4mwEN7ODkFQUQ-i9FQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Be sure that we are not doing neither read/write after shutdown of the
QEMUFile.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

---

Set error in case that there is none (dave)
---
 migration/qemu-file.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 26fb25ddc1..bbb2b63927 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -53,6 +53,8 @@ struct QEMUFile {
=20
     int last_error;
     Error *last_error_obj;
+    /* has the file has been shutdown */
+    bool shutdown;
 };
=20
 /*
@@ -61,10 +63,18 @@ struct QEMUFile {
  */
 int qemu_file_shutdown(QEMUFile *f)
 {
+    int ret;
+
+    f->shutdown =3D true;
     if (!f->ops->shut_down) {
         return -ENOSYS;
     }
-    return f->ops->shut_down(f->opaque, true, true, NULL);
+    ret =3D f->ops->shut_down(f->opaque, true, true, NULL);
+
+    if (!f->last_error) {
+        qemu_file_set_error(f, -EIO);
+    }
+    return ret;
 }
=20
 /*
@@ -214,6 +224,9 @@ void qemu_fflush(QEMUFile *f)
         return;
     }
=20
+    if (f->shutdown) {
+        return;
+    }
     if (f->iovcnt > 0) {
         expect =3D iov_size(f->iov, f->iovcnt);
         ret =3D f->ops->writev_buffer(f->opaque, f->iov, f->iovcnt, f->pos=
,
@@ -328,6 +341,10 @@ static ssize_t qemu_fill_buffer(QEMUFile *f)
     f->buf_index =3D 0;
     f->buf_size =3D pending;
=20
+    if (f->shutdown) {
+        return 0;
+    }
+
     len =3D f->ops->get_buffer(f->opaque, f->buf + pending, f->pos,
                              IO_BUF_SIZE - pending, &local_error);
     if (len > 0) {
@@ -642,6 +659,9 @@ int64_t qemu_ftell(QEMUFile *f)
=20
 int qemu_file_rate_limit(QEMUFile *f)
 {
+    if (f->shutdown) {
+        return 1;
+    }
     if (qemu_file_get_error(f)) {
         return 1;
     }
--=20
2.24.1


