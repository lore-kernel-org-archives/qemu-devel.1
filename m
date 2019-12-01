Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4E2C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9669E20725
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MP3Vimsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9669E20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibNQ3-0006z7-Hm
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 06:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNEG-00026N-NH
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:17:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNEF-0000Rl-Kp
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:17:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43266
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ibNEF-0000RY-Dg
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575199047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+uLCAof6wmZgo9xME7qRxr2HMptzayyaXeCCwfeR8RA=;
 b=MP3Vimsnvg5Ph8RxBaNzcN1sQsr9vm0Kpge+tMB2PGUWvi2XlOl8CjKG03vwPMPsjmx7qX
 uIvxyK9IHkY73urrAfYZn6VVtDhSNo5FAKYn8XY5Fwsmh03/Ss52DfeAgFCbzRZHrwgROk
 xf98bLzt1VgtQMhSK85UF+9QtAF64z8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-u0BDXnoKOxCXbYAfpc2v-A-1; Sun, 01 Dec 2019 06:17:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FCE6184CABB
 for <qemu-devel@nongnu.org>; Sun,  1 Dec 2019 11:17:25 +0000 (UTC)
Received: from localhost (unknown [10.36.112.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46D175D6A0;
 Sun,  1 Dec 2019 11:17:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/26] object: do not free class properties
Date: Sun,  1 Dec 2019 15:15:16 +0400
Message-Id: <20191201111531.1136947-12-marcandre.lureau@redhat.com>
In-Reply-To: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: u0BDXnoKOxCXbYAfpc2v-A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The release callback is called during object_property_del_all(), on a
live instance. But class properties are common among all
instances. It is not currently called, because we don't release
classes, but it would not the right callback anyway.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qom/object.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 63d489553c..55c690d62b 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2110,7 +2110,7 @@ object_class_property_add_str(ObjectClass *klass, con=
st char *name,
     rv =3D object_class_property_add(klass, name, "string",
                               get ? property_get_str : NULL,
                               set ? property_set_str : NULL,
-                              property_release_str,
+                              NULL,
                               prop, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -2203,7 +2203,7 @@ object_class_property_add_bool(ObjectClass *klass, co=
nst char *name,
     rv =3D object_class_property_add(klass, name, "bool",
                               get ? property_get_bool : NULL,
                               set ? property_set_bool : NULL,
-                              property_release_bool,
+                              NULL,
                               prop, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -2295,7 +2295,7 @@ object_class_property_add_enum(ObjectClass *klass, co=
nst char *name,
     rv =3D object_class_property_add(klass, name, typename,
                               get ? property_get_enum : NULL,
                               set ? property_set_enum : NULL,
-                              property_release_enum,
+                              NULL,
                               prop, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -2396,7 +2396,7 @@ object_class_property_add_tm(ObjectClass *klass, cons=
t char *name,
=20
     rv =3D object_class_property_add(klass, name, "struct tm",
                               get ? property_get_tm : NULL, NULL,
-                              property_release_tm,
+                              NULL,
                               prop, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
--=20
2.24.0


