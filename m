Received: from eggs.gnu.org ([2001:4830:134:3::10]:54631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjmzR-0002DH-4j
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjmzQ-0007eZ-7E
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:11:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cjmzQ-0007dh-1P
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:11:20 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  3 Mar 2017 14:11:12 +0100
Message-Id: <20170303131113.25898-5-pbonzini@redhat.com>
In-Reply-To: <20170303131113.25898-1-pbonzini@redhat.com>
References: <20170303131113.25898-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] main-loop: remove now unnecessary
 optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

This optimization is not necessary anymore, because the vCPU now drops
the I/O thread lock even with TCG.  Drop it to simplify the code and
avoid the "I/O thread spun for 1000 iterations" warning.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/vl.c b/vl.c
index bbbf1ba..b21b57e 100644
--- a/vl.c
+++ b/vl.c
@@ -1884,17 +1884,14 @@ static bool main_loop_should_exit(void)
 
 static void main_loop(void)
 {
-    bool nonblocking;
-    int last_io = 0;
 #ifdef CONFIG_PROFILER
     int64_t ti;
 #endif
     do {
-        nonblocking = tcg_enabled() && last_io > 0;
 #ifdef CONFIG_PROFILER
         ti = profile_getclock();
 #endif
-        last_io = main_loop_wait(nonblocking);
+        main_loop_wait(false);
 #ifdef CONFIG_PROFILER
         dev_time += profile_getclock() - ti;
 #endif
-- 
2.9.3
