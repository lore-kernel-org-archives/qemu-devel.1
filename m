Received: from eggs.gnu.org ([209.51.188.92]:38966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI6V-0001zI-He
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:23:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI6R-0002E7-AW
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:23:38 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:20:52 +0100
Message-Id: <20190225152053.15976-71-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 70/71] vmdk: false positive of compat6 with
 hwversion not set
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

From: yuchenlin <yuchenlin@synology.com>

In vmdk_co_create_opts, when it finds hw_version is undefined, it will
set it to 4, which misleading the compat6 and hwversion in
vmdk_co_do_create. Simply set hw_version to NULL after free, let
the logic in vmdk_co_do_create to decide the value of hw_version.

This bug can be reproduced by:

$ qemu-img convert -O vmdk -o subformat=3DstreamOptimized,compat6
/home/yuchenlin/syno.qcow2 /home/yuchenlin/syno.vmdk

qemu-img: /home/yuchenlin/syno.vmdk: error while converting vmdk:
compat6 cannot be enabled with hwversion set

Signed-off-by: yuchenlin <yuchenlin@synology.com>
Message-id: 20190221110805.28239-1-yuchenlin@synology.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/vmdk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 91345babb5..f4e68aa00b 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2267,7 +2267,7 @@ static int coroutine_fn vmdk_co_create_opts(const c=
har *filename, QemuOpts *opts
     compat6 =3D qemu_opt_get_bool_del(opts, BLOCK_OPT_COMPAT6, false);
     if (strcmp(hw_version, "undefined") =3D=3D 0) {
         g_free(hw_version);
-        hw_version =3D g_strdup("4");
+        hw_version =3D NULL;
     }
     fmt =3D qemu_opt_get_del(opts, BLOCK_OPT_SUBFMT);
     zeroed_grain =3D qemu_opt_get_bool_del(opts, BLOCK_OPT_ZEROED_GRAIN,=
 false);
--=20
2.20.1
