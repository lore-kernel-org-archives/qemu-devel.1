Received: from eggs.gnu.org ([2001:4830:134:3::10]:57615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ef94K-0002L7-I8
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ef94H-0003OI-Fm
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:49:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41442
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ef94H-0003O5-AA
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:49:41 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0QImnsU151691
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 13:49:39 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fr7rt53dy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 13:49:37 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 26 Jan 2018 11:49:37 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 26 Jan 2018 13:49:25 -0500
In-Reply-To: <1516992568-3139-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1516992568-3139-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1516992568-3139-3-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/5] tpm: lookup cancel path under tpm device
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
index 29142f3..f2563ac 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -216,7 +216,8 @@ static size_t tpm_passthrough_get_buffer_size(TPMBack=
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
@@ -227,26 +228,35 @@ static int tpm_passthrough_open_sysfs_cancel(TPMPas=
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
