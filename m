Received: from eggs.gnu.org ([2001:4830:134:3::10]:57073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SIv-0006TD-9u
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SIt-0006tS-Sf
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:53 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f0SIt-0006s4-Ly
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:51 -0400
Received: by mail-wr0-x244.google.com with SMTP id z73so18974107wrb.0
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:36:51 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Mar 2018 15:36:30 +0200
Message-Id: <1522071403-52486-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
References: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/16] WHPX fix WHvSetPartitionProperty in
 PropertyCode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Justin Terry (VM)" <juterry@microsoft.com>

From: "Justin Terry (VM)" <juterry@microsoft.com>

This fixes a breaking change to WHvSetPartitionProperty to pass the 'in'
PropertyCode on function invocation introduced in Windows Insider SDK 17110.
Usage of this indicates the PropertyCode of the opaque PropertyBuffer passed in
on function invocation.

Also fixes the removal of the PropertyCode parameter from the
WHV_PARTITION_PROPERTY struct as it is now passed to the function directly.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
Message-Id: <1521039163-138-3-git-send-email-juterry@microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 2080d58..63e6e1b 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -1278,9 +1278,9 @@ static int whpx_accel_init(MachineState *ms)
     }
 
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
-    prop.PropertyCode = WHvPartitionPropertyCodeProcessorCount;
     prop.ProcessorCount = smp_cpus;
     hr = WHvSetPartitionProperty(whpx->partition,
+                                 WHvPartitionPropertyCodeProcessorCount,
                                  &prop,
                                  sizeof(WHV_PARTITION_PROPERTY));
 
-- 
1.8.3.1
