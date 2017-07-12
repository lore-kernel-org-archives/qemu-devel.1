Received: from eggs.gnu.org ([2001:4830:134:3::10]:41525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVKLY-0007uQ-Ag
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVKLX-0002qX-88
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:18:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dVKLW-0002pt-VK
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:18:39 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 12 Jul 2017 17:18:26 +0100
Message-Id: <20170712161830.3621-2-berrange@redhat.com>
In-Reply-To: <20170712161830.3621-1-berrange@redhat.com>
References: <20170712161830.3621-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 1/5] sockets: ensure we can bind to both ipv4
 & ipv6 separately
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

When binding to an IPv6 socket we currently force the
IPV6_V6ONLY flag to off. This means that the IPv6 socket
will accept both IPv4 & IPv6 sockets when QEMU is launched
with something like

  -vnc :::1

While this is good for that case, it is bad for other
cases. For example if an empty hostname is given,
getaddrinfo resolves it to 2 addresses 0.0.0.0 and ::,
in that order. We will thus bind to 0.0.0.0 first, and
then fail to bind to :: on the same port. The same
problem can happen if any other hostname lookup causes
the IPv4 address to be reported before the IPv6 address.

When we get an IPv6 bind failure, we should re-try the
same port, but with IPV6_V6ONLY turned on again, to
avoid clash with any IPv4 listener.

This ensures that

  -vnc :1

will bind successfully to both 0.0.0.0 and ::, and also
avoid

  -vnc :1,to=3D2

from mistakenly using a 2nd port for the :: listener.

This is a regression due to commit 396f935 "ui: add ability to
specify multiple VNC listen addresses".

Acked-by: Gerd Hoffmann <kraxel@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 util/qemu-sockets.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index d3e5108..4c2f84b 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -208,22 +208,37 @@ static int inet_listen_saddr(InetSocketAddress *sad=
dr,
         }
=20
         socket_set_fast_reuse(slisten);
-#ifdef IPV6_V6ONLY
-        if (e->ai_family =3D=3D PF_INET6) {
-            /* listen on both ipv4 and ipv6 */
-            const int off =3D 0;
-            qemu_setsockopt(slisten, IPPROTO_IPV6, IPV6_V6ONLY, &off,
-                            sizeof(off));
-        }
-#endif
=20
         port_min =3D inet_getport(e);
         port_max =3D saddr->has_to ? saddr->to + port_offset : port_min;
         for (p =3D port_min; p <=3D port_max; p++) {
+#ifdef IPV6_V6ONLY
+            /* listen on both ipv4 and ipv6 */
+            int v6only =3D 0;
+#endif
             inet_setport(e, p);
+#ifdef IPV6_V6ONLY
+        rebind:
+            if (e->ai_family =3D=3D PF_INET6) {
+                qemu_setsockopt(slisten, IPPROTO_IPV6, IPV6_V6ONLY, &v6o=
nly,
+                                sizeof(v6only));
+            }
+#endif
             if (bind(slisten, e->ai_addr, e->ai_addrlen) =3D=3D 0) {
                 goto listen;
             }
+
+#ifdef IPV6_V6ONLY
+            /* If we got EADDRINUSE from an IPv6 bind & V6ONLY is unset,
+             * it could be that the IPv4 port is already claimed, so ret=
ry
+             * with V6ONLY set
+             */
+            if (e->ai_family =3D=3D PF_INET6 && errno =3D=3D EADDRINUSE =
&& !v6only) {
+                v6only =3D 1;
+                goto rebind;
+            }
+#endif
+
             if (p =3D=3D port_max) {
                 if (!e->ai_next) {
                     error_setg_errno(errp, errno, "Failed to bind socket=
");
--=20
2.9.4
