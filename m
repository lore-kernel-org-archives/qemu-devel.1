Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F3CC35257
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC1A216C4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="WDuBh+ts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC1A216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKRQP-0006Bt-B6
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 15:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kKRLZ-0000t2-Qk
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:19:33 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:41160)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kKRLW-0004Ge-3K
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:19:33 -0400
Received: from myt5-23f0be3aa648.qloud-c.yandex.net
 (myt5-23f0be3aa648.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 26CB92E14A6;
 Mon, 21 Sep 2020 22:19:28 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net
 (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
 by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 GCuVspIWjN-JRv0QbnN; Mon, 21 Sep 2020 22:19:28 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1600715968; bh=GapSdVC25AKC2CflXFewfNPi5RsPJU8VltPmNwjWpgU=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=WDuBh+tswRaNP/K/LS2FVN4ou7jFOubzfsmUTRBpO0ehI6TttMi5lItwFMwpyLTAe
 9d/PdYxttgaRrZWKYpjuln2U/PphXithCrmYnXcruHBXoR4RpgpLDhnTZUpGDlpMem
 QrwsBqCmnk5Z0fy1J7VoBu3gljRhZf934tMokmeM=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:6416::1:4])
 by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 3Nc4XKVFl3-JQl4pgJE; Mon, 21 Sep 2020 22:19:27 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Kirillov <lekiravi@yandex-team.ru>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 1/4] qapi: net: Add query-netdev command
Date: Mon, 21 Sep 2020 22:19:09 +0300
Message-Id: <20200921191912.105305-2-lekiravi@yandex-team.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921191912.105305-1-lekiravi@yandex-team.ru>
References: <20200921191912.105305-1-lekiravi@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=77.88.29.217;
 envelope-from=lekiravi@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 15:19:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Vincenzo Maffione <v.maffione@gmail.com>, yc-core@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a qmp command that provides information about currently attached
backend network devices and their configuration.

Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
---
 include/net/net.h |   1 +
 net/l2tpv3.c      |  19 +++++++
 net/net.c         |  32 ++++++++++++
 net/netmap.c      |  13 +++++
 net/slirp.c       | 126 ++++++++++++++++++++++++++++++++++++++++++++++
 net/socket.c      |  71 ++++++++++++++++++++++++++
 net/tap-win32.c   |   9 ++++
 net/tap.c         | 103 +++++++++++++++++++++++++++++++++++--
 net/vde.c         |  26 ++++++++++
 net/vhost-user.c  |  18 +++++--
 net/vhost-vdpa.c  |  14 ++++++
 qapi/net.json     |  80 +++++++++++++++++++++++++++++
 12 files changed, 504 insertions(+), 8 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index e7ef42d62b..04d51ac215 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -92,6 +92,7 @@ struct NetClientState {
     char *model;
     char *name;
     char info_str[256];
+    NetdevInfo *stored_config;
     unsigned receive_disabled : 1;
     NetClientDestructor *destructor;
     unsigned int queue_index;
diff --git a/net/l2tpv3.c b/net/l2tpv3.c
index 55fea17c0f..881fc6f7c1 100644
--- a/net/l2tpv3.c
+++ b/net/l2tpv3.c
@@ -535,6 +535,7 @@ int net_init_l2tpv3(const Netdev *netdev,
     struct addrinfo hints;
     struct addrinfo *result = NULL;
     char *srcport, *dstport;
+    NetdevL2TPv3Options *stored;
 
     nc = qemu_new_net_client(&net_l2tpv3_info, peer, "l2tpv3", name);
 
@@ -726,6 +727,24 @@ int net_init_l2tpv3(const Netdev *netdev,
 
     l2tpv3_read_poll(s, true);
 
+    /* Store startup parameters */
+    nc->stored_config = g_new0(NetdevInfo, 1);
+    nc->stored_config->type = NET_BACKEND_L2TPV3;
+    stored = &nc->stored_config->u.l2tpv3;
+
+    memcpy(stored, l2tpv3, sizeof(NetdevL2TPv3Options));
+
+    stored->src = g_strdup(l2tpv3->src);
+    stored->dst = g_strdup(l2tpv3->dst);
+
+    if (l2tpv3->has_srcport) {
+        stored->srcport = g_strdup(l2tpv3->srcport);
+    }
+
+    if (l2tpv3->has_dstport) {
+        stored->dstport = g_strdup(l2tpv3->dstport);
+    }
+
     snprintf(s->nc.info_str, sizeof(s->nc.info_str),
              "l2tpv3: connected");
     return 0;
diff --git a/net/net.c b/net/net.c
index 7a2a0fb5ac..ae4ca52c13 100644
--- a/net/net.c
+++ b/net/net.c
@@ -54,6 +54,7 @@
 #include "sysemu/sysemu.h"
 #include "net/filter.h"
 #include "qapi/string-output-visitor.h"
+#include "qapi/clone-visitor.h"
 
 /* Net bridge is currently not supported for W32. */
 #if !defined(_WIN32)
@@ -351,6 +352,7 @@ static void qemu_free_net_client(NetClientState *nc)
     }
     g_free(nc->name);
     g_free(nc->model);
+    qapi_free_NetdevInfo(nc->stored_config);
     if (nc->destructor) {
         nc->destructor(nc);
     }
@@ -1250,6 +1252,36 @@ RxFilterInfoList *qmp_query_rx_filter(bool has_name, const char *name,
     return filter_list;
 }
 
+NetdevInfoList *qmp_query_netdev(Error **errp)
+{
+    NetdevInfoList *list = NULL;
+    NetClientState *nc;
+
+    QTAILQ_FOREACH(nc, &net_clients, next) {
+        /*
+         * Only look at netdevs (backend network devices), not for each queue
+         * or NIC / hubport
+         */
+        if (nc->stored_config) {
+            NetdevInfoList *node = g_new0(NetdevInfoList, 1);
+
+            node->value = QAPI_CLONE(NetdevInfo, nc->stored_config);
+            g_free(node->value->id); /* Need to dealloc default empty id */
+            node->value->id = g_strdup(nc->name);
+
+            node->value->has_peer_id = nc->peer != NULL;
+            if (node->value->has_peer_id) {
+                node->value->peer_id = g_strdup(nc->peer->name);
+            }
+
+            node->next = list;
+            list = node;
+        }
+    }
+
+    return list;
+}
+
 void hmp_info_network(Monitor *mon, const QDict *qdict)
 {
     NetClientState *nc, *peer;
diff --git a/net/netmap.c b/net/netmap.c
index 350f097f91..b6087fdb7c 100644
--- a/net/netmap.c
+++ b/net/netmap.c
@@ -411,6 +411,7 @@ int net_init_netmap(const Netdev *netdev,
     NetClientState *nc;
     Error *err = NULL;
     NetmapState *s;
+    NetdevNetmapOptions *stored;
 
     nmd = netmap_open(netmap_opts, &err);
     if (err) {
@@ -427,6 +428,18 @@ int net_init_netmap(const Netdev *netdev,
     pstrcpy(s->ifname, sizeof(s->ifname), netmap_opts->ifname);
     netmap_read_poll(s, true); /* Initially only poll for reads. */
 
+    /* Store startup parameters */
+    nc->stored_config = g_new0(NetdevInfo, 1);
+    nc->stored_config->type = NET_BACKEND_NETMAP;
+    stored = &nc->stored_config->u.netmap;
+
+    stored->ifname = g_strdup(netmap_opts->ifname);
+
+    if (netmap_opts->has_devname) {
+        stored->has_devname = true;
+        stored->devname = g_strdup(netmap_opts->devname);
+    }
+
     return 0;
 }
 
diff --git a/net/slirp.c b/net/slirp.c
index 77042e6df7..65d3f2639c 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -346,6 +346,14 @@ static SaveVMHandlers savevm_slirp_state = {
     .load_state = net_slirp_state_load,
 };
 
+#define APPEND_STRINGLIST(tail, new_val) \
+    do { \
+        *(tail) = g_new0(StringList, 1); \
+        (*(tail))->value = g_new0(String, 1); \
+        (*(tail))->value->str = g_strdup((new_val)); \
+        (tail) = &((*(tail))->next); \
+    } while (0)
+
 static int net_slirp_init(NetClientState *peer, const char *model,
                           const char *name, int restricted,
                           bool ipv4, const char *vnetwork, const char *vhost,
@@ -378,6 +386,9 @@ static int net_slirp_init(NetClientState *peer, const char *model,
     int shift;
     char *end;
     struct slirp_config_str *config;
+    NetdevUserOptions *stored;
+    StringList **stored_hostfwd;
+    StringList **stored_guestfwd;
 
     if (!ipv4 && (vnetwork || vhost || vnameserver)) {
         error_setg(errp, "IPv4 disabled but netmask/host/dns provided");
@@ -553,6 +564,112 @@ static int net_slirp_init(NetClientState *peer, const char *model,
 
     nc = qemu_new_net_client(&net_slirp_info, peer, model, name);
 
+    /* Store startup parameters */
+    nc->stored_config = g_new0(NetdevInfo, 1);
+    nc->stored_config->type = NET_BACKEND_USER;
+    stored = &nc->stored_config->u.user;
+
+    if (vhostname) {
+        stored->has_hostname = true;
+        stored->hostname = g_strdup(vhostname);
+    }
+
+    stored->has_q_restrict = true;
+    stored->q_restrict = restricted;
+
+    stored->has_ipv4 = true;
+    stored->ipv4 = ipv4;
+
+    stored->has_ipv6 = true;
+    stored->ipv6 = ipv6;
+
+    if (ipv4) {
+        uint8_t *net_bytes = (uint8_t *)&net;
+        uint8_t *mask_bytes = (uint8_t *)&mask;
+
+        stored->has_net = true;
+        stored->net = g_strdup_printf("%d.%d.%d.%d/%d.%d.%d.%d",
+                                      net_bytes[0], net_bytes[1],
+                                      net_bytes[2], net_bytes[3],
+                                      mask_bytes[0], mask_bytes[1],
+                                      mask_bytes[2], mask_bytes[3]);
+
+        stored->has_host = true;
+        stored->host = g_strdup(inet_ntoa(host));
+    }
+
+    if (tftp_export) {
+        stored->has_tftp = true;
+        stored->tftp = g_strdup(tftp_export);
+    }
+
+    if (bootfile) {
+        stored->has_bootfile = true;
+        stored->bootfile = g_strdup(bootfile);
+    }
+
+    if (vdhcp_start) {
+        stored->has_dhcpstart = true;
+        stored->dhcpstart = g_strdup(vdhcp_start);
+    }
+
+    if (ipv4) {
+        stored->has_dns = true;
+        stored->dns = g_strdup(inet_ntoa(dns));
+    }
+
+    if (dnssearch) {
+        stored->has_dnssearch = true;
+        StringList **stored_list = &stored->dnssearch;
+
+        for (int i = 0; dnssearch[i]; i++) {
+            APPEND_STRINGLIST(stored_list, dnssearch[i]);
+        }
+    }
+
+    if (vdomainname) {
+        stored->has_domainname = true;
+        stored->domainname = g_strdup(vdomainname);
+    }
+
+    if (ipv6) {
+        char addrstr[INET6_ADDRSTRLEN];
+        const char *res;
+
+        stored->has_ipv6_prefix = true;
+        stored->ipv6_prefix = g_strdup(vprefix6);
+
+        stored->has_ipv6_prefixlen = true;
+        stored->ipv6_prefixlen = vprefix6_len;
+
+        res = inet_ntop(AF_INET6, &ip6_host,
+                        addrstr, sizeof(addrstr));
+
+        stored->has_ipv6_host = true;
+        stored->ipv6_host = g_strdup(res);
+
+        res = inet_ntop(AF_INET6, &ip6_dns,
+                        addrstr, sizeof(addrstr));
+
+        stored->has_ipv6_dns = true;
+        stored->ipv6_dns = g_strdup(res);
+    }
+
+    if (smb_export) {
+        stored->has_smb = true;
+        stored->smb = g_strdup(smb_export);
+    }
+
+    if (vsmbserver) {
+        stored->has_smbserver = true;
+        stored->smbserver = g_strdup(vsmbserver);
+    }
+
+    if (tftp_server_name) {
+        stored->has_tftp_server_name = true;
+        stored->tftp_server_name = g_strdup(tftp_server_name);
+    }
+
     snprintf(nc->info_str, sizeof(nc->info_str),
              "net=%s,restrict=%s", inet_ntoa(net),
              restricted ? "on" : "off");
@@ -582,14 +699,23 @@ static int net_slirp_init(NetClientState *peer, const char *model,
     s->poll_notifier.notify = net_slirp_poll_notify;
     main_loop_poll_add_notifier(&s->poll_notifier);
 
+    stored_hostfwd = &stored->hostfwd;
+    stored_guestfwd = &stored->guestfwd;
+
     for (config = slirp_configs; config; config = config->next) {
         if (config->flags & SLIRP_CFG_HOSTFWD) {
             if (slirp_hostfwd(s, config->str, errp) < 0) {
                 goto error;
+            } else {
+                stored->has_hostfwd = true;
+                APPEND_STRINGLIST(stored_hostfwd, config->str);
             }
         } else {
             if (slirp_guestfwd(s, config->str, errp) < 0) {
                 goto error;
+            } else {
+                stored->has_guestfwd = true;
+                APPEND_STRINGLIST(stored_guestfwd, config->str);
             }
         }
     }
diff --git a/net/socket.c b/net/socket.c
index 2d21fddd9c..b70bd2df94 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -342,6 +342,7 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
     NetSocketState *s;
     SocketAddress *sa;
     SocketAddressType sa_type;
+    NetdevSocketOptions *stored;
 
     sa = socket_local_address(fd, errp);
     if (!sa) {
@@ -385,8 +386,19 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
     net_socket_rs_init(&s->rs, net_socket_rs_finalize, false);
     net_socket_read_poll(s, true);
 
+    /* Store startup parameters */
+    nc->stored_config = g_new0(NetdevInfo, 1);
+    nc->stored_config->type = NET_BACKEND_SOCKET;
+    stored = &nc->stored_config->u.socket;
+
+    stored->has_fd = true;
+    stored->fd = g_strdup_printf("%d", fd);
+
     /* mcast: save bound address as dst */
     if (is_connected && mcast != NULL) {
+        stored->has_mcast = true;
+        stored->mcast = g_strdup(mcast);
+
         s->dgram_dst = saddr;
         snprintf(nc->info_str, sizeof(nc->info_str),
                  "socket: fd=%d (cloned mcast=%s:%d)",
@@ -428,6 +440,7 @@ static NetSocketState *net_socket_fd_init_stream(NetClientState *peer,
 {
     NetClientState *nc;
     NetSocketState *s;
+    NetdevSocketOptions *stored;
 
     nc = qemu_new_net_client(&net_socket_info, peer, model, name);
 
@@ -447,6 +460,15 @@ static NetSocketState *net_socket_fd_init_stream(NetClientState *peer,
     } else {
         qemu_set_fd_handler(s->fd, NULL, net_socket_connect, s);
     }
+
+    /* Store startup parameters */
+    nc->stored_config = g_new0(NetdevInfo, 1);
+    nc->stored_config->type = NET_BACKEND_SOCKET;
+    stored = &nc->stored_config->u.socket;
+
+    stored->has_fd = true;
+    stored->fd = g_strdup_printf("%d", fd);
+
     return s;
 }
 
@@ -483,6 +505,7 @@ static void net_socket_accept(void *opaque)
     struct sockaddr_in saddr;
     socklen_t len;
     int fd;
+    NetdevSocketOptions *stored;
 
     for(;;) {
         len = sizeof(saddr);
@@ -498,6 +521,13 @@ static void net_socket_accept(void *opaque)
     s->fd = fd;
     s->nc.link_down = false;
     net_socket_connect(s);
+
+    /* Store additional startup parameters (extend net_socket_listen_init) */
+    stored = &s->nc.stored_config->u.socket;
+
+    stored->has_fd = true;
+    stored->fd = g_strdup_printf("%d", fd);
+
     snprintf(s->nc.info_str, sizeof(s->nc.info_str),
              "socket: connection from %s:%d",
              inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
@@ -513,6 +543,7 @@ static int net_socket_listen_init(NetClientState *peer,
     NetSocketState *s;
     struct sockaddr_in saddr;
     int fd, ret;
+    NetdevSocketOptions *stored;
 
     if (parse_host_port(&saddr, host_str, errp) < 0) {
         return -1;
@@ -549,6 +580,15 @@ static int net_socket_listen_init(NetClientState *peer,
     net_socket_rs_init(&s->rs, net_socket_rs_finalize, false);
 
     qemu_set_fd_handler(s->listen_fd, net_socket_accept, NULL, s);
+
+    /* Store startup parameters */
+    nc->stored_config = g_new0(NetdevInfo, 1);
+    nc->stored_config->type = NET_BACKEND_SOCKET;
+    stored = &nc->stored_config->u.socket;
+
+    stored->has_listen = true;
+    stored->listen = g_strdup(host_str);
+
     return 0;
 }
 
@@ -561,6 +601,7 @@ static int net_socket_connect_init(NetClientState *peer,
     NetSocketState *s;
     int fd, connected, ret;
     struct sockaddr_in saddr;
+    NetdevSocketOptions *stored;
 
     if (parse_host_port(&saddr, host_str, errp) < 0) {
         return -1;
@@ -598,6 +639,12 @@ static int net_socket_connect_init(NetClientState *peer,
         return -1;
     }
 
+    /* Store additional startup parameters (extend net_socket_fd_init) */
+    stored = &s->nc.stored_config->u.socket;
+
+    stored->has_connect = true;
+    stored->connect = g_strdup(host_str);
+
     snprintf(s->nc.info_str, sizeof(s->nc.info_str),
              "socket: connect to %s:%d",
              inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
@@ -615,6 +662,7 @@ static int net_socket_mcast_init(NetClientState *peer,
     int fd;
     struct sockaddr_in saddr;
     struct in_addr localaddr, *param_localaddr;
+    NetdevSocketOptions *stored;
 
     if (parse_host_port(&saddr, host_str, errp) < 0) {
         return -1;
@@ -643,6 +691,19 @@ static int net_socket_mcast_init(NetClientState *peer,
 
     s->dgram_dst = saddr;
 
+    /* Store additional startup parameters (extend net_socket_fd_init) */
+    stored = &s->nc.stored_config->u.socket;
+
+    if (!stored->has_mcast) {
+        stored->has_mcast = true;
+        stored->mcast = g_strdup(host_str);
+    }
+
+    if (localaddr_str) {
+        stored->has_localaddr = true;
+        stored->localaddr = g_strdup(localaddr_str);
+    }
+
     snprintf(s->nc.info_str, sizeof(s->nc.info_str),
              "socket: mcast=%s:%d",
              inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
@@ -660,6 +721,7 @@ static int net_socket_udp_init(NetClientState *peer,
     NetSocketState *s;
     int fd, ret;
     struct sockaddr_in laddr, raddr;
+    NetdevSocketOptions *stored;
 
     if (parse_host_port(&laddr, lhost, errp) < 0) {
         return -1;
@@ -698,6 +760,15 @@ static int net_socket_udp_init(NetClientState *peer,
 
     s->dgram_dst = raddr;
 
+    /* Store additional startup parameters (extend net_socket_fd_init) */
+    stored = &s->nc.stored_config->u.socket;
+
+    stored->has_localaddr = true;
+    stored->localaddr = g_strdup(lhost);
+
+    stored->has_udp = true;
+    stored->udp = g_strdup(rhost);
+
     snprintf(s->nc.info_str, sizeof(s->nc.info_str),
              "socket: udp=%s:%d",
              inet_ntoa(raddr.sin_addr), ntohs(raddr.sin_port));
diff --git a/net/tap-win32.c b/net/tap-win32.c
index 2b5dcda36e..b60933bd1a 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -768,6 +768,7 @@ static int tap_win32_init(NetClientState *peer, const char *model,
     NetClientState *nc;
     TAPState *s;
     tap_win32_overlapped_t *handle;
+    NetdevTapOptions *stored;
 
     if (tap_win32_open(&handle, ifname) < 0) {
         printf("tap: Could not open '%s'\n", ifname);
@@ -778,6 +779,14 @@ static int tap_win32_init(NetClientState *peer, const char *model,
 
     s = DO_UPCAST(TAPState, nc, nc);
 
+    /* Store startup parameters */
+    nc->stored_config = g_new0(NetdevInfo, 1);
+    nc->stored_config->type = NET_BACKEND_TAP;
+    stored = &nc->stored_config->u.tap;
+
+    stored->has_ifname = true;
+    stored->ifname = g_strdup(ifname);
+
     snprintf(s->nc.info_str, sizeof(s->nc.info_str),
              "tap: ifname=%s", ifname);
 
diff --git a/net/tap.c b/net/tap.c
index 14dc904fca..14bdd92a9a 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -585,6 +585,7 @@ int net_init_bridge(const Netdev *netdev, const char *name,
     const char *helper, *br;
     TAPState *s;
     int fd, vnet_hdr;
+    NetdevBridgeOptions *stored;
 
     assert(netdev->type == NET_CLIENT_DRIVER_BRIDGE);
     bridge = &netdev->u.bridge;
@@ -605,6 +606,21 @@ int net_init_bridge(const Netdev *netdev, const char *name,
     }
     s = net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr);
 
+    /* Store startup parameters */
+    s->nc.stored_config = g_new0(NetdevInfo, 1);
+    s->nc.stored_config->type = NET_BACKEND_BRIDGE;
+    stored = &s->nc.stored_config->u.bridge;
+
+    if (br) {
+        stored->has_br = true;
+        stored->br = g_strdup(br);
+    }
+
+    if (helper) {
+        stored->has_helper = true;
+        stored->helper = g_strdup(helper);
+    }
+
     snprintf(s->nc.info_str, sizeof(s->nc.info_str), "helper=%s,br=%s", helper,
              br);
 
@@ -652,11 +668,13 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              const char *model, const char *name,
                              const char *ifname, const char *script,
                              const char *downscript, const char *vhostfdname,
-                             int vnet_hdr, int fd, Error **errp)
+                             int vnet_hdr, int fd, NetdevInfo **common_stored,
+                             Error **errp)
 {
     Error *err = NULL;
     TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
     int vhostfd;
+    NetdevTapOptions *stored;
 
     tap_set_sndbuf(s->fd, tap, &err);
     if (err) {
@@ -664,12 +682,65 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         return;
     }
 
+    /* Store startup parameters */
+    if (!*common_stored) {
+        *common_stored = g_new0(NetdevInfo, 1);
+        (*common_stored)->type = NET_BACKEND_TAP;
+        s->nc.stored_config = *common_stored;
+    }
+    stored = &(*common_stored)->u.tap;
+
+    if (tap->has_sndbuf && !stored->has_sndbuf) {
+        stored->has_sndbuf = true;
+        stored->sndbuf = tap->sndbuf;
+    }
+
+    if (vnet_hdr && !stored->has_vnet_hdr) {
+        stored->has_vnet_hdr = true;
+        stored->vnet_hdr = true;
+    }
+
     if (tap->has_fd || tap->has_fds) {
+        if (!stored->has_fds) {
+            stored->has_fds = true;
+            stored->fds = g_strdup_printf("%d", fd);
+        } else {
+            char *tmp_s = stored->fds;
+            stored->fds = g_strdup_printf("%s:%d", stored->fds, fd);
+            g_free(tmp_s);
+        }
+
         snprintf(s->nc.info_str, sizeof(s->nc.info_str), "fd=%d", fd);
     } else if (tap->has_helper) {
+        if (!stored->has_helper) {
+            stored->has_helper = true;
+            stored->helper = g_strdup(tap->helper);
+        }
+
+        if (!stored->has_br) {
+            stored->has_br = true;
+            stored->br = tap->has_br ? g_strdup(tap->br) :
+                                       g_strdup(DEFAULT_BRIDGE_INTERFACE);
+        }
+
         snprintf(s->nc.info_str, sizeof(s->nc.info_str), "helper=%s",
                  tap->helper);
     } else {
+        if (ifname && !stored->has_ifname) {
+            stored->has_ifname = true;
+            stored->ifname = g_strdup(ifname);
+        }
+
+        if (script && !stored->has_script) {
+            stored->has_script = true;
+            stored->script = g_strdup(script);
+        }
+
+        if (downscript && !stored->has_downscript) {
+            stored->has_downscript = true;
+            stored->downscript = g_strdup(downscript);
+        }
+
         snprintf(s->nc.info_str, sizeof(s->nc.info_str),
                  "ifname=%s,script=%s,downscript=%s", ifname, script,
                  downscript);
@@ -685,9 +756,20 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         vhostfdname || (tap->has_vhostforce && tap->vhostforce)) {
         VhostNetOptions options;
 
+        stored->has_vhost = true;
+        stored->vhost = true;
+
+        if (tap->has_vhostforce && tap->vhostforce) {
+            stored->has_vhostforce = true;
+            stored->vhostforce = true;
+        }
+
         options.backend_type = VHOST_BACKEND_TYPE_KERNEL;
         options.net_backend = &s->nc;
         if (tap->has_poll_us) {
+            stored->has_poll_us = true;
+            stored->poll_us = tap->poll_us;
+
             options.busyloop_timeout = tap->poll_us;
         } else {
             options.busyloop_timeout = 0;
@@ -727,6 +809,15 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         }
         options.opaque = (void *)(uintptr_t)vhostfd;
 
+        if (!stored->has_vhostfds) {
+            stored->has_vhostfds = true;
+            stored->vhostfds = g_strdup_printf("%d", vhostfd);
+        } else {
+            char *tmp_s = stored->vhostfds;
+            stored->vhostfds = g_strdup_printf("%s:%d", stored->fds, vhostfd);
+            g_free(tmp_s);
+        }
+
         s->vhost_net = vhost_net_init(&options);
         if (!s->vhost_net) {
             if (tap->has_vhostforce && tap->vhostforce) {
@@ -779,6 +870,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
     const char *vhostfdname;
     char ifname[128];
     int ret = 0;
+    NetdevInfo *common_stored = NULL; /* will store configuration */
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
     tap = &netdev->u.tap;
@@ -822,7 +914,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
         net_init_tap_one(tap, peer, "tap", name, NULL,
                          script, downscript,
-                         vhostfdname, vnet_hdr, fd, &err);
+                         vhostfdname, vnet_hdr, fd, &common_stored, &err);
         if (err) {
             error_propagate(errp, err);
             return -1;
@@ -884,7 +976,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             net_init_tap_one(tap, peer, "tap", name, ifname,
                              script, downscript,
                              tap->has_vhostfds ? vhost_fds[i] : NULL,
-                             vnet_hdr, fd, &err);
+                             vnet_hdr, fd, &common_stored, &err);
             if (err) {
                 error_propagate(errp, err);
                 ret = -1;
@@ -927,7 +1019,7 @@ free_fail:
 
         net_init_tap_one(tap, peer, "bridge", name, ifname,
                          script, downscript, vhostfdname,
-                         vnet_hdr, fd, &err);
+                         vnet_hdr, fd, &common_stored, &err);
         if (err) {
             error_propagate(errp, err);
             close(fd);
@@ -966,7 +1058,8 @@ free_fail:
             net_init_tap_one(tap, peer, "tap", name, ifname,
                              i >= 1 ? "no" : script,
                              i >= 1 ? "no" : downscript,
-                             vhostfdname, vnet_hdr, fd, &err);
+                             vhostfdname, vnet_hdr, fd,
+                             &common_stored, &err);
             if (err) {
                 error_propagate(errp, err);
                 close(fd);
diff --git a/net/vde.c b/net/vde.c
index 99189cccb6..1af9175060 100644
--- a/net/vde.c
+++ b/net/vde.c
@@ -84,6 +84,7 @@ static int net_vde_init(NetClientState *peer, const char *model,
     VDECONN *vde;
     char *init_group = (char *)group;
     char *init_sock = (char *)sock;
+    NetdevVdeOptions *stored;
 
     struct vde_open_args args = {
         .port = port,
@@ -108,6 +109,31 @@ static int net_vde_init(NetClientState *peer, const char *model,
 
     qemu_set_fd_handler(vde_datafd(s->vde), vde_to_qemu, NULL, s);
 
+    /* Store startup parameters */
+    nc->stored_config = g_new0(NetdevInfo, 1);
+    nc->stored_config->type = NET_BACKEND_VDE;
+    stored = &nc->stored_config->u.vde;
+
+    if (sock) {
+        stored->has_sock = true;
+        stored->sock = g_strdup(sock);
+    }
+
+    if (port) {
+        stored->has_port = true;
+        stored->port = port;
+    }
+
+    if (group) {
+        stored->has_group = true;
+        stored->group = g_strdup(group);
+    }
+
+    if (mode) {
+        stored->has_mode = true;
+        stored->mode = mode;
+    }
+
     return 0;
 }
 
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 17532daaf3..c69592c518 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -307,14 +307,15 @@ static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
 }
 
 static int net_vhost_user_init(NetClientState *peer, const char *device,
-                               const char *name, Chardev *chr,
-                               int queues)
+                               const char *name, const char *chardev,
+                               Chardev *chr, int queues)
 {
     Error *err = NULL;
     NetClientState *nc, *nc0 = NULL;
     NetVhostUserState *s = NULL;
     VhostUserState *user;
     int i;
+    NetdevVhostUserOptions *stored;
 
     assert(name);
     assert(queues > 0);
@@ -351,6 +352,16 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
 
     assert(s->vhost_net);
 
+    /* Store startup parameters */
+    nc0->stored_config = g_new0(NetdevInfo, 1);
+    nc0->stored_config->type = NET_BACKEND_VHOST_USER;
+    stored = &nc0->stored_config->u.vhost_user;
+
+    stored->chardev = g_strdup(chardev);
+
+    stored->has_queues = true;
+    stored->queues = queues;
+
     return 0;
 
 err:
@@ -442,5 +453,6 @@ int net_init_vhost_user(const Netdev *netdev, const char *name,
         return -1;
     }
 
-    return net_vhost_user_init(peer, "vhost_user", name, chr, queues);
+    return net_vhost_user_init(peer, "vhost_user", name,
+                               vhost_user_opts->chardev, chr, queues);
 }
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e2b3ba85bf..cffd7850ab 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -179,8 +179,22 @@ static int net_vhost_vdpa_init(NetClientState *peer, const char *device,
     VhostVDPAState *s;
     int vdpa_device_fd = -1;
     int ret = 0;
+    NetdevVhostVDPAOptions *stored;
+
     assert(name);
     nc = qemu_new_net_client(&net_vhost_vdpa_info, peer, device, name);
+
+    /* Store startup parameters */
+    nc->stored_config = g_new0(NetdevInfo, 1);
+    nc->stored_config->type = NET_BACKEND_VHOST_VDPA;
+    stored = &nc->stored_config->u.vhost_vdpa;
+
+    stored->has_vhostdev = true;
+    stored->vhostdev = g_strdup(vhostdev);
+
+    stored->has_queues = true;
+    stored->queues = 1; /* TODO: change when support multiqueue */
+
     snprintf(nc->info_str, sizeof(nc->info_str), TYPE_VHOST_VDPA);
     nc->queue_index = 0;
     s = DO_UPCAST(VhostVDPAState, nc, nc);
diff --git a/qapi/net.json b/qapi/net.json
index a3a1336001..039b84b698 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -714,3 +714,83 @@
 ##
 { 'event': 'FAILOVER_NEGOTIATED',
   'data': {'device-id': 'str'} }
+
+##
+# @NetBackend:
+#
+# Available netdev backend drivers.
+#
+# Since: 5.2
+##
+{ 'enum': 'NetBackend',
+  'data': [ 'user', 'tap', 'l2tpv3', 'socket', 'vde', 'bridge', 'netmap',
+            'vhost-user', 'vhost-vdpa' ] }
+
+##
+# @NetdevInfo:
+#
+# Configuration of a network backend device (netdev).
+#
+# @id: Device identifier.
+#
+# @type: Specify the driver used for interpreting remaining arguments.
+#
+# @peer-id: The connected frontend network device name (absent if no frontend
+#           is connected).
+#
+# Since: 5.2
+##
+{ 'union': 'NetdevInfo',
+  'base': { 'id': 'str',
+            'type': 'NetBackend',
+            '*peer-id': 'str' },
+  'discriminator': 'type',
+  'data': {
+      'user':       'NetdevUserOptions',
+      'tap':        'NetdevTapOptions',
+      'l2tpv3':     'NetdevL2TPv3Options',
+      'socket':     'NetdevSocketOptions',
+      'vde':        'NetdevVdeOptions',
+      'bridge':     'NetdevBridgeOptions',
+      'netmap':     'NetdevNetmapOptions',
+      'vhost-user': 'NetdevVhostUserOptions',
+      'vhost-vdpa': 'NetdevVhostVDPAOptions' } }
+
+##
+# @query-netdev:
+#
+# Get a list of @NetdevInfo for all virtual network backend devices (netdevs).
+#
+# Returns: a list of @NetdevInfo describing each netdev.
+#
+# Since: 5.2
+#
+# Example:
+#
+# -> { "execute": "query-netdev" }
+# <- { "return": [
+#          {
+#              "ipv6": true,
+#              "ipv4": true,
+#              "host": "10.0.2.2",
+#              "ipv6-dns": "fec0::3",
+#              "ipv6-prefix": "fec0::",
+#              "net": "10.0.2.0/255.255.255.0",
+#              "ipv6-host": "fec0::2",
+#              "type": "user",
+#              "peer-id": "net0",
+#              "dns": "10.0.2.3",
+#              "hostfwd": [
+#                  {
+#                      "str": "tcp::20004-:22"
+#                  }
+#              ],
+#              "ipv6-prefixlen": 64,
+#              "id": "netdev0",
+#              "restrict": false
+#          }
+#      ]
+#    }
+#
+##
+{ 'command': 'query-netdev', 'returns': ['NetdevInfo'] }
-- 
2.25.1


