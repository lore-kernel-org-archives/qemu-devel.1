Received: from eggs.gnu.org ([2001:4830:134:3::10]:34971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1egHrz-0004Xh-Dc
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 17:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1egHrw-0005sy-8s
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 17:25:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35048
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1egHrw-0005sU-3F
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 17:25:40 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0TMNfZg033883
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 17:25:39 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ft873tbvr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 17:25:38 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 29 Jan 2018 17:25:38 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 29 Jan 2018 17:25:16 -0500
In-Reply-To: <1517264719-18288-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1517264719-18288-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1517264719-18288-4-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 3/6] tpm: lookup cancel path under tpm device
 class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com, peter.maydell@linaro.org

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Since Linux commit 313d21eeab9282e, tpm devices have their own device
class "tpm" and the cancel path must be looked up under
/sys/class/tpm/ instead of /sys/class/misc/.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_passthrough.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 537e11a..fc42fe0 100644
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
2.5.5
