Received: from eggs.gnu.org ([2001:4830:134:3::10]:53418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxYqr-0002UA-RC
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxYqo-00037L-Al
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:25 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cxYqo-00036j-3V
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:22 -0400
Received: by mail-wr0-x22b.google.com with SMTP id c55so74644476wrc.3
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 05:55:21 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Apr 2017 13:55:17 +0100
Message-Id: <20170410125524.21008-5-alex.bennee@linaro.org>
In-Reply-To: <20170410125524.21008-1-alex.bennee@linaro.org>
References: <20170410125524.21008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/11] cpus: remove icount handling from
 qemu_tcg_cpu_thread_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

We should never be running in multi-threaded mode with icount enabled.
There is no point calling handle_icount_deadline here so remove it and
assert !use_icount.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>

diff --git a/cpus.c b/cpus.c
index 58d90aa2b9..fc0ddc8793 100644
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
