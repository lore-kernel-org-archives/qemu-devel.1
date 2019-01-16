Received: from eggs.gnu.org ([209.51.188.92]:53223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjjsN-00077D-LN
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjjsM-0006lf-CN
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:00:55 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed, 16 Jan 2019 13:00:41 +0100
Message-Id: <20190116120041.17095-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] xen: Fix format string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Anthony Perard <anthony.perard@citrix.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Trivial format string fix to solve:

  hw/block/xen-block.c: In function 'xen_block_realize':
  hw/block/xen-block.c:218:53: error: format '%lu' expects argument of ty=
pe 'long unsigned int', but argument 4 has type 'int64_t {aka long long i=
nt}' [-Werror=3Dformat=3D]
      xen_device_backend_printf(xendev, "sectors", "%lu",
                                                      ^
                                blk_getlength(conf->blk) /
                                conf->logical_block_size);

blk_getlength() returns an int64_t.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/xen-block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index be28b63442..3cf215b730 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -215,7 +215,7 @@ static void xen_block_realize(XenDevice *xendev, Erro=
r **errp)
=20
     xen_device_backend_printf(xendev, "sector-size", "%u",
                               conf->logical_block_size);
-    xen_device_backend_printf(xendev, "sectors", "%lu",
+    xen_device_backend_printf(xendev, "sectors", "%lld",
                               blk_getlength(conf->blk) /
                               conf->logical_block_size);
=20
--=20
2.17.2
