Received: from eggs.gnu.org ([2001:4830:134:3::10]:50551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etcHv-0004zj-Jo
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etcHr-0008TD-EQ
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:51:35 -0500
Received: from mail-bl2nam02on0075.outbound.protection.outlook.com
	([104.47.38.75]:34921
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1etcHr-0008Sq-8Y
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:51:31 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  7 Mar 2018 10:50:36 -0600
Message-ID: <20180307165038.88640-27-brijesh.singh@amd.com>
In-Reply-To: <20180307165038.88640-1-brijesh.singh@amd.com>
References: <20180307165038.88640-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 26/28] qmp: add query-sev-capabilities
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Brijesh Singh <brijesh.singh@amd.com>

The command can be used by libvirt to query the SEV capabilities.

Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 monitor.c             |  7 +++++++
 qapi/misc.json        | 42 ++++++++++++++++++++++++++++++++++++++++++
 target/i386/monitor.c |  6 ++++++
 3 files changed, 55 insertions(+)

diff --git a/monitor.c b/monitor.c
index d53ecc5ddab3..29ce695a80d5 100644
--- a/monitor.c
+++ b/monitor.c
@@ -985,6 +985,7 @@ static void qmp_unregister_commands_hack(void)
     qmp_unregister_command(&qmp_commands, "rtc-reset-reinjection");
     qmp_unregister_command(&qmp_commands, "query-sev");
     qmp_unregister_command(&qmp_commands, "query-sev-launch-measure");
+    qmp_unregister_command(&qmp_commands, "query-sev-capabilities");
 #endif
 #ifndef TARGET_S390X
     qmp_unregister_command(&qmp_commands, "dump-skeys");
@@ -4117,6 +4118,12 @@ SevLaunchMeasureInfo *qmp_query_sev_launch_measure(E=
rror **errp)
     error_setg(errp, QERR_FEATURE_DISABLED, "query-sev-launch-measure");
     return NULL;
 }
+
+SevCapability *qmp_query_sev_capabilities(Error **errp)
+{
+    error_setg(errp, QERR_FEATURE_DISABLED, "query-sev-capabilities");
+    return NULL;
+}
 #endif
=20
 #ifndef TARGET_S390X
diff --git a/qapi/misc.json b/qapi/misc.json
index 66c8229ec406..f34848831a4b 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3304,3 +3304,45 @@
 #
 ##
 { 'command': 'query-sev-launch-measure', 'returns': 'SevLaunchMeasureInfo'=
 }
+
+##
+# @SevCapability:
+#
+# The struct describes capability for a Secure Encrypted Virtualization
+# feature.
+#
+# @pdh:  Platform Diffie-Hellman key
+#
+# @cert-chain:  PDH certificate chain
+#
+# @cbitpos: C-bit location in page table entry
+#
+# @reduced-phys-bits: Number of physical Address bit reduction when SEV is
+#                     enabled
+#
+# Since: 2.12
+##
+{ 'struct': 'SevCapability',
+  'data': { 'pdh': 'str',
+            'cert-chain': 'str',
+            'cbitpos': 'int',
+            'reduced-phys-bits': 'int'} }
+
+##
+# @query-sev-capabilities:
+#
+# This command is used to get the SEV capabilities, and is supported on AM=
D
+# X86 platforms only.
+#
+# Returns: SevCapability objects.
+#
+# Since: 2.12
+#
+# Example:
+#
+# -> { "execute": "query-sev-capabilities" }
+# <- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
+#                  "cbitpos": 47, "reduced-phys-bits": 5}}
+#
+##
+{ 'command': 'query-sev-capabilities', 'returns': 'SevCapability' }
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index e5596bbc0fc2..33e6bade693b 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -737,3 +737,9 @@ SevLaunchMeasureInfo *qmp_query_sev_launch_measure(Erro=
r **errp)
=20
     return info;
 }
+
+SevCapability *qmp_query_sev_capabilities(Error **errp)
+{
+    error_setg(errp, "SEV feature is not available");
+    return NULL;
+}
--=20
2.14.3
