Received: from eggs.gnu.org ([2001:4830:134:3::10]:36816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fOTbi-0001kg-Ej
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fOTbh-0006a9-OZ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:51:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46006 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fOTbh-0006Zr-Jg
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:51:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29776818BAEE
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 19:51:33 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 31 May 2018 21:51:18 +0200
Message-Id: <20180531195119.22021-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180531195119.22021-1-marcandre.lureau@redhat.com>
References: <20180531195119.22021-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/4] usb-ccid: fix bus leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, spopovyc@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

qbus_create_inplace() creates a new reference in realize(), it must be
released in unrealize().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.=
c
index f7451923f4..a564d24d7e 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1147,6 +1147,7 @@ static void ccid_unrealize(USBDevice *dev, Error **=
errp)
     USBCCIDState *s =3D USB_CCID_DEV(dev);
=20
     ccid_bulk_in_clear(s);
+    object_unref(OBJECT(&s->bus));
 }
=20
 static void ccid_flush_pending_answers(USBCCIDState *s)
--=20
2.17.1.906.g10fd178552
