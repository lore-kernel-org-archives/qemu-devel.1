Received: from eggs.gnu.org ([2001:4830:134:3::10]:39070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHt-0002Ch-A7
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPrHp-00060f-W0
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:49 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:43201)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fPrHp-0005yo-L1
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:20:45 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  4 Jun 2018 17:20:00 +0200
Message-Id: <20180604152015.13359-3-laurent@vivier.eu>
In-Reply-To: <20180604152015.13359-1-laurent@vivier.eu>
References: <20180604152015.13359-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/17] linux-user: SPARC "rd %tick" can be used
 by user application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

we have the same problem decribed in 7d6b1daedd
("linux-user, ppc: mftbl can be used by user application")
for ppc in the case of sparc.

When we use an application trying to resolve a name, it hangs in

    0x00000000ff5dd40c:  rd  %tick, %o5
    0x00000000ff5dd410:  srlx  %o5, 0x20, %o4
    0x00000000ff5dd414:  btst  %o5, %g4
    0x00000000ff5dd418:  be  %icc, 0xff5dd40c

because %tick is staying at 0.

As QEMU_CLOCK_VIRTUAL is not available in linux-user mode,
simply use cpu_get_host_ticks() instead.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180528194812.31216-1-laurent@vivier.eu>
---
 target/sparc/helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 1d854890b4..46232788c8 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -67,7 +67,9 @@ uint64_t helper_tick_get_count(CPUSPARCState *env, void *opaque, int mem_idx)
 
     return cpu_tick_get_count(timer);
 #else
-    return 0;
+    /* In user-mode, QEMU_CLOCK_VIRTUAL doesn't exist.
+       Just pass through the host cpu clock ticks.  */
+    return cpu_get_host_ticks();
 #endif
 }
 
-- 
2.14.3
