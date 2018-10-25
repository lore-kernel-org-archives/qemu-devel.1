Received: from eggs.gnu.org ([2001:4830:134:3::10]:57229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfmt-0002Dq-3L
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFflg-0006tR-Px
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:33:45 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Oct 2018 10:32:20 -0300
Message-Id: <20181025133301.16578-3-ehabkost@redhat.com>
In-Reply-To: <20181025133301.16578-1-ehabkost@redhat.com>
References: <20181025133301.16578-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v2 02/43] vl.c deprecate incorrect CPUs topology
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>

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
[ehabkost: squashed unit test fix]
Message-Id: <20181019215345.521d58d7@igors-macbook-pro.local>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/cpu-plug-test.c | 18 +++++++++---------
 vl.c                  |  7 +++++++
 qemu-deprecated.texi  | 12 ++++++++++++
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
index 3e93c8e096..f4a677d238 100644
--- a/tests/cpu-plug-test.c
+++ b/tests/cpu-plug-test.c
@@ -32,12 +32,12 @@ static void test_plug_with_cpu_add(gconstpointer data)
     unsigned int i;
 
     args = g_strdup_printf("-machine %s -cpu %s "
-                           "-smp sockets=%u,cores=%u,threads=%u,maxcpus=%u",
+                           "-smp 1,sockets=%u,cores=%u,threads=%u,maxcpus=%u",
                            s->machine, s->cpu_model,
                            s->sockets, s->cores, s->threads, s->maxcpus);
     qtest_start(args);
 
-    for (i = s->sockets * s->cores * s->threads; i < s->maxcpus; i++) {
+    for (i = 1; i < s->maxcpus; i++) {
         response = qmp("{ 'execute': 'cpu-add',"
                        "  'arguments': { 'id': %d } }", i);
         g_assert(response);
@@ -56,7 +56,7 @@ static void test_plug_without_cpu_add(gconstpointer data)
     QDict *response;
 
     args = g_strdup_printf("-machine %s -cpu %s "
-                           "-smp sockets=%u,cores=%u,threads=%u,maxcpus=%u",
+                           "-smp 1,sockets=%u,cores=%u,threads=%u,maxcpus=%u",
                            s->machine, s->cpu_model,
                            s->sockets, s->cores, s->threads, s->maxcpus);
     qtest_start(args);
@@ -79,12 +79,12 @@ static void test_plug_with_device_add_x86(gconstpointer data)
     unsigned int s, c, t;
 
     args = g_strdup_printf("-machine %s -cpu %s "
-                           "-smp sockets=%u,cores=%u,threads=%u,maxcpus=%u",
+                           "-smp 1,sockets=%u,cores=%u,threads=%u,maxcpus=%u",
                            td->machine, td->cpu_model,
                            td->sockets, td->cores, td->threads, td->maxcpus);
     qtest_start(args);
 
-    for (s = td->sockets; s < td->maxcpus / td->cores / td->threads; s++) {
+    for (s = 1; s < td->sockets; s++) {
         for (c = 0; c < td->cores; c++) {
             for (t = 0; t < td->threads; t++) {
                 char *id = g_strdup_printf("id-%i-%i-%i", s, c, t);
@@ -113,7 +113,7 @@ static void test_plug_with_device_add_coreid(gconstpointer data)
                            td->sockets, td->cores, td->threads, td->maxcpus);
     qtest_start(args);
 
-    for (c = td->cores; c < td->maxcpus / td->sockets / td->threads; c++) {
+    for (c = 1; c < td->cores; c++) {
         char *id = g_strdup_printf("id-%i", c);
         qtest_qmp_device_add(td->device_model, id, "{'core-id':%u}", c);
         g_free(id);
@@ -148,7 +148,7 @@ static void add_pc_test_case(const char *mname)
     data->sockets = 1;
     data->cores = 3;
     data->threads = 2;
-    data->maxcpus = data->sockets * data->cores * data->threads * 2;
+    data->maxcpus = data->sockets * data->cores * data->threads;
     if (g_str_has_suffix(mname, "-1.4") ||
         (strcmp(mname, "pc-1.3") == 0) ||
         (strcmp(mname, "pc-1.2") == 0) ||
@@ -203,7 +203,7 @@ static void add_pseries_test_case(const char *mname)
     data->sockets = 2;
     data->cores = 3;
     data->threads = 1;
-    data->maxcpus = data->sockets * data->cores * data->threads * 2;
+    data->maxcpus = data->sockets * data->cores * data->threads;
 
     path = g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=%u",
                            mname, data->sockets, data->cores,
@@ -229,7 +229,7 @@ static void add_s390x_test_case(const char *mname)
     data->sockets = 1;
     data->cores = 3;
     data->threads = 1;
-    data->maxcpus = data->sockets * data->cores * data->threads * 2;
+    data->maxcpus = data->sockets * data->cores * data->threads;
 
     data2 = g_memdup(data, sizeof(PlugTestData));
     data2->machine = g_strdup(data->machine);
diff --git a/vl.c b/vl.c
index b2a405f80f..31febe965c 100644
--- a/vl.c
+++ b/vl.c
@@ -1266,6 +1266,13 @@ static void smp_parse(QemuOpts *opts)
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
