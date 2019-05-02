Received: from eggs.gnu.org ([209.51.188.92]:51264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMDAm-0002Cd-62
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMDAl-0005Qt-9u
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:58:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMDAl-0005QO-3V
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:58:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id a9so3818497wrp.6
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 07:58:54 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  2 May 2019 15:58:46 +0100
Message-Id: <20190502145846.26226-1-alex.bennee@linaro.org>
In-Reply-To: <877eb86hcf.fsf@zen.linaroharston>
References: <877eb86hcf.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] linux-user: avoid treading on gprof's SIGPROF
 signals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

The guest tends to get confused when it receives signals it doesn't
know about. Given the gprof magic has also set up it's own handler we
would do well to avoid stomping on it as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/signal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index e2c0b37173..44b2d3b35a 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -508,6 +508,11 @@ void signal_init(void)
     act.sa_flags = SA_SIGINFO;
     act.sa_sigaction = host_signal_handler;
     for(i = 1; i <= TARGET_NSIG; i++) {
+#ifdef TARGET_GPROF
+        if (i == SIGPROF) {
+            continue;
+        }
+#endif
         host_sig = target_to_host_signal(i);
         sigaction(host_sig, NULL, &oact);
         if (oact.sa_sigaction == (void *)SIG_IGN) {
-- 
2.20.1
