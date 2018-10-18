Received: from eggs.gnu.org ([2001:4830:134:3::10]:41277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEcq-0004W7-QN
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEcl-0004dU-0U
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:10:31 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Oct 2018 17:04:22 -0300
Message-Id: <20181018200422.4358-46-ehabkost@redhat.com>
In-Reply-To: <20181018200422.4358-1-ehabkost@redhat.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 45/45] numa: Clean up error reporting in
 parse_numa()
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

From: Markus Armbruster <armbru@redhat.com>

Calling error_report() in a function that takes an Error ** argument
is suspicious.  parse_numa() does that, and then fails without setting
an error.  Its caller main(), via qemu_opts_foreach(), is fine with
it, but clean it up anyway.

While there, give parse_numa() internal linkage.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20181008173125.19678-26-armbru@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/sysemu/numa.h | 1 -
 numa.c                | 8 +++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 7a0ae751aa..21713b7e2f 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -22,7 +22,6 @@ struct NumaNodeMem {
 };
 
 extern NodeInfo numa_info[MAX_NODES];
-int parse_numa(void *opaque, QemuOpts *opts, Error **errp);
 void parse_numa_opts(MachineState *ms);
 void numa_complete_configuration(MachineState *ms);
 void query_numa_node_mem(NumaNodeMem node_mem[]);
diff --git a/numa.c b/numa.c
index 1d7c49ad43..50ec016013 100644
--- a/numa.c
+++ b/numa.c
@@ -215,7 +215,7 @@ end:
     error_propagate(errp, err);
 }
 
-int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
+static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
 {
     NumaOptions *object = NULL;
     MachineState *ms = MACHINE(opaque);
@@ -239,7 +239,7 @@ int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
 end:
     qapi_free_NumaOptions(object);
     if (err) {
-        error_report_err(err);
+        error_propagate(errp, err);
         return -1;
     }
 
@@ -444,9 +444,7 @@ void numa_complete_configuration(MachineState *ms)
 
 void parse_numa_opts(MachineState *ms)
 {
-    if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, NULL)) {
-        exit(1);
-    }
+    qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, &error_fatal);
 }
 
 void qmp_set_numa_node(NumaOptions *cmd, Error **errp)
-- 
2.18.0.rc1.1.g3f1ff2140
