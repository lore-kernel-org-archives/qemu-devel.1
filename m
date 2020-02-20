Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280A4C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:09:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E558C207FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGEXniXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E558C207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4oNq-0003E5-3Z
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:09:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4oMm-0001z6-9Q
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:07:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4oMk-0004E8-U4
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:07:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24080
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4oMk-0004C2-Op
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582214874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZmI4DNaB7Lj41ajhnkOeFKygDdymhC+3mP9r+G8Ea/g=;
 b=dGEXniXvKdX1t36BUWlrvsGcaup4vOuIXkjj/x4qiZv8hq9/fhNsq/gA+b5O38AhETZO2L
 AmDKNWuU3IOwk4v2x5RFLgxqN/w8kfBux6q0usoPfqHUSa4Npp2EWTSKvliwFgugj6mKU9
 oXSZeR6FTiDS0992kV0P9AXMPGUmHzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-P2TEEgwfNpKBwQYun54vqg-1; Thu, 20 Feb 2020 11:07:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97BCF8017CC;
 Thu, 20 Feb 2020 16:07:48 +0000 (UTC)
Received: from localhost (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76DCA5DA7C;
 Thu, 20 Feb 2020 16:07:37 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 01/18] docs: improve qcow2 spec about extending image header
Date: Thu, 20 Feb 2020 17:06:53 +0100
Message-Id: <20200220160710.533297-2-mreitz@redhat.com>
In-Reply-To: <20200220160710.533297-1-mreitz@redhat.com>
References: <20200220160710.533297-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: P2TEEgwfNpKBwQYun54vqg-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Make it more obvious how to add new fields to the version 3 header and
how to interpret them.

The specification is adjusted so that for new defined optional fields:

1. Software may support some of these optional fields and ignore the
   others, which means that features may be backported to downstream
   Qemu independently.
2. If we want to add incompatible field (or a field, for which some of
   its values would be incompatible), it must be accompanied by
   incompatible feature bit.

Also the concept of "default is zero" is clarified, as it's strange to
say that the value of the field is assumed to be zero for the software
version which don't know about the field at all and don't know how to
treat it be it zero or not.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200131142219.3264-2-vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
[mreitz: s/some its/some of its/]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 docs/interop/qcow2.txt | 45 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index af5711e533..823cc266e0 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -79,9 +79,9 @@ The first cluster of a qcow2 image contains the file head=
er:
                     Offset into the image file at which the snapshot table
                     starts. Must be aligned to a cluster boundary.
=20
-If the version is 3 or higher, the header has the following additional fie=
lds.
-For version 2, the values are assumed to be zero, unless specified otherwi=
se
-in the description of a field.
+For version 2, the header is exactly 72 bytes in length, and finishes here=
.
+For version 3 or higher, the header length is at least 104 bytes, includin=
g
+the next fields through header_length.
=20
          72 -  79:  incompatible_features
                     Bitmask of incompatible features. An implementation mu=
st
@@ -164,6 +164,45 @@ in the description of a field.
         100 - 103:  header_length
                     Length of the header structure in bytes. For version 2
                     images, the length is always assumed to be 72 bytes.
+                    For version 3 it's at least 104 bytes and must be a mu=
ltiple
+                    of 8.
+
+
+=3D=3D=3D Additional fields (version 3 and higher) =3D=3D=3D
+
+In general, these fields are optional and may be safely ignored by the sof=
tware,
+as well as filled by zeros (which is equal to field absence), if software =
needs
+to set field B, but does not care about field A which precedes B. More
+formally, additional fields have the following compatibility rules:
+
+1. If the value of the additional field must not be ignored for correct
+handling of the file, it will be accompanied by a corresponding incompatib=
le
+feature bit.
+
+2. If there are no unrecognized incompatible feature bits set, an unknown
+additional field may be safely ignored other than preserving its value whe=
n
+rewriting the image header.
+
+3. An explicit value of 0 will have the same behavior as when the field is=
 not
+present*, if not altered by a specific incompatible bit.
+
+*. A field is considered not present when header_length is less than or eq=
ual
+to the field's offset. Also, all additional fields are not present for
+version 2.
+
+        < ... No additional fields in the header currently ... >
+
+
+=3D=3D=3D Header padding =3D=3D=3D
+
+@header_length must be a multiple of 8, which means that if the end of the=
 last
+additional field is not aligned, some padding is needed. This padding must=
 be
+zeroed, so that if some existing (or future) additional field will fall in=
to
+the padding, it will be interpreted accordingly to point [3.] of the previ=
ous
+paragraph, i.e.  in the same manner as when this field is not present.
+
+
+=3D=3D=3D Header extensions =3D=3D=3D
=20
 Directly after the image header, optional sections called header extension=
s can
 be stored. Each extension has a structure like the following:
--=20
2.24.1


