Received: from eggs.gnu.org ([2001:4830:134:3::10]:42150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZO-00084N-SC
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZL-00064B-48
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:22 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:38111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxZK-00063u-UP
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:19 -0500
Received: by mail-wr0-x241.google.com with SMTP id x1so859036wrb.5
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:32:18 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:31:14 +0100
Message-Id: <1515756676-3860-51-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 50/52] cpu: flush TB cache when loading VMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Maria Klimushenkova <maria.klimushenkova@ispras.ru>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Flushing TB cache is required because TBs key in the cache may match
different code which existed in the previous state.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
Message-Id: <20180110134846.12940.99993.stgit@pasha-VirtualBox>
[Add comment suggested by Peter Maydell. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 exec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/exec.c b/exec.c
index 9f4f450..d28fc0c 100644
--- a/exec.c
+++ b/exec.c
@@ -623,6 +623,13 @@ static int cpu_common_post_load(void *opaque, int version_id)
     cpu->interrupt_request &= ~0x01;
     tlb_flush(cpu);
 
+    /* loadvm has just updated the content of RAM, bypassing the
+     * usual mechanisms that ensure we flush TBs for writes to
+     * memory we've translated code from. So we must flush all TBs,
+     * which will now be stale.
+     */
+    tb_flush(cpu);
+
     return 0;
 }
 
-- 
1.8.3.1
