Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED11C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D37221D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJVXT4Ak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D37221D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufoz-000855-JN
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:59:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucu4-0000rV-G0
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucu3-0000uv-EJ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59449
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucu3-0000uh-Bn
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z5XFGQqk7sa0oFK95YMlOz0cT3ZBKnoL8H8zBBcszCI=;
 b=GJVXT4Akb7TdkbIoyv/GmCipGErG76ieJDOPAGGZnttSTEE8aK+AC5LUt4v7PhI8afd0MG
 crdZrSqsrwyA8rbPXYkEaQKBUrKzu9145VsMPol4ClkJ6x26NOkh1f5gs95opjFlP1I/rr
 981HGOXYf3tSh5/yizsutqOmr4tHZHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-rTLGWIa7Mk20VPn43uRbaQ-1; Thu, 23 Jan 2020 08:52:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87F5063AD9
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:08 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80C4884DBD;
 Thu, 23 Jan 2020 13:52:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 35/59] object: avoid extra class property key duplication
Date: Thu, 23 Jan 2020 14:50:25 +0100
Message-Id: <1579787449-27599-36-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: rTLGWIa7Mk20VPn43uRbaQ-1
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

Like object properties, no need to duplicate property name, as it is
owned already by ObjectProperty value.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-6-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index dcb6863..e921363 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -311,7 +311,7 @@ static void type_initialize(TypeImpl *ti)
         memcpy(ti->class, parent->class, parent->class_size);
         ti->class->interfaces =3D NULL;
         ti->class->properties =3D g_hash_table_new_full(
-            g_str_hash, g_str_equal, g_free, object_property_free);
+            g_str_hash, g_str_equal, NULL, object_property_free);
=20
         for (e =3D parent->class->interfaces; e; e =3D e->next) {
             InterfaceClass *iface =3D e->data;
@@ -343,7 +343,7 @@ static void type_initialize(TypeImpl *ti)
         }
     } else {
         ti->class->properties =3D g_hash_table_new_full(
-            g_str_hash, g_str_equal, g_free, object_property_free);
+            g_str_hash, g_str_equal, NULL, object_property_free);
     }
=20
     ti->class->type =3D ti;
@@ -1187,7 +1187,7 @@ object_class_property_add(ObjectClass *klass,
     prop->release =3D release;
     prop->opaque =3D opaque;
=20
-    g_hash_table_insert(klass->properties, g_strdup(name), prop);
+    g_hash_table_insert(klass->properties, prop->name, prop);
=20
     return prop;
 }
--=20
1.8.3.1



