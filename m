Received: from eggs.gnu.org ([2001:4830:134:3::10]:34751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1w-0001Uk-1a
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1s-0004ch-RX
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1s-0004aj-MH
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5750C04B94F
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:18:07 +0200
Message-Id: <20170504071811.3547-27-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 26/30] audio: IRQHandler is not used anymore
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-id: 20170425223739.6703-23-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/fmopl.h | 2 --
 hw/audio/fmopl.c | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index 446de08d15..b1641f56de 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -92,8 +92,6 @@ typedef struct fm_opl_f {
 	/* external event callback handler */
 	OPL_TIMERHANDLER  TimerHandler;		/* TIMER handler   */
 	int TimerParam;						/* TIMER parameter */
-	OPL_IRQHANDLER    IRQHandler;		/* IRQ handler    */
-	int IRQParam;						/* IRQ parameter  */
 	OPL_UPDATEHANDLER UpdateHandler;	/* stream update handler   */
 	int UpdateParam;					/* stream update parameter */
 } FM_OPL;
diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 694a77b229..5b8a884a59 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -260,8 +260,6 @@ static inline void OPL_STATUS_SET(FM_OPL *OPL,int flag)
 		if(OPL->status & OPL->statusmask)
 		{	/* IRQ on */
 			OPL->status |= 0x80;
-			/* callback user interrupt handler (IRQ is OFF to ON) */
-			if(OPL->IRQHandler) (OPL->IRQHandler)(OPL->IRQParam,1);
 		}
 	}
 }
@@ -276,8 +274,6 @@ static inline void OPL_STATUS_RESET(FM_OPL *OPL,int flag)
 		if (!(OPL->status & OPL->statusmask) )
 		{
 			OPL->status &= 0x7f;
-			/* callback user interrupt handler (IRQ is ON to OFF) */
-			if(OPL->IRQHandler) (OPL->IRQHandler)(OPL->IRQParam,0);
 		}
 	}
 }
-- 
2.9.3
