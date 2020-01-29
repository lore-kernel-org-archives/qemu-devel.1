Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B50C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE54620708
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5q6NuNR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE54620708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwlQf-0003uD-0x
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 06:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iwlKt-0002Uo-Us
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iwlKs-0006f7-Sj
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53547
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iwlKs-0006ev-Ok
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580296602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hjjwn0fOpYN/gfMzUwOqi6F4cm4+9cIjd+x69SSGxI4=;
 b=M5q6NuNRHz+DzTdvIrc+I/8sDCv9h3svSuXO73Xah2ZoFTyDhgII1eOAYp54QDB4ZIlf7X
 T2v4z03nmz8xMylNUnLcNIPHXJkyityBb/KnE+Dh7kwHmySctKhLog2jzh7Wd8QNjtavaJ
 /1u6/fRBEPOQbLRuM7SknUk6Lh9OnPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-2n1jwJJYM1ug131zSFiebQ-1; Wed, 29 Jan 2020 06:16:40 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 876CF8F70C1;
 Wed, 29 Jan 2020 11:16:39 +0000 (UTC)
Received: from secure.mitica (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2E0F89D2E;
 Wed, 29 Jan 2020 11:16:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/18] migration/compress: compress QEMUFile is not writable
Date: Wed, 29 Jan 2020 12:15:36 +0100
Message-Id: <20200129111536.9497-19-quintela@redhat.com>
In-Reply-To: <20200129111536.9497-1-quintela@redhat.com>
References: <20200129111536.9497-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 2n1jwJJYM1ug131zSFiebQ-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

We open a file with empty_ops for compress QEMUFile, which means this is
not writable.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index bbb2b63927..1c3a358a14 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -764,11 +764,8 @@ static int qemu_compress_data(z_stream *stream, uint8_=
t *dest, size_t dest_len,
 /* Compress size bytes of data start at p and store the compressed
  * data to the buffer of f.
  *
- * When f is not writable, return -1 if f has no space to save the
- * compressed data.
- * When f is wirtable and it has no space to save the compressed data,
- * do fflush first, if f still has no space to save the compressed
- * data, return -1.
+ * Since the file is dummy file with empty_ops, return -1 if f has no spac=
e to
+ * save the compressed data.
  */
 ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
                                   const uint8_t *p, size_t size)
@@ -776,14 +773,7 @@ ssize_t qemu_put_compression_data(QEMUFile *f, z_strea=
m *stream,
     ssize_t blen =3D IO_BUF_SIZE - f->buf_index - sizeof(int32_t);
=20
     if (blen < compressBound(size)) {
-        if (!qemu_file_is_writable(f)) {
-            return -1;
-        }
-        qemu_fflush(f);
-        blen =3D IO_BUF_SIZE - sizeof(int32_t);
-        if (blen < compressBound(size)) {
-            return -1;
-        }
+        return -1;
     }
=20
     blen =3D qemu_compress_data(stream, f->buf + f->buf_index + sizeof(int=
32_t),
--=20
2.24.1


