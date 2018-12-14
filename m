Received: from eggs.gnu.org ([2001:4830:134:3::10]:38358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXoff-0008T8-Em
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofe-0004Oe-J5
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:31 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:40744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXofe-0004NW-Bg
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:30 -0500
Received: by mail-wr1-x429.google.com with SMTP id p4so5659962wrt.7
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:42:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id m6sm3263204wrv.24.2018.12.14.06.42.27
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Dec 2018 06:42:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:42:02 +0000
Message-Id: <20181214144214.1260-11-peter.maydell@linaro.org>
In-Reply-To: <20181214144214.1260-1-peter.maydell@linaro.org>
References: <20181214144214.1260-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/22] hw/pci/pci.c: Don't use load_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The load_image() function is deprecated, as it does not let the
caller specify how large the buffer to read the file into is.
Instead use load_image_size().

While we are converting this code, add an error-check
for read failure.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20181130151712.2312-5-peter.maydell@linaro.org
---
 hw/pci/pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 56b13b3320e..efb5ce196ff 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2261,7 +2261,11 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
     pdev->has_rom = true;
     memory_region_init_rom(&pdev->rom, OBJECT(pdev), name, size, &error_fatal);
     ptr = memory_region_get_ram_ptr(&pdev->rom);
-    load_image(path, ptr);
+    if (load_image_size(path, ptr, size) < 0) {
+        error_setg(errp, "failed to load romfile \"%s\"", pdev->romfile);
+        g_free(path);
+        return;
+    }
     g_free(path);
 
     if (is_default_rom) {
-- 
2.19.2
