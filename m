Received: from eggs.gnu.org ([2001:4830:134:3::10]:46591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWm-0004f9-Rg
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWl-0007gw-KF
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:12 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeWl-0007gT-DZ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:11 -0400
Received: by mail-wm0-x22b.google.com with SMTP id f67so102817981wmh.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:15:11 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:20 +0200
Message-Id: <1499238885-26161-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/42] main_loop: Make main_loop_wait() return
 void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

The last users of main_loop_wait() that cared about the return value
have now been changed to no longer use it. Drop the now-useless return
value and make the function return void.

We avoid the awkwardness of ifdeffery to handle the 'ret'
variable in main_loop_wait() only being wanted if CONFIG_SLIRP
by simply dropping all the ifdefs. There are stub implementations
of slirp_pollfds_poll() and slirp_pollfds_fill() already in
stubs/slirp.c which do nothing, as required.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <1498584769-12439-3-git-send-email-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/main-loop.h | 2 +-
 util/main-loop.c         | 8 +-------
 2 files changed, 2 insertions(+), 8 deletions(-)

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
index 19cad6b..2f48f41 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -487,7 +487,7 @@ static int os_host_main_loop_wait(int64_t timeout)
 }
 #endif
 
-int main_loop_wait(int nonblocking)
+void main_loop_wait(int nonblocking)
 {
     int ret;
     uint32_t timeout = UINT32_MAX;
@@ -500,9 +500,7 @@ int main_loop_wait(int nonblocking)
     /* poll any events */
     g_array_set_size(gpollfds, 0); /* reset for new iteration */
     /* XXX: separate device handlers from system ones */
-#ifdef CONFIG_SLIRP
     slirp_pollfds_fill(gpollfds, &timeout);
-#endif
 
     if (timeout == UINT32_MAX) {
         timeout_ns = -1;
@@ -515,16 +513,12 @@ int main_loop_wait(int nonblocking)
                                           &main_loop_tlg));
 
     ret = os_host_main_loop_wait(timeout_ns);
-#ifdef CONFIG_SLIRP
     slirp_pollfds_poll(gpollfds, (ret < 0));
-#endif
 
     /* CPU thread can infinitely wait for event after
        missing the warp */
     qemu_start_warp_timer();
     qemu_clock_run_all_timers();
-
-    return ret;
 }
 
 /* Functions to operate on the main QEMU AioContext.  */
-- 
1.8.3.1
