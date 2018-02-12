Received: from eggs.gnu.org ([2001:4830:134:3::10]:56429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1elGBx-0003rC-9P
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:38:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1elGBt-0004k2-QO
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:38:53 -0500
Received: from mail-by2nam01on0076.outbound.protection.outlook.com
	([104.47.34.76]:58163
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1elGBt-0004h6-G7
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:38:49 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Mon, 12 Feb 2018 09:37:13 -0600
Message-ID: <20180212153715.87555-27-brijesh.singh@amd.com>
In-Reply-To: <20180212153715.87555-1-brijesh.singh@amd.com>
References: <20180212153715.87555-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 26/28] qmp: add query-sev-launch-measure
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

The command can be used by libvirt to retrieve the measurement of SEV guest=
.
This measurement is a signature of the memory contents that was encrypted
through the LAUNCH_UPDATE_DATA.

Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 qapi-schema.json | 29 +++++++++++++++++++++++++++++
 qmp.c            | 17 +++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/qapi-schema.json b/qapi-schema.json
index 9203e28b8aee..5e4836ef9c8b 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3236,3 +3236,32 @@
 #
 ##
 { 'command': 'query-sev', 'returns': 'SevInfo' }
+
+##
+# @SevLaunchMeasureInfo:
+#
+# SEV Guest Launch measurement information
+#
+# @data: the measurement value encoded in base64
+#
+# Since: 2.12
+#
+##
+{ 'struct': 'SevLaunchMeasureInfo', 'data': {'data': 'str'} }
+
+##
+# @query-sev-launch-measure:
+#
+# Query the SEV guest launch information.
+#
+# Returns: The @SevLaunchMeasureInfo for the guest
+#
+# Since: 2.12
+#
+# Example:
+#
+# -> { "execute": "query-sev-launch-measure" }
+# <- { "return": { "data": "4l8LXeNlSPUDlXPJG5966/8%YZ" } }
+#
+##
+{ 'command': 'query-sev-launch-measure', 'returns': 'SevLaunchMeasureInfo'=
 }
diff --git a/qmp.c b/qmp.c
index 7907e539c8f2..0b994f1d9cd7 100644
--- a/qmp.c
+++ b/qmp.c
@@ -735,3 +735,20 @@ SevInfo *qmp_query_sev(Error **errp)
=20
     return info;
 }
+
+SevLaunchMeasureInfo *qmp_query_sev_launch_measure(Error **errp)
+{
+    char *data;
+    SevLaunchMeasureInfo *info;
+
+    data =3D sev_get_launch_measurement();
+    if (!data) {
+        error_setg(errp, "Measurement is not available");
+        return NULL;
+    }
+
+    info =3D g_malloc0(sizeof(*info));
+    info->data =3D data;
+
+    return info;
+}
--=20
2.14.3
