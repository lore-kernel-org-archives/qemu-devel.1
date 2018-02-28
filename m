Received: from eggs.gnu.org ([2001:4830:134:3::10]:53949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1erA1R-0003Am-RL
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1erA1P-0002zn-Pi
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:16:25 -0500
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 28 Feb 2018 14:15:59 -0800
Message-Id: <20180228221609.11265-2-jcmvbkbc@gmail.com>
In-Reply-To: <20180228221609.11265-1-jcmvbkbc@gmail.com>
References: <20180228221609.11265-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2 01/11] target/xtensa: dump correct physical
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-stable@nongnu.org

xtensa_cpu_dump_state outputs CPU physical registers as is, without
synchronization from current window. That may result in different values
printed for the current window and corresponding physical registers.
Synchronize physical registers from window before dumping.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 671d934ff424..3ad86d4508e4 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1215,6 +1215,7 @@ void xtensa_cpu_dump_state(CPUState *cs, FILE *f,
                 (i % 4) == 3 ? '\n' : ' ');
     }
 
+    xtensa_sync_phys_from_window(env);
     cpu_fprintf(f, "\n");
 
     for (i = 0; i < env->config->nareg; ++i) {
-- 
2.11.0
