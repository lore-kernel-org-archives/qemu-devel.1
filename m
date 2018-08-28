Received: from eggs.gnu.org ([2001:4830:134:3::10]:34336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fue0c-00049Y-BP
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fue0Z-0006Tq-0e
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:26:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45694 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fue0Y-0006TT-PZ
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:26:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 467008D77B
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 13:26:10 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 28 Aug 2018 15:26:07 +0200
Message-Id: <1535462767-2297-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3] vl.c deprecate incorrect CPUs topology
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, ehabkost@redhat.com, berrange@redhat.com, drjones@redhat.com

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
v3:
  - more spelling fixes (Andrew Jones <drjones@redhat.com>)
  - place deprecation check after (sockets * cores * threads > max_cpus) check
    (Eduardo Habkost <ehabkost@redhat.com>)
v2:
  - spelling&&co fixes (Andrew Jones <drjones@redhat.com>)
---
 qemu-deprecated.texi | 11 +++++++++++
 vl.c                 |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 87212b6..dc9d9ee 100644
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
+  sockets * cores * threads >= X && X < maxcpus
+which could lead to an incorrect topology enumeration by the guest.
+Support for invalid topologies will be removed, the user must ensure
+topologies described with -smp include all possible cpus, i.e.
+  sockets * cores * threads == maxcpus
+
 @section QEMU Machine Protocol (QMP) commands
 
 @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
diff --git a/vl.c b/vl.c
index 5ba06ad..7fd700e 100644
--- a/vl.c
+++ b/vl.c
@@ -1246,6 +1246,13 @@ static void smp_parse(QemuOpts *opts)
             exit(1);
         }
 
+        if (sockets * cores * threads != max_cpus) {
+            warn_report("Invalid CPU topology deprecated: "
+                        "sockets (%u) * cores (%u) * threads (%u) "
+                        "!= maxcpus (%u)",
+                        sockets, cores, threads, max_cpus);
+        }
+
         smp_cpus = cpus;
         smp_cores = cores;
         smp_threads = threads;
-- 
2.7.4
