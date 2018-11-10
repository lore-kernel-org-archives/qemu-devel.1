Received: from eggs.gnu.org ([2001:4830:134:3::10]:41226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gLRFr-0000zF-Ra
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 06:16:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gLRFm-00037S-Q6
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 06:16:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gLRFm-00030E-Jv
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 06:16:38 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EFA4F394D52
	for <qemu-devel@nongnu.org>; Sat, 10 Nov 2018 11:16:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 10 Nov 2018 15:16:23 +0400
Message-Id: <20181110111623.31356-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] edid: silence a stringop-overflow warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Simplify the code that doesn't need strncpy() since length of string
is already computed.

/home/elmarco/src/qemu/hw/display/edid-generate.c: In function 'edid_desc=
_text':
/home/elmarco/src/qemu/hw/display/edid-generate.c:168:5: error: 'strncpy'=
 specified bound depends on the length of the source argument [-Werror=3D=
stringop-overflow=3D]
     strncpy((char *)(desc + 5), text, len);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/elmarco/src/qemu/hw/display/edid-generate.c:164:11: note: length co=
mputed here
     len =3D strlen(text);
           ^~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/display/edid-generate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/edid-generate.c b/hw/display/edid-generate.c
index bdf5e1d4d4..77d9127344 100644
--- a/hw/display/edid-generate.c
+++ b/hw/display/edid-generate.c
@@ -165,7 +165,7 @@ static void edid_desc_text(uint8_t *desc, uint8_t typ=
e,
     if (len > 12) {
         len =3D 12;
     }
-    strncpy((char *)(desc + 5), text, len);
+    memcpy(desc + 5, text, len);
     desc[5 + len] =3D '\n';
 }
=20
--=20
2.19.1.708.g4ede3d42df
