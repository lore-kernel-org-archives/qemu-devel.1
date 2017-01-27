Received: from eggs.gnu.org ([2001:4830:134:3::10]:33326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qm-0004sL-RO
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6ql-0003pb-TT
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:00 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6ql-0003p8-Nm
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:45:59 -0500
Received: by mail-wm0-x242.google.com with SMTP id c85so58231288wmi.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:45:59 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:14 +0100
Message-Id: <1485524749-118532-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/41] replay: exception replay fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This patch fixes replaying the exception when TB cache is full.
It breaks cpu loop execution through setting exception_index
to process such queued work as TB flush.

v8: moved setting of exeption_index to tb_gen_code

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-Id: <20170126123418.5412.33815.stgit@PASHA-ISP>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 translate-all.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/translate-all.c b/translate-all.c
index 2026293..6d2fcab 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -1290,6 +1290,8 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         /* flush must be done */
         tb_flush(cpu);
         mmap_unlock();
+        /* Make the execution loop process the flush as soon as possible.  */
+        cpu->exception_index = EXCP_INTERRUPT;
         cpu_loop_exit(cpu);
     }
 
-- 
1.8.3.1
