Received: from eggs.gnu.org ([2001:4830:134:3::10]:56850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cbsDW-0006N8-5s
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:09:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cbsDS-0002Ty-3q
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:09:10 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cbsDR-0002TK-RQ
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:09:06 -0500
Received: by mail-wm0-x231.google.com with SMTP id c85so237592388wmi.1
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 09:09:05 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  9 Feb 2017 17:08:52 +0000
Message-Id: <20170209170904.5713-13-alex.bennee@linaro.org>
In-Reply-To: <20170209170904.5713-1-alex.bennee@linaro.org>
References: <20170209170904.5713-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v11 12/24] tcg: handle EXCP_ATOMIC exception
 for system emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net
Cc: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

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
index 25897edbd3..cb44544fcf 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1347,6 +1347,11 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
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
@@ -1457,6 +1462,10 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
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
