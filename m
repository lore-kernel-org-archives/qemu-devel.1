Received: from eggs.gnu.org ([2001:4830:134:3::10]:41535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVKLZ-0007ur-7y
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVKLY-0002rF-A2
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:18:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dVKLY-0002qj-3t
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:18:40 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 12 Jul 2017 17:18:27 +0100
Message-Id: <20170712161830.3621-3-berrange@redhat.com>
In-Reply-To: <20170712161830.3621-1-berrange@redhat.com>
References: <20170712161830.3621-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 2/5] sockets: don't block IPv4 clients when
 listening on "::"
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

When inet_parse() parses the hostname, it is forcing the
has_ipv6 && ipv6 flags if the address contains a ":". This
means that if the user had set the ipv4=3Don flag, to try to
restrict the listener to just ipv4, an error would not have
been raised.  eg

   -incoming tcp:[::]:9000,ipv4

should have raised an error because listening for IPv4
on "::" is a non-sensical combination. With this removed,
we now call getaddrinfo() on "::" passing PF_INET and
so getaddrinfo reports an error about the hostname being
incompatible with the requested protocol:

 qemu-system-x86_64: -incoming tcp:[::]:9000,ipv4: address resolution
    failed for :::9000: Address family for hostname not supported

Likewise it is explicitly setting the has_ipv4 & ipv4
flags when the address contains only digits + '.'. This
has no ill-effect, but also has no benefit, so is removed.

Acked-by: Gerd Hoffmann <kraxel@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 util/qemu-sockets.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 4c2f84b..f4ddcaf 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -618,16 +618,12 @@ int inet_parse(InetSocketAddress *addr, const char =
*str, Error **errp)
             error_setg(errp, "error parsing IPv6 address '%s'", str);
             return -1;
         }
-        addr->ipv6 =3D addr->has_ipv6 =3D true;
     } else {
         /* hostname or IPv4 addr */
         if (sscanf(str, "%64[^:]:%32[^,]%n", host, port, &pos) !=3D 2) {
             error_setg(errp, "error parsing address '%s'", str);
             return -1;
         }
-        if (host[strspn(host, "0123456789.")] =3D=3D '\0') {
-            addr->ipv4 =3D addr->has_ipv4 =3D true;
-        }
     }
=20
     addr->host =3D g_strdup(host);
--=20
2.9.4
