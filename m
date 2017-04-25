Received: from eggs.gnu.org ([2001:4830:134:3::10]:36414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d396Q-0000bl-K9
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d396P-0002at-Ni
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d396P-0002ag-Hn
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75E1280F93
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:38:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:37:35 +0200
Message-Id: <20170425223739.6703-23-quintela@redhat.com>
In-Reply-To: <20170425223739.6703-1-quintela@redhat.com>
References: <20170425223739.6703-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 22/26] audio: IRQHandler is not used anymore
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/audio/fmopl.c | 4 ----
 hw/audio/fmopl.h | 2 --
 2 files changed, 6 deletions(-)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 694a77b..5b8a884 100644
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
diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index 446de08..b1641f5 100644
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
-- 
2.9.3
