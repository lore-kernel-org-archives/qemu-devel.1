Received: from eggs.gnu.org ([2001:4830:134:3::10]:43233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8O1e-00036k-Lj
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8O1b-0003qV-KB
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:12:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g8O1b-0003pl-EO
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:12:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2389C0587FF
	for <qemu-devel@nongnu.org>; Fri,  5 Oct 2018 11:12:02 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  5 Oct 2018 13:11:57 +0200
Message-Id: <20181005111157.12801-5-kraxel@redhat.com>
In-Reply-To: <20181005111157.12801-1-kraxel@redhat.com>
References: <20181005111157.12801-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] edid: fix vendor default
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
Message-id: 20181005091934.12143-1-kraxel@redhat.com
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
