Received: from eggs.gnu.org ([2001:4830:134:3::10]:41072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAsr-0002pe-Cl
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAsq-0001Hd-0D
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:14:57 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:20 +0200
Message-Id: <1525817687-34620-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/30] cpus: tcg: fix never exiting loop on
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-stable@nongnu.org

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
---
 cpus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index be3a4eb..d1f1629 100644
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
1.8.3.1
