Received: from eggs.gnu.org ([2001:4830:134:3::10]:51517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fuG85-0005x5-9a
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fuG7z-0006F2-HJ
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:56:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34488 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fuG7z-0006Ec-Ah
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:56:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4009801145A
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 11:56:14 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 27 Aug 2018 13:56:08 +0200
Message-Id: <1535370968-217716-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH] vl.c deprecate incorrect CPUs topology
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, libvir-list@redhat.com, ehabkost@redhat.com, berrange@redhat.com, drjones@redhat.com

-smp [cpus],sockets/cores/threads[,maxcpus] should describe topology
so that total number of logical CPUs [sockets * cores * threads]
would be equal to [maxcpus], however historically we didn't have
such check in QEMU and it is possible to start VM with an invalid
topology.
Deprecate invalid options combination so we can make sure that
the topology VM started with is always correct in the future.
Users with an invalid sockets/cores/threads/maxcpus values should
fix their CLI to make sure that
   [sockets * cores * threads] == [maxcpus]

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 qemu-deprecated.texi | 11 +++++++++++
 vl.c                 |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 87212b6..d5d9ce6 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -159,6 +159,17 @@ The 'file' driver for drives is no longer appropriate for character or host
 devices and will only accept regular files (S_IFREG). The correct driver
 for these file types is 'host_cdrom' or 'host_device' as appropriate.
 
+@subsection -smp X,[socket=a,core=b,thread=c],maxcpus=Y (since 3.1)
+
+CPU topology properties should describe whole machine topology including
+possible CPUs. but historically it was possible to start QEMU with
+an incorrect topology where
+  socket * core * thread >= X && < maxcpus
+which could lead to incorrect topology enumeration by the guest.
+Support for invalid topology will be removed, end user must ensure
+that topology described with -smp includes all possible cpus, i.e.:
+  socket * core * thread == maxcpus
+
 @section QEMU Machine Protocol (QMP) commands
 
 @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
diff --git a/vl.c b/vl.c
index 5ba06ad..bc53828 100644
--- a/vl.c
+++ b/vl.c
@@ -1238,6 +1238,12 @@ static void smp_parse(QemuOpts *opts)
             exit(1);
         }
 
+        if (sockets * cores * threads != max_cpus) {
+            warn_report("Invalid CPUs topology deprecated. "
+                        "sockets (%u) * cores (%u) * threads (%u) "
+                        "!= maxcpus (%u)",
+                        sockets, cores, threads, max_cpus);
+        }
         if (sockets * cores * threads > max_cpus) {
             error_report("cpu topology: "
                          "sockets (%u) * cores (%u) * threads (%u) > "
-- 
2.7.4
