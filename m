Received: from eggs.gnu.org ([2001:4830:134:3::10]:38323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofe-0008Rw-8E
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofb-0004L8-Lx
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:30 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:38711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXofb-0004Ka-FU
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:27 -0500
Received: by mail-wr1-x430.google.com with SMTP id v13so5670263wrw.5
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:42:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id m6sm3263204wrv.24.2018.12.14.06.42.25
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Dec 2018 06:42:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:42:00 +0000
Message-Id: <20181214144214.1260-9-peter.maydell@linaro.org>
In-Reply-To: <20181214144214.1260-1-peter.maydell@linaro.org>
References: <20181214144214.1260-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/22] hw/ppc/ppc405_boards: Don't use
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

The load_image() function is deprecated, as it does not let the
caller specify how large the buffer to read the file into is.
Instead use load_image_size().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-id: 20181130151712.2312-3-peter.maydell@linaro.org
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
2.19.2
