Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F047CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 20:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F76721872
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 20:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzClbIRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F76721872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNNBU-0000Ck-AH
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 16:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKVT-0003kB-8x
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKVQ-0001gW-Oo
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:33:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37042
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iNKVQ-0001gA-K5
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571851988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/qSKp+Dha50wwfkLLlipKox8Za+pAS4L71giPOhThTA=;
 b=dzClbIRAcxNk0l8KxoQfTCE+i2fEOU9/Ib6y1N7fjRmTRzmLx0XrcwVTsfENe6iQX6ZpOo
 G7/hQ/U9RDZU2v4rW6RLbjPtylOGT4M9dDJ/erzB53RCuuRF9jYEwMo1UJZI/PBiBh4hvL
 WQZ8V4+7XzFJtPom6VmYx1EF26hKe24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-mZ58rmSeMD2w1fKqUt37PA-1; Wed, 23 Oct 2019 13:33:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44222107AD34;
 Wed, 23 Oct 2019 17:33:00 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93D685D6D0;
 Wed, 23 Oct 2019 17:32:54 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/33] chardev: generate an internal id when none given
Date: Wed, 23 Oct 2019 19:31:25 +0200
Message-Id: <20191023173154.30051-5-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-1-marcandre.lureau@redhat.com>
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: mZ58rmSeMD2w1fKqUt37PA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Internally, qemu may create chardev without ID. Those will not be
looked up with qemu_chr_find(), which prevents using qdev_prop_set_chr().

Use id_generate(), to generate an internal name (prefixed with #), so
no conflict exist with user-named chardev.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c    | 32 ++++++++++++++++++++++++--------
 include/qemu/id.h |  1 +
 util/id.c         |  1 +
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 7b6b2cb123..e7e7492b0e 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -37,6 +37,7 @@
 #include "qemu/help_option.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
+#include "qemu/id.h"
=20
 #include "chardev/char-mux.h"
=20
@@ -944,10 +945,10 @@ void qemu_chr_set_feature(Chardev *chr,
     return set_bit(feature, chr->features);
 }
=20
-Chardev *qemu_chardev_new(const char *id, const char *typename,
-                          ChardevBackend *backend,
-                          GMainContext *gcontext,
-                          Error **errp)
+static Chardev *chardev_new(const char *id, const char *typename,
+                            ChardevBackend *backend,
+                            GMainContext *gcontext,
+                            Error **errp)
 {
     Object *obj;
     Chardev *chr =3D NULL;
@@ -991,6 +992,21 @@ end:
     return chr;
 }
=20
+Chardev *qemu_chardev_new(const char *id, const char *typename,
+                          ChardevBackend *backend,
+                          GMainContext *gcontext,
+                          Error **errp)
+{
+    g_autofree char *genid =3D NULL;
+
+    if (!id) {
+        genid =3D id_generate(ID_CHR);
+        id =3D genid;
+    }
+
+    return chardev_new(id, typename, backend, gcontext, errp);
+}
+
 ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend,
                                Error **errp)
 {
@@ -1003,8 +1019,8 @@ ChardevReturn *qmp_chardev_add(const char *id, Charde=
vBackend *backend,
         return NULL;
     }
=20
-    chr =3D qemu_chardev_new(id, object_class_get_name(OBJECT_CLASS(cc)),
-                           backend, NULL, errp);
+    chr =3D chardev_new(id, object_class_get_name(OBJECT_CLASS(cc)),
+                      backend, NULL, errp);
     if (!chr) {
         return NULL;
     }
@@ -1061,8 +1077,8 @@ ChardevReturn *qmp_chardev_change(const char *id, Cha=
rdevBackend *backend,
         return NULL;
     }
=20
-    chr_new =3D qemu_chardev_new(NULL, object_class_get_name(OBJECT_CLASS(=
cc)),
-                               backend, chr->gcontext, errp);
+    chr_new =3D chardev_new(NULL, object_class_get_name(OBJECT_CLASS(cc)),
+                          backend, chr->gcontext, errp);
     if (!chr_new) {
         return NULL;
     }
diff --git a/include/qemu/id.h b/include/qemu/id.h
index 40c70103e4..b55c406e69 100644
--- a/include/qemu/id.h
+++ b/include/qemu/id.h
@@ -4,6 +4,7 @@
 typedef enum IdSubSystems {
     ID_QDEV,
     ID_BLOCK,
+    ID_CHR,
     ID_MAX      /* last element, used as array size */
 } IdSubSystems;
=20
diff --git a/util/id.c b/util/id.c
index af1c5f1b81..5addb4460e 100644
--- a/util/id.c
+++ b/util/id.c
@@ -34,6 +34,7 @@ bool id_wellformed(const char *id)
 static const char *const id_subsys_str[ID_MAX] =3D {
     [ID_QDEV]  =3D "qdev",
     [ID_BLOCK] =3D "block",
+    [ID_CHR] =3D "chr",
 };
=20
 /*
--=20
2.23.0.606.g08da6496b6


