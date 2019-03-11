Received: from eggs.gnu.org ([209.51.188.92]:32802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODq-0007N9-CA
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODm-0003iP-Qw
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:17 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:38950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODk-0003bz-Se
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:14 -0400
Received: by mail-wr1-x434.google.com with SMTP id p8so4335160wrq.6
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:56:11 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:33 +0100
Message-Id: <1552323335-46779-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 29/31] qom: cpu: destroy work_mutex in
 cpu_common_finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Qiang <liq3ea@163.com>

From: Li Qiang <liq3ea@163.com>

Commit 376692b9dc6(cpus: protect work list with work_mutex)
initialize a work_mutex in cpu_common_initfn, however forget
to destroy it. This will cause resource leak when hotunplug cpu
or hotplug cpu fails.

Signed-off-by: Li Qiang <liq3ea@163.com>
Message-Id: <20190102074114.26988-1-liq3ea@163.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qom/cpu.c b/qom/cpu.c
index f5579b1..a8d2958 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -380,6 +380,9 @@ static void cpu_common_initfn(Object *obj)
 
 static void cpu_common_finalize(Object *obj)
 {
+    CPUState *cpu = CPU(obj);
+
+    qemu_mutex_destroy(&cpu->work_mutex);
 }
 
 static int64_t cpu_common_get_arch_id(CPUState *cpu)
-- 
1.8.3.1
