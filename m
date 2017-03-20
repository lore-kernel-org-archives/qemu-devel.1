Received: from eggs.gnu.org ([2001:4830:134:3::10]:57278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cpuMA-0003Ya-Kz
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cpuM9-0007Lv-Kx
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:16:06 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:34317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vpalatin@google.com>) id 1cpuM9-0007KB-69
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:16:05 -0400
Received: by mail-wr0-x22b.google.com with SMTP id l37so88871516wrc.1
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 03:16:03 -0700 (PDT)
Sender: Vincent Palatin <vpalatin@google.com>
From: Vincent Palatin <vpalatin@chromium.org>
Date: Mon, 20 Mar 2017 11:15:49 +0100
Message-Id: <20170320101549.150076-1-vpalatin@chromium.org>
Subject: [Qemu-devel] [PATCH] hax: fix breakage in locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Yu Ning <yu.ning@linux.intel.com>, Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Palatin <vpalatin@chromium.org>

use qemu_mutex_lock_iothread consistently in qemu_hax_cpu_thread_fn() as
done in other _thread_fn functions, instead of grabbing directly the
BQL. This way we ensure that iothread_locked is properly set.

On v2.9.0-rc0, QEMU was dying in an assertion in the mutex code when
running with '--enable-hax' either on OSX or Windows. This bug was triggered
since the code modification for multithreading added new usages of
qemu_mutex_iothread_locked.
This fixes the breakage on both platforms, I can now run again a full
Chromium OS image with HAX kernel acceleration.

Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
---
 cpus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index b84a392dda..167d9615e1 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1344,8 +1344,9 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
 {
     CPUState *cpu = arg;
     int r;
+
+    qemu_mutex_lock_iothread();
     qemu_thread_get_self(cpu->thread);
-    qemu_mutex_lock(&qemu_global_mutex);
 
     cpu->thread_id = qemu_get_thread_id();
     cpu->created = true;
-- 
2.12.0.367.g23dc2f6d3c-goog
