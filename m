Received: from eggs.gnu.org ([2001:4830:134:3::10]:56908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ffBJ4-00063S-EB
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ffBJ1-00042r-Ax
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:45:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ffBJ1-00042e-0R
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:45:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6GLdRjJ101711
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 17:45:17 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k8xhtb9bv-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 17:45:17 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 16 Jul 2018 17:45:16 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 16 Jul 2018 16:44:50 -0500
In-Reply-To: <20180716214450.17758-1-mdroth@linux.vnet.ibm.com>
References: <20180716214450.17758-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180716214450.17758-3-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-3.0 2/2] qga: fix file descriptor leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

The file descriptor for /sys/power/state was never closed.  Reported
by Coverity.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index c46767b0dd..37e8a2d791 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1652,6 +1652,7 @@ static bool linux_sys_state_supports_mode(SuspendMo=
de mode, Error **errp)
     }
=20
     ret =3D read(fd, buf, sizeof(buf) - 1);
+    close(fd);
     if (ret <=3D 0) {
         return false;
     }
--=20
2.11.0
