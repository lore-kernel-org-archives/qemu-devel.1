Received: from eggs.gnu.org ([2001:4830:134:3::10]:32937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fB5lM-0002ls-Ql
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fB5lL-00075Z-Cv
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:46:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32824 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fB5lL-00075P-8I
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:46:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB839406E97E
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 21:46:10 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Tue, 24 Apr 2018 23:45:49 +0200
Message-Id: <20180424214550.32549-6-lersek@redhat.com>
In-Reply-To: <20180424214550.32549-1-lersek@redhat.com>
References: <20180424214550.32549-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH 5/6] qapi: extract CpuInfoCommon to mitigate
 schema duplication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

@CpuInfo and @CpuInfoFast duplicate the following four fields: @qom-path,
@thread-id, @props and @arch. From these, extract the first three to a
common structure called @CpuInfoCommon. (More on @arch later.)

Introduce two new mid-layer structures, @CpuInfoBase and @CpuInfoFastBase,
to soak up the union base struct fields on top of @CpuInfoCommon that are
specific to @query-cpus and @query-cpus-fast, respectively. This is
necessary because the base struct spec in union definitions does not let
us mix named fields with a recursive base struct. (In other words, we
couldn't directly use @CpuInfoCommon *plus* some other fields within
@CpuInfo and @CpuInfoFast as base struct).

@arch cannot be hoisted higher than to @CpuInfoBase and @CpuInfoFastBase
because the union descriminator is only accepted from a direct base
struct, not from an indirect one.

Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---

Notes:
    PATCHv1:
    
    - new patch

 qapi/misc.json                      | 94 +++++++++++++++++++++++++------------
 qapi/qapi-schema.json               |  2 +-
 tests/test-x86-cpuid-compat.c       |  2 +-
 tests/migration/guestperf/engine.py |  2 +-
 4 files changed, 68 insertions(+), 32 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 460866cf542f..d7b776a5af37 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -348,52 +348,81 @@
 #
 # @s390: since 2.12
 #
 # @riscv: since 2.12
 #
 # Since: 2.6
 ##
 { 'enum': 'CpuInfoArch',
   'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 's390', 'riscv', 'other' ] }
 
 ##
-# @CpuInfo:
+# @CpuInfoCommon:
 #
-# Information about a virtual CPU
+# Collects fields common to @CpuInfoBase and @CpuInfoFastBase; that is,
+# fields that are shared by @query-cpus and @query-cpus-fast, and not
+# specific to the target architecture.
+#
+# @qom-path: path to the CPU object in the QOM tree (since 2.4)
+#
+# @thread-id: ID of the underlying host thread
+#
+# @props: properties describing which node/socket/core/thread the
+#         virtual CPU belongs to, if supported by the board (since 2.10)
+#
+# Since: 2.13
+##
+{ 'struct' : 'CpuInfoCommon',
+  'data'   : { 'qom-path'  : 'str',
+               'thread-id' : 'int',
+               '*props'    : 'CpuInstanceProperties' } }
+
+##
+# @CpuInfoBase:
+#
+# Extends @CpuInfoCommon with fields that are specific to the @query-cpus
+# command, but not specific to the target architecture.
 #
 # @CPU: the index of the virtual CPU
 #
 # @current: this only exists for backwards compatibility and should be ignored
 #
 # @halted: true if the virtual CPU is in the halt state.  Halt usually refers
 #          to a processor specific low power mode.
 #
-# @qom_path: path to the CPU object in the QOM tree (since 2.4)
-#
-# @thread_id: ID of the underlying host thread
-#
-# @props: properties describing to which node/socket/core/thread
-#         virtual CPU belongs to, provided if supported by board (since 2.10)
-#
 # @arch: architecture of the cpu, which determines which additional fields
 #        will be listed (since 2.6)
 #
-# Since: 0.14.0
+# Since: 2.13
 #
 # Notes: @halted is a transient state that changes frequently.  By the time the
 #        data is sent to the client, the guest may no longer be halted.
+#        Moreover, @arch cannot be moved up to @CpuInfoCommon because
+#        that would prevent its use as the discriminator in @CpuInfo.
+##
+{ 'struct' : 'CpuInfoBase',
+  'base'   : 'CpuInfoCommon',
+  'data'   : { 'CPU'     : 'int',
+               'current' : 'bool',
+               'halted'  : 'bool',
+               'arch'    : 'CpuInfoArch' } }
+
+##
+# @CpuInfo:
+#
+# Information about a virtual CPU
+#
+# Since: 0.14.0
 ##
 { 'union': 'CpuInfo',
-  'base': {'CPU': 'int', 'current': 'bool', 'halted': 'bool',
-           'qom_path': 'str', 'thread_id': 'int',
-           '*props': 'CpuInstanceProperties', 'arch': 'CpuInfoArch' },
+  'base': 'CpuInfoBase',
   'discriminator': 'arch',
   'data': { 'x86': 'CpuInfoX86',
             'sparc': 'CpuInfoSPARC',
             'ppc': 'CpuInfoPPC',
             'mips': 'CpuInfoMIPS',
             'tricore': 'CpuInfoTricore',
             's390': 'CpuInfoS390',
             'riscv': 'CpuInfoRISCV',
             'other': 'CpuInfoOther' } }
 
 ##
@@ -512,70 +541,77 @@
 #
 # Since: 0.14.0
 #
 # Example:
 #
 # -> { "execute": "query-cpus" }
 # <- { "return": [
 #          {
 #             "CPU":0,
 #             "current":true,
 #             "halted":false,
-#             "qom_path":"/machine/unattached/device[0]",
+#             "qom-path":"/machine/unattached/device[0]",
 #             "arch":"x86",
 #             "pc":3227107138,
-#             "thread_id":3134
+#             "thread-id":3134
 #          },
 #          {
 #             "CPU":1,
 #             "current":false,
 #             "halted":true,
-#             "qom_path":"/machine/unattached/device[2]",
+#             "qom-path":"/machine/unattached/device[2]",
 #             "arch":"x86",
 #             "pc":7108165,
-#             "thread_id":3135
+#             "thread-id":3135
 #          }
 #       ]
 #    }
 #
 # Notes: This interface is deprecated (since 2.12.0), and it is strongly
 #        recommended that you avoid using it. Use @query-cpus-fast to
 #        obtain information about virtual CPUs.
 #
 ##
 { 'command': 'query-cpus', 'returns': ['CpuInfo'] }
 
 ##
-# @CpuInfoFast:
+# @CpuInfoFastBase:
 #
-# Information about a virtual CPU
+# Extends @CpuInfoCommon with fields that are specific to the
+# @query-cpus-fast command, but not specific to the target architecture.
 #
 # @cpu-index: index of the virtual CPU
 #
-# @qom-path: path to the CPU object in the QOM tree
-#
-# @thread-id: ID of the underlying host thread
-#
-# @props: properties describing to which node/socket/core/thread
-#         virtual CPU belongs to, provided if supported by board
-#
 # @arch: architecture of the cpu, which determines which additional fields
 #        will be listed
 #
+# Since: 2.13
+#
+# Notes: @arch cannot be moved up to @CpuInfoCommon because that would
+#        prevent its use as the discriminator in @CpuInfoFast.
+##
+{ 'struct' : 'CpuInfoFastBase',
+  'base'   : 'CpuInfoCommon',
+  'data'   : { 'cpu-index' : 'int',
+               'arch'      : 'CpuInfoArch' } }
+
+##
+# @CpuInfoFast:
+#
+# Information about a virtual CPU
+#
 # Since: 2.12
 #
 ##
 { 'union': 'CpuInfoFast',
-  'base': {'cpu-index': 'int', 'qom-path': 'str',
-           'thread-id': 'int', '*props': 'CpuInstanceProperties',
-           'arch': 'CpuInfoArch' },
+  'base': 'CpuInfoFastBase',
   'discriminator': 'arch',
   'data': { 'x86': 'CpuInfoOther',
             'sparc': 'CpuInfoOther',
             'ppc': 'CpuInfoOther',
             'mips': 'CpuInfoOther',
             'tricore': 'CpuInfoOther',
             's390': 'CpuInfoS390',
             'riscv': 'CpuInfoOther',
             'other': 'CpuInfoOther' } }
 
 ##
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 25bce78352b8..5bfd2ef1dd3b 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -61,23 +61,23 @@
         'query-migrate-cache-size',
         'query-tpm-models',
         'query-tpm-types',
         'ringbuf-read' ],
     'name-case-whitelist': [
         'ACPISlotType',         # DIMM, visible through query-acpi-ospm-status
         'CpuInfoMIPS',          # PC, visible through query-cpu
         'CpuInfoTricore',       # PC, visible through query-cpu
         'QapiErrorClass',       # all members, visible through errors
         'UuidInfo',             # UUID, visible through query-uuid
         'X86CPURegister32',     # all members, visible indirectly through qom-get
-        'q_obj_CpuInfo-base'    # CPU, visible through query-cpu
+        'CpuInfoBase'           # CPU, visible through query-cpu
     ] } }
 
 # Documentation generated with qapi-gen.py is in source order, with
 # included sub-schemas inserted at the first include directive
 # (subsequent include directives have no effect).  To get a sane and
 # stable order, it's best to include each sub-schema just once, or
 # include it first right here.
 
 { 'include': 'common.json' }
 { 'include': 'sockets.json' }
 { 'include': 'run-state.json' }
diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.c
index 02e41843fc9c..df51b3bbacbc 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -10,23 +10,23 @@ static char *get_cpu0_qom_path(void)
 {
     QDict *resp;
     QList *ret;
     QDict *cpu0;
     char *path;
 
     resp = qmp("{'execute': 'query-cpus', 'arguments': {}}");
     g_assert(qdict_haskey(resp, "return"));
     ret = qdict_get_qlist(resp, "return");
 
     cpu0 = qobject_to(QDict, qlist_peek(ret));
-    path = g_strdup(qdict_get_str(cpu0, "qom_path"));
+    path = g_strdup(qdict_get_str(cpu0, "qom-path"));
     QDECREF(resp);
     return path;
 }
 
 static QObject *qom_get(const char *path, const char *prop)
 {
     QDict *resp = qmp("{ 'execute': 'qom-get',"
                       "  'arguments': { 'path': %s,"
                       "                 'property': %s } }",
                       path, prop);
     QObject *ret = qdict_get(resp, "return");
diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/engine.py
index e14d4320b239..663881c163e9 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -104,23 +104,23 @@ class Engine(object):
             info.get("x-cpu-throttle-percentage", 0),
         )
 
     def _migrate(self, hardware, scenario, src, dst, connect_uri):
         src_qemu_time = []
         src_vcpu_time = []
         src_pid = src.get_pid()
 
         vcpus = src.command("query-cpus")
         src_threads = []
         for vcpu in vcpus:
-            src_threads.append(vcpu["thread_id"])
+            src_threads.append(vcpu["thread-id"])
 
         # XXX how to get dst timings on remote host ?
 
         if self._verbose:
             print "Sleeping %d seconds for initial guest workload run" % self._sleep
         sleep_secs = self._sleep
         while sleep_secs > 1:
             src_qemu_time.append(self._cpu_timing(src_pid))
             src_vcpu_time.extend(self._vcpu_timing(src_pid, src_threads))
             time.sleep(1)
             sleep_secs -= 1
-- 
2.14.1.3.gb7cf6e02401b
