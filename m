Received: from eggs.gnu.org ([2001:4830:134:3::10]:49560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cWjFn-0003BR-TR
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:34:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cWjFm-0004xS-MS
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:34:15 -0500
Received: from mail.ispras.ru ([83.149.199.45]:42466)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cWjFm-0004wo-Fo
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:34:14 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Thu, 26 Jan 2017 15:34:18 +0300
Message-ID: <20170126123418.5412.33815.stgit@PASHA-ISP>
In-Reply-To: <20170126123411.5412.44769.stgit@PASHA-ISP>
References: <20170126123411.5412.44769.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v8 1/9] replay: exception replay fix
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

v8: moved setting of exeption_index to tb_gen_code

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 translate-all.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/translate-all.c b/translate-all.c
index 2026293..abce8f1 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -1290,6 +1290,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         /* flush must be done */
         tb_flush(cpu);
         mmap_unlock();
+        /* Set exception index to make sure that the execution loop
+           will exit and go to flushing and other queued work. */
+        cpu->exception_index = EXCP_INTERRUPT;
         cpu_loop_exit(cpu);
     }
 
