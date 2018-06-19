Received: from eggs.gnu.org ([2001:4830:134:3::10]:45783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hv-0001Xl-VK
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hv-0008Nv-64
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:20 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:00 -0500
Message-Id: <20180619014319.28272-35-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 034/113] memory: fix flatview_access_valid RCU
 read lock/unlock imbalance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Fixes: 11e732a5ed46903f997985bed4c3767ca28a7eb6
Reported-by: Cornelia Huck <cohuck@redhat.com>
Reported-by: luigi burdo <intermediadc@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Cornelia Huck <cohuck@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-id: 20180307130238.19358-1-pbonzini@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit b39b61e410022f96ceb53d4381d25cba5126ac44)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 exec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/exec.c b/exec.c
index d589283bdd..5f8017a5d7 100644
--- a/exec.c
+++ b/exec.c
@@ -3320,7 +3320,6 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
         if (!memory_access_is_direct(mr, is_write)) {
             l = memory_access_size(mr, l, addr);
             if (!memory_region_access_valid(mr, xlat, l, is_write)) {
-                rcu_read_unlock();
                 return false;
             }
         }
-- 
2.11.0
