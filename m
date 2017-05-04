Received: from eggs.gnu.org ([2001:4830:134:3::10]:34742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1v-0001Ud-S1
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1s-0004c4-Jo
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1s-0004aF-ES
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 38017C04B946
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:17:57 +0200
Message-Id: <20170504071811.3547-17-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 16/30] audio: Remove Unused OPL_TYPE_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Juan Quintela <quintela@redhat.com>

Since we removed the previous unused devices, they are not used anymore.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-id: 20170425223739.6703-13-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/fmopl.h |  3 ---
 hw/audio/fmopl.c | 16 ----------------
 2 files changed, 19 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index c23628724c..8ef0b3e3c3 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -12,9 +12,6 @@ typedef unsigned char (*OPL_PORTHANDLER_R)(int param);
 /* !!!!! here is private section , do not access there member direct !!!!! */
 
 #define OPL_TYPE_WAVESEL   0x01  /* waveform select    */
-#define OPL_TYPE_ADPCM     0x02  /* DELTA-T ADPCM unit */
-#define OPL_TYPE_KEYBOARD  0x04  /* keyboard interface */
-#define OPL_TYPE_IO        0x08  /* I/O port */
 
 /* Saving is necessary for member of the 'R' mark for suspend/resume */
 /* ---------- OPL one of slot  ---------- */
diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index b1cb4b46d6..9171001030 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -1188,28 +1188,12 @@ unsigned char OPLRead(FM_OPL *OPL,int a)
 	switch(OPL->address)
 	{
 	case 0x05: /* KeyBoard IN */
-		if(OPL->type&OPL_TYPE_KEYBOARD)
-		{
-			if(OPL->keyboardhandler_r)
-				return OPL->keyboardhandler_r(OPL->keyboard_param);
-			else {
-				LOG(LOG_WAR,("OPL:read unmapped KEYBOARD port\n"));
-			}
-		}
 		return 0;
 #if 0
 	case 0x0f: /* ADPCM-DATA  */
 		return 0;
 #endif
 	case 0x19: /* I/O DATA    */
-		if(OPL->type&OPL_TYPE_IO)
-		{
-			if(OPL->porthandler_r)
-				return OPL->porthandler_r(OPL->port_param);
-			else {
-				LOG(LOG_WAR,("OPL:read unmapped I/O port\n"));
-			}
-		}
 		return 0;
 	case 0x1a: /* PCM-DATA    */
 		return 0;
-- 
2.9.3
