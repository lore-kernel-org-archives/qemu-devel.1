Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EFAC352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46C3206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSrjBfnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46C3206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1z6H-0000Bs-1Z
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 15:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j1z5F-0007ji-Jx
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j1z5E-0000aX-JB
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:58:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35130
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j1z5E-0000aI-Ff
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581541088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnoiTOxvlWrl49cZaP7PlfgsIJrwXYmikRqXnqw6mZM=;
 b=LSrjBfnHcD3f60GoGKr8F6reKCjt/CwCpvTX9Hs4uO1vc9UqjFzpLYaWnToEz2MGB6FsXH
 5/PSjlhOVHoqfLdLVZCQyloi76U5qALnnvLTQaciZBIB4rlybG2HkY2nKFF/kUL+OQTz7m
 AoGqB8PfXuvZA+3j0e0Vk7JPBVqjKQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-hrpHrTPwPy6ezjFRya2fQg-1; Wed, 12 Feb 2020 15:58:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27BAC10766DE
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 20:58:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com
 [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33B91863CC;
 Wed, 12 Feb 2020 20:57:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 426F431E30; Wed, 12 Feb 2020 21:57:57 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] uas: fix super speed bMaxPacketSize0
Date: Wed, 12 Feb 2020 21:57:57 +0100
Message-Id: <20200212205757.5608-3-kraxel@redhat.com>
In-Reply-To: <20200212205757.5608-1-kraxel@redhat.com>
References: <20200212205757.5608-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: hrpHrTPwPy6ezjFRya2fQg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For usb2 bMaxPacketSize0 is "n", for usb3 it is "1 << n",
so it must be 9 not 64 ...

rom "Universal Serial Bus 3.1 Specification":

   If the device is operating at Gen X speed, the bMaxPacketSize0
   field shall be set to 09H indicating a 512-byte maximum packet.
   An Enhanced SuperSpeed device shall not support any other maximum
   packet sizes for the default control pipe (endpoint 0) control
   endpoint.

We now announce a 512-byte maximum packet.

Fixes: 89a453d4a5c ("uas-uas: usb3 streams")
Reported-by: Benjamin David Lunt <fys@fysnet.net>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20200117073716.31335-1-kraxel@redhat.com
---
 hw/usb/dev-uas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 9825ec37d09c..11a8684cc2ab 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -303,7 +303,7 @@ static const USBDescDevice desc_device_high =3D {
=20
 static const USBDescDevice desc_device_super =3D {
     .bcdUSB                        =3D 0x0300,
-    .bMaxPacketSize0               =3D 64,
+    .bMaxPacketSize0               =3D 9,
     .bNumConfigurations            =3D 1,
     .confs =3D (USBDescConfig[]) {
         {
--=20
2.18.2


