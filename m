Received: from eggs.gnu.org ([2001:4830:134:3::10]:50622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gSkXs-0004cg-9G
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:17:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gSkXr-0005Ui-Ip
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:17:32 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 15:17:08 +0000
Message-Id: <20181130151712.2312-7-peter.maydell@linaro.org>
In-Reply-To: <20181130151712.2312-1-peter.maydell@linaro.org>
References: <20181130151712.2312-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/10] hw/i386/multiboot.c: Don't use
 load_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Philip Li <philip.li@intel.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org, qemu-ppc@nongnu.org

The load_image() function is deprecated, as it does not let the
caller specify how large the buffer to read the file into is.
Instead use load_image_size().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i386/multiboot.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 1a4344f5fc3..62340687e8e 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -343,7 +343,11 @@ int load_multiboot(FWCfgState *fw_cfg,
             mbs.mb_buf_size = TARGET_PAGE_ALIGN(mb_mod_length + mbs.mb_buf_size);
             mbs.mb_buf = g_realloc(mbs.mb_buf, mbs.mb_buf_size);
 
-            load_image(one_file, (unsigned char *)mbs.mb_buf + offs);
+            if (load_image_size(one_file, (unsigned char *)mbs.mb_buf + offs,
+                                mbs.mb_buf_size - offs) < 0) {
+                error_report("Error loading file '%s'", one_file);
+                exit(1);
+            }
             mb_add_mod(&mbs, mbs.mb_buf_phys + offs,
                        mbs.mb_buf_phys + offs + mb_mod_length, c);
 
-- 
2.19.1
