Received: from eggs.gnu.org ([2001:4830:134:3::10]:33920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dwBKp-0004Z1-7f
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 14:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dwBKm-000580-55
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 14:08:55 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:49409)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1dwBKl-00057W-Re
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 14:08:52 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 24 Sep 2017 20:08:46 +0200
Message-Id: <20170924180848.19168-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170924180848.19168-1-samuel.thibault@ens-lyon.org>
References: <20170924180848.19168-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] slirp: Add explanation for hostfwd parsing
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

e.g.
./x86_64-softmmu/qemu-system-x86_64 -nographic -netdev 'user,id=3Dvnet,ho=
stfwd=3D:555.0.0.0:0-:22'
qemu-system-x86_64: -netdev user,id=3Dvnet,hostfwd=3D:555.0.0.0:0-:22: In=
valid host forwarding rule ':555.0.0.0:0-:22' (Bad host address)

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 net/slirp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/slirp.c b/net/slirp.c
index 01ed21c006..318a26e892 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -496,9 +496,11 @@ static int slirp_hostfwd(SlirpState *s, const char *=
redir_str,
     char buf[256];
     int is_udp;
     char *end;
+    const char *fail_reason =3D "Unknown reason";
=20
     p =3D redir_str;
     if (!p || get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+        fail_reason =3D "No : separators";
         goto fail_syntax;
     }
     if (!strcmp(buf, "tcp") || buf[0] =3D=3D '\0') {
@@ -506,35 +508,43 @@ static int slirp_hostfwd(SlirpState *s, const char =
*redir_str,
     } else if (!strcmp(buf, "udp")) {
         is_udp =3D 1;
     } else {
+        fail_reason =3D "Bad protocol name";
         goto fail_syntax;
     }
=20
     if (!legacy_format) {
         if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+            fail_reason =3D "Missing : separator";
             goto fail_syntax;
         }
         if (buf[0] !=3D '\0' && !inet_aton(buf, &host_addr)) {
+            fail_reason =3D "Bad host address";
             goto fail_syntax;
         }
     }
=20
     if (get_str_sep(buf, sizeof(buf), &p, legacy_format ? ':' : '-') < 0=
) {
+        fail_reason =3D "Bad host port separator";
         goto fail_syntax;
     }
     host_port =3D strtol(buf, &end, 0);
     if (*end !=3D '\0' || host_port < 0 || host_port > 65535) {
+        fail_reason =3D "Bad host port";
         goto fail_syntax;
     }
=20
     if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+        fail_reason =3D "Missing guest address";
         goto fail_syntax;
     }
     if (buf[0] !=3D '\0' && !inet_aton(buf, &guest_addr)) {
+        fail_reason =3D "Bad guest address";
         goto fail_syntax;
     }
=20
     guest_port =3D strtol(p, &end, 0);
     if (*end !=3D '\0' || guest_port < 1 || guest_port > 65535) {
+        fail_reason =3D "Bad guest port";
         goto fail_syntax;
     }
=20
@@ -547,7 +557,8 @@ static int slirp_hostfwd(SlirpState *s, const char *r=
edir_str,
     return 0;
=20
  fail_syntax:
-    error_setg(errp, "Invalid host forwarding rule '%s'", redir_str);
+    error_setg(errp, "Invalid host forwarding rule '%s' (%s)", redir_str=
,
+               fail_reason);
     return -1;
 }
=20
--=20
2.14.1
