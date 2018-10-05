Received: from eggs.gnu.org ([2001:4830:134:3::10]:47368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8MRx-0001nn-LQ
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8MGt-0004oh-3g
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:19:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g8MGs-0004oF-Ub
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:19:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4680A81256
	for <qemu-devel@nongnu.org>; Fri,  5 Oct 2018 09:19:41 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  5 Oct 2018 11:19:34 +0200
Message-Id: <20181005091934.12143-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] edid: fix vendor default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

"EMU" actually is "Emulex Corporation", so not a good idea to use that
by default.  Lets use the Red Hat vendor id instead, which is in line
with the pci ids which are allocated from Red Hat vendor ids too.

Vendor list is available from http://www.uefi.org/pnp_id_list

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/display/edid.h  | 2 +-
 hw/display/edid-generate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/display/edid.h b/include/hw/display/edid.h
index bd51d26916..bacf170889 100644
--- a/include/hw/display/edid.h
+++ b/include/hw/display/edid.h
@@ -4,7 +4,7 @@
 #include "hw/hw.h"
 
 typedef struct qemu_edid_info {
-    const char *vendor;
+    const char *vendor; /* http://www.uefi.org/pnp_id_list */
     const char *name;
     const char *serial;
     uint32_t    dpi;
diff --git a/hw/display/edid-generate.c b/hw/display/edid-generate.c
index c80397ea96..37e60fe42a 100644
--- a/hw/display/edid-generate.c
+++ b/hw/display/edid-generate.c
@@ -301,7 +301,7 @@ void qemu_edid_generate(uint8_t *edid, size_t size,
     /* =============== set defaults  =============== */
 
     if (!info->vendor || strlen(info->vendor) != 3) {
-        info->vendor = "EMU";
+        info->vendor = "RHT";
     }
     if (!info->name) {
         info->name = "QEMU Monitor";
-- 
2.9.3
