Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14322C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD39920836
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="B4Qk6XEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD39920836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1josrM-00071I-12
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1josql-0006NT-BY
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:13:19 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:52558 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1josqh-0000ws-1O
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:13:18 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 464944C8C0;
 Fri, 26 Jun 2020 18:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-transfer-encoding:content-type:content-type:mime-version
 :x-mailer:message-id:date:date:subject:subject:from:from
 :received:received:received; s=mta-01; t=1593195189; x=
 1595009590; bh=VgxwOsTng8yXFF2TGZvkjGY1MYY+vfGNYc5dZxS9qxw=; b=B
 4Qk6XEQMyspYiO/tCrgFDMf1iabFg84A20rMaE8sgt935jO+bZI9mmejsOtOY6De
 kNW1sMMdh1TkA1lwQOPar/T/qWCtYsyl4t5zLMhv/ghdklf+0w6w5DGB5h8rNJv8
 ytZTaN2uKo9vNbVQaD1E7sefqL67OS8zngUNPPbnWM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pRdLyLNHzCSB; Fri, 26 Jun 2020 21:13:09 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 6A42E4C8AE;
 Fri, 26 Jun 2020 21:13:09 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 26
 Jun 2020 21:13:09 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <seabios@seabios.org>
Subject: [PATCH v2] timer: Handle decrements of PIT counter
Date: Fri, 26 Jun 2020 21:06:58 +0300
Message-ID: <20200626180656.3441-1-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 14:13:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Roman Bolshakov <r.bolshakov@yadro.com>,
 Kevin O'Connor <kevin@koconnor.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There's a fallback to PIT if TSC is not present but it doesn't work
properly. It prevents boot from floppy on isapc and 486 cpu [1][2].

SeaBIOS configures PIT in Mode 2. PIT counter is decremented in the mode
but timer_adjust_bits() thinks that the counter overflows and increases
32-bit tick counter on each detected "overflow". Invalid overflow
detection results in 55ms time advance (1 / 18.2Hz) on each read from
PIT counter. So all timers expire much faster and 5-second floppy
timeout expires in 83 real microseconds (or just a bit longer).

It can be fixed by making the counter recieved from PIT an increasing
value so it can be passed to timer_adjust_bits():
0, 1, 2 and up to 65535 and then the counter is re-loaded with 0.

1. https://bugs.launchpad.net/seabios/+bug/1840719
2. https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg03924.html

Fixes: eac11944019 ("Unify pmtimer_read() and pittimer_read() code.")
Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
Changes since v1:
- Simplified change of counter direction (Kevin)

 src/hw/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/hw/timer.c b/src/hw/timer.c
index 56bb289..b6f102e 100644
--- a/src/hw/timer.c
+++ b/src/hw/timer.c
@@ -180,7 +180,7 @@ timer_read(void)
     // Read from PIT.
     outb(PM_SEL_READBACK | PM_READ_VALUE | PM_READ_COUNTER0, PORT_PIT_MODE);
     u16 v = inb(PORT_PIT_COUNTER0) | (inb(PORT_PIT_COUNTER0) << 8);
-    return timer_adjust_bits(v, 0xffff);
+    return timer_adjust_bits(-v, 0xffff);
 }
 
 // Return the TSC value that is 'msecs' time in the future.
-- 
2.26.1


