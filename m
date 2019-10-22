Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A93ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE88820684
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBhP0d56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE88820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxdN-0001jb-At
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iMwyM-0001PL-Jy
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iMwyL-0008KX-7M
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:25:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58276
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iMwyL-0008KO-2u
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571761524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iXTj0c9mnsZUNU3c6vAQwWlOMZGkI+hF1/jsq9eDS60=;
 b=YBhP0d564QFDIc65HH/gSNgQppjL0u3SNL5R4xKwNay0r8B91cKfPmgAE+o4fMrT9uzG26
 ZMBVTUFi3YLLQMWFRAy5INvuqq9DYaZGimdMutbf0M++4bfC2/nmO81VTmrx4fVY5L4uZu
 tbmjhRxCE2lBZbukFoYg8RQY3ZxJIDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-8_Rnom3WPXSisZa7y5iblw-1; Tue, 22 Oct 2019 12:25:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99F9E80183D;
 Tue, 22 Oct 2019 16:25:16 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C52419C4F;
 Tue, 22 Oct 2019 16:25:10 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 28/28] Remove QDEV_PROP_PTR
Date: Tue, 22 Oct 2019 18:21:37 +0200
Message-Id: <20191022162137.27161-29-marcandre.lureau@redhat.com>
In-Reply-To: <20191022162137.27161-1-marcandre.lureau@redhat.com>
References: <20191022162137.27161-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 8_Rnom3WPXSisZa7y5iblw-1
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
 Aleksandar Rikalo <arikalo@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
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

No longer used in the tree. The comment about user_creatable is still
quite relevant, but there is already a similar comment in qdev-core.h.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties.c    | 18 ------------------
 include/hw/qdev-properties.h | 22 ----------------------
 2 files changed, 40 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index ac28890e5a..6ca7697599 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -501,13 +501,6 @@ const PropertyInfo qdev_prop_string =3D {
     .set   =3D set_string,
 };
=20
-/* --- pointer --- */
-
-/* Not a proper property, just for dirty hacks.  TODO Remove it!  */
-const PropertyInfo qdev_prop_ptr =3D {
-    .name  =3D "ptr",
-};
-
 /* --- mac address --- */
=20
 /*
@@ -1165,17 +1158,6 @@ void qdev_prop_set_enum(DeviceState *dev, const char=
 *name, int value)
                             name, &error_abort);
 }
=20
-void qdev_prop_set_ptr(DeviceState *dev, const char *name, void *value)
-{
-    Property *prop;
-    void **ptr;
-
-    prop =3D qdev_prop_find(dev, name);
-    assert(prop && prop->info =3D=3D &qdev_prop_ptr);
-    ptr =3D qdev_get_prop_ptr(dev, prop);
-    *ptr =3D value;
-}
-
 static GPtrArray *global_props(void)
 {
     static GPtrArray *gp;
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 16837ab5dd..a90a9cec80 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -18,7 +18,6 @@ extern const PropertyInfo qdev_prop_size;
 extern const PropertyInfo qdev_prop_string;
 extern const PropertyInfo qdev_prop_chr;
 extern const PropertyInfo qdev_prop_tpm;
-extern const PropertyInfo qdev_prop_ptr;
 extern const PropertyInfo qdev_prop_macaddr;
 extern const PropertyInfo qdev_prop_on_off_auto;
 extern const PropertyInfo qdev_prop_losttickpolicy;
@@ -171,25 +170,6 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
 #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
=20
-/*
- * Please avoid pointer properties.  If you must use them, you must
- * cover them in their device's class init function as follows:
- *
- * - If the property must be set, the device cannot be used with
- *   device_add, so add code like this:
- *   |* Reason: pointer property "NAME-OF-YOUR-PROP" *|
- *   DeviceClass *dc =3D DEVICE_CLASS(class);
- *   dc->user_creatable =3D false;
- *
- * - If the property may safely remain null, document it like this:
- *   |*
- *    * Note: pointer property "interrupt_vector" may remain null, thus
- *    * no need for dc->user_creatable =3D false;
- *    *|
- */
-#define DEFINE_PROP_PTR(_n, _s, _f)             \
-    DEFINE_PROP(_n, _s, _f, qdev_prop_ptr, void*)
-
 #define DEFINE_PROP_CHR(_n, _s, _f)             \
     DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharBackend)
 #define DEFINE_PROP_STRING(_n, _s, _f)             \
@@ -262,8 +242,6 @@ void qdev_prop_set_drive(DeviceState *dev, const char *=
name,
 void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
                            const uint8_t *value);
 void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
-/* FIXME: Remove opaque pointer properties.  */
-void qdev_prop_set_ptr(DeviceState *dev, const char *name, void *value);
=20
 void qdev_prop_register_global(GlobalProperty *prop);
 int qdev_prop_check_globals(void);
--=20
2.23.0.606.g08da6496b6


