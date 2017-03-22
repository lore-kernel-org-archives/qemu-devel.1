Received: from eggs.gnu.org ([2001:4830:134:3::10]:47065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cqj82-0001XU-8e
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cqj7y-0005QJ-Ua
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:28:54 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:34831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cqj7y-0005Px-O5
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:28:50 -0400
Received: by mail-wr0-x22f.google.com with SMTP id g10so132489768wrg.2
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 09:28:50 -0700 (PDT)
References: <20170315144825.3108-1-alex.bennee@linaro.org>
	<CABoDooPQt2WJWJcf0FzwvJQU8Yb7OQjfAwbioY_+0ED_nVq-dw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CABoDooPQt2WJWJcf0FzwvJQU8Yb7OQjfAwbioY_+0ED_nVq-dw@mail.gmail.com>
Date: Wed, 22 Mar 2017 16:28:47 +0000
Message-ID: <87h92lxolc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] ui/console: ensure graphic updates
 don't race with TCG vCPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


Laurent Desnogues <laurent.desnogues@gmail.com> writes:

> Hi Alex,
>
> this patch breaks:
>
>   http://wiki.qemu.org/download/arm-test-0.2.tar.gz
>
> qemu-system-arm -kernel zImage.integrator -initrd arm_root.img
> -append "console=ttyAMA0" -machine integratorcp -serial stdio -icount
> 0
> Uncompressing Linux..........................................................................
> done, booting the kernel.
> qemu-system-arm: /work/qemu/qemu/memory.c:920:
> memory_region_transaction_commit: Assertion
> `qemu_mutex_iothread_locked()' failed.

Doh - too many levels of BQL. So wi->exclusive tasks drop the iothread
so they don't deadlock as any other threads try and wake up and get to
cpu_exec_end. Of course the update was originally under BQL so the
deferred work should be as well. We have to make a minor tweak to avoid
triggering RCU clean-up outside the execution context though. Try this:

ui/console: ensure do_safe_dpy_refresh holds BQL

I missed the fact that when an exclusive work item runs it drops the
BQL to ensure all no vCPUs are stuck waiting for it, hence causing a
deadlock. However the actual helper needs to take the BQL especially
as we'll be messing with device emulation bits during the update which
all assume BQL is held.

We make a minor cpu_reloading_memory_map which must try and unlock the
RCU if we are actually outside the running context.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
CC: Gerd Hoffmann <kraxel@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

2 files changed, 3 insertions(+), 1 deletion(-)
cpu-exec-common.c | 2 +-
ui/console.c      | 2 ++

modified   cpu-exec-common.c
@@ -35,7 +35,7 @@ void cpu_loop_exit_noexc(CPUState *cpu)
 #if defined(CONFIG_SOFTMMU)
 void cpu_reloading_memory_map(void)
 {
-    if (qemu_in_vcpu_thread()) {
+    if (qemu_in_vcpu_thread() && current_cpu->running) {
         /* The guest can in theory prolong the RCU critical section as long
          * as it feels like. The major problem with this is that because it
          * can do multiple reconfigurations of the memory map within the
modified   ui/console.c
@@ -1586,7 +1586,9 @@ bool dpy_gfx_check_format(QemuConsole *con,
 static void do_safe_dpy_refresh(CPUState *cpu, run_on_cpu_data opaque)
 {
     DisplayChangeListener *dcl = opaque.host_ptr;
+    qemu_mutex_lock_iothread();
     dcl->ops->dpy_refresh(dcl);
+    qemu_mutex_unlock_iothread();
 }

 static void dpy_refresh(DisplayState *s)
