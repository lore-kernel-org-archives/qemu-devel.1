Received: from eggs.gnu.org ([2001:4830:134:3::10]:40892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dPuMO-0000eM-0L
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dPuMI-0002XS-C2
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:33:08 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dPuMI-0002VF-4k
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:33:02 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2017 18:32:49 +0100
Message-Id: <1498584769-12439-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1498584769-12439-1-git-send-email-peter.maydell@linaro.org>
References: <1498584769-12439-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 2/2] main_loop: Make main_loop_wait() return
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
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

The last users of main_loop_wait() that cared about the return value
have now been changed to no longer use it. Drop the now-useless return
value and make the function return void.

We avoid the awkwardness of ifdeffery to handle the 'ret'
variable in main_loop_wait() only being wanted if CONFIG_SLIRP
by simply dropping all the ifdefs. There are stub implementations
of slirp_pollfds_poll() and slirp_pollfds_fill() already in
stubs/slirp.c which do nothing, as required.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
This will coincidentally satisfy Coverity, which currently complains
in CID 1372464 that we call main_loop_wait() in vl.c and ignore the
return value which may be reporting a poll() syscall failure.
Essentially we don't expect poll() to fail, except perhaps with
a transient EINTR -- if it ever did we'd spin retrying endlessly
I think.
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
2.7.4
