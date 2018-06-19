Received: from eggs.gnu.org ([2001:4830:134:3::10]:45282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hV-00013V-32
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hU-00085n-21
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:53 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:48 -0500
Message-Id: <20180619014319.28272-23-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 022/113] target/xtensa: dump correct physical
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>

From: Max Filippov <jcmvbkbc@gmail.com>

xtensa_cpu_dump_state outputs CPU physical registers as is, without
synchronization from current window. That may result in different values
printed for the current window and corresponding physical registers.
Synchronize physical registers from window before dumping.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
(cherry picked from commit b55b1afda942306e4e40420aced1524bd83ba16d)
 Conflicts:
	target/xtensa/translate.c
* drop context dependencies
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/xtensa/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 20f7ddf042..60f2fe6e0b 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -3288,6 +3288,7 @@ void xtensa_cpu_dump_state(CPUState *cs, FILE *f,
                 (i % 4) == 3 ? '\n' : ' ');
     }
 
+    xtensa_sync_phys_from_window(env);
     cpu_fprintf(f, "\n");
 
     for (i = 0; i < env->config->nareg; ++i) {
-- 
2.11.0
