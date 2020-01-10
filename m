Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D31C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2030520721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpiBwkgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2030520721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwN1-00071A-Mi
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwHW-0007qw-Gj
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwHV-00009Y-Av
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:33:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29164
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ipwHV-00008n-7O
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578670380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZrOBFZgdRT+c9efvM7QHjhwRIBjwggJwLEGh2tOx7M=;
 b=NpiBwkgmj4D1AZxpuvjEqTKegvFkmJDuLLentrK9SKGGBmpH0E/Rr1PvLUm7w+LNcIfb3Y
 0AyVs3yCX+SItm/+2PyRbs0rhiDYaQlNLkkbfyn+MC1eISU+gARa42ol4BGEB7U/J3wC6f
 +6fT6XVbJlPlBM1ux6K2/b2H641TO3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-oBbVpXrgOtKIRQDZJ_xWNQ-1; Fri, 10 Jan 2020 10:32:58 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4EED10054A0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 15:32:57 +0000 (UTC)
Received: from localhost (ovpn-112-59.ams2.redhat.com [10.36.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21CD85C296;
 Fri, 10 Jan 2020 15:32:50 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/26] object: do not free class properties
Date: Fri, 10 Jan 2020 19:30:24 +0400
Message-Id: <20200110153039.1379601-12-marcandre.lureau@redhat.com>
In-Reply-To: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: oBbVpXrgOtKIRQDZJ_xWNQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The release callback is called during object_property_del_all(), on a
live instance. But class properties are common among all
instances. It is not currently called, because we don't release
classes, but it would not be correct if we did.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qom/object.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index aef7e64b5c..1ce961b84f 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2134,7 +2134,7 @@ object_class_property_add_str(ObjectClass *klass, con=
st char *name,
     rv =3D object_class_property_add(klass, name, "string",
                               get ? property_get_str : NULL,
                               set ? property_set_str : NULL,
-                              property_release_str,
+                              NULL,
                               prop, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -2227,7 +2227,7 @@ object_class_property_add_bool(ObjectClass *klass, co=
nst char *name,
     rv =3D object_class_property_add(klass, name, "bool",
                               get ? property_get_bool : NULL,
                               set ? property_set_bool : NULL,
-                              property_release_bool,
+                              NULL,
                               prop, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -2319,7 +2319,7 @@ object_class_property_add_enum(ObjectClass *klass, co=
nst char *name,
     rv =3D object_class_property_add(klass, name, typename,
                               get ? property_get_enum : NULL,
                               set ? property_set_enum : NULL,
-                              property_release_enum,
+                              NULL,
                               prop, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -2420,7 +2420,7 @@ object_class_property_add_tm(ObjectClass *klass, cons=
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
2.25.0.rc1.20.g2443f3f80d.dirty


