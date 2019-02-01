Received: from eggs.gnu.org ([209.51.188.92]:39111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpbo5-0007nC-Q7
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpbo3-0008W9-Le
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:36:45 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  1 Feb 2019 17:35:04 +0100
Message-Id: <20190201163518.31157-14-kwolf@redhat.com>
In-Reply-To: <20190201163518.31157-1-kwolf@redhat.com>
References: <20190201163518.31157-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/27] block/vpc: Don't take address of fields
 in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

Taking the address of a field in a packed struct is a bad idea, because
it might not be actually aligned enough for that pointer type (and
thus cause a crash on dereference on some host architectures). Newer
versions of clang warn about this. Avoid the bug by generating the
UUID into a local variable which is definitely safely aligned and
then copying it into place.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/vpc.c b/block/vpc.c
index d886465b7e..52ab717642 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -979,6 +979,7 @@ static int coroutine_fn vpc_co_create(BlockdevCreateO=
ptions *opts,
     int64_t total_size;
     int disk_type;
     int ret =3D -EIO;
+    QemuUUID uuid;
=20
     assert(opts->driver =3D=3D BLOCKDEV_DRIVER_VPC);
     vpc_opts =3D &opts->u.vpc;
@@ -1062,7 +1063,8 @@ static int coroutine_fn vpc_co_create(BlockdevCreat=
eOptions *opts,
=20
     footer->type =3D cpu_to_be32(disk_type);
=20
-    qemu_uuid_generate(&footer->uuid);
+    qemu_uuid_generate(&uuid);
+    footer->uuid =3D uuid;
=20
     footer->checksum =3D cpu_to_be32(vpc_checksum(buf, HEADER_SIZE));
=20
--=20
2.20.1
