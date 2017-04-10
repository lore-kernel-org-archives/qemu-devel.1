Received: from eggs.gnu.org ([2001:4830:134:3::10]:53420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxYqr-0002UD-SL
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxYqp-00037v-1B
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:25 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:33376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cxYqo-00037B-QJ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:22 -0400
Received: by mail-wr0-x22f.google.com with SMTP id l28so18757309wre.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 05:55:22 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Apr 2017 13:55:18 +0100
Message-Id: <20170410125524.21008-6-alex.bennee@linaro.org>
In-Reply-To: <20170410125524.21008-1-alex.bennee@linaro.org>
References: <20170410125524.21008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/11] cpus: check cpu->running in
 cpu_get_icount_raw()
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

The lifetime of current_cpu is now the lifetime of the vCPU thread.
However get_icount_raw() can apply a fudge factor if called while code
is running to take into account the current executed instruction
count.

To ensure this is always the case we also check cpu->running.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>

diff --git a/cpus.c b/cpus.c
index fc0ddc8793..7ec6473c02 100644
--- a/cpus.c
+++ b/cpus.c
@@ -229,7 +229,7 @@ int64_t cpu_get_icount_raw(void)
     CPUState *cpu = current_cpu;
 
     icount = timers_state.qemu_icount;
-    if (cpu) {
+    if (cpu && cpu->running) {
         if (!cpu->can_do_io) {
             fprintf(stderr, "Bad icount read\n");
             exit(1);
-- 
2.11.0
