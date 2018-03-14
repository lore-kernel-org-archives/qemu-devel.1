Received: from eggs.gnu.org ([2001:4830:134:3::10]:53484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1ew7mI-0002fT-LG
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1ew7mE-0001AY-Fs
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:53:18 -0400
Received: from mail-co1nam03on0105.outbound.protection.outlook.com
	([104.47.40.105]:27552
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1ew7mE-00018f-8K
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:53:14 -0400
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Wed, 14 Mar 2018 07:52:42 -0700
Message-Id: <1521039163-138-3-git-send-email-juterry@microsoft.com>
In-Reply-To: <1521039163-138-1-git-send-email-juterry@microsoft.com>
References: <1521039163-138-1-git-send-email-juterry@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/3] WHPX fix WHvSetPartitionProperty in
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
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, "Justin Terry (VM)" <juterry@microsoft.com>

This fixes a breaking change to WHvSetPartitionProperty to pass the 'in'
PropertyCode on function invocation introduced in Windows Insider SDK 17110.
Usage of this indicates the PropertyCode of the opaque PropertyBuffer passed in
on function invocation.

Also fixes the removal of the PropertyCode parameter from the
WHV_PARTITION_PROPERTY struct as it is now passed to the function directly.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
---
 target/i386/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 2080d58c4c..63e6e1b6f2 100644
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
2.13.6
