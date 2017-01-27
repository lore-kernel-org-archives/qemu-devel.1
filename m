Received: from eggs.gnu.org ([2001:4830:134:3::10]:48048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX3sM-0007xv-Fp
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX3sI-0002DU-PQ
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:35:26 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:34764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX3sI-0002D6-JX
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:35:22 -0500
Received: by mail-wm0-x231.google.com with SMTP id f73so12548277wmf.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 02:35:22 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 27 Jan 2017 10:34:52 +0000
Message-Id: <20170127103505.18606-13-alex.bennee@linaro.org>
In-Reply-To: <20170127103505.18606-1-alex.bennee@linaro.org>
References: <20170127103505.18606-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 12/25] tcg: handle EXCP_ATOMIC exception for
 system emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Pranith Kumar <bobby.prani@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>

From: Pranith Kumar <bobby.prani@gmail.com>

The patch enables handling atomic code in the guest. This should be
preferably done in cpu_handle_exception(), but the current assumptions
regarding when we can execute atomic sections cause a deadlock.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
[AJB: tweak title]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 cpus.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/cpus.c b/cpus.c
index ecd1ec08d3..e3d9f3fe21 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1346,6 +1346,11 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
                 if (r == EXCP_DEBUG) {
                     cpu_handle_guest_debug(cpu);
                     break;
+                } else if (r == EXCP_ATOMIC) {
+                    qemu_mutex_unlock_iothread();
+                    cpu_exec_step_atomic(cpu);
+                    qemu_mutex_lock_iothread();
+                    break;
                 }
             } else if (cpu->stop) {
                 if (cpu->unplug) {
@@ -1456,6 +1461,10 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                  */
                 g_assert(cpu->halted);
                 break;
+            case EXCP_ATOMIC:
+                qemu_mutex_unlock_iothread();
+                cpu_exec_step_atomic(cpu);
+                qemu_mutex_lock_iothread();
             default:
                 /* Ignore everything else? */
                 break;
-- 
2.11.0
