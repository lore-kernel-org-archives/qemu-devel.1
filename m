Received: from eggs.gnu.org ([2001:4830:134:3::10]:55989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1elGBb-0003X4-UH
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:38:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1elGBY-0004GT-FU
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:38:31 -0500
Received: from mail-by2nam01on0074.outbound.protection.outlook.com
	([104.47.34.74]:4096
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1elGBX-0004FY-Vn
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:38:28 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Mon, 12 Feb 2018 09:37:01 -0600
Message-ID: <20180212153715.87555-15-brijesh.singh@amd.com>
In-Reply-To: <20180212153715.87555-1-brijesh.singh@amd.com>
References: <20180212153715.87555-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 14/28] hmp: add 'info sev' command
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

Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 hmp-commands-info.hx | 14 ++++++++++++++
 hmp.c                | 19 +++++++++++++++++++
 hmp.h                |  1 +
 3 files changed, 34 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ad590a4ffb2b..236811c465d2 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -865,6 +865,20 @@ STEXI
 @findex info memory_size_summary
 Display the amount of initially allocated and present hotpluggable (if
 enabled) memory in bytes.
+ETEXI
+
+    {
+        .name       =3D "sev",
+        .args_type  =3D "",
+        .params     =3D "",
+        .help       =3D "show SEV information",
+        .cmd        =3D hmp_info_sev,
+    },
+
+STEXI
+@item info sev
+@findex info sev
+Show SEV information.
 ETEXI
=20
 STEXI
diff --git a/hmp.c b/hmp.c
index 7870d6a3004e..138bb8243207 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2924,3 +2924,22 @@ void hmp_info_memory_size_summary(Monitor *mon, cons=
t QDict *qdict)
     }
     hmp_handle_error(mon, &err);
 }
+
+void hmp_info_sev(Monitor *mon, const QDict *qdict)
+{
+    SevInfo *info;
+
+    info =3D qmp_query_sev(NULL);
+    monitor_printf(mon, "sev support: ");
+    monitor_printf(mon, "%s\n", info->enabled ? "enabled" : "disabled");
+
+    if (info->enabled) {
+        monitor_printf(mon, "state: %s\n", info->state);
+        monitor_printf(mon, "policy: 0x%x\n", info->policy);
+        monitor_printf(mon, "build id: %u\n", info->build_id);
+        monitor_printf(mon, "api version: %u.%u\n",
+                       info->api_major, info->api_minor);
+    }
+
+    qapi_free_SevInfo(info);
+}
diff --git a/hmp.h b/hmp.h
index 1143db44a760..4ca1a77b2c1f 100644
--- a/hmp.h
+++ b/hmp.h
@@ -146,5 +146,6 @@ void hmp_info_ramblock(Monitor *mon, const QDict *qdict=
);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
+void hmp_info_sev(Monitor *mon, const QDict *qdict);
=20
 #endif
--=20
2.14.3
