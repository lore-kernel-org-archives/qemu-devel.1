Received: from eggs.gnu.org ([2001:4830:134:3::10]:43063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eOBp6-0006Y1-MP
	for qemu-devel@nongnu.org; Sun, 10 Dec 2017 19:19:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eOBp5-00017R-RT
	for qemu-devel@nongnu.org; Sun, 10 Dec 2017 19:19:56 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:35903)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eOBp5-00015w-KW
	for qemu-devel@nongnu.org; Sun, 10 Dec 2017 19:19:55 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 11 Dec 2017 01:19:50 +0100
Message-Id: <20171211001950.27843-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PATCH] baum: Truncate braille device size to 84x1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>

Baum device bigger than 84 do not actually exist, some guest drivers
would be upset by such sizes.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 chardev/baum.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/chardev/baum.c b/chardev/baum.c
index 67fd783a59..78b0c87625 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -1,7 +1,7 @@
 /*
  * QEMU Baum Braille Device
  *
- * Copyright (c) 2008, 2010-2011, 2016 Samuel Thibault
+ * Copyright (c) 2008, 2010-2011, 2016-2017 Samuel Thibault
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -239,6 +239,12 @@ static int baum_deferred_init(BaumChardev *baum)
         brlapi_perror("baum: brlapi__getDisplaySize");
         return 0;
     }
+    if (baum->y > 1) {
+        baum->y = 1;
+    }
+    if (baum->x > 84) {
+        baum->x = 84;
+    }
 
     con = qemu_console_lookup_by_index(0);
     if (con && qemu_console_is_graphic(con)) {
-- 
2.15.0
