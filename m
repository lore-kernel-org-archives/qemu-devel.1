Received: from eggs.gnu.org ([2001:4830:134:3::10]:52177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj6R-0006Nx-Fu
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:26:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj6O-0005dd-7Q
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:26:35 -0500
Received: from mail-sn1nam01on0070.outbound.protection.outlook.com
	([104.47.32.70]:22852
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1clj6N-0005dH-V2
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:26:32 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 8 Mar 2017 15:52:46 -0500
Message-ID: <148900636610.27090.7472863810631270644.stgit@brijesh-build-machine>
In-Reply-To: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 09/20] hmp: display memory encryption
 support in 'info kvm'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com

update 'info kvm' to display the memory encryption support.

(qemu) info kvm
kvm support: enabled
memory encryption: disabled

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 hmp.c            |    2 ++
 qapi-schema.json |    5 ++++-
 qmp.c            |    1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index 261843f..0b8b315 100644
--- a/hmp.c
+++ b/hmp.c
@@ -83,6 +83,8 @@ void hmp_info_kvm(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "kvm support: ");
     if (info->present) {
         monitor_printf(mon, "%s\n", info->enabled ? "enabled" : "disabled");
+        monitor_printf(mon, "memory encryption: %s\n",
+                       info->mem_encryption ? "enabled" : "disabled");
     } else {
         monitor_printf(mon, "not compiled\n");
     }
diff --git a/qapi-schema.json b/qapi-schema.json
index 6febfa7..e1dc847 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -185,9 +185,12 @@
 #
 # @present: true if KVM acceleration is built into this executable
 #
+# @mem-encryption: true if Memory Encryption is active (since 2.8)
+#
 # Since: 0.14.0
 ##
-{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
+{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool',
+            'mem-encryption' : 'bool'} }
 
 ##
 # @query-kvm:
diff --git a/qmp.c b/qmp.c
index fa82b59..7b61c43 100644
--- a/qmp.c
+++ b/qmp.c
@@ -69,6 +69,7 @@ KvmInfo *qmp_query_kvm(Error **errp)
 
     info->enabled = kvm_enabled();
     info->present = kvm_available();
+    info->mem_encryption = kvm_memcrypt_enabled();
 
     return info;
 }
