Received: from eggs.gnu.org ([2001:4830:134:3::10]:60890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc@brightwise.de>) id 1ci6DK-0004na-Sv
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 16:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marc@brightwise.de>) id 1ci6DF-0005mH-UX
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 16:18:42 -0500
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::4]:21247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marc@brightwise.de>) id 1ci6DF-0005m0-Kd
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 16:18:37 -0500
Date: Sun, 26 Feb 2017 22:18:33 +0100 (CET)
From: Marc Bommert <marc@brightwise.de>
Message-ID: <285146688.73855.1488143914060@communicator.strato.de>
In-Reply-To: <20170226205945.23033.77107.launchpad@chaenomeles.canonical.com>
References: <20170226205013.23267.77116.malonedeb@chaenomeles.canonical.com>
	<20170226205945.23033.77107.launchpad@chaenomeles.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1668103] Re: Possible off-by-one error in
 priority handling of hw/PL190.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Bug 1668103 <1668103@bugs.launchpad.net>, peter.maydell@linaro.org

>From 0cd0c1346f9adb7b90df3e4e30a5904eeda33bfa Mon Sep 17 00:00:00 2001
From: Marc Bommert <marc@brightwise.de>
Date: Sun, 26 Feb 2017 22:08:49 +0100
Subject: [PATCH] Fix off-by-one error in priority handling when reading
 VECTADDR: Also, if enabled, have the "current" priority bit (1<<i) set in
 s->prio_mask[i].

Signed-off-by: Marc Bommert <marc@brightwise.de>
---
 hw/intc/pl190.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/pl190.c b/hw/intc/pl190.c
index 55ea15d..0369da8 100644
--- a/hw/intc/pl190.c
+++ b/hw/intc/pl190.c
@@ -80,12 +80,12 @@ static void pl190_update_vectors(PL190State *s)
     mask = 0;
     for (i = 0; i < 16; i++)
       {
-        s->prio_mask[i] = mask;
         if (s->vect_control[i] & 0x20)
           {
             n = s->vect_control[i] & 0x1f;
             mask |= 1 << n;
           }
+        s->prio_mask[i] = mask;
       }
     s->prio_mask[16] = mask;
     pl190_update(s);
--
2.5.0
