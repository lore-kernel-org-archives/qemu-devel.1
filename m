Received: from eggs.gnu.org ([2001:4830:134:3::10]:48419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csp0S-0004Gx-41
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csp0P-00037L-Dq
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:44 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:35807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1csp0P-00036i-7F
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:41 -0400
Received: by mail-wr0-x22c.google.com with SMTP id u1so99369718wra.2
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:09:41 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 28 Mar 2017 12:09:33 +0100
Message-Id: <20170328110936.24806-4-alex.bennee@linaro.org>
In-Reply-To: <20170328110936.24806-1-alex.bennee@linaro.org>
References: <20170328110936.24806-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/6] ui/console: ensure do_safe_dpy_refresh
 holds BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Gerd Hoffmann <kraxel@redhat.com>

I missed the fact that when an exclusive work item runs it drops the
BQL to ensure all no vCPUs are stuck waiting for it, hence causing a
deadlock. However the actual helper needs to take the BQL especially
as we'll be messing with device emulation bits during the update which
all assume BQL is held.

We make a minor cpu_reloading_memory_map which must try and unlock the
RCU if we are actually outside the running context.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 cpu-exec-common.c | 2 +-
 ui/console.c      | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/cpu-exec-common.c b/cpu-exec-common.c
index 0504a9457b..e81da276bb 100644
--- a/cpu-exec-common.c
+++ b/cpu-exec-common.c
@@ -35,7 +35,7 @@ void cpu_loop_exit_noexc(CPUState *cpu)
 #if defined(CONFIG_SOFTMMU)
 void cpu_reloading_memory_map(void)
 {
-    if (qemu_in_vcpu_thread()) {
+    if (qemu_in_vcpu_thread() && current_cpu->running) {
         /* The guest can in theory prolong the RCU critical section as long
          * as it feels like. The major problem with this is that because it
          * can do multiple reconfigurations of the memory map within the
diff --git a/ui/console.c b/ui/console.c
index 937c950840..dd27c9501b 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1586,7 +1586,9 @@ bool dpy_gfx_check_format(QemuConsole *con,
 static void do_safe_dpy_refresh(CPUState *cpu, run_on_cpu_data opaque)
 {
     DisplayChangeListener *dcl = opaque.host_ptr;
+    qemu_mutex_lock_iothread();
     dcl->ops->dpy_refresh(dcl);
+    qemu_mutex_unlock_iothread();
 }
 
 static void dpy_refresh(DisplayState *s)
-- 
2.11.0
