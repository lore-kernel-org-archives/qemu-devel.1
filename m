Received: from eggs.gnu.org ([2001:4830:134:3::10]:37172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eZj3x-0006H5-Da
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:02:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eZj3t-00017u-HF
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:02:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eZj3t-000144-97
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:02:53 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 11 Jan 2018 21:02:40 +0100
Message-Id: <1515700960-26388-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] net: Allow netdevs to be used with
 'hostfwd_add' and 'hostfwd_remove'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

It does not make much sense to limit these commands to the legacy 'vlan'
concept only, they should work with the modern netdevs, too. So now
it is possible to use this command with one, two or three parameters.

With one parameter, the command installs a hostfwd rule on the default
"user" network:
    hostfwd_add tcp:...

With two parameters, the command installs a hostfwd rule on a netdev
(that's the new way of using this command):
    hostfwd_add netdev_id tcp:...

With three parameters, the command installs a rule on a 'vlan' (aka hub):
    hostfwd_add hub_id name tcp:...

Same applies to the hostfwd_remove command now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hmp-commands.hx |  4 ++--
 net/slirp.c     | 33 +++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 1a680c7..0ef2008 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1353,7 +1353,7 @@ ETEXI
     {
         .name       = "hostfwd_add",
         .args_type  = "arg1:s,arg2:s?,arg3:s?",
-        .params     = "[vlan_id name] [tcp|udp]:[hostaddr]:hostport-[guestaddr]:guestport",
+        .params     = "[hub_id name]|[netdev_id] [tcp|udp]:[hostaddr]:hostport-[guestaddr]:guestport",
         .help       = "redirect TCP or UDP connections from host to guest (requires -net user)",
         .cmd        = hmp_hostfwd_add,
     },
@@ -1368,7 +1368,7 @@ ETEXI
     {
         .name       = "hostfwd_remove",
         .args_type  = "arg1:s,arg2:s?,arg3:s?",
-        .params     = "[vlan_id name] [tcp|udp]:[hostaddr]:hostport",
+        .params     = "[hub_id name]|[netdev_id] [tcp|udp]:[hostaddr]:hostport",
         .help       = "remove host-to-guest TCP or UDP redirection",
         .cmd        = hmp_hostfwd_remove,
     },
diff --git a/net/slirp.c b/net/slirp.c
index cb8ca23..7044d29 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -405,16 +405,23 @@ error:
     return -1;
 }
 
-static SlirpState *slirp_lookup(Monitor *mon, const char *vlan,
-                                const char *stack)
+static SlirpState *slirp_lookup(Monitor *mon, const char *hub_id,
+                                const char *name)
 {
-
-    if (vlan) {
+    if (name) {
         NetClientState *nc;
-        nc = net_hub_find_client_by_name(strtol(vlan, NULL, 0), stack);
-        if (!nc) {
-            monitor_printf(mon, "unrecognized (vlan-id, stackname) pair\n");
-            return NULL;
+        if (hub_id) {
+            nc = net_hub_find_client_by_name(strtol(hub_id, NULL, 0), name);
+            if (!nc) {
+                monitor_printf(mon, "unrecognized (vlan-id, stackname) pair\n");
+                return NULL;
+            }
+        } else {
+            nc = qemu_find_netdev(name);
+            if (!nc) {
+                monitor_printf(mon, "unrecognized netdev id '%s'\n", name);
+                return NULL;
+            }
         }
         if (strcmp(nc->model, "user")) {
             monitor_printf(mon, "invalid device specified\n");
@@ -443,9 +450,12 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict)
     const char *arg2 = qdict_get_try_str(qdict, "arg2");
     const char *arg3 = qdict_get_try_str(qdict, "arg3");
 
-    if (arg2) {
+    if (arg3) {
         s = slirp_lookup(mon, arg1, arg2);
         src_str = arg3;
+    } else if (arg2) {
+        s = slirp_lookup(mon, NULL, arg1);
+        src_str = arg2;
     } else {
         s = slirp_lookup(mon, NULL, NULL);
         src_str = arg1;
@@ -570,9 +580,12 @@ void hmp_hostfwd_add(Monitor *mon, const QDict *qdict)
     const char *arg2 = qdict_get_try_str(qdict, "arg2");
     const char *arg3 = qdict_get_try_str(qdict, "arg3");
 
-    if (arg2) {
+    if (arg3) {
         s = slirp_lookup(mon, arg1, arg2);
         redir_str = arg3;
+    } else if (arg2) {
+        s = slirp_lookup(mon, NULL, arg1);
+        redir_str = arg2;
     } else {
         s = slirp_lookup(mon, NULL, NULL);
         redir_str = arg1;
-- 
1.8.3.1
