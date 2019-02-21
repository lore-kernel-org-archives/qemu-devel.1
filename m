Received: from eggs.gnu.org ([209.51.188.92]:34691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmCK-00020u-LS
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmCH-0006pc-0Z
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwmCG-0006o3-M6
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F8A9C057F3D
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:07:18 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 Feb 2019 12:06:56 +0100
Message-Id: <20190221110703.5775-5-marcandre.lureau@redhat.com>
In-Reply-To: <20190221110703.5775-1-marcandre.lureau@redhat.com>
References: <20190221110703.5775-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 04/11] spice: merge options lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Passing several -spice options to qemu command line, or calling
several time qemu_opts_set() will ignore all but the first option
list. Since the spice server is a singleton, it makes sense to merge
all the options, the last value being the one taken into account.

This changes the behaviour from, for ex:
$ qemu... -spice port=3D5900 -spice port=3D5901 -> port: 5900
to:
$ qemu... -spice port=3D5900 -spice port=3D5901 -> port: 5901

(if necessary we could instead produce an error when an option is
given twice, although this makes handling default values and such more
complicated)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Tested-by: Victor Toso <victortoso@redhat.com>
---
 ui/spice-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index 94b31ce3ad..91d0960522 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -397,6 +397,7 @@ static SpiceChannelList *qmp_query_spice_channels(voi=
d)
 static QemuOptsList qemu_spice_opts =3D {
     .name =3D "spice",
     .head =3D QTAILQ_HEAD_INITIALIZER(qemu_spice_opts.head),
+    .merge_lists =3D true,
     .desc =3D {
         {
             .name =3D "port",
--=20
2.21.0.rc1
