Received: from eggs.gnu.org ([2001:4830:134:3::10]:52374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cv1MU-0001LY-1Q
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cv1MS-00012z-HM
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:45:34 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:36763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cv1MS-00012h-9u
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:45:32 -0400
Received: by mail-wr0-x230.google.com with SMTP id w11so166921235wrc.3
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 05:45:32 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  3 Apr 2017 13:45:21 +0100
Message-Id: <20170403124524.10824-7-alex.bennee@linaro.org>
In-Reply-To: <20170403124524.10824-1-alex.bennee@linaro.org>
References: <20170403124524.10824-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v1 6/9] cpus: check cpu->running in
 cpu_get_icount_raw()
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

The lifetime of current_cpu is now the lifetime of the vCPU thread.
However get_icount_raw() can apply a fudge factor if called while code
is running to take into account the current executed instruction
count.

To ensure this is always the case we also check cpu->running.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 cpus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index 4e48b9c4ad..18b1746770 100644
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
