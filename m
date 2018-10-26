Received: from eggs.gnu.org ([2001:4830:134:3::10]:37621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <max7255@yandex-team.ru>) id 1gFpbn-0002vF-Nd
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 20:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <max7255@yandex-team.ru>) id 1gFpbm-0007er-66
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 20:04:11 -0400
Received: from forwardcorp1g.cmail.yandex.net ([2a02:6b8:0:1465::fd]:59678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <max7255@yandex-team.ru>)
	id 1gFpbk-0007da-0J
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 20:04:08 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::162])
	by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id D19CE21804
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 03:04:05 +0300 (MSK)
From: Maxim Samoylov <max7255@yandex-team.ru>
Date: Fri, 26 Oct 2018 03:03:43 +0300
Message-Id: <1540512223-21199-5-git-send-email-max7255@yandex-team.ru>
In-Reply-To: <1540512223-21199-1-git-send-email-max7255@yandex-team.ru>
References: <1540512223-21199-1-git-send-email-max7255@yandex-team.ru>
Subject: [Qemu-devel] [PATCH RFC 4/4] net/slirp: add ipv6-hostfwd option for
 user netdev type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: max7255@yandex-team.ru

This allows forwarding TCP6 and UDP6 connections down to
netdev=user connected guests.

Signed-off-by: Maxim Samoylov <max7255@yandex-team.ru>
---
 hmp-commands.hx     |  31 ++++++++
 include/net/slirp.h |   2 +
 net/slirp.c         | 214 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/net.json       |   3 +-
 4 files changed, 249 insertions(+), 1 deletion(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index db0c681..b0e1a08 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1448,6 +1448,37 @@ STEXI
 Remove host-to-guest TCP or UDP redirection.
 ETEXI
 
+#ifdef CONFIG_SLIRP
+    {
+        .name       = "ipv6_hostfwd_add",
+        .args_type  = "arg1:s,arg2:s?,arg3:s?",
+        .params     = "[hub_id name]|[netdev_id] [tcp|udp]:[hostaddr6]:hostport-guestaddr6:guestport",
+        .help       = "redirect TCP6 or UDP6 connections from host to guest (requires -net user)",
+        .cmd        = hmp_ipv6_hostfwd_add,
+    },
+#endif
+STEXI
+@item hostfwd_add
+@findex hostfwd_add
+Redirect TCP6 or UDP6 connections from host to guest (requires -net user).
+ETEXI
+
+#ifdef CONFIG_SLIRP
+    {
+        .name       = "ipv6_hostfwd_remove",
+        .args_type  = "arg1:s,arg2:s?,arg3:s?",
+        .params     = "[hub_id name]|[netdev_id] [tcp|udp]:[hostaddr6]:hostport",
+        .help       = "remove host-to-guest TCP6 or UDP6 redirection",
+        .cmd        = hmp_ipv6_hostfwd_remove,
+    },
+
+#endif
+STEXI
+@item hostfwd_remove
+@findex hostfwd_remove
+Remove host-to-guest TCP6 or UDP6 redirection.
+ETEXI
+
     {
         .name       = "balloon",
         .args_type  = "value:M",
diff --git a/include/net/slirp.h b/include/net/slirp.h
index bad3e1e..4796a5c 100644
--- a/include/net/slirp.h
+++ b/include/net/slirp.h
@@ -29,6 +29,8 @@
 
 void hmp_hostfwd_add(Monitor *mon, const QDict *qdict);
 void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict);
+void hmp_ipv6_hostfwd_add(Monitor *mon, const QDict *qdict);
+void hmp_ipv6_hostfwd_remove(Monitor *mon, const QDict *qdict);
 
 void hmp_info_usernet(Monitor *mon, const QDict *qdict);
 
diff --git a/net/slirp.c b/net/slirp.c
index f6dc039..abe112b 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -67,6 +67,7 @@ static int get_str_sep(char *buf, int buf_size, const char **pp, int sep)
 /* slirp network adapter */
 
 #define SLIRP_CFG_HOSTFWD 1
+#define SLIRP_CFG_IPV6_HOSTFWD 2
 
 struct slirp_config_str {
     struct slirp_config_str *next;
@@ -89,6 +90,8 @@ static QTAILQ_HEAD(slirp_stacks, SlirpState) slirp_stacks =
     QTAILQ_HEAD_INITIALIZER(slirp_stacks);
 
 static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp);
+static int slirp_ipv6_hostfwd(SlirpState *s, const char *redir_str,
+                              Error **errp);
 static int slirp_guestfwd(SlirpState *s, const char *config_str, Error **errp);
 
 #ifndef _WIN32
@@ -386,6 +389,10 @@ static int net_slirp_init(NetClientState *peer, const char *model,
             if (slirp_hostfwd(s, config->str, errp) < 0) {
                 goto error;
             }
+        } else if (config->flags & SLIRP_CFG_IPV6_HOSTFWD) {
+            if (slirp_ipv6_hostfwd(s, config->str, errp) < 0) {
+                goto error;
+            }
         } else {
             if (slirp_guestfwd(s, config->str, errp) < 0) {
                 goto error;
@@ -504,6 +511,73 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "invalid format\n");
 }
 
+void hmp_ipv6_hostfwd_remove(Monitor *mon, const QDict *qdict)
+{
+    struct in6_addr host_addr = in6addr_any;
+    int host_port;
+    char buf[256];
+    const char *src_str, *p;
+    SlirpState *s;
+    int is_udp = 0;
+    int err;
+    const char *arg1 = qdict_get_str(qdict, "arg1");
+    const char *arg2 = qdict_get_try_str(qdict, "arg2");
+    const char *arg3 = qdict_get_try_str(qdict, "arg3");
+
+    if (arg2) {
+        s = slirp_lookup(mon, arg1, arg2);
+        src_str = arg3;
+    } else {
+        s = slirp_lookup(mon, NULL, NULL);
+        src_str = arg1;
+    }
+    if (!s) {
+        return;
+    }
+
+    p = src_str;
+    if (!p || get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+        goto fail_syntax;
+    }
+
+    if (!strcmp(buf, "tcp") || buf[0] == '\0') {
+        is_udp = 0;
+    } else if (!strcmp(buf, "udp")) {
+        is_udp = 1;
+    } else {
+        goto fail_syntax;
+    }
+
+    if (*(p++) != '[') {
+        goto fail_syntax;
+    }
+
+    if (get_str_sep(buf, sizeof(buf), &p, ']') < 0) {
+        goto fail_syntax;
+    }
+
+    if (!inet_pton(AF_INET6, buf, &host_addr)) {
+        goto fail_syntax;
+    }
+
+    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+        goto fail_syntax;
+    }
+
+    if (qemu_strtoi(p, NULL, 10, &host_port) < 0) {
+        goto fail_syntax;
+    }
+
+    err = slirp_remove_ipv6_hostfwd(s->slirp, is_udp, host_addr, host_port);
+
+    monitor_printf(mon, "host forwarding rule for %s %s\n", src_str,
+                   err ? "not found" : "removed");
+    return;
+
+ fail_syntax:
+    monitor_printf(mon, "invalid format\n");
+}
+
 static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
 {
     struct in_addr host_addr = { .s_addr = INADDR_ANY };
@@ -577,6 +651,119 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
     return -1;
 }
 
+static int slirp_ipv6_hostfwd(SlirpState *s, const char *redir_str,
+                              Error **errp)
+{
+    struct in6_addr host_addr = in6addr_any;
+    struct in6_addr guest_addr;
+    int host_port, guest_port;
+    const char *p;
+    char buf[256];
+    int is_udp;
+    const char *end;
+    const char *fail_reason = "Unknown reason";
+
+    memset(&guest_addr, 0, sizeof(guest_addr));
+
+    p = redir_str;
+    if (!p || get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+        fail_reason = "No : separators";
+        goto fail_syntax;
+    }
+    if (!strcmp(buf, "tcp") || buf[0] == '\0') {
+        is_udp = 0;
+    } else if (!strcmp(buf, "udp")) {
+        is_udp = 1;
+    } else {
+        fail_reason = "Bad protocol name";
+        goto fail_syntax;
+    }
+
+    if (*(p++) != '[') {
+        fail_reason = "IPv6 address must be enclosed in square brackets";
+        goto fail_syntax;
+    }
+
+    if (get_str_sep(buf, sizeof(buf), &p, ']') < 0) {
+        fail_reason = "IPv6 address must be enclosed in square brackets";
+        goto fail_syntax;
+    }
+
+    if (!inet_pton(AF_INET6, buf, &host_addr)) {
+        fail_reason = "Bad host address";
+        goto fail_syntax;
+    }
+
+    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0 ||
+        buf[0] != '\0') {
+        fail_reason = "Bad ipv6 address and port separator";
+        goto fail_syntax;
+    }
+
+    if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
+        fail_reason = "Bad host port separator";
+        goto fail_syntax;
+    }
+
+    if (qemu_strtoi(buf, &end, 0, &host_port)) {
+        fail_reason = "Bad host port";
+        goto fail_syntax;
+    }
+
+    if (*end != '\0' || host_port < 0 || host_port > 65535) {
+        fail_reason = "Host port out of range";
+        goto fail_syntax;
+    }
+
+    if (*p == '\0') {
+        fail_reason = "Missing guest ipv6 address";
+        goto fail_syntax;
+    }
+
+    if (*(p++) != '[') {
+        fail_reason = "IPv6 address must be enclosed in square brackets";
+        goto fail_syntax;
+    }
+
+    if (get_str_sep(buf, sizeof(buf), &p,  ']') < 0) {
+        fail_reason = "IPv6 address must be enclosed in square brackets";
+        goto fail_syntax;
+    }
+
+    if (!inet_pton(AF_INET6, buf, &guest_addr)) {
+        fail_reason = "Bad guest address";
+        goto fail_syntax;
+    }
+
+    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0 || buf[0] != '\0') {
+        fail_reason = "Bad ipv6 address and port separator";
+        goto fail_syntax;
+    }
+
+    if (qemu_strtoi(p, &end, 0, &guest_port) < 0) {
+        fail_reason = "Bad guest port";
+        goto fail_syntax;
+    }
+
+    if (*end != '\0' || guest_port < 1 || guest_port > 65535) {
+        fail_reason = "Guest port number out of range";
+        goto fail_syntax;
+    }
+
+    if (slirp_add_ipv6_hostfwd(s->slirp, is_udp, host_addr, host_port,
+                               guest_addr, guest_port) < 0) {
+        error_report("could not set up host forwarding rule '%s'",
+                     redir_str);
+        return -1;
+    }
+    return 0;
+
+ fail_syntax:
+    error_setg(errp, "Invalid host forwarding rule '%s' (%s)", redir_str,
+               fail_reason);
+    return -1;
+}
+
 void hmp_hostfwd_add(Monitor *mon, const QDict *qdict)
 {
     const char *redir_str;
@@ -604,6 +791,32 @@ void hmp_hostfwd_add(Monitor *mon, const QDict *qdict)
 
 }
 
+void hmp_ipv6_hostfwd_add(Monitor *mon, const QDict *qdict)
+{
+    const char *redir_str;
+    SlirpState *s;
+    const char *arg1 = qdict_get_str(qdict, "arg1");
+    const char *arg2 = qdict_get_try_str(qdict, "arg2");
+    const char *arg3 = qdict_get_try_str(qdict, "arg3");
+
+    if (arg2) {
+        s = slirp_lookup(mon, arg1, arg2);
+        redir_str = arg3;
+    } else if (arg2) {
+        s = slirp_lookup(mon, NULL, arg1);
+        redir_str = arg2;
+    } else {
+        s = slirp_lookup(mon, NULL, NULL);
+        redir_str = arg1;
+    }
+    if (s) {
+        Error *err = NULL;
+        if (slirp_ipv6_hostfwd(s, redir_str, &err) < 0) {
+            error_report_err(err);
+        }
+    }
+}
+
 #ifndef _WIN32
 
 /* automatic user mode samba server configuration */
@@ -906,6 +1119,7 @@ int net_init_slirp(const Netdev *netdev, const char *name,
     /* all optional fields are initialized to "all bits zero" */
 
     net_init_slirp_configs(user->hostfwd, SLIRP_CFG_HOSTFWD);
+    net_init_slirp_configs(user->ipv6_hostfwd, SLIRP_CFG_IPV6_HOSTFWD);
     net_init_slirp_configs(user->guestfwd, 0);
 
     ret = net_slirp_init(peer, "user", name, user->q_restrict,
diff --git a/qapi/net.json b/qapi/net.json
index 8f99fd9..4f67caf 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -201,7 +201,8 @@
     '*smbserver': 'str',
     '*hostfwd':   ['String'],
     '*guestfwd':  ['String'],
-    '*tftp-server-name': 'str' } }
+    '*tftp-server-name': 'str',
+    '*ipv6-hostfwd': ['String']} }
 
 ##
 # @NetdevTapOptions:
-- 
2.7.4
