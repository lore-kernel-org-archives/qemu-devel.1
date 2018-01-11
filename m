Received: from eggs.gnu.org ([2001:4830:134:3::10]:45608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYAi-0007yH-AE
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYAe-0000Er-Av
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:25:12 -0500
Received: from mail.ispras.ru ([83.149.199.45]:41488)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYAe-0000Eg-3I
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:25:08 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 11 Jan 2018 11:25:04 +0300
Message-ID: <20180111082504.27295.44505.stgit@pasha-VirtualBox>
In-Reply-To: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v3 02/30] cpu: flush TB cache when loading
 VMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org

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
