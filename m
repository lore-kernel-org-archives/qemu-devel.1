Received: from eggs.gnu.org ([2001:4830:134:3::10]:55191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dIfAD-0005OV-DL
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dIfAC-0007um-Kn
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:54:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29983)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dIfAC-0007ua-EQ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:54:36 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed,  7 Jun 2017 18:54:18 +0100
Message-Id: <20170607175419.13558-5-berrange@redhat.com>
In-Reply-To: <20170607175419.13558-1-berrange@redhat.com>
References: <20170607175419.13558-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 4/5] io: preserve ipv4/ipv6 flags when
 resolving InetSocketAddress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

The original InetSocketAddress struct may have has_ipv4 and
has_ipv6 fields set, which will control both the ai_family
used during DNS resolution, and later use of the V6ONLY
flag.

Currently the standalone DNS resolver code drops the
has_ipv4 & has_ipv6 flags after resolving, which means
the later bind() code won't correctly set V6ONLY.

This fixes the following scenarios

  -vnc :0,ipv4=3Doff
  -vnc :0,ipv6=3Don
  -vnc :::0,ipv4=3Doff
  -vnc :::0,ipv6=3Don

which all mistakenly accepted IPv4 clients

Acked-by: Gerd Hoffmann <kraxel@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/dns-resolver.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index 57a8896..c072d12 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -116,8 +116,10 @@ static int qio_dns_resolver_lookup_sync_inet(QIODNSR=
esolver *resolver,
             .numeric =3D true,
             .has_to =3D iaddr->has_to,
             .to =3D iaddr->to,
-            .has_ipv4 =3D false,
-            .has_ipv6 =3D false,
+            .has_ipv4 =3D iaddr->has_ipv4,
+            .ipv4 =3D iaddr->ipv4,
+            .has_ipv6 =3D iaddr->has_ipv6,
+            .ipv6 =3D iaddr->ipv6,
         };
=20
         (*addrs)[i] =3D newaddr;
--=20
2.9.3
