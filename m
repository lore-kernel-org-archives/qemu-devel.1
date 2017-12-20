Received: from eggs.gnu.org ([2001:4830:134:3::10]:56294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyC-0004V9-IM
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyB-0007A6-Is
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:52 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:46960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyB-00079b-Bq
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:51 -0500
Received: by mail-wr0-x244.google.com with SMTP id g17so13685671wrd.13
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:15:51 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:27 +0100
Message-Id: <1513790098-9815-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/46] baum: Truncate braille device size to 84x1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

Baum device bigger than 84 do not actually exist, but the user's own
Braille device might be wider than 84 columns.  Some guest drivers
would be upset by such sizes, so clamp the device size.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Message-Id: <20171211001950.27843-1-samuel.thibault@ens-lyon.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/baum.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/chardev/baum.c b/chardev/baum.c
index 67fd783..78b0c87 100644
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
1.8.3.1
