Received: from eggs.gnu.org ([2001:4830:134:3::10]:42182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJl-0002y1-Hs
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJk-0004k1-Mr
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:29 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:03 -0500
Message-Id: <20180723201748.25573-55-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 54/99] cpus: tcg: fix never exiting loop on
 unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>

From: Cédric Le Goater <clg@kaod.org>

Commit 9b0605f9837b ("cpus: tcg: unregister thread with RCU, fix
exiting of loop on unplug") changed the exit condition of the loop in
the vCPU thread function but forgot to remove the beginning 'while (1)'
statement. The resulting code :

	while (1) {
	...
	} while (!cpu->unplug || cpu_can_run(cpu));

is a sequence of two distinct two while() loops, the first not exiting
in case of an unplug event.

Remove the first while (1) to fix CPU unplug.

Signed-off-by: CÃ©dric Le Goater <clg@kaod.org>
Message-Id: <20180425131828.15604-1-clg@kaod.org>
Cc: qemu-stable@nongnu.org
Fixes: 9b0605f9837b68fd56c7fc7c96a3a1a3b983687d
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
(cherry picked from commit 54961aac190df28d311802364d19e18d5cda8bab)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 cpus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index 38eba8bff3..e1d94038fd 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1648,7 +1648,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
     /* process any pending work */
     cpu->exit_request = 1;
 
-    while (1) {
+    do {
         if (cpu_can_run(cpu)) {
             int r;
             qemu_mutex_unlock_iothread();
-- 
2.17.1
