Received: from eggs.gnu.org ([209.51.188.92]:36761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hEyF6-0000Ic-R6
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hEyF5-0001XJ-Pn
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:37:28 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 12 Apr 2019 17:36:37 +0200
Message-Id: <20190412153647.19027-4-marcandre.lureau@redhat.com>
In-Reply-To: <20190412153647.19027-1-marcandre.lureau@redhat.com>
References: <20190412153647.19027-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 03/13] curses: fix wchar_t printf warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Gerd Hoffmann <kraxel@redhat.com>

On some systems wchar_t is "long int", on others just "int".
So go cast to "long int" and adjust the printf format accordingly.

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190402073018.17747-1-kraxel@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/curses.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/curses.c b/ui/curses.c
index cc6d6da684..fb63945188 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -453,8 +453,8 @@ static uint16_t get_ucs(wchar_t wch, iconv_t conv)
     swch =3D sizeof(wch);
=20
     if (iconv(conv, &pwch, &swch, &pch, &sch) =3D=3D (size_t) -1) {
-        fprintf(stderr, "Could not convert 0x%02x from WCHAR_T to UCS-2:=
 %s\n",
-                        wch, strerror(errno));
+        fprintf(stderr, "Could not convert 0x%02lx from WCHAR_T to UCS-2=
: %s\n",
+                (unsigned long)wch, strerror(errno));
         return 0xFFFD;
     }
=20
--=20
2.21.0.313.ge35b8cb8e2
