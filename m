Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59E1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF3C2071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUzPoaXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF3C2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufvm-00082O-Rb
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucuE-000177-6C
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucuD-00019i-3H
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23312
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucuC-00019Y-WA
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=de9QrPkRWGGC7NfeGWGFAsbrfkEMdZgdrwJ20cK3IrI=;
 b=EUzPoaXkvvKfTUgs5BNn4/uBImuUw2L8gfdOOfQp6EkoU4LzeUI1C0oot03F8giBsp92BN
 FPKT9VImgYw52fBkzNEAjD7xwTNxyWc6E0nK16reuhIqpCYZwkquzGA4Kn8AGAjC8/9+KV
 yrD3QR8GJduQr4pf/XWnxutPQwjZbKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-36Hd2ofsNsyiU4XqaIt2-A-1; Thu, 23 Jan 2020 08:52:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 213C08010F7
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:18 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2C2F1CB;
 Thu, 23 Jan 2020 13:52:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 40/59] object: do not free class properties
Date: Thu, 23 Jan 2020 14:50:30 +0100
Message-Id: <1579787449-27599-41-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 36Hd2ofsNsyiU4XqaIt2-A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The release callback is called during object_property_del_all(), on a
live instance. But class properties are common among all
instances. It is not currently called, because we don't release
classes, but it would not be correct if we did.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-12-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 2d29019..864281e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2127,7 +2127,7 @@ object_class_property_add_str(ObjectClass *klass, con=
st char *name,
     rv =3D object_class_property_add(klass, name, "string",
                               get ? property_get_str : NULL,
                               set ? property_set_str : NULL,
-                              property_release_str,
+                              NULL,
                               prop, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -2220,7 +2220,7 @@ object_class_property_add_bool(ObjectClass *klass, co=
nst char *name,
     rv =3D object_class_property_add(klass, name, "bool",
                               get ? property_get_bool : NULL,
                               set ? property_set_bool : NULL,
-                              property_release_bool,
+                              NULL,
                               prop, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -2312,7 +2312,7 @@ object_class_property_add_enum(ObjectClass *klass, co=
nst char *name,
     rv =3D object_class_property_add(klass, name, typename,
                               get ? property_get_enum : NULL,
                               set ? property_set_enum : NULL,
-                              property_release_enum,
+                              NULL,
                               prop, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -2413,7 +2413,7 @@ object_class_property_add_tm(ObjectClass *klass, cons=
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
1.8.3.1



