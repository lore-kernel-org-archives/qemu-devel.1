Received: from eggs.gnu.org ([2001:4830:134:3::10]:40165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fle0T-00084t-2p
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fle0S-0001OZ-5Z
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41670 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fle0S-0001Nw-0X
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C5A1F2B40
	for <qemu-devel@nongnu.org>; Fri,  3 Aug 2018 17:36:51 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  3 Aug 2018 19:36:12 +0200
Message-Id: <20180803173614.12358-9-marcandre.lureau@redhat.com>
In-Reply-To: <20180803173614.12358-1-marcandre.lureau@redhat.com>
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/10] char: register spice ports after spice
 started
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

Spice port registration is delayed until the server is started. But
ports created after are not being registered. If the server is already
started, do vmc_register_interface() to register it from
qemu_chr_open_spice_port().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/spice.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/chardev/spice.c b/chardev/spice.c
index 0112efb6d2..1deb0cedef 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -308,6 +308,11 @@ void qemu_chr_open_spice_port(Chardev *chr,
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
2.18.0.547.g1d89318c48
