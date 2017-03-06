Received: from eggs.gnu.org ([2001:4830:134:3::10]:50655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ckwqK-0005MF-17
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ckwqG-0005eJ-Sw
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:54:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ckwqG-0005e4-Jt
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:54:40 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v26HrdKU096397
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 12:54:38 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2917uupxtw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 12:54:38 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 6 Mar 2017 17:54:36 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon,  6 Mar 2017 18:54:07 +0100
In-Reply-To: <1488822850-23070-1-git-send-email-groug@kaod.org>
References: <1488822850-23070-1-git-send-email-groug@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1488822850-23070-4-git-send-email-groug@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/6] 9pfs: fail local_statfs() earlier
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

If we cannot open the given path, we can return right away instead of
passing -1 to fstatfs() and close(). This will make Coverity happy.

(Coverity issue CID1371729)

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Daniel P. berrange <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/9pfs/9p-local.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 09f6a46d61b8..6d16c4a06587 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1053,6 +1053,9 @@ static int local_statfs(FsContext *s, V9fsPath *fs_=
path, struct statfs *stbuf)
     int fd, ret;
=20
     fd =3D local_open_nofollow(s, fs_path->data, O_RDONLY, 0);
+    if (fd =3D=3D -1) {
+        return -1;
+    }
     ret =3D fstatfs(fd, stbuf);
     close_preserve_errno(fd);
     return ret;
--=20
2.7.4
