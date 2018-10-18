Received: from eggs.gnu.org ([2001:4830:134:3::10]:38429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEXK-0007TJ-Rc
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEXJ-0006yo-SS
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:04:50 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Oct 2018 17:03:39 -0300
Message-Id: <20181018200422.4358-3-ehabkost@redhat.com>
In-Reply-To: <20181018200422.4358-1-ehabkost@redhat.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 02/45] vl.c deprecate incorrect CPUs topology
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>

From: Igor Mammedov <imammedo@redhat.com>

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
Message-Id: <1536836762-273036-2-git-send-email-imammedo@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 vl.c                 |  7 +++++++
 qemu-deprecated.texi | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/vl.c b/vl.c
index 4e25c78bff..027d04c7ca 100644
--- a/vl.c
+++ b/vl.c
@@ -1235,6 +1235,13 @@ static void smp_parse(QemuOpts *opts)
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
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 11b870c5c1..5d2d7a3588 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -86,6 +86,18 @@ for these file types is 'host_cdrom' or 'host_device' as appropriate.
 The @option{name} parameter of the @option{-net} option is a synonym
 for the @option{id} parameter, which should now be used instead.
 
+@subsection -smp (invalid topologies) (since 3.1)
+
+CPU topology properties should describe whole machine topology including
+possible CPUs.
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
-- 
2.18.0.rc1.1.g3f1ff2140
