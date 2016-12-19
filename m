Received: from eggs.gnu.org ([2001:4830:134:3::10]:52988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cJ6hg-0004o0-0q
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 17:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cJ6he-0008Cf-SU
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 17:46:44 -0500
Received: from mail-it0-x231.google.com ([2607:f8b0:4001:c0b::231]:36967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cJ6he-0008CZ-Nh
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 17:46:42 -0500
Received: by mail-it0-x231.google.com with SMTP id y23so96660880itc.0
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 14:46:42 -0800 (PST)
From: ben@skyportsystems.com
Date: Mon, 19 Dec 2016 14:46:34 -0800
Message-Id: <d73fe3d84b15c6bda193c709ed11d9335f99d9f8.1482187052.git.ben@skyportsystems.com>
In-Reply-To: <cover.1482187052.git.ben@skyportsystems.com>
References: <cover.1482187052.git.ben@skyportsystems.com>
In-Reply-To: <cover.1482187052.git.ben@skyportsystems.com>
References: <cover.1482187052.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH 5/5] qmp/hmp: add set-vm-generation-id commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>, Eric Blake <eblake@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Add set-vm-generation-id command to set Virtual Machine
Generation ID counter.

QMP command example:
    { "execute": "set-vm-generation-id",
          "arguments": {
              "changed": true,
              "guid": "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
          }
    }

HMP command example:
    set-vm-generation-id changed=true guid=324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87

Signed-off-by: Ben Warren <ben@skyportsystems.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
---
 hmp-commands.hx  | 13 +++++++++++++
 hmp.c            | 13 +++++++++++++
 hmp.h            |  1 +
 qapi-schema.json | 12 ++++++++++++
 stubs/vmgenid.c  |  6 ++++++
 5 files changed, 45 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 8819281..495fc95 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1775,5 +1775,18 @@ ETEXI
     },
 
 STEXI
+@item set-vm-generation-id @var{changed} @var{uuid}
+Set Virtual Machine Generation ID counter to @var{guid}
+ETEXI
+
+    {
+        .name       = "set-vm-generation-id",
+        .args_type  = "changed:b,guid:s",
+        .params     = "changed guid",
+        .help       = "Set Virtual Machine Generation ID counter",
+        .cmd = hmp_set_vm_generation_id,
+    },
+
+STEXI
 @end table
 ETEXI
diff --git a/hmp.c b/hmp.c
index 9ec27ae..d73af31 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2579,3 +2579,16 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
     }
     qapi_free_GuidInfo(info);
 }
+
+void hmp_set_vm_generation_id(Monitor *mon, const QDict *qdict)
+{
+    Error *errp = NULL;
+    const char *guid = qdict_get_str(qdict, "guid");
+    bool changed = qdict_get_bool(qdict, "changed");
+
+    qmp_set_vm_generation_id(changed, guid, &errp);
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
index 2348391..72f3515 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4796,3 +4796,15 @@
 # Since 2.9
 ##
 { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
+
+##
+# @set-vm-generation-id
+#
+# Set Virtual Machine Generation ID
+#
+# @changed: Is the Virtual Machine Generation ID a new value?
+# @guid: new GUID to set as Virtual Machine Generation ID
+#
+# Since 2.9
+##
+{ 'command': 'set-vm-generation-id', 'data': { 'changed': 'bool', 'guid': 'str' } }
diff --git a/stubs/vmgenid.c b/stubs/vmgenid.c
index 8c448ac..588aeb4 100644
--- a/stubs/vmgenid.c
+++ b/stubs/vmgenid.c
@@ -6,3 +6,9 @@ GuidInfo *qmp_query_vm_generation_id(Error **errp)
     error_setg(errp, "this command is not currently supported");
     return NULL;
 }
+
+void qmp_set_vm_generation_id(bool changed, const char *guid, Error **errp)
+{
+    error_setg(errp, "this command is not currently supported");
+    return;
+}
-- 
2.7.4
