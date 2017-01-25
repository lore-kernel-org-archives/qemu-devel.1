Received: from eggs.gnu.org ([2001:4830:134:3::10]:47496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cWCcy-0003hX-8j
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cWCcx-0005OD-ET
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:44:00 -0500
Received: from mail-yw0-x232.google.com ([2607:f8b0:4002:c05::232]:32968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cWCcx-0005O8-Aj
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:43:59 -0500
Received: by mail-yw0-x232.google.com with SMTP id u68so3013435ywg.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 17:43:59 -0800 (PST)
From: ben@skyportsystems.com
Date: Tue, 24 Jan 2017 17:43:25 -0800
Message-Id: <3bce614f2babb3b4d3c7d9446223c389a28d1080.1485308342.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485308342.git.ben@skyportsystems.com>
References: <cover.1485308342.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485308342.git.ben@skyportsystems.com>
References: <cover.1485308342.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v4 6/9] qmp/hmp: add set-vm-generation-id
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>

From: Igor Mammedov <imammedo@redhat.com>

Add set-vm-generation-id command to set Virtual Machine
Generation ID counter.

QMP command example:
    { "execute": "set-vm-generation-id",
          "arguments": {
              "guid": "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
          }
    }

HMP command example:
    set-vm-generation-id guid=324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Ben Warren <ben@skyportsystems.com>
---
 hmp-commands.hx  | 13 +++++++++++++
 hmp.c            | 12 ++++++++++++
 hmp.h            |  1 +
 qapi-schema.json | 11 +++++++++++
 stubs/vmgenid.c  |  6 ++++++
 5 files changed, 43 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 8819281..56744aa 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1775,5 +1775,18 @@ ETEXI
     },
 
 STEXI
+@item set-vm-generation-id @var{uuid}
+Set Virtual Machine Generation ID counter to @var{guid}
+ETEXI
+
+    {
+        .name       = "set-vm-generation-id",
+        .args_type  = "guid:s",
+        .params     = "guid",
+        .help       = "Set Virtual Machine Generation ID counter",
+        .cmd = hmp_set_vm_generation_id,
+    },
+
+STEXI
 @end table
 ETEXI
diff --git a/hmp.c b/hmp.c
index c2280e0..3a4db8b 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2573,3 +2573,15 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
     }
     qapi_free_GuidInfo(info);
 }
+
+void hmp_set_vm_generation_id(Monitor *mon, const QDict *qdict)
+{
+    Error *errp = NULL;
+    const char *guid = qdict_get_str(qdict, "guid");
+
+    qmp_set_vm_generation_id(guid, &errp);
+    if (errp) {
+        hmp_handle_error(mon, &errp);
+        return;
+    }
+}
diff --git a/hmp.h b/hmp.h
index 799fd37..e0ac1e8 100644
--- a/hmp.h
+++ b/hmp.h
@@ -138,5 +138,6 @@ void hmp_rocker_of_dpa_groups(Monitor *mon, const QDict *qdict);
 void hmp_info_dump(Monitor *mon, const QDict *qdict);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
+void hmp_set_vm_generation_id(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/qapi-schema.json b/qapi-schema.json
index 413ac52..e2ed75c 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -6046,3 +6046,14 @@
 # Since 2.9
 ##
 { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
+
+##
+# @set-vm-generation-id:
+#
+# Set Virtual Machine Generation ID
+#
+# @guid: new GUID to set as Virtual Machine Generation ID
+#
+# Since 2.9
+##
+{ 'command': 'set-vm-generation-id', 'data': {'guid': 'str'} }
diff --git a/stubs/vmgenid.c b/stubs/vmgenid.c
index 8c448ac..d25d41b 100644
--- a/stubs/vmgenid.c
+++ b/stubs/vmgenid.c
@@ -6,3 +6,9 @@ GuidInfo *qmp_query_vm_generation_id(Error **errp)
     error_setg(errp, "this command is not currently supported");
     return NULL;
 }
+
+void qmp_set_vm_generation_id(const char *guid, Error **errp)
+{
+    error_setg(errp, "this command is not currently supported");
+    return;
+}
-- 
2.7.4
