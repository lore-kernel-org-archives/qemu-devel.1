Received: from eggs.gnu.org ([2001:4830:134:3::10]:42741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eGing-0003O0-CT
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:55:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eGinc-0005EI-HV
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:55:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eGinc-0005Dc-BM
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:55:32 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 20 Nov 2017 10:55:15 +0100
Message-Id: <20171120095519.15214-2-marcandre.lureau@redhat.com>
In-Reply-To: <20171120095519.15214-1-marcandre.lureau@redhat.com>
References: <20171120095519.15214-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 1/5] fw_cfg: fix driver remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: qemu-devel@nongnu.org, somlo@cmu.edu, xiaolong.ye@intel.com, mst@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

On driver remove(), all objects created during probe() should be
removed, but sysfs qemu_fw_cfg/rev file was left. Also reorder
functions to match probe() error cleanup code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 drivers/firmware/qemu_fw_cfg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cf=
g.c
index 5cfe39f7a45f..deb483064f53 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -582,9 +582,10 @@ static int fw_cfg_sysfs_remove(struct platform_devic=
e *pdev)
 {
 	pr_debug("fw_cfg: unloading.\n");
 	fw_cfg_sysfs_cache_cleanup();
+	sysfs_remove_file(fw_cfg_top_ko, &fw_cfg_rev_attr.attr);
+	fw_cfg_io_cleanup();
 	fw_cfg_kset_unregister_recursive(fw_cfg_fname_kset);
 	fw_cfg_kobj_cleanup(fw_cfg_sel_ko);
-	fw_cfg_io_cleanup();
 	return 0;
 }
=20
--=20
2.15.0.277.ga3d2ad2c43
