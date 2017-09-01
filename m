Received: from eggs.gnu.org ([2001:4830:134:3::10]:60094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dnlmG-0000HG-FF
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 09:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dnlmB-0006Gn-Vs
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 09:14:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dnlmB-0006GQ-Pc
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 09:14:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7778806C1
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 13:14:22 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  1 Sep 2017 15:14:09 +0200
Message-Id: <20170901131409.6712-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] wm8750: add record buffer underrun check
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

Reported-by: niuguoxiang@huawei.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/wm8750.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index f8b5bebfc2..d2bf2e1da1 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -680,8 +680,12 @@ uint32_t wm8750_adc_dat(void *opaque)
     WM8750State *s = (WM8750State *) opaque;
     uint32_t *data;
 
-    if (s->idx_in >= sizeof(s->data_in))
+    if (s->idx_in >= sizeof(s->data_in)) {
         wm8750_in_load(s);
+        if (s->idx_in >= sizeof(s->data_in)) {
+            return 0x80008000; /* silence in AUD_FMT_S16 sample format */
+        }
+    }
 
     data = (uint32_t *) &s->data_in[s->idx_in];
     s->req_in -= 4;
-- 
2.9.3
