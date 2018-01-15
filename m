Received: from eggs.gnu.org ([2001:4830:134:3::10]:55731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eb0YS-0003jt-UY
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 03:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eb0YP-0007my-Qt
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 03:55:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eb0YP-0007lw-HT
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 03:55:41 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon, 15 Jan 2018 16:55:28 +0800
Message-Id: <20180115085528.32663-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] fw_cfg: don't use DMA mapping for fw_cfg device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Baoquan He <bhe@redhat.com>, peterx@redhat.com

fw_cfg device does not need IOMMU protection, so use physical addresses
always.  That's how QEMU implements fw_cfg.  Otherwise we'll see call
traces during boot when vIOMMU is enabled in guest:

[    1.018306] ------------[ cut here ]------------
[    1.018314] WARNING: CPU: 1 PID: 1 at drivers/firmware/qemu_fw_cfg.c:1=
52 fw_cfg_dma_transfer+0x399/0x500
[    1.018315] fw_cfg_dma_transfer: failed to map fw_cfg_dma
[    1.018316] Modules linked in:
[    1.018320] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 3.10.0-827.el7.x=
86_64 #1
[    1.018321] Hardware name: Red Hat KVM, BIOS 1.11.0-1.el7 04/01/2014
[    1.018322] Call Trace:
[    1.018330]  [<ffffffffafcf6b3a>] dump_stack+0x19/0x1b
[    1.018334]  [<ffffffffaf68fff8>] __warn+0xd8/0x100
[    1.018336]  [<ffffffffaf69007f>] warn_slowpath_fmt+0x5f/0x80
[    1.018338]  [<ffffffffafb67329>] fw_cfg_dma_transfer+0x399/0x500
[    1.018340]  [<ffffffffafb6753c>] fw_cfg_read_blob+0xac/0x1c0
[    1.018342]  [<ffffffffafb67720>] fw_cfg_register_dir_entries+0x80/0x4=
50
[    1.018344]  [<ffffffffafb67d02>] fw_cfg_sysfs_probe+0x212/0x3f0
[    1.018347]  [<ffffffffafa70352>] platform_drv_probe+0x42/0x110
[    1.018350]  [<ffffffffafa6e002>] driver_probe_device+0xc2/0x3e0
[    1.018352]  [<ffffffffafa6e3f3>] __driver_attach+0x93/0xa0
[    1.018354]  [<ffffffffafa6e360>] ? __device_attach+0x40/0x40
[    1.018359]  [<ffffffffafa6bbd3>] bus_for_each_dev+0x73/0xc0
[    1.018362]  [<ffffffffafa6d97e>] driver_attach+0x1e/0x20
[    1.018364]  [<ffffffffafa6d420>] bus_add_driver+0x200/0x2d0
[    1.018366]  [<ffffffffb03c2041>] ? firmware_map_add_early+0x58/0x58
[    1.018368]  [<ffffffffafa6ea84>] driver_register+0x64/0xf0
[    1.018370]  [<ffffffffafa7013a>] __platform_driver_register+0x4a/0x50
[    1.018372]  [<ffffffffb03c2075>] fw_cfg_sysfs_init+0x34/0x61
[    1.018376]  [<ffffffffaf602108>] do_one_initcall+0xb8/0x230
[    1.018379]  [<ffffffffb036b34a>] kernel_init_freeable+0x17a/0x219
[    1.018381]  [<ffffffffb036ab19>] ? initcall_blacklist+0xb0/0xb0
[    1.018383]  [<ffffffffafce5b30>] ? rest_init+0x80/0x80
[    1.018385]  [<ffffffffafce5b3e>] kernel_init+0xe/0xf0
[    1.018388]  [<ffffffffafd08898>] ret_from_fork+0x58/0x90
[    1.018390]  [<ffffffffafce5b30>] ? rest_init+0x80/0x80
[    1.018392] ---[ end trace d00a5b71608a8f59 ]---

Bug: https://bugzilla.redhat.com/show_bug.cgi?id=3D1533367
Fixes: e90cb816599b ("fw_cfg: do DMA read operation", 2017-11-28)
CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
--

This is based on tree:
  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/log/?h=3D=
vhost

Please review, thanks.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/firmware/qemu_fw_cfg.c | 37 ++++++++----------------------------=
-
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cf=
g.c
index 6eb5d8f43c3e..62a44bc81a88 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -106,11 +106,12 @@ static inline bool fw_cfg_dma_enabled(void)
 }
=20
 /* qemu fw_cfg device is sync today, but spec says it may become async *=
/
-static void fw_cfg_wait_for_control(struct fw_cfg_dma *d, dma_addr_t dma=
)
+static void fw_cfg_wait_for_control(struct fw_cfg_dma *d)
 {
 	do {
-		dma_sync_single_for_cpu(dev, dma, sizeof(*d), DMA_FROM_DEVICE);
-		if ((be32_to_cpu(d->control) & ~FW_CFG_DMA_CTL_ERROR) =3D=3D 0)
+		u32 ctrl =3D be32_to_cpu(READ_ONCE(d->control));
+
+		if ((ctrl & ~FW_CFG_DMA_CTL_ERROR) =3D=3D 0)
 			return;
=20
 		usleep_range(50, 100);
@@ -119,21 +120,9 @@ static void fw_cfg_wait_for_control(struct fw_cfg_dm=
a *d, dma_addr_t dma)
=20
 static ssize_t fw_cfg_dma_transfer(void *address, u32 length, u32 contro=
l)
 {
-	dma_addr_t dma_addr =3D 0;
 	struct fw_cfg_dma *d =3D NULL;
-	dma_addr_t dma;
 	ssize_t ret =3D length;
-	enum dma_data_direction dir =3D
-		(control & FW_CFG_DMA_CTL_READ ? DMA_FROM_DEVICE : 0) |
-		(control & FW_CFG_DMA_CTL_WRITE ? DMA_TO_DEVICE : 0);
-
-	if (address && length) {
-		dma_addr =3D dma_map_single(dev, address, length, dir);
-		if (dma_mapping_error(NULL, dma_addr)) {
-			WARN(1, "%s: failed to map address\n", __func__);
-			return -EFAULT;
-		}
-	}
+	phys_addr_t dma;
=20
 	d =3D kmalloc(sizeof(*d), GFP_KERNEL);
 	if (!d) {
@@ -142,34 +131,24 @@ static ssize_t fw_cfg_dma_transfer(void *address, u=
32 length, u32 control)
 	}
=20
 	*d =3D (struct fw_cfg_dma) {
-		.address =3D cpu_to_be64(dma_addr),
+		.address =3D cpu_to_be64(virt_to_phys(address)),
 		.length =3D cpu_to_be32(length),
 		.control =3D cpu_to_be32(control)
 	};
=20
-	dma =3D dma_map_single(dev, d, sizeof(*d), DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(NULL, dma)) {
-		WARN(1, "%s: failed to map fw_cfg_dma\n", __func__);
-		ret =3D -EFAULT;
-		goto end;
-	}
+	dma =3D virt_to_phys(d);
=20
 	iowrite32be((u64)dma >> 32, fw_cfg_reg_dma);
 	iowrite32be(dma, fw_cfg_reg_dma + 4);
=20
-	fw_cfg_wait_for_control(d, dma);
+	fw_cfg_wait_for_control(d);
=20
 	if (be32_to_cpu(d->control) & FW_CFG_DMA_CTL_ERROR) {
 		ret =3D -EIO;
 	}
=20
-	dma_unmap_single(dev, dma, sizeof(*d), DMA_BIDIRECTIONAL);
-
 end:
 	kfree(d);
-	if (dma_addr)
-		dma_unmap_single(dev, dma_addr, length, dir);
-
 	return ret;
 }
=20
--=20
2.14.3
