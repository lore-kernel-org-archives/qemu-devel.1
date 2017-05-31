Received: from eggs.gnu.org ([2001:4830:134:3::10]:36853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Mr-0007gw-SR
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Mq-0003gF-UR
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:53 -0400
Received: from mail-lf0-x22b.google.com ([2a00:1450:4010:c07::22b]:34521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1dG3Mq-0003g8-NI
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:52 -0400
Received: by mail-lf0-x22b.google.com with SMTP id 99so8623986lfu.1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:08:52 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 31 May 2017 16:08:26 +0300
Message-Id: <f196c3700deb6ea714228209fb2a864bbfa4b67d.1496234767.git.riku.voipio@linaro.org>
MIME-Version: 1.0
In-Reply-To: <cover.1496234766.git.riku.voipio@linaro.org>
References: <cover.1496234766.git.riku.voipio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/15] linux-user: fix inconsistent spaces in
 print_siginfo() output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com, =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>

From: Miloš Stojanović <Milos.Stojanovic@rt-rk.com>

This patch improves the consistentcy of the output from print_siginfo()
by removing spaces around the equal sign of si_pid, si_uid, si_timer1,
si_timer2, si_band, si_fd, si_addr, si_status and si_sigval. This way
they match si_signo and ci_code. Host strace was used as a reference
for this chage.

Prior to this commit, typical strace output used to look like this:

Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/strace.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 779cda1a5e..5fbe067fd5 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -206,26 +206,26 @@ static void print_siginfo(const target_siginfo_t *tinfo)
 
     switch (si_type) {
     case QEMU_SI_KILL:
-        gemu_log(", si_pid = %u, si_uid = %u",
+        gemu_log(", si_pid=%u, si_uid=%u",
                  (unsigned int)tinfo->_sifields._kill._pid,
                  (unsigned int)tinfo->_sifields._kill._uid);
         break;
     case QEMU_SI_TIMER:
-        gemu_log(", si_timer1 = %u, si_timer2 = %u",
+        gemu_log(", si_timer1=%u, si_timer2=%u",
                  tinfo->_sifields._timer._timer1,
                  tinfo->_sifields._timer._timer2);
         break;
     case QEMU_SI_POLL:
-        gemu_log(", si_band = %d, si_fd = %d",
+        gemu_log(", si_band=%d, si_fd=%d",
                  tinfo->_sifields._sigpoll._band,
                  tinfo->_sifields._sigpoll._fd);
         break;
     case QEMU_SI_FAULT:
-        gemu_log(", si_addr = ");
+        gemu_log(", si_addr=");
         print_pointer(tinfo->_sifields._sigfault._addr, 1);
         break;
     case QEMU_SI_CHLD:
-        gemu_log(", si_pid = %u, si_uid = %u, si_status = %d"
+        gemu_log(", si_pid=%u, si_uid=%u, si_status=%d"
                  ", si_utime=" TARGET_ABI_FMT_ld
                  ", si_stime=" TARGET_ABI_FMT_ld,
                  (unsigned int)(tinfo->_sifields._sigchld._pid),
@@ -235,7 +235,7 @@ static void print_siginfo(const target_siginfo_t *tinfo)
                  tinfo->_sifields._sigchld._stime);
         break;
     case QEMU_SI_RT:
-        gemu_log(", si_pid = %u, si_uid = %u, si_sigval = " TARGET_ABI_FMT_ld,
+        gemu_log(", si_pid=%u, si_uid=%u, si_sigval=" TARGET_ABI_FMT_ld,
                  (unsigned int)tinfo->_sifields._rt._pid,
                  (unsigned int)tinfo->_sifields._rt._uid,
                  tinfo->_sifields._rt._sigval.sival_ptr);
-- 
2.11.0
