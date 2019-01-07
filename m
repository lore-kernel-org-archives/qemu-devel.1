Received: from eggs.gnu.org ([209.51.188.92]:46434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXod-00053K-25
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoa-0002Bg-Pl
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:50 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:38747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXoa-00029M-Ep
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:48 -0500
Received: by mail-wr1-x42c.google.com with SMTP id v13so1074532wrw.5
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.45 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:31:02 +0000
Message-Id: <20190107163117.16269-23-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/37] cpus.c: Fix race condition in
 cpu_stop_current()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We use cpu_stop_current() to ensure the current CPU has stopped
from places like qemu_system_reset_request(). Unfortunately its
current implementation has a race. It calls qemu_cpu_stop(),
which sets cpu->stopped to true even though the CPU hasn't
actually stopped yet. The main thread will look at the flags
set by qemu_system_reset_request() and call pause_all_vcpus().
pause_all_vcpus() waits for every cpu to have cpu->stopped true,
so it can continue (and we will start the system reset operation)
before the vcpu thread has got back to its top level loop.

Instead, just set cpu->stop and call cpu_exit(). This will
cause the vcpu to exit back to the top level loop, and there
(as part of the wait_io_event code) it will call qemu_cpu_stop().

This fixes bugs where the reset request appeared to be ignored
or the CPU misbehaved because the reset operation started
to change vcpu state while the vcpu thread was still using it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Tested-by: Jaap Crezee <jaap@jcz.nl>
Message-id: 20181207155911.12710-1-peter.maydell@linaro.org
---
 cpus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index 0ddeeefc14f..b09b7027126 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2100,7 +2100,8 @@ void qemu_init_vcpu(CPUState *cpu)
 void cpu_stop_current(void)
 {
     if (current_cpu) {
-        qemu_cpu_stop(current_cpu, true);
+        current_cpu->stop = true;
+        cpu_exit(current_cpu);
     }
 }
 
-- 
2.19.2
