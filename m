Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E30C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E31A2071B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="E4F8jTDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E31A2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDB08-0006u2-AN
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 14:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kDAwk-0002VW-Cc
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:23:54 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:36670)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kDAwf-0006iZ-Q7
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:23:54 -0400
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net
 (sas1-ec30c78b6c5b.qloud-c.yandex.net
 [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id CBD852E155D;
 Tue,  1 Sep 2020 21:23:47 +0300 (MSK)
Received: from sas1-58a37b48fb94.qloud-c.yandex.net
 (sas1-58a37b48fb94.qloud-c.yandex.net [2a02:6b8:c08:1d1b:0:640:58a3:7b48])
 by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 ht2oBPWaGn-NjQOtXXv; Tue, 01 Sep 2020 21:23:47 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1598984627; bh=dsNySRRI8O3TYJ/VgJLD9f0RYcQlOma9W5BAbqgGe+g=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=E4F8jTDPxzPvQMd72CU0thfrTaIQ+9ZmczGzeyng3njZ8aomNev/ibXq1pYVs8ueK
 42a3Gnz50eDArUrx01ODH/x00LGnPugAPoyVt0lpuao5GBNip9lHZpGy6HlQNjadq3
 vHcdrK4uTJH8KaJfKYTzK1X/+bC4aJW/AQvdVF2w=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:8026::1:2])
 by sas1-58a37b48fb94.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 kKjd0SHRPh-NiluJeZQ; Tue, 01 Sep 2020 21:23:45 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Kirillov <lekiravi@yandex-team.ru>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v3 3/4] hmp: Use QMP query-netdevs in hmp_info_network
Date: Tue,  1 Sep 2020 21:23:25 +0300
Message-Id: <20200901182326.59633-4-lekiravi@yandex-team.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200901182326.59633-1-lekiravi@yandex-team.ru>
References: <20200901182326.59633-1-lekiravi@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.45.199.163;
 envelope-from=lekiravi@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 14:23:44
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

Replace usage of legacy field info_str of NetClientState for
backend network devices with result of QMP command query-netdevs.
NIC and hubports still use legacy info_str field.

Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
---
 include/net/net.h |   3 +-
 net/clients.h     |   1 +
 net/hub.c         |   4 +-
 net/hub.h         |   2 +-
 net/net.c         | 181 ++++++++++++++++++++++++++++++++++++++++++++--
 net/vde.c         |  10 +++
 6 files changed, 192 insertions(+), 9 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 04d51ac215..d6d3168a0d 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -172,7 +172,8 @@ void qemu_check_nic_model(NICInfo *nd, const char *model);
 int qemu_find_nic_model(NICInfo *nd, const char * const *models,
                         const char *default_model);
 
-void print_net_client(Monitor *mon, NetClientState *nc);
+void print_net_client(Monitor *mon, NetClientState *nc,
+                      NetdevInfoList *ni_list);
 void hmp_info_network(Monitor *mon, const QDict *qdict);
 void net_socket_rs_init(SocketReadState *rs,
                         SocketReadStateFinalize *finalize,
diff --git a/net/clients.h b/net/clients.h
index 92f9b59aed..fdf257f641 100644
--- a/net/clients.h
+++ b/net/clients.h
@@ -51,6 +51,7 @@ int net_init_l2tpv3(const Netdev *netdev, const char *name,
 #ifdef CONFIG_VDE
 int net_init_vde(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp);
+int net_vde_get_fd(const NetClientState *nc);
 #endif
 
 #ifdef CONFIG_NETMAP
diff --git a/net/hub.c b/net/hub.c
index 1375738bf1..7815248650 100644
--- a/net/hub.c
+++ b/net/hub.c
@@ -221,7 +221,7 @@ NetClientState *net_hub_port_find(int hub_id)
 /**
  * Print hub configuration
  */
-void net_hub_info(Monitor *mon)
+void net_hub_info(Monitor *mon, NetdevInfoList *ni_list)
 {
     NetHub *hub;
     NetHubPort *port;
@@ -232,7 +232,7 @@ void net_hub_info(Monitor *mon)
             monitor_printf(mon, " \\ %s", port->nc.name);
             if (port->nc.peer) {
                 monitor_printf(mon, ": ");
-                print_net_client(mon, port->nc.peer);
+                print_net_client(mon, port->nc.peer, ni_list);
             } else {
                 monitor_printf(mon, "\n");
             }
diff --git a/net/hub.h b/net/hub.h
index ce45f7b399..2c9a384077 100644
--- a/net/hub.h
+++ b/net/hub.h
@@ -17,7 +17,7 @@
 
 NetClientState *net_hub_add_port(int hub_id, const char *name,
                                  NetClientState *hubpeer);
-void net_hub_info(Monitor *mon);
+void net_hub_info(Monitor *mon, NetdevInfoList *ninfo);
 void net_hub_check_clients(void);
 bool net_hub_flush(NetClientState *nc);
 
diff --git a/net/net.c b/net/net.c
index 923e3d0bc6..384b57da3b 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1175,14 +1175,182 @@ static void netfilter_print_info(Monitor *mon, NetFilterState *nf)
     monitor_printf(mon, "\n");
 }
 
-void print_net_client(Monitor *mon, NetClientState *nc)
+static NetdevInfo *get_netdev_info(NetdevInfoList *ni_list, char *name)
+{
+    NetdevInfo *ni;
+
+    while (ni_list) {
+        ni = ni_list->value;
+        if (g_str_equal(ni->id, name)) {
+            return ni;
+        }
+        ni_list = ni_list->next;
+    }
+
+    return NULL;
+}
+
+static char *generate_info_str(NetdevInfo *ni, NetClientState *nc)
+{
+    char *info_str;
+
+    /* Use legacy field info_str for NIC and hubports */
+    if ((nc->info->type == NET_CLIENT_DRIVER_NIC) ||
+        (nc->info->type == NET_CLIENT_DRIVER_HUBPORT)) {
+        return g_strdup(nc->info_str);
+    }
+
+    if (!ni) {
+        return g_malloc0(1);
+    }
+
+    switch (ni->type) {
+#ifdef CONFIG_SLIRP
+        case NET_CLIENT_DRIVER_USER: {
+            size_t len = strchr(ni->u.user.net, '/') - ni->u.user.net;
+            char *net = g_strndup(ni->u.user.net, len);
+
+            info_str = g_strdup_printf("net=%s,restrict=%s",
+                                       net,
+                                       ni->u.user.q_restrict ? "on" : "off");
+            g_free(net);
+            break;
+        }
+#endif /* CONFIG_SLIRP */
+        case NET_CLIENT_DRIVER_TAP: {
+#ifndef _WIN32
+            if (ni->u.tap.has_fds) {
+                char **fds = g_strsplit(ni->u.tap.fds, ":", -1);
+
+                info_str = g_strdup_printf("fd=%s", fds[nc->queue_index]);
+                g_strfreev(fds);
+            } else if (ni->u.tap.has_helper) {
+                info_str = g_strdup_printf("helper=%s", ni->u.tap.helper);
+            } else {
+                info_str = g_strdup_printf("ifname=%s,script=%s,downscript=%s",
+                    ni->u.tap.ifname,
+                    nc->queue_index == 0 ? ni->u.tap.script : "no",
+                    nc->queue_index == 0 ? ni->u.tap.downscript : "no");
+            }
+#else
+            info_str = g_strdup_printf("tap: ifname=%s", ni->u.tap.ifname);
+#endif /* _WIN32 */
+            break;
+        }
+#ifdef CONFIG_L2TPV3
+        case NET_CLIENT_DRIVER_L2TPV3: {
+            info_str = g_strdup_printf("l2tpv3: connected");
+            break;
+        }
+#endif /* CONFIG_L2TPV3 */
+        case NET_CLIENT_DRIVER_SOCKET: {
+            if (ni->u.socket.has_listen) {
+                if (ni->u.socket.has_fd) {
+                    info_str = g_strdup_printf("socket: connection from %s",
+                                               ni->u.socket.listen);
+                } else {
+                    info_str = g_strdup_printf("socket: wait from %s",
+                                               ni->u.socket.listen);
+                }
+            } else if (ni->u.socket.has_connect && ni->u.socket.has_fd) {
+                info_str = g_strdup_printf("socket: connect to %s",
+                                           ni->u.socket.connect);
+            } else if (ni->u.socket.has_mcast && ni->u.socket.has_fd) {
+                info_str = g_strdup_printf("socket: mcast=%s",
+                                           ni->u.socket.mcast);
+            } else if (ni->u.socket.has_udp && ni->u.socket.has_fd) {
+                info_str = g_strdup_printf("socket: udp=%s", ni->u.socket.udp);
+            } else {
+                g_assert(ni->u.socket.has_fd);
+                int so_type = -1;
+                int optlen = sizeof(so_type);
+                int fd = atoi(ni->u.socket.fd);
+
+                getsockopt(fd, SOL_SOCKET, SO_TYPE, (char *)&so_type,
+                           (socklen_t *)&optlen);
+                if (so_type == SOCK_STREAM) {
+                    info_str = g_strdup_printf("socket: fd=%s",
+                                               ni->u.socket.fd);
+                } else {
+                    if (ni->u.socket.has_mcast) {
+                        /*
+                         * This branch is unreachable, according to how it is in
+                         * net/socket.c at this moment
+                         */
+                        info_str = g_strdup_printf("socket: fd=%s "
+                                                   "(cloned mcast=%s)",
+                                                   ni->u.socket.fd,
+                                                   ni->u.socket.mcast);
+                    } else {
+                        SocketAddress *sa = socket_local_address(fd, NULL);
+
+                        info_str = g_strdup_printf("socket: fd=%s %s",
+                            ni->u.socket.fd,
+                            SocketAddressType_str(sa->type));
+                        qapi_free_SocketAddress(sa);
+                    }
+                }
+            }
+            break;
+        }
+#ifdef CONFIG_VDE
+        case NET_CLIENT_DRIVER_VDE: {
+            info_str = g_strdup_printf("sock=%s,fd=%d",
+                                       ni->u.vde.sock,
+                                       net_vde_get_fd(nc));
+            break;
+        }
+#endif /* CONFIG_VDE */
+#ifdef CONFIG_NET_BRIDGE
+        case NET_CLIENT_DRIVER_BRIDGE: {
+            info_str = g_strdup_printf("helper=%s,br=%s",
+                                       ni->u.bridge.helper,
+                                       ni->u.bridge.br);
+            break;
+        }
+#endif /* CONFIG_NET_BRIDGE */
+#ifdef CONFIG_NETMAP
+        case NET_CLIENT_DRIVER_NETMAP: {
+            info_str = g_strdup_printf("netmap: ifname=%s",
+                                       ni->u.netmap.ifname);
+            break;
+        }
+#endif /* CONFIG_NETMAP */
+#ifdef CONFIG_VHOST_NET_USER
+        case NET_CLIENT_DRIVER_VHOST_USER: {
+            info_str = g_strdup_printf("vhost-user%d to %s",
+                                       nc->queue_index,
+                                       ni->u.vhost_user.chardev);
+            break;
+        }
+#endif /* CONFIG_VHOST_NET_USER */
+#ifdef CONFIG_VHOST_NET_VDPA
+        case NET_CLIENT_DRIVER_VHOST_VDPA: {
+            info_str = g_strdup("vhost-vdpa");
+            break;
+        }
+#endif /* CONFIG_VHOST_NET_VDPA */
+        default: {
+            info_str = g_malloc0(1);
+            break;
+        }
+    }
+
+    return info_str;
+}
+
+void print_net_client(Monitor *mon, NetClientState *nc, NetdevInfoList *ni_list)
 {
     NetFilterState *nf;
+    NetdevInfo *ni = get_netdev_info(ni_list, nc->name);
+    char *info_str = generate_info_str(ni, nc);
 
     monitor_printf(mon, "%s: index=%d,type=%s,%s\n", nc->name,
                    nc->queue_index,
                    NetClientDriver_str(nc->info->type),
-                   nc->info_str);
+                   info_str);
+    g_free(info_str);
+
     if (!QTAILQ_EMPTY(&nc->filters)) {
         monitor_printf(mon, "filters:\n");
     }
@@ -1286,8 +1454,9 @@ void hmp_info_network(Monitor *mon, const QDict *qdict)
 {
     NetClientState *nc, *peer;
     NetClientDriver type;
+    NetdevInfoList *ni_list = qmp_query_netdevs(NULL);
 
-    net_hub_info(mon);
+    net_hub_info(mon, ni_list);
 
     QTAILQ_FOREACH(nc, &net_clients, next) {
         peer = nc->peer;
@@ -1299,13 +1468,15 @@ void hmp_info_network(Monitor *mon, const QDict *qdict)
         }
 
         if (!peer || type == NET_CLIENT_DRIVER_NIC) {
-            print_net_client(mon, nc);
+            print_net_client(mon, nc, ni_list);
         } /* else it's a netdev connected to a NIC, printed with the NIC */
         if (peer && type == NET_CLIENT_DRIVER_NIC) {
             monitor_printf(mon, " \\ ");
-            print_net_client(mon, peer);
+            print_net_client(mon, peer, ni_list);
         }
     }
+
+    qapi_free_NetdevInfoList(ni_list);
 }
 
 void colo_notify_filters_event(int event, Error **errp)
diff --git a/net/vde.c b/net/vde.c
index c0ab2bb65c..c4edf5cba1 100644
--- a/net/vde.c
+++ b/net/vde.c
@@ -153,3 +153,13 @@ int net_init_vde(const Netdev *netdev, const char *name,
 
     return 0;
 }
+
+int net_vde_get_fd(const NetClientState *nc)
+{
+    VDEState *s;
+    assert(nc->info->type == NET_CLIENT_DRIVER_VDE);
+
+    s = DO_UPCAST(VDEState, nc, nc);
+
+    return vde_datafd(s->vde);
+}
-- 
2.25.1


