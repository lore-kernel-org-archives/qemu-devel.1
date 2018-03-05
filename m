Received: from eggs.gnu.org ([2001:4830:134:3::10]:46038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1esgYO-00075g-A2
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:12:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1esgYL-0005d4-JT
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:12:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57210 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1esgYL-0005cV-Dm
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:12:41 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  5 Mar 2018 11:12:02 +0800
Message-Id: <1520219524-17160-8-git-send-email-jasowang@redhat.com>
In-Reply-To: <1520219524-17160-1-git-send-email-jasowang@redhat.com>
References: <1520219524-17160-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 7/9] net: Add a new convenience option "--nic"
 to configure default/on-board NICs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The legacy "-net" option can be quite confusing for the users since most
people do not expect to get a "vlan" hub between their emulated guest
hardware and the host backend. But so far, we are also not able to get
rid of "-net" completely, since it is the only way to configure on-board
NICs that can not be instantiated via "-device" yet. It's also a little
bit shorter to type "-net nic -net tap" instead of "-device xyz,netdev=n1
-netdev tap,id=n1".

So what we need is a new convenience option that is shorter to type than
the full -device + -netdev stuff, and which can be used to configure the
on-board NICs that can not be handled via -device yet. Thus this patch now
provides such a new option "--nic": It adds an entry in the nd_table to
configure a on-board / default NIC, creates a host backend and connects
the two directly, without a confusing "vlan" hub inbetween.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/sysemu/sysemu.h |  1 +
 net/net.c               | 78 +++++++++++++++++++++++++++++++++++++++++++++++++
 qemu-options.hx         | 40 +++++++++++++++++++++----
 vl.c                    |  7 +++++
 4 files changed, 120 insertions(+), 6 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 77bb3da..66f0761 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -197,6 +197,7 @@ extern QemuOptsList bdrv_runtime_opts;
 extern QemuOptsList qemu_chardev_opts;
 extern QemuOptsList qemu_device_opts;
 extern QemuOptsList qemu_netdev_opts;
+extern QemuOptsList qemu_nic_opts;
 extern QemuOptsList qemu_net_opts;
 extern QemuOptsList qemu_global_opts;
 extern QemuOptsList qemu_mon_opts;
diff --git a/net/net.c b/net/net.c
index 2d05808..0bab269 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1462,6 +1462,67 @@ static int net_init_netdev(void *dummy, QemuOpts *opts, Error **errp)
     return net_client_init(opts, true, errp);
 }
 
+/* For the convenience "--nic" parameter */
+static int net_param_nic(void *dummy, QemuOpts *opts, Error **errp)
+{
+    char *mac, *nd_id;
+    int idx, ret;
+    NICInfo *ni;
+    const char *type;
+
+    type = qemu_opt_get(opts, "type");
+    if (type && g_str_equal(type, "none")) {
+        return 0;    /* Nothing to do, default_net is cleared in vl.c */
+    }
+
+    idx = nic_get_free_idx();
+    if (idx == -1 || nb_nics >= MAX_NICS) {
+        error_setg(errp, "no more on-board/default NIC slots available");
+        return -1;
+    }
+
+    if (!type) {
+        qemu_opt_set(opts, "type", "user", &error_abort);
+    }
+
+    ni = &nd_table[idx];
+    memset(ni, 0, sizeof(*ni));
+    ni->model = qemu_opt_get_del(opts, "model");
+
+    /* Create an ID if the user did not specify one */
+    nd_id = g_strdup(qemu_opts_id(opts));
+    if (!nd_id) {
+        nd_id = g_strdup_printf("__org.qemu.nic%i\n", idx);
+        qemu_opts_set_id(opts, nd_id);
+    }
+
+    /* Handle MAC address */
+    mac = qemu_opt_get_del(opts, "mac");
+    if (mac) {
+        ret = net_parse_macaddr(ni->macaddr.a, mac);
+        g_free(mac);
+        if (ret) {
+            error_setg(errp, "invalid syntax for ethernet address");
+            return -1;
+        }
+        if (is_multicast_ether_addr(ni->macaddr.a)) {
+            error_setg(errp, "NIC cannot have multicast MAC address");
+            return -1;
+        }
+    }
+    qemu_macaddr_default_if_unset(&ni->macaddr);
+
+    ret = net_client_init(opts, true, errp);
+    if (ret == 0) {
+        ni->netdev = qemu_find_netdev(nd_id);
+        ni->used = true;
+        nb_nics++;
+    }
+
+    g_free(nd_id);
+    return ret;
+}
+
 int net_init_clients(Error **errp)
 {
     net_change_state_entry =
@@ -1474,6 +1535,10 @@ int net_init_clients(Error **errp)
         return -1;
     }
 
+    if (qemu_opts_foreach(qemu_find_opts("nic"), net_param_nic, NULL, errp)) {
+        return -1;
+    }
+
     if (qemu_opts_foreach(qemu_find_opts("net"), net_init_client, NULL, errp)) {
         return -1;
     }
@@ -1549,6 +1614,19 @@ QemuOptsList qemu_netdev_opts = {
     },
 };
 
+QemuOptsList qemu_nic_opts = {
+    .name = "nic",
+    .implied_opt_name = "type",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_nic_opts.head),
+    .desc = {
+        /*
+         * no elements => accept any params
+         * validation will happen later
+         */
+        { /* end of list */ }
+    },
+};
+
 QemuOptsList qemu_net_opts = {
     .name = "net",
     .implied_opt_name = "type",
diff --git a/qemu-options.hx b/qemu-options.hx
index 9ce0cfe..2a22a62 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2004,13 +2004,34 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
 #endif
     "-netdev hubport,id=str,hubid=n[,netdev=nd]\n"
     "                configure a hub port on QEMU VLAN 'n'\n", QEMU_ARCH_ALL)
+DEF("nic", HAS_ARG, QEMU_OPTION_nic,
+    "--nic [tap|bridge|"
+#ifdef CONFIG_SLIRP
+    "user|"
+#endif
+#ifdef __linux__
+    "l2tpv3|"
+#endif
+#ifdef CONFIG_VDE
+    "vde|"
+#endif
+#ifdef CONFIG_NETMAP
+    "netmap|"
+#endif
+#ifdef CONFIG_POSIX
+    "vhost-user|"
+#endif
+    "socket][,option][,...][mac=macaddr]\n"
+    "                initialize an on-board / default host NIC (using MAC address\n"
+    "                macaddr) and connect it to the given host network backend\n"
+    "--nic none      use it alone to have zero network devices (the default is to\n"
+    "                provided a 'user' network connection)\n",
+    QEMU_ARCH_ALL)
 DEF("net", HAS_ARG, QEMU_OPTION_net,
     "-net nic[,vlan=n][,netdev=nd][,macaddr=mac][,model=type][,name=str][,addr=str][,vectors=v]\n"
     "                configure or create an on-board (or machine default) NIC and\n"
     "                connect it either to VLAN 'n' or the netdev 'nd' (for pluggable\n"
     "                NICs please use '-device devtype,netdev=nd' instead)\n"
-    "-net none       use it alone to have zero network devices. If no -net option\n"
-    "                is provided, the default is '-net nic -net user'\n"
     "-net ["
 #ifdef CONFIG_SLIRP
     "user|"
@@ -2456,10 +2477,17 @@ qemu -m 512 -object memory-backend-file,id=mem,size=512M,mem-path=/hugetlbfs,sha
      -device virtio-net-pci,netdev=net0
 @end example
 
-@item -net none
-Indicate that no network devices should be configured. It is used to
-override the default configuration (@option{-net nic -net user}) which
-is activated if no @option{-net} options are provided.
+@item --nic [tap|bridge|user|l2tpv3|vde|netmap|vhost-user|socket][,...][,mac=macaddr]
+
+This option is a shortcut for setting both, the on-board (default) guest NIC
+hardware and the host network backend in one go. The host backend options are
+the same as with the corresponding @option{--netdev} option. The guest NIC
+hardware MAC address can be set with @option{mac=@var{macaddr}}.
+
+@item --nic none
+Indicate that no network devices should be configured. It is used to override
+the default configuration (default NIC with @option{--net user} backend) which
+is activated if no other networking options are provided.
 ETEXI
 
 STEXI
diff --git a/vl.c b/vl.c
index 1931621..d15985d 100644
--- a/vl.c
+++ b/vl.c
@@ -3091,6 +3091,7 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_chardev_opts);
     qemu_add_opts(&qemu_device_opts);
     qemu_add_opts(&qemu_netdev_opts);
+    qemu_add_opts(&qemu_nic_opts);
     qemu_add_opts(&qemu_net_opts);
     qemu_add_opts(&qemu_rtc_opts);
     qemu_add_opts(&qemu_global_opts);
@@ -3311,6 +3312,12 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
+            case QEMU_OPTION_nic:
+                default_net = 0;
+                if (net_client_parse(qemu_find_opts("nic"), optarg) == -1) {
+                    exit(1);
+                }
+                break;
             case QEMU_OPTION_net:
                 default_net = 0;
                 if (net_client_parse(qemu_find_opts("net"), optarg) == -1) {
-- 
2.7.4
