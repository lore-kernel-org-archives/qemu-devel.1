Received: from eggs.gnu.org ([2001:4830:134:3::10]:43637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g07z6-0002F4-Lu
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g07z2-00069G-2S
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:27:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34180 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1g07z1-00068v-Sq
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:27:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80E6A804B4DB
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 16:27:15 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 12 Sep 2018 18:19:14 +0200
Message-Id: <1536769155-269737-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1536769155-269737-1-git-send-email-imammedo@redhat.com>
References: <1536769155-269737-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v7 1/2] vl.c deprecate incorrect CPUs topology
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, ehabkost@redhat.com

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
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
v7:
  - add corrections to deprication doc formulas/math/section title
  - drop Note section
      (Eduardo Habkost <ehabkost@redhat.com>)
v6:
  - s/socket/sockets/, the same for core, thread in subsection
    (Andrew Jones <drjones@redhat.com>)
v5:
  - extend deprecation doc, adding that maxcpus should be multiple of
    present on CLI [sockets/cores/threads] options
    (Eduardo Habkost <ehabkost@redhat.com>)
v4:
  - missed dot comment, fix it with s/./,/ (Andrew Jones <drjones@redhat.com>)
v3:
  - more spelling fixes (Andrew Jones <drjones@redhat.com>)
  - place deprecation check after (sockets * cores * threads > max_cpus) check
    (Eduardo Habkost <ehabkost@redhat.com>)
v2:
  - spelling&&co fixes (Andrew Jones <drjones@redhat.com>)
---
 qemu-deprecated.texi | 13 +++++++++++++
 vl.c                 |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 1b9c007..31dc1b3 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -139,6 +139,19 @@ The 'file' driver for drives is no longer appropriate for character or host
 devices and will only accept regular files (S_IFREG). The correct driver
 for these file types is 'host_cdrom' or 'host_device' as appropriate.
 
+@subsection -smp (invalid topologies) (since 3.1)
+
+CPU topology properties should describe whole machine topology including
+possible CPUs. In other words: @var{maxcpus} should be equal to
+@math{@var{sockets} * @var{cores} * @var{threads}}.
+
+However, historically it was possible to start QEMU with an incorrect topology
+where @math{@var{n} <= @var{sockets} * @var{cores} * @var{threads} < @var{maxcpus}},
+which could lead to an incorrect topology enumeration by the guest.
+Support for invalid topologies will be removed, the user must ensure
+topologies described with -smp include all possible cpus, i.e.
+  @math{@var{sockets} * @var{cores} * @var{threads} = @var{maxcpus}}.
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
