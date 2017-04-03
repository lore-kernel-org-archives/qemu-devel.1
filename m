Received: from eggs.gnu.org ([2001:4830:134:3::10]:39244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cv7tm-0005Jw-EL
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cv7tl-0003Ce-5A
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:44:22 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:36142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cv7tk-0003CI-U2
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:44:21 -0400
Received: by mail-wr0-x244.google.com with SMTP id k6so35038858wre.3
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 12:44:20 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Apr 2017 21:44:09 +0200
Message-Id: <20170403194409.21276-7-pbonzini@redhat.com>
In-Reply-To: <20170403194409.21276-1-pbonzini@redhat.com>
References: <20170403194409.21276-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 6/6] main-loop: Acquire main_context lock around
 os_host_main_loop_wait.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Richard W.M. Jones" <rjones@redhat.com>

From: "Richard W.M. Jones" <rjones@redhat.com>

When running virt-rescue the serial console hangs from time to time.
Virt-rescue runs an ordinary Linux kernel "appliance", but there is
only a single idle process running inside, so the qemu main loop is
largely idle.  With virt-rescue >= 1.37 you may be able to observe the
hang by doing:

  $ virt-rescue -e ^] --scratch
  ><rescue> while true; do ls -l /usr/bin; done

The hang in virt-rescue can be resolved by pressing a key on the
serial console.

Possibly with the same root cause, we also observed hangs during very
early boot of regular Linux VMs with a serial console.  Those hangs
are extremely rare, but you may be able to observe them by running
this command on baremetal for a sufficiently long time:

  $ while libguestfs-test-tool -t 60 >& /tmp/log ; do echo -n . ; done

(Check in /tmp/log that the failure was caused by a hang during early
boot, and not some other reason)

During investigation of this bug, Paolo Bonzini wrote:

> glib is expecting QEMU to use g_main_context_acquire around accesses to
> GMainContext.  However QEMU is not doing that, instead it is taking its
> own mutex.  So we should add g_main_context_acquire and
> g_main_context_release in the two implementations of
> os_host_main_loop_wait; these should undo the effect of Frediano's
> glib patch.

This patch exactly implements Paolo's suggestion in that paragraph.

This fixes the serial console hang in my testing, across 3 different
physical machines (AMD, Intel Core i7 and Intel Xeon), over many hours
of automated testing.  I wasn't able to reproduce the early boot hangs
(but as noted above, these are extremely rare in any case).

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1435432
Reported-by: Richard W.M. Jones <rjones@redhat.com>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
Message-Id: <20170331205133.23906-1-rjones@redhat.com>
[Paolo: this is actually a glib bug: recent glib versions are also
expecting g_main_context_acquire around g_poll---but that is not
documented and probably not even intended].
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/main-loop.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/util/main-loop.c b/util/main-loop.c
index 4534c89..19cad6b 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -218,9 +218,12 @@ static void glib_pollfds_poll(void)
 
 static int os_host_main_loop_wait(int64_t timeout)
 {
+    GMainContext *context = g_main_context_default();
     int ret;
     static int spin_counter;
 
+    g_main_context_acquire(context);
+
     glib_pollfds_fill(&timeout);
 
     /* If the I/O thread is very busy or we are incorrectly busy waiting in
@@ -256,6 +259,9 @@ static int os_host_main_loop_wait(int64_t timeout)
     }
 
     glib_pollfds_poll();
+
+    g_main_context_release(context);
+
     return ret;
 }
 #else
@@ -412,12 +418,15 @@ static int os_host_main_loop_wait(int64_t timeout)
     fd_set rfds, wfds, xfds;
     int nfds;
 
+    g_main_context_acquire(context);
+
     /* XXX: need to suppress polling by better using win32 events */
     ret = 0;
     for (pe = first_polling_entry; pe != NULL; pe = pe->next) {
         ret |= pe->func(pe->opaque);
     }
     if (ret != 0) {
+        g_main_context_release(context);
         return ret;
     }
 
@@ -472,6 +481,8 @@ static int os_host_main_loop_wait(int64_t timeout)
         g_main_context_dispatch(context);
     }
 
+    g_main_context_release(context);
+
     return select_ret || g_poll_ret;
 }
 #endif
-- 
1.8.3.1
