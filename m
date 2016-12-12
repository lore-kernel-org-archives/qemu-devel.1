Received: from eggs.gnu.org ([2001:4830:134:3::10]:42596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZJo-00037e-VH
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:43:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZJo-0003Df-5v
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:43:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZJo-0003DP-08
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:43:36 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 210168124B
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:43:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:42:32 +0300
Message-Id: <20161212224325.20790-2-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/54] gtk: avoid oob array access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

When too many consoles are created, vcs[] may be write out-of-bounds.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ui/gtk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index e81642876a..67c52179ee 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1696,6 +1696,11 @@ static CharDriverState *gd_vc_handler(ChardevVC *v=
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
2.11.0
