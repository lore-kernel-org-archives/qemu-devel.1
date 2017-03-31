Received: from eggs.gnu.org ([2001:4830:134:3::10]:52372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ctwy3-0006sd-0D
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ctwy2-0000XG-5A
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:51:55 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:49014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ctwy1-0000WC-UC
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:51:54 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Mar 2017 14:51:49 +0100
Message-Id: <1490968309-13672-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] main_loop: Make main_loop_wait() return void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

In commit e330c118f2a5a the last usage of main_loop_wait() that cared
about the return value was changed to no longer use it. Drop the
now-useless return value and make the function return void.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Coverity complains (CID 1372464) about main_loop() calling
main_loop_wait() and ignoring its return value. I suspect
this change will just displace that to within main_loop_wait()
itself since the underlying issue there is "the ppoll() that
gets called to poll fds can return an error code, but what
do we do if it does?". Suggestions on that point welcome.

I guess this will make the compiler warn about ret being
set and never used if CONFIG_SLIRP is not defined, which
is irritating. I'm postponing messing about with fixing
that in favour of seeing whether anybody has a good answer
to the question above (which might make it moot).
---
 include/qemu/main-loop.h | 2 +-
 util/main-loop.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index d7e24af..6b4b60b 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -79,7 +79,7 @@ int qemu_init_main_loop(Error **errp);
  *
  * @nonblocking: Whether the caller should block until an event occurs.
  */
-int main_loop_wait(int nonblocking);
+void main_loop_wait(int nonblocking);
 
 /**
  * qemu_get_aio_context: Return the main loop's AioContext
diff --git a/util/main-loop.c b/util/main-loop.c
index 4534c89..d0e27f3 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -476,7 +476,7 @@ static int os_host_main_loop_wait(int64_t timeout)
 }
 #endif
 
-int main_loop_wait(int nonblocking)
+void main_loop_wait(int nonblocking)
 {
     int ret;
     uint32_t timeout = UINT32_MAX;
@@ -513,7 +513,7 @@ int main_loop_wait(int nonblocking)
     qemu_start_warp_timer();
     qemu_clock_run_all_timers();
 
-    return ret;
+    return;
 }
 
 /* Functions to operate on the main QEMU AioContext.  */
-- 
2.7.4
