Received: from eggs.gnu.org ([2001:4830:134:3::10]:41034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAsq-0002on-30
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAso-0001H9-WD
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:14:56 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:34642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAso-0001Gy-PI
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:14:54 -0400
Received: by mail-wm0-x22d.google.com with SMTP id a137-v6so20816824wme.1
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:14:54 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:19 +0200
Message-Id: <1525817687-34620-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/30] cpus: Fix event order on resume of
 stopped guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

When resume of a stopped guest immediately runs into block device
errors, the BLOCK_IO_ERROR event is sent before the RESUME event.

Reproducer:

1. Create a scratch image
   $ dd if=/dev/zero of=scratch.img bs=1M count=100

   Size doesn't actually matter.

2. Prepare blkdebug configuration:

   $ cat >blkdebug.conf <<EOF
   [inject-error]
   event = "write_aio"
   errno = "5"
   EOF

   Note that errno 5 is EIO.

3. Run a guest with an additional scratch disk, i.e. with additional
   arguments
   -drive if=none,id=scratch-drive,format=raw,werror=stop,file=blkdebug:blkdebug.conf:scratch.img
   -device virtio-blk-pci,id=scratch,drive=scratch-drive

   The blkdebug part makes all writes to the scratch drive fail with
   EIO.  The werror=stop pauses the guest on write errors.

4. Connect to the QMP socket e.g. like this:
   $ socat UNIX:/your/qmp/socket READLINE,history=$HOME/.qmp_history,prompt='QMP> '

   Issue QMP command 'qmp_capabilities':
   QMP> { "execute": "qmp_capabilities" }

5. Boot the guest.

6. In the guest, write to the scratch disk, e.g. like this:

   # dd if=/dev/zero of=/dev/vdb count=1

   Do double-check the device specified with of= is actually the
   scratch device!

7. Issue QMP command 'cont':
   QMP> { "execute": "cont" }

After step 6, I get a BLOCK_IO_ERROR event followed by a STOP event.  Good.

After step 7, I get BLOCK_IO_ERROR, then RESUME, then STOP.  Not so
good; I'd expect RESUME, then BLOCK_IO_ERROR, then STOP.

The funny event order confuses libvirt: virsh -r domstate DOMAIN
--reason reports "paused (unknown)" rather than "paused (I/O error)".

The culprit is vm_prepare_start().

    /* Ensure that a STOP/RESUME pair of events is emitted if a
     * vmstop request was pending.  The BLOCK_IO_ERROR event, for
     * example, according to documentation is always followed by
     * the STOP event.
     */
    if (runstate_is_running()) {
        qapi_event_send_stop(&error_abort);
        res = -1;
    } else {
        replay_enable_events();
        cpu_enable_ticks();
        runstate_set(RUN_STATE_RUNNING);
        vm_state_notify(1, RUN_STATE_RUNNING);
    }

    /* We are sending this now, but the CPUs will be resumed shortly later */
    qapi_event_send_resume(&error_abort);
    return res;

When resuming a stopped guest, we take the else branch before we get
to sending RESUME.  vm_state_notify() runs virtio_vmstate_change(),
among other things.  This restarts I/O, triggering the BLOCK_IO_ERROR
event.

Reshuffle vm_prepare_start() to send the RESUME event earlier.

Fixes RHBZ 1566153.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180423084518.2426-1-armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/cpus.c b/cpus.c
index 5bcd3ec..be3a4eb 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2043,7 +2043,6 @@ int vm_stop(RunState state)
 int vm_prepare_start(void)
 {
     RunState requested;
-    int res = 0;
 
     qemu_vmstop_requested(&requested);
     if (runstate_is_running() && requested == RUN_STATE__MAX) {
@@ -2057,17 +2056,18 @@ int vm_prepare_start(void)
      */
     if (runstate_is_running()) {
         qapi_event_send_stop(&error_abort);
-        res = -1;
-    } else {
-        replay_enable_events();
-        cpu_enable_ticks();
-        runstate_set(RUN_STATE_RUNNING);
-        vm_state_notify(1, RUN_STATE_RUNNING);
+        qapi_event_send_resume(&error_abort);
+        return -1;
     }
 
     /* We are sending this now, but the CPUs will be resumed shortly later */
     qapi_event_send_resume(&error_abort);
-    return res;
+
+    replay_enable_events();
+    cpu_enable_ticks();
+    runstate_set(RUN_STATE_RUNNING);
+    vm_state_notify(1, RUN_STATE_RUNNING);
+    return 0;
 }
 
 void vm_start(void)
-- 
1.8.3.1
