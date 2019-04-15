Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3045C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 15:47:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 987E420880
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 15:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987E420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51993 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG3pQ-0001xP-SU
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 11:47:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hG3nU-0000nJ-6d
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hG3nR-0007m6-Fa
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:45:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hG3nO-0007gJ-Lu
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:45:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7985E3002F52;
	Mon, 15 Apr 2019 15:45:18 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B75D9608C1;
	Mon, 15 Apr 2019 15:45:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Apr 2019 16:45:03 +0100
Message-Id: <20190415154503.6758-4-berrange@redhat.com>
In-Reply-To: <20190415154503.6758-1-berrange@redhat.com>
References: <20190415154503.6758-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Mon, 15 Apr 2019 15:45:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/3] usb-mtp: fix alignment of access of
 ObjectInfo filename field
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Greg Kurz <groug@kaod.org>, Bandan Das <bsd@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415154503.vRByk2j7_dFAH63lFAUshdSUtpqqxZOsi6hUTA-EUjs@z>

The ObjectInfo struct's "filename" field is following a uint8_t
field in a packed struct and thus has bad alignment for a 16-bit
field. Switch the field to to uint8_t and use the helper function
for accessing unaligned 16-bit data.

Note that although the MTP spec specifies big endian, when transported
over the USB protocol, data is little endian.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 hw/usb/dev-mtp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 6b7d1296e4..963449ec7d 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -226,7 +226,7 @@ typedef struct {
     uint32_t assoc_desc;
     uint32_t seq_no; /*unused*/
     uint8_t length; /*part of filename field*/
-    uint16_t filename[0];
+    uint8_t filename[0]; /* UTF-16 encoded */
     char date_created[0]; /*unused*/
     char date_modified[0]; /*unused*/
     char keywords[0]; /*unused*/
@@ -1551,7 +1551,7 @@ static void usb_mtp_cancel_packet(USBDevice *dev, U=
SBPacket *p)
     fprintf(stderr, "%s\n", __func__);
 }
=20
-static char *utf16_to_str(uint8_t len, uint16_t *arr)
+static char *utf16_to_str(uint8_t len, uint8_t *str16)
 {
     wchar_t *wstr =3D g_new0(wchar_t, len + 1);
     int count, dlen;
@@ -1559,7 +1559,7 @@ static char *utf16_to_str(uint8_t len, uint16_t *ar=
r)
=20
     for (count =3D 0; count < len; count++) {
         /* FIXME: not working for surrogate pairs */
-        wstr[count] =3D (wchar_t)arr[count];
+        wstr[count] =3D lduw_le_p(str16 + (count * 2));
     }
     wstr[count] =3D 0;
=20
--=20
2.20.1


