Received: from eggs.gnu.org ([2001:4830:134:3::10]:55821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc84X-00062n-Kd
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc84U-0006wB-JW
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:37:13 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 31 Jul 2017 13:21:30 +0300
Message-Id: <9f26f3252534e7680cfc7c0dbd1d79fdb56519ad.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/25] ui/vnc: fix leak of SocketAddress **
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Extract the (correct) cleaning code as a new function vnc_free_addresses(=
) then
use it to remove the memory leaks.

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 ui/vnc.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index eb91559b6b..651cbb8606 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3521,6 +3521,20 @@ static int vnc_display_get_address(const char *add=
rstr,
     return ret;
 }
=20
+static void vnc_free_addresses(SocketAddress ***retsaddr,
+                               size_t *retnsaddr)
+{
+    size_t i;
+
+    for (i =3D 0; i < *retnsaddr; i++) {
+        qapi_free_SocketAddress((*retsaddr)[i]);
+    }
+    g_free(*retsaddr);
+
+    *retsaddr =3D NULL;
+    *retnsaddr =3D 0;
+}
+
 static int vnc_display_get_addresses(QemuOpts *opts,
                                      bool reverse,
                                      SocketAddress ***retsaddr,
@@ -3538,7 +3552,6 @@ static int vnc_display_get_addresses(QemuOpts *opts=
,
     bool has_ipv6 =3D qemu_opt_get(opts, "ipv6");
     bool ipv4 =3D qemu_opt_get_bool(opts, "ipv4", false);
     bool ipv6 =3D qemu_opt_get_bool(opts, "ipv6", false);
-    size_t i;
     int displaynum =3D -1;
     int ret =3D -1;
=20
@@ -3614,16 +3627,8 @@ static int vnc_display_get_addresses(QemuOpts *opt=
s,
     ret =3D 0;
  cleanup:
     if (ret < 0) {
-        for (i =3D 0; i < *retnsaddr; i++) {
-            qapi_free_SocketAddress((*retsaddr)[i]);
-        }
-        g_free(*retsaddr);
-        for (i =3D 0; i < *retnwsaddr; i++) {
-            qapi_free_SocketAddress((*retwsaddr)[i]);
-        }
-        g_free(*retwsaddr);
-        *retsaddr =3D *retwsaddr =3D NULL;
-        *retnsaddr =3D *retnwsaddr =3D 0;
+        vnc_free_addresses(retsaddr, retnsaddr);
+        vnc_free_addresses(retwsaddr, retnwsaddr);
     }
     return ret;
 }
@@ -3772,7 +3777,6 @@ void vnc_display_open(const char *id, Error **errp)
     int acl =3D 0;
     int lock_key_sync =3D 1;
     int key_delay_ms;
-    size_t i;
=20
     if (!vd) {
         error_setg(errp, "VNC display not active");
@@ -3993,12 +3997,8 @@ void vnc_display_open(const char *id, Error **errp=
)
     }
=20
  cleanup:
-    for (i =3D 0; i < nsaddr; i++) {
-        qapi_free_SocketAddress(saddr[i]);
-    }
-    for (i =3D 0; i < nwsaddr; i++) {
-        qapi_free_SocketAddress(wsaddr[i]);
-    }
+    vnc_free_addresses(&saddr, &nsaddr);
+    vnc_free_addresses(&wsaddr, &nwsaddr);
     return;
=20
 fail:
--=20
2.11.0
