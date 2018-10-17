Received: from eggs.gnu.org ([2001:4830:134:3::10]:51147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChAe-000872-6j
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChAc-00016z-MT
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gChAc-00013q-2m
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A99FA3082141
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 08:27:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 17 Oct 2018 10:26:37 +0200
Message-Id: <20181017082702.5581-14-armbru@redhat.com>
In-Reply-To: <20181017082702.5581-1-armbru@redhat.com>
References: <20181017082702.5581-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 13/38] l2tpv3: Improve
 -netdev/netdev_add/-net/... error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

When -netdev l2tpv3 fails, it first reports a specific error, then a
generic one, like this:

    $ qemu-system-x86_64 -netdev l2tpv3,id=3Dfoo,src=3D,dst=3D,txsession=3D=
1
    qemu-system-x86_64: -netdev l2tpv3,id=3Dfoo,src=3D,dst=3D,txsession=3D=
1: l2tpv3_open : could not resolve src, errno =3D Name or service not kno=
wn
    qemu-system-x86_64: Device 'l2tpv3' could not be initialized

With the command line, the messages go to stderr.  In HMP, they go to
the monitor.  In QMP, the second one becomes the error reply, and the
first one goes to stderr.

Convert net_init_tap() to Error.  This suppresses the unwanted second
message, and makes the specific error the QMP error reply.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 net/l2tpv3.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/net/l2tpv3.c b/net/l2tpv3.c
index 6745b78990..81db24dc8c 100644
--- a/net/l2tpv3.c
+++ b/net/l2tpv3.c
@@ -28,6 +28,7 @@
 #include <netdb.h>
 #include "net/net.h"
 #include "clients.h"
+#include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
@@ -528,7 +529,6 @@ int net_init_l2tpv3(const Netdev *netdev,
                     const char *name,
                     NetClientState *peer, Error **errp)
 {
-    /* FIXME error_setg(errp, ...) on failure */
     const NetdevL2TPv3Options *l2tpv3;
     NetL2TPV3State *s;
     NetClientState *nc;
@@ -555,7 +555,7 @@ int net_init_l2tpv3(const Netdev *netdev,
     }
=20
     if ((l2tpv3->has_offset) && (l2tpv3->offset > 256)) {
-        error_report("l2tpv3_open : offset must be less than 256 bytes")=
;
+        error_setg(errp, "offset must be less than 256 bytes");
         goto outerr;
     }
=20
@@ -563,6 +563,8 @@ int net_init_l2tpv3(const Netdev *netdev,
         if (l2tpv3->has_rxcookie && l2tpv3->has_txcookie) {
             s->cookie =3D true;
         } else {
+            error_setg(errp,
+                       "require both 'rxcookie' and 'txcookie' or neithe=
r");
             goto outerr;
         }
     } else {
@@ -578,7 +580,7 @@ int net_init_l2tpv3(const Netdev *netdev,
     if (l2tpv3->has_udp && l2tpv3->udp) {
         s->udp =3D true;
         if (!(l2tpv3->has_srcport && l2tpv3->has_dstport)) {
-            error_report("l2tpv3_open : need both src and dst port for u=
dp");
+            error_setg(errp, "need both src and dst port for udp");
             goto outerr;
         } else {
             srcport =3D l2tpv3->srcport;
@@ -639,20 +641,19 @@ int net_init_l2tpv3(const Netdev *netdev,
     gairet =3D getaddrinfo(l2tpv3->src, srcport, &hints, &result);
=20
     if ((gairet !=3D 0) || (result =3D=3D NULL)) {
-        error_report(
-            "l2tpv3_open : could not resolve src, errno =3D %s",
-            gai_strerror(gairet)
-        );
+        error_setg(errp, "could not resolve src, errno =3D %s",
+                   gai_strerror(gairet));
         goto outerr;
     }
     fd =3D socket(result->ai_family, result->ai_socktype, result->ai_pro=
tocol);
     if (fd =3D=3D -1) {
         fd =3D -errno;
-        error_report("l2tpv3_open : socket creation failed, errno =3D %d=
", -fd);
+        error_setg(errp, "socket creation failed, errno =3D %d",
+                   -fd);
         goto outerr;
     }
     if (bind(fd, (struct sockaddr *) result->ai_addr, result->ai_addrlen=
)) {
-        error_report("l2tpv3_open :  could not bind socket err=3D%i", er=
rno);
+        error_setg(errp, "could not bind socket err=3D%i", errno);
         goto outerr;
     }
     if (result) {
@@ -677,10 +678,8 @@ int net_init_l2tpv3(const Netdev *netdev,
     result =3D NULL;
     gairet =3D getaddrinfo(l2tpv3->dst, dstport, &hints, &result);
     if ((gairet !=3D 0) || (result =3D=3D NULL)) {
-        error_report(
-            "l2tpv3_open : could not resolve dst, error =3D %s",
-            gai_strerror(gairet)
-        );
+        error_setg(errp, "could not resolve dst, error =3D %s",
+                   gai_strerror(gairet));
         goto outerr;
     }
=20
--=20
2.17.1
