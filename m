Received: from eggs.gnu.org ([2001:4830:134:3::10]:53797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eoRUF-0004ik-2G
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:18:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eoRUD-0001Yg-Jv
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:18:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50148 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eoRUD-0001YX-EZ
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:18:53 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 194648182D15
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 10:18:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 21 Feb 2018 11:18:35 +0100
Message-Id: <1519208316-18812-7-git-send-email-thuth@redhat.com>
In-Reply-To: <1519208316-18812-1-git-send-email-thuth@redhat.com>
References: <1519208316-18812-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/7] net: Remove the deprecated
 'host_net_add' and 'host_net_remove' HMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

They are deprecated since QEMU v2.10, and so far nobody complained that
these commands are still necessary for any reason - and since you can use
'netdev_add' and 'netdev_remove' instead, there also should not be any
real reason. Since they are also standing in the way for the upcoming
'vlan' clean-up, it's now time to remove them.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hmp-commands.hx  | 30 ------------------
 hmp.h            |  3 --
 monitor.c        | 61 ------------------------------------
 net/net.c        | 94 --------------------------------------------------------
 qemu-doc.texi    | 10 ------
 tests/test-hmp.c |  2 --
 6 files changed, 200 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index d26eb41..964eb51 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1291,36 +1291,6 @@ Inject PCIe AER error
 ETEXI
 
     {
-        .name       = "host_net_add",
-        .args_type  = "device:s,opts:s?",
-        .params     = "tap|user|socket|vde|netmap|bridge|vhost-user|dump [options]",
-        .help       = "add host VLAN client (deprecated, use netdev_add instead)",
-        .cmd        = hmp_host_net_add,
-        .command_completion = host_net_add_completion,
-    },
-
-STEXI
-@item host_net_add
-@findex host_net_add
-Add host VLAN client. Deprecated, please use @code{netdev_add} instead.
-ETEXI
-
-    {
-        .name       = "host_net_remove",
-        .args_type  = "vlan_id:i,device:s",
-        .params     = "vlan_id name",
-        .help       = "remove host VLAN client (deprecated, use netdev_del instead)",
-        .cmd        = hmp_host_net_remove,
-        .command_completion = host_net_remove_completion,
-    },
-
-STEXI
-@item host_net_remove
-@findex host_net_remove
-Remove host VLAN client. Deprecated, please use @code{netdev_del} instead.
-ETEXI
-
-    {
         .name       = "netdev_add",
         .args_type  = "netdev:O",
         .params     = "[user|tap|socket|vde|bridge|hubport|netmap|vhost-user],id=str[,prop=value][,...]",
diff --git a/hmp.h b/hmp.h
index 1143db4..b897338 100644
--- a/hmp.h
+++ b/hmp.h
@@ -132,9 +132,6 @@ void migrate_set_capability_completion(ReadLineState *rs, int nb_args,
                                        const char *str);
 void migrate_set_parameter_completion(ReadLineState *rs, int nb_args,
                                       const char *str);
-void host_net_add_completion(ReadLineState *rs, int nb_args, const char *str);
-void host_net_remove_completion(ReadLineState *rs, int nb_args,
-                                const char *str);
 void delvm_completion(ReadLineState *rs, int nb_args, const char *str);
 void loadvm_completion(ReadLineState *rs, int nb_args, const char *str);
 void hmp_rocker(Monitor *mon, const QDict *qdict);
diff --git a/monitor.c b/monitor.c
index 373bb8d..a4f1f28 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3574,67 +3574,6 @@ void migrate_set_parameter_completion(ReadLineState *rs, int nb_args,
     }
 }
 
-void host_net_add_completion(ReadLineState *rs, int nb_args, const char *str)
-{
-    int i;
-    size_t len;
-    if (nb_args != 2) {
-        return;
-    }
-    len = strlen(str);
-    readline_set_completion_index(rs, len);
-    for (i = 0; host_net_devices[i]; i++) {
-        if (!strncmp(host_net_devices[i], str, len)) {
-            readline_add_completion(rs, host_net_devices[i]);
-        }
-    }
-}
-
-void host_net_remove_completion(ReadLineState *rs, int nb_args, const char *str)
-{
-    NetClientState *ncs[MAX_QUEUE_NUM];
-    int count, i, len;
-
-    len = strlen(str);
-    readline_set_completion_index(rs, len);
-    if (nb_args == 2) {
-        count = qemu_find_net_clients_except(NULL, ncs,
-                                             NET_CLIENT_DRIVER_NONE,
-                                             MAX_QUEUE_NUM);
-        for (i = 0; i < MIN(count, MAX_QUEUE_NUM); i++) {
-            int id;
-            char name[16];
-
-            if (net_hub_id_for_client(ncs[i], &id)) {
-                continue;
-            }
-            snprintf(name, sizeof(name), "%d", id);
-            if (!strncmp(str, name, len)) {
-                readline_add_completion(rs, name);
-            }
-        }
-        return;
-    } else if (nb_args == 3) {
-        count = qemu_find_net_clients_except(NULL, ncs,
-                                             NET_CLIENT_DRIVER_NIC,
-                                             MAX_QUEUE_NUM);
-        for (i = 0; i < MIN(count, MAX_QUEUE_NUM); i++) {
-            int id;
-            const char *name;
-
-            if (ncs[i]->info->type == NET_CLIENT_DRIVER_HUBPORT ||
-                net_hub_id_for_client(ncs[i], &id)) {
-                continue;
-            }
-            name = ncs[i]->name;
-            if (!strncmp(str, name, len)) {
-                readline_add_completion(rs, name);
-            }
-        }
-        return;
-    }
-}
-
 static void vm_completion(ReadLineState *rs, const char *str)
 {
     size_t len;
diff --git a/net/net.c b/net/net.c
index cbd553d..2d05808 100644
--- a/net/net.c
+++ b/net/net.c
@@ -60,25 +60,6 @@
 static VMChangeStateEntry *net_change_state_entry;
 static QTAILQ_HEAD(, NetClientState) net_clients;
 
-const char *host_net_devices[] = {
-    "tap",
-    "socket",
-#ifdef CONFIG_NET_BRIDGE
-    "bridge",
-#endif
-#ifdef CONFIG_NETMAP
-    "netmap",
-#endif
-#ifdef CONFIG_SLIRP
-    "user",
-#endif
-#ifdef CONFIG_VDE
-    "vde",
-#endif
-    "vhost-user",
-    NULL,
-};
-
 /***********************************************************/
 /* network device redirectors */
 
@@ -1174,81 +1155,6 @@ static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
     return ret;
 }
 
-
-static int net_host_check_device(const char *device)
-{
-    int i;
-    for (i = 0; host_net_devices[i]; i++) {
-        if (!strncmp(host_net_devices[i], device,
-                     strlen(host_net_devices[i]))) {
-            return 1;
-        }
-    }
-
-    return 0;
-}
-
-void hmp_host_net_add(Monitor *mon, const QDict *qdict)
-{
-    const char *device = qdict_get_str(qdict, "device");
-    const char *opts_str = qdict_get_try_str(qdict, "opts");
-    Error *local_err = NULL;
-    QemuOpts *opts;
-    static bool warned;
-
-    if (!warned && !qtest_enabled()) {
-        error_report("host_net_add is deprecated, use netdev_add instead");
-        warned = true;
-    }
-
-    if (!net_host_check_device(device)) {
-        monitor_printf(mon, "invalid host network device %s\n", device);
-        return;
-    }
-
-    opts = qemu_opts_parse_noisily(qemu_find_opts("net"),
-                                   opts_str ? opts_str : "", false);
-    if (!opts) {
-        return;
-    }
-
-    qemu_opt_set(opts, "type", device, &error_abort);
-
-    net_client_init(opts, false, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        monitor_printf(mon, "adding host network device %s failed\n", device);
-    }
-}
-
-void hmp_host_net_remove(Monitor *mon, const QDict *qdict)
-{
-    NetClientState *nc;
-    int vlan_id = qdict_get_int(qdict, "vlan_id");
-    const char *device = qdict_get_str(qdict, "device");
-    static bool warned;
-
-    if (!warned && !qtest_enabled()) {
-        error_report("host_net_remove is deprecated, use netdev_del instead");
-        warned = true;
-    }
-
-    nc = net_hub_find_client_by_name(vlan_id, device);
-    if (!nc) {
-        error_report("Host network device '%s' on hub '%d' not found",
-                     device, vlan_id);
-        return;
-    }
-    if (nc->info->type == NET_CLIENT_DRIVER_NIC) {
-        error_report("invalid host network device '%s'", device);
-        return;
-    }
-
-    qemu_del_net_client(nc->peer);
-    qemu_del_net_client(nc);
-    qemu_opts_del(qemu_opts_find(qemu_find_opts("net"), device));
-}
-
 void netdev_add(QemuOpts *opts, Error **errp)
 {
     net_client_init(opts, true, errp);
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 97025c2..36acfc9 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2756,16 +2756,6 @@ by the ``convert -l snapshot_param'' argument instead.
 "autoload" parameter is now ignored. All bitmaps are automatically loaded
 from qcow2 images.
 
-@section System emulator human monitor commands
-
-@subsection host_net_add (since 2.10.0)
-
-The ``host_net_add'' command is replaced by the ``netdev_add'' command.
-
-@subsection host_net_remove (since 2.10.0)
-
-The ``host_net_remove'' command is replaced by the ``netdev_del'' command.
-
 @section System emulator devices
 
 @subsection ivshmem (since 2.6.0)
diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 5b7e447..5352c9c 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -37,10 +37,8 @@ static const char *hmp_cmds[] = {
     "dump-guest-memory /dev/null 0 4096",
     "dump-guest-memory /dev/null",
     "gdbserver",
-    "host_net_add user id=net0",
     "hostfwd_add tcp::43210-:43210",
     "hostfwd_remove tcp::43210-:43210",
-    "host_net_remove 0 net0",
     "i /w 0",
     "log all",
     "log none",
-- 
1.8.3.1
