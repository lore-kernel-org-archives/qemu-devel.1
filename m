Received: from eggs.gnu.org ([2001:4830:134:3::10]:40087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fle0H-0007ur-MS
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fle0E-0001JQ-Jn
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41662 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fle0E-0001JC-Et
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CDD0857AB
	for <qemu-devel@nongnu.org>; Fri,  3 Aug 2018 17:36:38 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  3 Aug 2018 19:36:09 +0200
Message-Id: <20180803173614.12358-6-marcandre.lureau@redhat.com>
In-Reply-To: <20180803173614.12358-1-marcandre.lureau@redhat.com>
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/10] spice: merge options lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

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
index 13f1c11b61..6bd107f0f9 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -400,6 +400,7 @@ static SpiceChannelList *qmp_query_spice_channels(voi=
d)
 static QemuOptsList qemu_spice_opts =3D {
     .name =3D "spice",
     .head =3D QTAILQ_HEAD_INITIALIZER(qemu_spice_opts.head),
+    .merge_lists =3D true,
     .desc =3D {
         {
             .name =3D "port",
--=20
2.18.0.547.g1d89318c48
