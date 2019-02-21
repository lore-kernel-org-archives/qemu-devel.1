Received: from eggs.gnu.org ([209.51.188.92]:34761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmCW-00029D-5i
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmCV-0006yd-DO
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:7977)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwmCS-0006to-6m
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E63C286663
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:07:27 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 Feb 2019 12:06:59 +0100
Message-Id: <20190221110703.5775-8-marcandre.lureau@redhat.com>
In-Reply-To: <20190221110703.5775-1-marcandre.lureau@redhat.com>
References: <20190221110703.5775-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 07/11] char: register spice ports after
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
Cc: kraxel@redhat.com

Spice port registration is delayed until the server is started. But
ports created after are not being registered. If the server is already
started, do vmc_register_interface() to register it from
qemu_chr_open_spice_port().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Tested-by: Victor Toso <victortoso@redhat.com>
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
2.21.0.rc1
