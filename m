Received: from eggs.gnu.org ([2001:4830:134:3::10]:36646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1egEFQ-00046y-3F
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1egEFP-0004kI-5B
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:33:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1egEFO-0004jp-Tm
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:33:39 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 29 Jan 2018 19:33:04 +0100
Message-Id: <20180129183307.19689-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180129183307.19689-1-marcandre.lureau@redhat.com>
References: <20180129183307.19689-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 2/5] tpm: lookup cancel path under tpm
 device class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Since Linux commit 313d21eeab9282e, tpm devices have their own device
class "tpm" and the cancel path must be looked up under
/sys/class/tpm/ instead of /sys/class/misc/.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_passthrough.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 537e11a3f9..fc42fe0933 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -214,7 +214,8 @@ static size_t tpm_passthrough_get_buffer_size(TPMBack=
end *tb)
  * Unless path or file descriptor set has been provided by user,
  * determine the sysfs cancel file following kernel documentation
  * in Documentation/ABI/stable/sysfs-class-tpm.
- * From /dev/tpm0 create /sys/class/misc/tpm0/device/cancel
+ * From /dev/tpm0 create /sys/class/tpm/tpm0/device/cancel
+ * before 4.0: /sys/class/misc/tpm0/device/cancel
  */
 static int tpm_passthrough_open_sysfs_cancel(TPMPassthruState *tpm_pt)
 {
@@ -225,26 +226,35 @@ static int tpm_passthrough_open_sysfs_cancel(TPMPas=
sthruState *tpm_pt)
     if (tpm_pt->options->cancel_path) {
         fd =3D qemu_open(tpm_pt->options->cancel_path, O_WRONLY);
         if (fd < 0) {
-            error_report("Could not open TPM cancel path : %s",
+            error_report("tpm_passthrough: Could not open TPM cancel pat=
h: %s",
                          strerror(errno));
         }
         return fd;
     }
=20
     dev =3D strrchr(tpm_pt->tpm_dev, '/');
-    if (dev) {
-        dev++;
-        if (snprintf(path, sizeof(path), "/sys/class/misc/%s/device/canc=
el",
-                     dev) < sizeof(path)) {
-            fd =3D qemu_open(path, O_WRONLY);
-            if (fd < 0) {
-                error_report("tpm_passthrough: Could not open TPM cancel=
 "
-                             "path %s : %s", path, strerror(errno));
+    if (!dev) {
+        error_report("tpm_passthrough: Bad TPM device path %s",
+                     tpm_pt->tpm_dev);
+        return -1;
+    }
+
+    dev++;
+    if (snprintf(path, sizeof(path), "/sys/class/tpm/%s/device/cancel",
+                 dev) < sizeof(path)) {
+        fd =3D qemu_open(path, O_WRONLY);
+        if (fd < 0) {
+            if (snprintf(path, sizeof(path), "/sys/class/misc/%s/device/=
cancel",
+                         dev) < sizeof(path)) {
+                fd =3D qemu_open(path, O_WRONLY);
             }
         }
+    }
+
+    if (fd < 0) {
+        error_report("tpm_passthrough: Could not guess TPM cancel path")=
;
     } else {
-       error_report("tpm_passthrough: Bad TPM device path %s",
-                    tpm_pt->tpm_dev);
+        tpm_pt->options->cancel_path =3D g_strdup(path);
     }
=20
     return fd;
--=20
2.16.0.rc1.1.gef27df75a1
