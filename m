Received: from eggs.gnu.org ([2001:4830:134:3::10]:49895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfvy-0006FP-3j
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfvu-0002f8-SO
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:46 -0500
Received: from mail-sn1nam01on0068.outbound.protection.outlook.com
	([104.47.32.68]:30256
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eMfvu-0002du-Lt
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:42 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  6 Dec 2017 14:03:36 -0600
Message-Id: <20171206200346.116537-14-brijesh.singh@amd.com>
In-Reply-To: <20171206200346.116537-1-brijesh.singh@amd.com>
References: <20171206200346.116537-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 13/23] hmp: display memory encryption
 support in 'info kvm'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E . Iglesias " <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>

update 'info kvm' to display the memory encryption support.

(qemu) info kvm
kvm support: enabled
memory encryption: disabled

Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 hmp.c            | 2 ++
 qapi-schema.json | 5 ++++-
 qmp.c            | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index 35a704182494..3184ed5d1550 100644
--- a/hmp.c
+++ b/hmp.c
@@ -88,6 +88,8 @@ void hmp_info_kvm(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "kvm support: ");
     if (info->present) {
         monitor_printf(mon, "%s\n", info->enabled ? "enabled" : "disabled");
+        monitor_printf(mon, "memory encryption: %s\n",
+                       info->mem_encryption ? "enabled" : "disabled");
     } else {
         monitor_printf(mon, "not compiled\n");
     }
diff --git a/qapi-schema.json b/qapi-schema.json
index 18457954a841..7eec403cd34a 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -314,9 +314,12 @@
 #
 # @present: true if KVM acceleration is built into this executable
 #
+# @mem-encryption: true if Memory Encryption is active (since 2.11)
+#
 # Since: 0.14.0
 ##
-{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
+{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool',
+            'mem-encryption' : 'bool'} }
 
 ##
 # @query-kvm:
diff --git a/qmp.c b/qmp.c
index e8c303116af2..baf367af55c0 100644
--- a/qmp.c
+++ b/qmp.c
@@ -69,6 +69,7 @@ KvmInfo *qmp_query_kvm(Error **errp)
 
     info->enabled = kvm_enabled();
     info->present = kvm_available();
+    info->mem_encryption = kvm_memcrypt_enabled();
 
     return info;
 }
-- 
2.9.5
