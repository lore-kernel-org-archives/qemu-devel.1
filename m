Received: from eggs.gnu.org ([2001:4830:134:3::10]:35288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fIwxT-0007Wh-B4
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fIwxN-00064P-SD
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:59:11 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 16 May 2018 14:03:03 -0400
Message-Id: <1526493784-25328-2-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1526493784-25328-1-git-send-email-eric.auger@redhat.com>
References: <1526493784-25328-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] hw/arm/smmuv3: Fix Coverity issue in
 smmuv3_record_event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org

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
---
 hw/arm/smmuv3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index b3026de..42dc521 100644
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
1.8.3.1
