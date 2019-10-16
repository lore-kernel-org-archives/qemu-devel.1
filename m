Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE026FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 19:26:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95DF92053B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 19:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DF92053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKowE-00039V-Lu
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 15:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iKoug-0001Fo-J9
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 15:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iKoue-0002Lx-Jl
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 15:24:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1iKouZ-0002GC-7r; Wed, 16 Oct 2019 15:24:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1608481F0C;
 Wed, 16 Oct 2019 19:24:39 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FE9060127;
 Wed, 16 Oct 2019 19:24:36 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/10] image-fuzzer: Open image files in binary mode
Date: Wed, 16 Oct 2019 16:24:21 -0300
Message-Id: <20191016192430.25098-2-ehabkost@redhat.com>
In-Reply-To: <20191016192430.25098-1-ehabkost@redhat.com>
References: <20191016192430.25098-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 16 Oct 2019 19:24:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This probably never caused problems because on Linux there's no
actual newline conversion happening, but on Python 3 the
binary/text distinction is stronger and we must explicitly open
the image file in binary mode.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/image-fuzzer/qcow2/layout.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/image-fuzzer/qcow2/layout.py b/tests/image-fuzzer/qcow=
2/layout.py
index 675877da96..c57418fa15 100644
--- a/tests/image-fuzzer/qcow2/layout.py
+++ b/tests/image-fuzzer/qcow2/layout.py
@@ -503,7 +503,7 @@ class Image(object):
=20
     def write(self, filename):
         """Write an entire image to the file."""
-        image_file =3D open(filename, 'w')
+        image_file =3D open(filename, 'wb')
         for field in self:
             image_file.seek(field.offset)
             image_file.write(struct.pack(field.fmt, field.value))
--=20
2.21.0


