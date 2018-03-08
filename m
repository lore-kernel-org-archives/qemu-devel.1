Received: from eggs.gnu.org ([2001:4830:134:3::10]:58946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etuzn-0005K7-EO
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etuzj-00046K-8s
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:50:07 -0500
Received: from mail-cys01nam02on0057.outbound.protection.outlook.com
	([104.47.37.57]:36832
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1etuzj-00045m-1k
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:50:03 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Thu,  8 Mar 2018 06:48:47 -0600
Message-ID: <20180308124901.83533-15-brijesh.singh@amd.com>
In-Reply-To: <20180308124901.83533-1-brijesh.singh@amd.com>
References: <20180308124901.83533-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 14/28] hmp: add 'info sev' command
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

The command can be used to show the SEV information when memory
encryption is enabled on AMD platform.

Cc: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Reviewed-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 hmp-commands-info.hx  | 16 ++++++++++++++++
 hmp.h                 |  1 +
 target/i386/monitor.c | 20 ++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ad590a4ffb2b..ddfcd5adcca6 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -867,6 +867,22 @@ Display the amount of initially allocated and present =
hotpluggable (if
 enabled) memory in bytes.
 ETEXI
=20
+#if defined(TARGET_I386)
+    {
+        .name       =3D "sev",
+        .args_type  =3D "",
+        .params     =3D "",
+        .help       =3D "show SEV information",
+        .cmd        =3D hmp_info_sev,
+    },
+#endif
+
+STEXI
+@item info sev
+@findex info sev
+Show SEV information.
+ETEXI
+
 STEXI
 @end table
 ETEXI
diff --git a/hmp.h b/hmp.h
index b89733876de1..4e2ec375b0f4 100644
--- a/hmp.h
+++ b/hmp.h
@@ -143,5 +143,6 @@ void hmp_info_ramblock(Monitor *mon, const QDict *qdict=
);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
+void hmp_info_sev(Monitor *mon, const QDict *qdict);
=20
 #endif
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 29de61996371..4d9019626031 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -29,6 +29,7 @@
 #include "qapi/qmp/qdict.h"
 #include "hw/i386/pc.h"
 #include "sysemu/kvm.h"
+#include "sysemu/sev.h"
 #include "hmp.h"
 #include "sev_i386.h"
 #include "qapi/qapi-commands-misc.h"
@@ -680,3 +681,22 @@ SevInfo *qmp_query_sev(Error **errp)
=20
     return info;
 }
+
+void hmp_info_sev(Monitor *mon, const QDict *qdict)
+{
+    SevInfo *info =3D sev_get_info();
+
+    if (info && info->enabled) {
+        monitor_printf(mon, "handle: %d\n", info->handle);
+        monitor_printf(mon, "state: %s\n", SevState_str(info->state));
+        monitor_printf(mon, "build: %d\n", info->build_id);
+        monitor_printf(mon, "api version: %d.%d\n",
+                       info->api_major, info->api_minor);
+        monitor_printf(mon, "debug: %s\n",
+                       info->policy & SEV_POLICY_NODBG ? "off" : "on");
+        monitor_printf(mon, "key-sharing: %s\n",
+                       info->policy & SEV_POLICY_NOKS ? "off" : "on");
+    } else {
+        monitor_printf(mon, "SEV is not enabled\n");
+    }
+}
--=20
2.14.3
