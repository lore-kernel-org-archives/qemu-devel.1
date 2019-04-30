Received: from eggs.gnu.org ([209.51.188.92]:48645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuo-0007y7-Dq
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUum-00022w-LS
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:21 +0200
Message-Id: <20190430154244.30083-5-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/27] vmdk: Set vmdk parent backing_format to
 vmdk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Sam Eiderman <shmuel.eiderman@oracle.com>

Commit b69864e5a ("vmdk: Support version=3D3 in VMDK descriptor files")
fixed the probe function to correctly guess vmdk descriptors with
version=3D3.

This solves the issue where vmdk snapshot with parent vmdk descriptor
containing "version=3D3" would be treated as raw instead vmdk.

In the future case where a new vmdk version is introduced, we will again
experience this issue, even if the user will provide "-f vmdk" it will
only apply to the tip image and not to the underlying "misprobed" parent
image.

The code in vmdk.c already assumes that the backing file of vmdk must be
vmdk (see vmdk_is_cid_valid which returns 0 if backing file is not
vmdk).

So let's make it official by supplying the backing_format as vmdk.

Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
Reviewed-By: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Shmuel Eiderman <shmuel.eiderman@oracle.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <fam@euphon.net>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vmdk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/vmdk.c b/block/vmdk.c
index 8dec6ef767..de8cb859f8 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -397,6 +397,8 @@ static int vmdk_parent_open(BlockDriverState *bs)
         pstrcpy(bs->auto_backing_file, end_name - p_name + 1, p_name);
         pstrcpy(bs->backing_file, sizeof(bs->backing_file),
                 bs->auto_backing_file);
+        pstrcpy(bs->backing_format, sizeof(bs->backing_format),
+                "vmdk");
     }
=20
 out:
--=20
2.20.1
