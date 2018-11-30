Received: from eggs.gnu.org ([2001:4830:134:3::10]:50816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gSkXx-0004kI-I1
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:17:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gSkXw-0005Yw-G2
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:17:37 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 15:17:04 +0000
Message-Id: <20181130151712.2312-3-peter.maydell@linaro.org>
In-Reply-To: <20181130151712.2312-1-peter.maydell@linaro.org>
References: <20181130151712.2312-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/10] hw/ppc/ppc405_boards: Don't use
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
 hw/ppc/ppc405_boards.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 3be3fe4432b..1b0a0a8ba3a 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -219,9 +219,11 @@ static void ref405ep_init(MachineState *machine)
             bios_name = BIOS_FILENAME;
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
         if (filename) {
-            bios_size = load_image(filename, memory_region_get_ram_ptr(bios));
+            bios_size = load_image_size(filename,
+                                        memory_region_get_ram_ptr(bios),
+                                        BIOS_SIZE);
             g_free(filename);
-            if (bios_size < 0 || bios_size > BIOS_SIZE) {
+            if (bios_size < 0) {
                 error_report("Could not load PowerPC BIOS '%s'", bios_name);
                 exit(1);
             }
@@ -515,9 +517,11 @@ static void taihu_405ep_init(MachineState *machine)
                                &error_fatal);
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
         if (filename) {
-            bios_size = load_image(filename, memory_region_get_ram_ptr(bios));
+            bios_size = load_image_size(filename,
+                                        memory_region_get_ram_ptr(bios),
+                                        BIOS_SIZE);
             g_free(filename);
-            if (bios_size < 0 || bios_size > BIOS_SIZE) {
+            if (bios_size < 0) {
                 error_report("Could not load PowerPC BIOS '%s'", bios_name);
                 exit(1);
             }
-- 
2.19.1
