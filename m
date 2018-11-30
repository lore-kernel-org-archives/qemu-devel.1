Received: from eggs.gnu.org ([2001:4830:134:3::10]:50688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gSkXu-0004fB-Ch
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gSkXt-0005WU-Kb
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:17:34 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 15:17:09 +0000
Message-Id: <20181130151712.2312-8-peter.maydell@linaro.org>
In-Reply-To: <20181130151712.2312-1-peter.maydell@linaro.org>
References: <20181130151712.2312-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/10] hw/block/tc58128.c: Don't use
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
 hw/block/tc58128.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/tc58128.c b/hw/block/tc58128.c
index 808ad76ba60..d0fae248dcc 100644
--- a/hw/block/tc58128.c
+++ b/hw/block/tc58128.c
@@ -38,7 +38,8 @@ static void init_dev(tc58128_dev * dev, const char *filename)
     memset(dev->flash_contents, 0xff, FLASH_SIZE);
     if (filename) {
 	/* Load flash image skipping the first block */
-	ret = load_image(filename, dev->flash_contents + 528 * 32);
+        ret = load_image_size(filename, dev->flash_contents + 528 * 32,
+                              FLASH_SIZE - 528 * 32);
 	if (ret < 0) {
             if (!qtest_enabled()) {
                 error_report("Could not load flash image %s", filename);
-- 
2.19.1
