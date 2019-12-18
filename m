Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95087C2D0C3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 05:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A71F20733
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 05:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDbN3Glo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A71F20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihRZ0-0002Av-FV
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 00:07:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ihRW1-0006vW-Rt
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 00:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ihRVv-0003Z4-FZ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 00:04:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34513
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ihRVv-0003XK-2v
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 00:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576645486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f8pG+ePynhpBGfAMaIg4eXtSkCZio1rbAzzHRQGEB9s=;
 b=BDbN3Glo1+2y9k0W8gd57FPVfTyO61e80YCaWqqgbB2Qcg+IArLP13NnNEREH4BnsXegQz
 Ws9wapY8R3DsQf4ZOopv5XQ09L18XiTZnmVD7ZEzEZ52FYIQ+355n6ERAXbSecmPGzilLc
 sO5nQ2u8ba9zdI9Ru2IcnezZ4UUFRw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-BneBhDcoOXeCM9MFALv5wg-1; Wed, 18 Dec 2019 00:04:45 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57D6910CE7A9
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 05:04:44 +0000 (UTC)
Received: from secure.mitica (ovpn-116-32.ams2.redhat.com [10.36.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D53575D9E1;
 Wed, 18 Dec 2019 05:04:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] qemu-file: Don't do IO after shutdown
Date: Wed, 18 Dec 2019 06:04:36 +0100
Message-Id: <20191218050439.5989-2-quintela@redhat.com>
In-Reply-To: <20191218050439.5989-1-quintela@redhat.com>
References: <20191218050439.5989-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: BneBhDcoOXeCM9MFALv5wg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Be sure that we are not doing neither read/write after shutdown of the
QEMUFile.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 26fb25ddc1..1e5543a279 100644
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
@@ -61,6 +63,7 @@ struct QEMUFile {
  */
 int qemu_file_shutdown(QEMUFile *f)
 {
+    f->shutdown =3D true;
     if (!f->ops->shut_down) {
         return -ENOSYS;
     }
@@ -214,6 +217,9 @@ void qemu_fflush(QEMUFile *f)
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
@@ -328,6 +334,10 @@ static ssize_t qemu_fill_buffer(QEMUFile *f)
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
@@ -642,6 +652,9 @@ int64_t qemu_ftell(QEMUFile *f)
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
2.23.0


