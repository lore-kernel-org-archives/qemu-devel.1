Received: from eggs.gnu.org ([2001:4830:134:3::10]:50608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2yPA-0007Ls-UL
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2yP6-0002sV-LY
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:45:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46308
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e2yP6-0002s0-FH
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:45:24 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9DBhsNr087218
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 07:45:21 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2djrwm5ex7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 07:45:21 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 13 Oct 2017 07:45:20 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 13 Oct 2017 07:44:50 -0400
In-Reply-To: <1507895100-26457-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507895100-26457-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1507895100-26457-2-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 01/11] tpm: Use EMSGSIZE instead of EBADMSG
 to compile on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, amarnath.valluri@intel.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

EBADMSG was only added to OpenBSD very recently. To make QEMU compilable
on older OpenBSD versions use EMSGSIZE instead when a mismatch between
number of received bytes and message size indicated in the header was
found.

Return -EMSGSIZE and convert all other errnos in the same functions to
return the negative errno.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_util.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index 7b35429..4484207 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -43,10 +43,10 @@ static int tpm_util_test(int fd,
=20
     n =3D write(fd, request, requestlen);
     if (n < 0) {
-        return errno;
+        return -errno;
     }
     if (n !=3D requestlen) {
-        return EFAULT;
+        return -EFAULT;
     }
=20
     FD_ZERO(&readfds);
@@ -55,18 +55,18 @@ static int tpm_util_test(int fd,
     /* wait for a second */
     n =3D select(fd + 1, &readfds, NULL, NULL, &tv);
     if (n !=3D 1) {
-        return errno;
+        return -errno;
     }
=20
     n =3D read(fd, &buf, sizeof(buf));
     if (n < sizeof(struct tpm_resp_hdr)) {
-        return EFAULT;
+        return -EFAULT;
     }
=20
     resp =3D (struct tpm_resp_hdr *)buf;
     /* check the header */
     if (be32_to_cpu(resp->len) !=3D n) {
-        return EBADMSG;
+        return -EMSGSIZE;
     }
=20
     *return_tag =3D be16_to_cpu(resp->tag);
--=20
2.5.5
