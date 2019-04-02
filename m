Received: from eggs.gnu.org ([209.51.188.92]:59252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hBDtp-0004px-7X
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:32:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hBDsF-0004YN-Il
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:30:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hBDsF-0004Ti-Ah
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:30:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1B8930821FF
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 07:30:21 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  2 Apr 2019 09:30:18 +0200
Message-Id: <20190402073018.17747-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] curses: fix wchar_t printf warning
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

On some systems wchar_t is "long int", on others just "int".
So go cast to "long int" and adjust the printf format accordingly.

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/curses.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/curses.c b/ui/curses.c
index cc6d6da68463..fb63945188b2 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -453,8 +453,8 @@ static uint16_t get_ucs(wchar_t wch, iconv_t conv)
     swch = sizeof(wch);
 
     if (iconv(conv, &pwch, &swch, &pch, &sch) == (size_t) -1) {
-        fprintf(stderr, "Could not convert 0x%02x from WCHAR_T to UCS-2: %s\n",
-                        wch, strerror(errno));
+        fprintf(stderr, "Could not convert 0x%02lx from WCHAR_T to UCS-2: %s\n",
+                (unsigned long)wch, strerror(errno));
         return 0xFFFD;
     }
 
-- 
2.18.1
