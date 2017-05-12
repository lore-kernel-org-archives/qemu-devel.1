Received: from eggs.gnu.org ([2001:4830:134:3::10]:49989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1d98LJ-00042e-CQ
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1d98LG-0006R7-Qp
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:41 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46412 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Milos.Stojanovic@rt-rk.com>)
	id 1d98LG-0006Py-Jv
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:38 -0400
From: =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>
Date: Fri, 12 May 2017 13:02:16 +0200
Message-Id: <1494586944-7253-9-git-send-email-Milos.Stojanovic@rt-rk.com>
In-Reply-To: <1494586944-7253-1-git-send-email-Milos.Stojanovic@rt-rk.com>
References: <1494586944-7253-1-git-send-email-Milos.Stojanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/16] linux-user: fix inconsistent spaces in
 print_siginfo() output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, riku.voipio@iki.fi
Cc: Milos.Stojanovic@rt-rk.com

This patch improves the consistentcy of the output from print_siginfo()
by removing spaces around the equal sign of si_pid, si_uid, si_timer1,
si_timer2, si_band, si_fd, si_addr, si_status and si_sigval. This way
they match si_signo and ci_code. Host strace was used as a reference
for this chage.

Prior to this commit, typical strace output used to look like this:
--- 64 {si_signo=3D64, si_code=3DSI_TKILL, si_pid =3D 22845, si_uid =3D 1=
000} ---

After this commit, it looks like this:
--- 64 {si_signo=3D64, si_code=3DSI_TKILL, si_pid=3D22845, si_uid=3D1000}=
 ---

Signed-off-by: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
---
 linux-user/strace.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 779cda1..5fbe067 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -206,26 +206,26 @@ static void print_siginfo(const target_siginfo_t *t=
info)
=20
     switch (si_type) {
     case QEMU_SI_KILL:
-        gemu_log(", si_pid =3D %u, si_uid =3D %u",
+        gemu_log(", si_pid=3D%u, si_uid=3D%u",
                  (unsigned int)tinfo->_sifields._kill._pid,
                  (unsigned int)tinfo->_sifields._kill._uid);
         break;
     case QEMU_SI_TIMER:
-        gemu_log(", si_timer1 =3D %u, si_timer2 =3D %u",
+        gemu_log(", si_timer1=3D%u, si_timer2=3D%u",
                  tinfo->_sifields._timer._timer1,
                  tinfo->_sifields._timer._timer2);
         break;
     case QEMU_SI_POLL:
-        gemu_log(", si_band =3D %d, si_fd =3D %d",
+        gemu_log(", si_band=3D%d, si_fd=3D%d",
                  tinfo->_sifields._sigpoll._band,
                  tinfo->_sifields._sigpoll._fd);
         break;
     case QEMU_SI_FAULT:
-        gemu_log(", si_addr =3D ");
+        gemu_log(", si_addr=3D");
         print_pointer(tinfo->_sifields._sigfault._addr, 1);
         break;
     case QEMU_SI_CHLD:
-        gemu_log(", si_pid =3D %u, si_uid =3D %u, si_status =3D %d"
+        gemu_log(", si_pid=3D%u, si_uid=3D%u, si_status=3D%d"
                  ", si_utime=3D" TARGET_ABI_FMT_ld
                  ", si_stime=3D" TARGET_ABI_FMT_ld,
                  (unsigned int)(tinfo->_sifields._sigchld._pid),
@@ -235,7 +235,7 @@ static void print_siginfo(const target_siginfo_t *tin=
fo)
                  tinfo->_sifields._sigchld._stime);
         break;
     case QEMU_SI_RT:
-        gemu_log(", si_pid =3D %u, si_uid =3D %u, si_sigval =3D " TARGET=
_ABI_FMT_ld,
+        gemu_log(", si_pid=3D%u, si_uid=3D%u, si_sigval=3D" TARGET_ABI_F=
MT_ld,
                  (unsigned int)tinfo->_sifields._rt._pid,
                  (unsigned int)tinfo->_sifields._rt._uid,
                  tinfo->_sifields._rt._sigval.sival_ptr);
--=20
1.9.1
