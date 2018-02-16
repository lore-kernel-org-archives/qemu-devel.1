Received: from eggs.gnu.org ([2001:4830:134:3::10]:44370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1emfI6-0004SR-7K
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1emfI4-0003b7-M3
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:39:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39388 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1emfI4-0003ax-Hs
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:39:00 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 16 Feb 2018 13:37:19 +0100
Message-Id: <1518784641-43151-8-git-send-email-imammedo@redhat.com>
In-Reply-To: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
References: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 7/9] QMP: permit query-hotpluggable-cpus in
 preconfig state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com

it will allow mgmt to query possible CPUs, which depends on
used machine(version)/-smp options, without restarting
QEMU and use results to configure numa mapping or adding
CPUs with device_add* later.

*) device_add is not allowed to run at preconfig in this series
   but later it could be dealt with by injecting -device
   in preconfig state and letting existing -device handling
   to actually plug devices

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 qapi-schema.json | 6 +++++-
 tests/qmp-test.c | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index ee1053d..4365dfe 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3167,7 +3167,11 @@
 #    ]}
 #
 ##
-{ 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'] }
+{ 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'],
+  'runstates': [ 'debug', 'inmigrate', 'internal-error', 'io-error', 'paused',
+                 'postmigrate', 'prelaunch', 'finish-migrate', 'restore-vm',
+                 'running', 'save-vm', 'shutdown', 'suspended', 'watchdog',
+                 'guest-panicked', 'colo', 'preconfig' ] }
 
 ##
 # @GuidInfo:
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 3adc485..4ab0b7c 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -323,6 +323,7 @@ static void test_qmp_preconfig(void)
     /* preconfig state */
     /* enabled commands, no error expected  */
     g_assert(!is_err(qtest_qmp(qs, "{ 'execute': 'query-commands' }")));
+    g_assert(!is_err(qtest_qmp(qs, "{ 'execute': 'query-hotpluggable-cpus'}")));
 
     /* forbidden commands, expected error */
     g_assert(is_err(qtest_qmp(qs, "{ 'execute': 'query-cpus' }")));
-- 
2.7.4
