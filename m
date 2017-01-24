Received: from eggs.gnu.org ([2001:4830:134:3::10]:35192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvLx-00067b-7s
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:17:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvLs-0005lU-9E
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:17:17 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38532)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvLs-0005lM-2B
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:17:12 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Tue, 24 Jan 2017 10:17:13 +0300
Message-ID: <20170124071713.4572.36636.stgit@PASHA-ISP>
In-Reply-To: <20170124071654.4572.41407.stgit@PASHA-ISP>
References: <20170124071654.4572.41407.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v7 03/14] replay: exception replay fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, dovgaluk@ispras.ru, kraxel@redhat.com, pbonzini@redhat.com

This patch fixes replaying the exception when TB cache is full.
It breaks cpu loop execution through setting exception_index
to process such queued work as TB flush.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 cpu-exec.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/cpu-exec.c b/cpu-exec.c
index fa08c73..79a2167 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -451,6 +451,10 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 #ifndef CONFIG_USER_ONLY
     } else if (replay_has_exception()
                && cpu->icount_decr.u16.low + cpu->icount_extra == 0) {
+        /* Break the execution loop in case of running out of TB cache.
+           This is needed to make flushing of the TB cache, because
+           real flush is queued to be executed outside the cpu loop. */
+        cpu->exception_index = EXCP_INTERRUPT;
         /* try to cause an exception pending in the log */
         cpu_exec_nocache(cpu, 1, tb_find(cpu, NULL, 0), true);
         *ret = -1;
