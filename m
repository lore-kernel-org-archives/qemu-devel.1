Received: from eggs.gnu.org ([2001:4830:134:3::10]:35805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gZzLc-000770-Cs
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gZz8I-00011k-VW
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:17:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gZz8I-00011L-Pt
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:17:02 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A52F804E5
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 14:17:02 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 20 Dec 2018 18:15:49 +0400
Message-Id: <20181220141553.24098-9-marcandre.lureau@redhat.com>
In-Reply-To: <20181220141553.24098-1-marcandre.lureau@redhat.com>
References: <20181220141553.24098-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 08/12] char: register spice ports after
 spice started
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

Spice port registration is delayed until the server is started. But
ports created after are not being registered. If the server is already
started, do vmc_register_interface() to register it from
qemu_chr_open_spice_port().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/spice.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/chardev/spice.c b/chardev/spice.c
index 2202d50eee..22c30ae833 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -316,6 +316,11 @@ void qemu_chr_open_spice_port(Chardev *chr,
     *be_opened =3D false;
     s =3D SPICE_CHARDEV(chr);
     s->sin.portname =3D g_strdup(name);
+
+    if (using_spice) {
+        /* spice server already created */
+        vmc_register_interface(s);
+    }
 }
=20
 void qemu_spice_register_ports(void)
--=20
2.20.1.2.gb21ebb671b
