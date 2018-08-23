Received: from eggs.gnu.org ([2001:4830:134:3::10]:48015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fsqxL-0002lA-24
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fsqxI-00070W-A3
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:51:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40982 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fsqxG-0006zP-Fy
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:51:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBBE140216E6
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 14:51:21 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 23 Aug 2018 16:51:17 +0200
Message-Id: <1535035877-219196-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH] vl.c: make sure maxcpus matches topology to
 prevent migration failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, dgilbert@redhat.com

Topology (threads*cores*sockets) must match maxcpus to be valid,
otherwise we could start QEMU with invalid topology that throws
a error on migration destination side, that should not be reachable:
Source:
  -smp 8,maxcpus=64,cores=1,threads=8,sockets=1
// hotplug cpus upto maxcpus
Destination:
  -smp 64,maxcpus=64,cores=1,threads=8,sockets=1
  qemu: cpu topology: sockets (1) * cores (1) * threads (8) < smp_cpus (64)

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 vl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/vl.c b/vl.c
index 16b913f..2b35e0c 100644
--- a/vl.c
+++ b/vl.c
@@ -1238,10 +1238,10 @@ static void smp_parse(QemuOpts *opts)
             exit(1);
         }
 
-        if (sockets * cores * threads > max_cpus) {
+        if (sockets * cores * threads != max_cpus) {
             error_report("cpu topology: "
-                         "sockets (%u) * cores (%u) * threads (%u) > "
-                         "maxcpus (%u)",
+                         "sockets (%u) * cores (%u) * threads (%u) not equal to"
+                         " maxcpus (%u)",
                          sockets, cores, threads, max_cpus);
             exit(1);
         }
-- 
2.7.4
