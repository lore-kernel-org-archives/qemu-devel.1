Received: from eggs.gnu.org ([2001:4830:134:3::10]:50642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ckwqH-0005Ka-LR
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ckwqE-0005dl-Dv
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:54:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ckwqE-0005df-4U
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:54:38 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v26HrjSK011288
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 12:54:36 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2917qmy9t1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 12:54:36 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 6 Mar 2017 17:54:33 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon,  6 Mar 2017 18:54:06 +0100
In-Reply-To: <1488822850-23070-1-git-send-email-groug@kaod.org>
References: <1488822850-23070-1-git-send-email-groug@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1488822850-23070-3-git-send-email-groug@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/6] 9pfs: fix fd leak in local_opendir()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

Coverity issue CID1371731

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/9pfs/9p-local.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 5db7104334d6..09f6a46d61b8 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -435,6 +435,7 @@ static int local_opendir(FsContext *ctx,
=20
     stream =3D fdopendir(dirfd);
     if (!stream) {
+        close(dirfd);
         return -1;
     }
     fs->dir.stream =3D stream;
--=20
2.7.4
