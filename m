Received: from eggs.gnu.org ([2001:4830:134:3::10]:35903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3A-0000ZD-T9
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj39-0007R1-Nv
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:16 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fJj39-0007PT-HR
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:15 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj38-0004ly-LN
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:20:14 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 18:19:43 +0100
Message-Id: <20180518172009.14416-7-peter.maydell@linaro.org>
In-Reply-To: <20180518172009.14416-1-peter.maydell@linaro.org>
References: <20180518172009.14416-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/32] hw/arm/smmuv3: Fix Coverity issue in
 smmuv3_record_event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

Coverity complains about use of uninitialized Evt struct.
The EVT_SET_TYPE and similar setters use deposit32() on fields
in the struct, so they read the uninitialized existing values.
In cases where we don't set all the fields in the event struct
we'll end up leaking random uninitialized data from QEMU's
stack into the guest.

Initializing the struct with "Evt evt = {};" ought to satisfy
Coverity and fix the data leak.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1526493784-25328-2-git-send-email-eric.auger@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index b3026dea20..42dc521c13 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -143,7 +143,7 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
 
 void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
 {
-    Evt evt;
+    Evt evt = {};
     MemTxResult r;
 
     if (!smmuv3_eventq_enabled(s)) {
-- 
2.17.0
