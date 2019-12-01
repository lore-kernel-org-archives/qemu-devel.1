Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BF9C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D8E20833
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrAEvh1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D8E20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibNca-0004bM-74
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 06:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNGN-0003JJ-I2
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNGM-0001qv-9F
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:19:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23628
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ibNGM-0001qT-5d
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575199177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3cewDszy/wF7jL+HLN01cuqGlSVrMzQ003efKpixUIQ=;
 b=JrAEvh1RBUTlSZVKuxQ04vbfphJyu8KaudorFx+cMjqn2N7gRRNGKnIae6N6Lzaq66zy6w
 t6jg8Jen6goBnD+QC3UOU4QvEmIhqRDqUFEUNfvMXQG9C4xc+gmEMjm0+3rZy+BYgZMXDS
 i/rSYj+XEkA29aPcj2l2e4C6NcyK3rc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-_PDWplz1N7eXCvjXv9Mk9A-1; Sun, 01 Dec 2019 06:19:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A83480183C
 for <qemu-devel@nongnu.org>; Sun,  1 Dec 2019 11:19:33 +0000 (UTC)
Received: from localhost (unknown [10.36.112.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2CCA600C8;
 Sun,  1 Dec 2019 11:19:29 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/26] qom: simplify qmp_device_list_properties()
Date: Sun,  1 Dec 2019 15:15:28 +0400
Message-Id: <20191201111531.1136947-24-marcandre.lureau@redhat.com>
In-Reply-To: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: _PDWplz1N7eXCvjXv9Mk9A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All qdev properties are object properties, no need for
make_device_property_info() helper.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qom/qom-qmp-cmds.c | 52 +++++-----------------------------------------
 1 file changed, 5 insertions(+), 47 deletions(-)

diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index f4494f98ac..8785816c1f 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -121,48 +121,6 @@ ObjectTypeInfoList *qmp_qom_list_types(bool has_implem=
ents,
     return ret;
 }
=20
-/* Return a DevicePropertyInfo for a qdev property.
- *
- * If a qdev property with the given name does not exist, use the given de=
fault
- * type.  If the qdev property info should not be shown, return NULL.
- *
- * The caller must free the return value.
- */
-static ObjectPropertyInfo *make_device_property_info(ObjectClass *klass,
-                                                  const char *name,
-                                                  const char *default_type=
,
-                                                  const char *description)
-{
-    ObjectPropertyInfo *info;
-    Property *prop;
-
-    do {
-        for (prop =3D DEVICE_CLASS(klass)->props; prop && prop->name; prop=
++) {
-            if (strcmp(name, prop->name) !=3D 0) {
-                continue;
-            }
-
-            info =3D g_malloc0(sizeof(*info));
-            info->name =3D g_strdup(prop->name);
-            info->type =3D default_type ? g_strdup(default_type)
-                                      : g_strdup(prop->info->name);
-            info->has_description =3D !!prop->info->description;
-            info->description =3D g_strdup(prop->info->description);
-            return info;
-        }
-        klass =3D object_class_get_parent(klass);
-    } while (klass !=3D object_class_by_name(TYPE_DEVICE));
-
-    /* Not a qdev property, use the default type */
-    info =3D g_malloc0(sizeof(*info));
-    info->name =3D g_strdup(name);
-    info->type =3D g_strdup(default_type);
-    info->has_description =3D !!description;
-    info->description =3D g_strdup(description);
-
-    return info;
-}
-
 ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
                                                 Error **errp)
 {
@@ -214,11 +172,11 @@ ObjectPropertyInfoList *qmp_device_list_properties(co=
nst char *typename,
             continue;
         }
=20
-        info =3D make_device_property_info(klass, prop->name, prop->type,
-                                         prop->description);
-        if (!info) {
-            continue;
-        }
+        info =3D g_new0(ObjectPropertyInfo, 1);
+        info->name =3D g_strdup(prop->name);
+        info->type =3D g_strdup(prop->type);
+        info->has_description =3D !!prop->description;
+        info->description =3D g_strdup(prop->description);
=20
         entry =3D g_malloc0(sizeof(*entry));
         entry->value =3D info;
--=20
2.24.0


