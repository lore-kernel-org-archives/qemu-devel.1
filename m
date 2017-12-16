Received: from eggs.gnu.org ([2001:4830:134:3::10]:45870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTc-0005w4-PX
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTY-0008Lj-Gc
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54306
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTY-0008L3-BT
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:16 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHfL98074822
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:13 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2evx0cxt5w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:13 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:12 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:26 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-10-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 09/32] tpm-passthrough: don't save guessed
 cancel_path in options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The value is later unneeded, and may leak if the free visitor doesn't
consider it since has_cancel_path is false. And for consistency with
"path" it shouldn't be returned in get_tpm_options().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_passthrough.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 8c002e4..048edb1 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -226,9 +226,7 @@ static int tpm_passthrough_open_sysfs_cancel(TPMPasst=
hruState *tpm_pt)
         if (snprintf(path, sizeof(path), "/sys/class/misc/%s/device/canc=
el",
                      dev) < sizeof(path)) {
             fd =3D qemu_open(path, O_WRONLY);
-            if (fd >=3D 0) {
-                tpm_pt->options->cancel_path =3D g_strdup(path);
-            } else {
+            if (fd < 0) {
                 error_report("tpm_passthrough: Could not open TPM cancel=
 "
                              "path %s : %s", path, strerror(errno));
             }
--=20
2.5.5
