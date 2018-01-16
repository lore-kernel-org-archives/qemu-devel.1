Received: from eggs.gnu.org ([2001:4830:134:3::10]:43532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <root@devhost2.servers.provps.com>)
	id 1ebb51-0002w4-1n
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:55:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <root@devhost2.servers.provps.com>)
	id 1ebb4w-0004OU-TY
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:55:47 -0500
Received: from devhost2.servers.provps.com ([208.82.112.163]:43840)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <root@devhost2.servers.provps.com>)
	id 1ebb4w-0004Nt-Kj
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:55:42 -0500
From: Shaun Reitan <shaun.reitan@ndchost.com>
Date: Tue, 16 Jan 2018 15:18:24 -0800
Message-Id: <20180116231824.27114-1-shaun.reitan@ndchost.com>
Subject: [Qemu-devel] [PATCH] Add ability to provide ifname when using
 netdev bridge or tap helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Shaun Reitan <shaun.reitan@ndchost.com>

This patch replaces the patch I sent yesturday. This one fixes
a bug in my original code as well as corrects a few styling
issues. Hopfully this one comes out correct!  Sorry for the
inconvienece.
 
When currently using -netdev bridge or -netdev tap with a helper
you are unable to set an ifname. This patch adds that ability so
that you can now specify an ifname.

Signed-off-by: Shaun Reitan <shaun.reitan@ndchost.com>
---
 net/tap.c            | 33 ++++++++++++++++++++++++---------
 qapi/net.json        |  1 +
 qemu-bridge-helper.c | 11 +++++++++--
 qemu-options.hx      |  2 +-
 4 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 979e622..c4f3bb0 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -472,7 +472,7 @@ static int recv_fd(int c)
 }
 
 static int net_bridge_run_helper(const char *helper, const char *bridge,
-                                 Error **errp)
+                                 const char *ifname, Error **errp)
 {
     sigset_t oldmask, mask;
     int pid, status;
@@ -499,7 +499,9 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
         int open_max = sysconf(_SC_OPEN_MAX), i;
         char fd_buf[6+10];
         char br_buf[6+IFNAMSIZ] = {0};
-        char helper_cmd[PATH_MAX + sizeof(fd_buf) + sizeof(br_buf) + 15];
+        char ifname_buf[10 + IFNAMSIZ];
+        char helper_cmd[PATH_MAX + sizeof(fd_buf) + sizeof(br_buf)
+                        + sizeof(ifname_buf) + 16];
 
         for (i = 3; i < open_max; i++) {
             if (i != sv[1]) {
@@ -516,8 +518,13 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
                 snprintf(br_buf, sizeof(br_buf), "%s%s", "--br=", bridge);
             }
 
-            snprintf(helper_cmd, sizeof(helper_cmd), "%s %s %s %s",
-                     helper, "--use-vnet", fd_buf, br_buf);
+            if (strstr(helper, "--ifname=") == NULL && ifname != NULL) {
+                snprintf(ifname_buf, sizeof(ifname_buf), "%s%s", "--ifname=",
+                         ifname);
+            }
+
+            snprintf(helper_cmd, sizeof(helper_cmd), "%s %s %s %s %s",
+                     helper, "--use-vnet", fd_buf, br_buf, ifname_buf);
 
             parg = args;
             *parg++ = (char *)"sh";
@@ -536,6 +543,13 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
             *parg++ = (char *)"--use-vnet";
             *parg++ = fd_buf;
             *parg++ = br_buf;
+
+            if (ifname != NULL) {
+                snprintf(ifname_buf, sizeof(ifname_buf), "%s%s", "--ifname=",
+                         ifname);
+                *parg++ = ifname_buf;
+            }
+
             *parg++ = NULL;
 
             execv(helper, args);
@@ -586,7 +600,7 @@ int net_init_bridge(const Netdev *netdev, const char *name,
     helper = bridge->has_helper ? bridge->helper : DEFAULT_BRIDGE_HELPER;
     br     = bridge->has_br     ? bridge->br     : DEFAULT_BRIDGE_INTERFACE;
 
-    fd = net_bridge_run_helper(helper, br, errp);
+    fd = net_bridge_run_helper(helper, br, bridge->ifname, errp);
     if (fd == -1) {
         return -1;
     }
@@ -854,16 +868,17 @@ free_fail:
         g_free(vhost_fds);
         return -1;
     } else if (tap->has_helper) {
-        if (tap->has_ifname || tap->has_script || tap->has_downscript ||
-            tap->has_vnet_hdr || tap->has_queues || tap->has_vhostfds) {
-            error_setg(errp, "ifname=, script=, downscript=, vnet_hdr=, "
-                       "queues=, and vhostfds= are invalid with helper=");
+        if (tap->has_script || tap->has_downscript || tap->has_vnet_hdr ||
+            tap->has_queues || tap->has_vhostfds) {
+            error_setg(errp, "script=, downscript=, vnet_hdr=, queues=, and "
+                       "vhostfds= are invalid with helper=");
             return -1;
         }
 
         fd = net_bridge_run_helper(tap->helper,
                                    tap->has_br ?
                                    tap->br : DEFAULT_BRIDGE_INTERFACE,
+                                   tap->ifname,
                                    errp);
         if (fd == -1) {
             return -1;
diff --git a/qapi/net.json b/qapi/net.json
index 4beff5d..5b5b281 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -402,6 +402,7 @@
 { 'struct': 'NetdevBridgeOptions',
   'data': {
     '*br':     'str',
+    '*ifname': 'str',
     '*helper': 'str' } }
 
 ##
diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
index 5396fbf..7b01cd5 100644
--- a/qemu-bridge-helper.c
+++ b/qemu-bridge-helper.c
@@ -57,7 +57,7 @@ typedef QSIMPLEQ_HEAD(ACLList, ACLRule) ACLList;
 static void usage(void)
 {
     fprintf(stderr,
-            "Usage: qemu-bridge-helper [--use-vnet] --br=bridge --fd=unixfd\n");
+            "Usage: qemu-bridge-helper [--use-vnet] --br=bridge --fd=unixfd [--ifname=name]\n");
 }
 
 static int parse_acl_file(const char *filename, ACLList *acl_list)
@@ -223,6 +223,7 @@ int main(int argc, char **argv)
     int use_vnet = 0;
     int mtu;
     const char *bridge = NULL;
+    const char *ifname = NULL;
     char iface[IFNAMSIZ];
     int index;
     ACLRule *acl_rule;
@@ -249,6 +250,8 @@ int main(int argc, char **argv)
             bridge = &argv[index][5];
         } else if (strncmp(argv[index], "--fd=", 5) == 0) {
             unixfd = atoi(&argv[index][5]);
+        } else if (strncmp(argv[index], "--ifname=", 9) == 0) {
+            ifname = &argv[index][9];
         } else {
             usage();
             return EXIT_FAILURE;
@@ -320,7 +323,11 @@ int main(int argc, char **argv)
 
     /* request a tap device, disable PI, and add vnet header support if
      * requested and it's available. */
-    prep_ifreq(&ifr, "tap%d");
+    if (ifname == NULL) {
+        prep_ifreq(&ifr, "tap%d");
+    } else {
+        prep_ifreq(&ifr, ifname);
+    }
     ifr.ifr_flags = IFF_TAP|IFF_NO_PI;
     if (use_vnet && has_vnet_hdr(fd)) {
         ifr.ifr_flags |= IFF_VNET_HDR;
diff --git a/qemu-options.hx b/qemu-options.hx
index 678181c..81cbc3c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1961,7 +1961,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                use 'queues=n' to specify the number of queues to be created for multiqueue TAP\n"
     "                use 'poll-us=n' to speciy the maximum number of microseconds that could be\n"
     "                spent on busy polling for vhost net\n"
-    "-netdev bridge,id=str[,br=bridge][,helper=helper]\n"
+    "-netdev bridge,id=str[,br=bridge][,helper=helper][,ifname=name]\n"
     "                configure a host TAP network backend with ID 'str' that is\n"
     "                connected to a bridge (default=" DEFAULT_BRIDGE_INTERFACE ")\n"
     "                using the program 'helper (default=" DEFAULT_BRIDGE_HELPER ")\n"
-- 
2.9.5
