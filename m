Received: from eggs.gnu.org ([2001:4830:134:3::10]:58267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fiG5Q-0002Ri-9b
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fiG5N-0000eE-8q
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:28:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35426 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fiG5N-0000dj-39
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:27:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE7E14077071
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 09:27:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 25 Jul 2018 10:27:50 +0100
Message-Id: <20180725092751.21767-2-berrange@redhat.com>
In-Reply-To: <20180725092751.21767-1-berrange@redhat.com>
References: <20180725092751.21767-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] doc: switch to modern syntax for VNC TLS
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

The use of 'tls', 'x509' and 'x509verify' properties is the deprecated
backcompat syntax, replaced by use of TLS creds objects.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 qemu-doc.texi | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index abfd2db546..080548f79c 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -1097,7 +1097,9 @@ support provides a secure session, but no authentic=
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
@@ -1112,10 +1114,14 @@ only be readable by the user owning it.
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
@@ -1126,7 +1132,9 @@ Finally, the previous method can be combined with V=
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
@@ -1163,7 +1171,9 @@ credentials. This can be enabled, by combining the =
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
2.17.1
