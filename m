Received: from eggs.gnu.org ([2001:4830:134:3::10]:39959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fsmMT-000233-KF
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fsmMS-00072b-Kj
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:57:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32998 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fsmMS-000721-AQ
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:57:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D44EA40216E6
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 09:57:03 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 23 Aug 2018 11:56:46 +0200
Message-Id: <20180823095653.14556-6-kraxel@redhat.com>
In-Reply-To: <20180823095653.14556-1-kraxel@redhat.com>
References: <20180823095653.14556-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/12] doc: switch to modern syntax for VNC TLS
 setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

The use of 'tls', 'x509' and 'x509verify' properties is the deprecated
backcompat syntax, replaced by use of TLS creds objects.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20180725092751.21767-2-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 qemu-doc.texi | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index f74542a0e9..7bd449f398 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -1103,7 +1103,9 @@ support provides a secure session, but no authentic=
ation. This allows any
 client to connect, and provides an encrypted session.
=20
 @example
-qemu-system-i386 [...OPTIONS...] -vnc :1,tls,x509=3D/etc/pki/qemu -monit=
or stdio
+qemu-system-i386 [...OPTIONS...] \
+  -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dserver=
,verify-peer=3Dno \
+  -vnc :1,tls-creds=3Dtls0 -monitor stdio
 @end example
=20
 In the above example @code{/etc/pki/qemu} should contain at least three =
files,
@@ -1118,10 +1120,14 @@ only be readable by the user owning it.
 Certificates can also provide a means to authenticate the client connect=
ing.
 The server will request that the client provide a certificate, which it =
will
 then validate against the CA certificate. This is a good choice if deplo=
ying
-in an environment with a private internal certificate authority.
+in an environment with a private internal certificate authority. It uses=
 the
+same syntax as previously, but with @code{verify-peer} set to @code{yes}
+instead.
=20
 @example
-qemu-system-i386 [...OPTIONS...] -vnc :1,tls,x509verify=3D/etc/pki/qemu =
-monitor stdio
+qemu-system-i386 [...OPTIONS...] \
+  -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dserver=
,verify-peer=3Dyes \
+  -vnc :1,tls-creds=3Dtls0 -monitor stdio
 @end example
=20
=20
@@ -1132,7 +1138,9 @@ Finally, the previous method can be combined with V=
NC password authentication
 to provide two layers of authentication for clients.
=20
 @example
-qemu-system-i386 [...OPTIONS...] -vnc :1,password,tls,x509verify=3D/etc/=
pki/qemu -monitor stdio
+qemu-system-i386 [...OPTIONS...] \
+  -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dserver=
,verify-peer=3Dyes \
+  -vnc :1,tls-creds=3Dtls0,password -monitor stdio
 (qemu) change vnc password
 Password: ********
 (qemu)
@@ -1169,7 +1177,9 @@ credentials. This can be enabled, by combining the =
'sasl' option
 with the aforementioned TLS + x509 options:
=20
 @example
-qemu-system-i386 [...OPTIONS...] -vnc :1,tls,x509,sasl -monitor stdio
+qemu-system-i386 [...OPTIONS...] \
+  -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dserver=
,verify-peer=3Dyes \
+  -vnc :1,tls-creds=3Dtls0,sasl -monitor stdio
 @end example
=20
 @node vnc_setup_sasl
--=20
2.9.3
