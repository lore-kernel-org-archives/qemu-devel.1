Received: from eggs.gnu.org ([2001:4830:134:3::10]:52375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cv1MU-0001LZ-1W
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cv1MR-00012l-PZ
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:45:34 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cv1MR-00012N-Io
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:45:31 -0400
Received: by mail-wr0-x231.google.com with SMTP id w43so167567353wrb.0
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 05:45:31 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  3 Apr 2017 13:45:20 +0100
Message-Id: <20170403124524.10824-6-alex.bennee@linaro.org>
In-Reply-To: <20170403124524.10824-1-alex.bennee@linaro.org>
References: <20170403124524.10824-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v1 5/9] cpus: remove icount handling from
 qemu_tcg_cpu_thread_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dovgaluk@ispras.ru, rth@twiddle.net, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

We should never be running in multi-threaded mode with icount enabled.
There is no point calling handle_icount_deadline here so remove it and
assert !use_icount.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 cpus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index 68fdbc40b9..4e48b9c4ad 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1392,6 +1392,8 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
 {
     CPUState *cpu = arg;
 
+    g_assert(!use_icount);
+
     rcu_register_thread();
 
     qemu_mutex_lock_iothread();
@@ -1434,8 +1436,6 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
             }
         }
 
-        handle_icount_deadline();
-
         atomic_mb_set(&cpu->exit_request, 0);
         qemu_tcg_wait_io_event(cpu);
     }
-- 
2.11.0
