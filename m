Received: from eggs.gnu.org ([2001:4830:134:3::10]:36191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gZzLf-0007ZB-2R
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gZz84-0000oi-D2
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:16:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gZz84-0000jq-4W
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:16:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D96B980F9B
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 14:16:41 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 20 Dec 2018 18:15:46 +0400
Message-Id: <20181220141553.24098-6-marcandre.lureau@redhat.com>
In-Reply-To: <20181220141553.24098-1-marcandre.lureau@redhat.com>
References: <20181220141553.24098-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/12] spice: merge options lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com

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
---
 ui/spice-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index 1f1501de78..6fefd95cea 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -398,6 +398,7 @@ static SpiceChannelList *qmp_query_spice_channels(voi=
d)
 static QemuOptsList qemu_spice_opts =3D {
     .name =3D "spice",
     .head =3D QTAILQ_HEAD_INITIALIZER(qemu_spice_opts.head),
+    .merge_lists =3D true,
     .desc =3D {
         {
             .name =3D "port",
--=20
2.20.1.2.gb21ebb671b
