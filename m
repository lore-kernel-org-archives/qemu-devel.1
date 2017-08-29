Received: from eggs.gnu.org ([2001:4830:134:3::10]:48988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCu-0001pm-Fx
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCr-0006H2-9z
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35344
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCr-0006GL-3j
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:37 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E9cj017824
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:36 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmub2wwbx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:36 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:36 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:13:41 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1503965694-10794-7-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/79] block: An empty filename counts as no
 filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: Max Reitz <mreitz@redhat.com>

Reproducer:
    $ ./qemu-img info ''
    qemu-img: ./block.c:1008: bdrv_open_driver: Assertion
        `!drv->bdrv_needs_filename || bs->filename[0]' failed.
    [1]    26105 abort (core dumped)  ./qemu-img info ''

This patch fixes this to be:
    $ ./qemu-img info ''
    qemu-img: Could not open '': The 'file' block driver requires a file
    name

Cc: qemu-stable <qemu-stable@nongnu.org>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 4a0082401a770261b85625a41eef4a4e89ad7a74)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 1fbbb8d..46da908 100644
--- a/block.c
+++ b/block.c
@@ -1167,7 +1167,7 @@ static int bdrv_open_common(BlockDriverState *bs, B=
lockBackend *file,
         filename =3D qdict_get_try_str(options, "filename");
     }
=20
-    if (drv->bdrv_needs_filename && !filename) {
+    if (drv->bdrv_needs_filename && (!filename || !filename[0])) {
         error_setg(errp, "The '%s' block driver requires a file name",
                    drv->format_name);
         ret =3D -EINVAL;
--=20
2.7.4
