Received: from eggs.gnu.org ([2001:4830:134:3::10]:39808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZGkM-0002h5-7s
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:48:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZGkJ-0005Af-3x
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:48:50 -0500
Received: from mail.ispras.ru ([83.149.199.45]:36780)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZGkI-00058S-S8
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:48:47 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 10 Jan 2018 16:48:46 +0300
Message-ID: <20180110134846.12940.99993.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] cpu: flush TB cache when loading VMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com

Flushing TB cache is required because TBs key in the cache may match
different code which existed in the previous state.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
---
 exec.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/exec.c b/exec.c
index 4722e52..ff31e71 100644
--- a/exec.c
+++ b/exec.c
@@ -622,6 +622,7 @@ static int cpu_common_post_load(void *opaque, int version_id)
        version_id is increased. */
     cpu->interrupt_request &= ~0x01;
     tlb_flush(cpu);
+    tb_flush(cpu);
 
     return 0;
 }
