Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AC1C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138CD206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VASq8+Nr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138CD206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXS1d-00030f-Op
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:36:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRtO-000219-21
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRtM-0007X4-Uw
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:27:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20513
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iXRtM-0007Wz-RT
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574263660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ba+kBqAV5GbEBNm1Pi6SpFhQByeyZ3n89Yv4VJ0pIB8=;
 b=VASq8+Nr6VAigKLqWWo5hT4VSBB4B5aBO5yEt1lxf6U6aosqYutnQIVc+6D4foi+sLJyhE
 W6cMb3s1j6puEeeG5CUzz1oXjdEUG+J/KnblAUy2kIOYaqSUZH7cTCVjwFBh0qMUpRMTDk
 O2je9IE8tWW1hgfCjUmbrQ0BG0bEQDw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-A3zL4fFCPP6Oq0B25xYkfA-1; Wed, 20 Nov 2019 10:27:39 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F037107ACC6;
 Wed, 20 Nov 2019 15:27:38 +0000 (UTC)
Received: from localhost (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F31960499;
 Wed, 20 Nov 2019 15:27:30 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 14/37] serial-mm: add endianness property
Date: Wed, 20 Nov 2019 19:24:19 +0400
Message-Id: <20191120152442.26657-15-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-1-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: A3zL4fFCPP6Oq0B25xYkfA-1
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
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a qdev property for endianness, so memory region setup can be done
in realize.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/char/serial.c         | 2 ++
 include/hw/char/serial.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 225f09f30f..1c16fed4d1 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1080,6 +1080,7 @@ SerialMM *serial_mm_init(MemoryRegion *address_space,
     qdev_prop_set_uint32(DEVICE(s), "baudbase", baudbase);
     qdev_prop_set_chr(DEVICE(s), "chardev", chr);
     qdev_set_legacy_instance_id(DEVICE(s), base, 2);
+    qdev_prop_set_uint8(DEVICE(self), "endianness", end);
=20
     qdev_init_nofail(DEVICE(s));
     qdev_init_nofail(DEVICE(smm));
@@ -1106,6 +1107,7 @@ static Property serial_mm_properties[] =3D {
      * previous one.
      */
     DEFINE_PROP_UINT8("regshift", SerialMM, regshift, 0),
+    DEFINE_PROP_UINT8("endianness", SerialMM, endianness, DEVICE_NATIVE_EN=
DIAN),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index eaeda62698..d586924937 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -85,6 +85,7 @@ typedef struct SerialMM {
     SerialState serial;
=20
     uint8_t regshift;
+    uint8_t endianness;
 } SerialMM;
=20
 extern const VMStateDescription vmstate_serial;
--=20
2.24.0


