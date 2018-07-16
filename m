Received: from eggs.gnu.org ([2001:4830:134:3::10]:56898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ffBJ1-00063D-OD
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ffBIy-000421-CF
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:45:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44672
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ffBIy-00041f-6E
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:45:16 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6GLd8sa116844
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 17:45:15 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k9073y867-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 17:45:14 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 16 Jul 2018 17:45:14 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 16 Jul 2018 16:44:49 -0500
In-Reply-To: <20180716214450.17758-1-mdroth@linux.vnet.ibm.com>
References: <20180716214450.17758-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180716214450.17758-2-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-3.0 1/2] qga: fix 'driver' leak in
 guest-get-fsinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

'driver' is leaked when the loop is not broken.

Leak introduced by commit 743c71d03c20d64f2bae5fba6f26cdf5e4b1bda6,
spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 233f78a406..c46767b0dd 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -890,6 +890,7 @@ static void build_guest_fsinfo_for_real_device(char c=
onst *syspath,
             break;
         }
=20
+        g_free(driver);
         if (sscanf(p, "/%x:%x:%x.%x%n",
                           pci, pci + 1, pci + 2, pci + 3, &pcilen) =3D=3D=
 4) {
             p +=3D pcilen;
--=20
2.11.0
