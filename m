Received: from eggs.gnu.org ([2001:4830:134:3::10]:52403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOjdK-0001ig-HX
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOjdJ-0001ti-Kk
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOjdJ-0001t5-CE
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:29 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90FFE61BAE
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 11:21:29 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed,  4 Jan 2017 12:21:20 +0100
Message-Id: <1483528883-1753-9-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483528883-1753-1-git-send-email-kraxel@redhat.com>
References: <1483528883-1753-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/11] gtk: avoid oob array access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

When too many consoles are created, vcs[] may be write out-of-bounds.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20161207105511.25173-1-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 356f400..86368e3 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1706,6 +1706,11 @@ static CharDriverState *gd_vc_handler(ChardevVC *v=
c, Error **errp)
     ChardevCommon *common =3D qapi_ChardevVC_base(vc);
     CharDriverState *chr;
=20
+    if (nb_vcs =3D=3D MAX_VCS) {
+        error_setg(errp, "Maximum number of consoles reached");
+        return NULL;
+    }
+
     chr =3D qemu_chr_alloc(common, errp);
     if (!chr) {
         return NULL;
--=20
1.8.3.1
