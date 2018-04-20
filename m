Received: from eggs.gnu.org ([2001:4830:134:3::10]:35266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f9Xuu-0001zd-Lq
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f9Xup-00039T-Km
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:25:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36404 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f9Xup-00034n-GL
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:25:35 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 20 Apr 2018 17:25:11 +0200
Message-Id: <20180420152511.18878-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qemu-ga: make get-fsinfo work over pci bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, mdroth@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Iterate over the PCI bridges to lookup the PCI device associated with
the block device.

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1567041

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qga/commands-posix.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 0dc219dbcf..5d4e5f627f 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -879,9 +879,24 @@ static void build_guest_fsinfo_for_real_device(char =
const *syspath,
         return;
     }
=20
-    driver =3D get_pci_driver(syspath, (p + 12 + pcilen) - syspath, errp=
);
-    if (!driver) {
-        goto cleanup;
+    p +=3D 12 + pcilen;
+    while (true) {
+        driver =3D get_pci_driver(syspath, p - syspath, errp);
+        if (!driver) {
+            goto cleanup;
+        }
+
+        if (g_str_equal(driver, "pcieport")) {
+            if (sscanf(p, "/%x:%x:%x.%x%n",
+                       pci, pci + 1, pci + 2, pci + 3, &pcilen) < 4) {
+                g_debug("only pci device is supported: sysfs path \"%s\"=
",
+                        syspath);
+                return;
+            }
+            p +=3D pcilen;
+            continue;
+        }
+        break;
     }
=20
     p =3D strstr(syspath, "/target");
--=20
2.17.0.253.g3dd125b46d
