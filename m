Received: from eggs.gnu.org ([2001:4830:134:3::10]:36208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3963-0000Fq-JM
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3962-0002UM-UV
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d3962-0002U3-Og
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE28D64DBF
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:38:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:37:24 +0200
Message-Id: <20170425223739.6703-12-quintela@redhat.com>
In-Reply-To: <20170425223739.6703-1-quintela@redhat.com>
References: <20170425223739.6703-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 11/26] audio: Unfold OPLSAMPLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

It was used only once, and now it was always int16_t.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/audio/fmopl.c |  2 +-
 hw/audio/fmopl.h | 11 -----------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 8f935f6..b1cb4b4 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -988,7 +988,7 @@ void YM3812UpdateOne(FM_OPL *OPL, int16_t *buffer, int length)
 {
     int i;
 	int data;
-	OPLSAMPLE *buf = buffer;
+	int16_t *buf = buffer;
 	uint32_t amsCnt  = OPL->amsCnt;
 	uint32_t  vibCnt  = OPL->vibCnt;
 	uint8_t rhythm = OPL->rhythm&0x20;
diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index 1e74019..c236287 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -3,17 +3,6 @@
 
 #include <stdint.h>
 
-/* --- system optimize --- */
-/* select bit size of output : 8 or 16 */
-#define OPL_OUTPUT_BIT 16
-
-#if (OPL_OUTPUT_BIT==16)
-typedef int16_t OPLSAMPLE;
-#endif
-#if (OPL_OUTPUT_BIT==8)
-typedef unsigned char  OPLSAMPLE;
-#endif
-
 typedef void (*OPL_TIMERHANDLER)(int channel,double interval_Sec);
 typedef void (*OPL_IRQHANDLER)(int param,int irq);
 typedef void (*OPL_UPDATEHANDLER)(int param,int min_interval_us);
-- 
2.9.3
