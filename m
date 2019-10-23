Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160B5CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 18:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32D12084C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 18:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kp5cFQ+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32D12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNLqe-0008Ar-HF
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 14:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKYK-0006W7-23
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKYE-0002yz-3w
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:36:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46701
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iNKY8-0002wm-D6
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571852153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UfiNxxYjH3sYEO1mfbxHgayQzvy7QgMJpTON/ahYwLE=;
 b=Kp5cFQ+8UdaWQFq4Hark5xFVRSuvIaEGfU35C8XBs28O+xrrYSvdKk0UMKMFju7RznBNeK
 zr/zjaXrk9LHQK6MP4D7tmhSWr8D6YMM63+FkkLLrQrZ8JNkf8fue9clYrrSOIW6HUlc8m
 OE8tIaXP3py9emBaQ3FkpogTKDq+F3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-CBcB3M0VN4G3EIEOra0ZtQ-1; Wed, 23 Oct 2019 13:35:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E200F1800E01;
 Wed, 23 Oct 2019 17:35:47 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 47FD2196B2;
 Wed, 23 Oct 2019 17:35:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 33/33] qdev: remove QDEV_PROP_PTR
Date: Wed, 23 Oct 2019 19:31:54 +0200
Message-Id: <20191023173154.30051-34-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-1-marcandre.lureau@redhat.com>
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: CBcB3M0VN4G3EIEOra0ZtQ-1
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

No longer used in the tree. The comment about user_creatable is still
quite relevant, but there is already a similar comment in qdev-core.h.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties.c    | 18 ------------------
 include/hw/qdev-properties.h | 22 ----------------------
 2 files changed, 40 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index be4cb01f0b..6271169d7d 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -469,13 +469,6 @@ const PropertyInfo qdev_prop_string =3D {
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
@@ -1133,17 +1126,6 @@ void qdev_prop_set_enum(DeviceState *dev, const char=
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
index 5bba033b7b..a708c3870b 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -17,7 +17,6 @@ extern const PropertyInfo qdev_prop_size;
 extern const PropertyInfo qdev_prop_string;
 extern const PropertyInfo qdev_prop_chr;
 extern const PropertyInfo qdev_prop_tpm;
-extern const PropertyInfo qdev_prop_ptr;
 extern const PropertyInfo qdev_prop_macaddr;
 extern const PropertyInfo qdev_prop_on_off_auto;
 extern const PropertyInfo qdev_prop_losttickpolicy;
@@ -168,25 +167,6 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
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
@@ -259,8 +239,6 @@ void qdev_prop_set_drive(DeviceState *dev, const char *=
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


