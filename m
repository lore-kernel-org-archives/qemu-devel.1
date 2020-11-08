Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682C7C4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 00:05:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC5520637
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 00:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="aDDXHfcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC5520637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbugi-00007L-1r
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 19:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kbucE-0003nw-NO
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 19:00:58 -0500
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:54444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kbucC-0003xn-Cy
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 19:00:58 -0500
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net
 (sas1-ec30c78b6c5b.qloud-c.yandex.net
 [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id F1EED2E14A4;
 Mon,  9 Nov 2020 03:00:54 +0300 (MSK)
Received: from sas2-c156b1cb922a.qloud-c.yandex.net
 (sas2-c156b1cb922a.qloud-c.yandex.net [2a02:6b8:c08:b78e:0:640:c156:b1cb])
 by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 PaDJTaGbEL-0pweK6v4; Mon, 09 Nov 2020 03:00:54 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1604880054; bh=4UT9zLwR/HbyGJkWxMzsQ6xPZvU8eI6Qk1oOhho2jsQ=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=aDDXHfcdr1oyKmiIbGcfanR3c0rTx6s9cDeM6P4xhVjJQfhfyr2o79x6fZsOc/cjF
 72uKG6uMwJXxIjLADNhfbPwA99ENqzpPC2//FNARc/C1E19sCSLVQUBfDLegN8xGD/
 7XgEKAxY3ZfGVCciPNVvB3uj5Y7Y2tuqbAoyr7X8=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:425::1:0])
 by sas2-c156b1cb922a.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 AEjcvNO5zB-05nCNlmg; Mon, 09 Nov 2020 03:00:51 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Kirillov <lekiravi@yandex-team.ru>
To: Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v5 4/4] net: Do not use legacy info_str for backends
Date: Mon,  9 Nov 2020 02:59:52 +0300
Message-Id: <20201108235952.107961-5-lekiravi@yandex-team.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201108235952.107961-1-lekiravi@yandex-team.ru>
References: <20201108235952.107961-1-lekiravi@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:0:1472:2741:0:8b6:217;
 envelope-from=lekiravi@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 19:00:34
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

As we use QMP query-netdev to store and get information about
backend network devices, we can drop usage legacy field info_str
for them.
We still use this field for NIC and hubports, so we can not
completely remove it.

Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
---
 net/l2tpv3.c     |  2 --
 net/slirp.c      |  4 ----
 net/socket.c     | 22 ----------------------
 net/tap-win32.c  |  3 ---
 net/tap.c        | 12 ------------
 net/vde.c        |  3 ---
 net/vhost-user.c |  2 --
 net/vhost-vdpa.c |  1 -
 8 files changed, 49 deletions(-)

diff --git a/net/l2tpv3.c b/net/l2tpv3.c
index 881fc6f7c1..7f2a590155 100644
--- a/net/l2tpv3.c
+++ b/net/l2tpv3.c
@@ -745,8 +745,6 @@ int net_init_l2tpv3(const Netdev *netdev,
         stored->dstport = g_strdup(l2tpv3->dstport);
     }
 
-    snprintf(s->nc.info_str, sizeof(s->nc.info_str),
-             "l2tpv3: connected");
     return 0;
 outerr:
     qemu_del_net_client(nc);
diff --git a/net/slirp.c b/net/slirp.c
index 65d3f2639c..14fa64227d 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -670,10 +670,6 @@ static int net_slirp_init(NetClientState *peer, const char *model,
         stored->tftp_server_name = g_strdup(tftp_server_name);
     }
 
-    snprintf(nc->info_str, sizeof(nc->info_str),
-             "net=%s,restrict=%s", inet_ntoa(net),
-             restricted ? "on" : "off");
-
     s = DO_UPCAST(SlirpState, nc, nc);
 
     s->slirp = slirp_init(restricted, ipv4, net, mask, host,
diff --git a/net/socket.c b/net/socket.c
index 1614523b82..93b5163f0e 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -180,7 +180,6 @@ static void net_socket_send(void *opaque)
         s->fd = -1;
         net_socket_rs_init(&s->rs, net_socket_rs_finalize, false);
         s->nc.link_down = true;
-        memset(s->nc.info_str, 0, sizeof(s->nc.info_str));
 
         return;
     }
@@ -400,16 +399,10 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
         stored->mcast = g_strdup(mcast);
 
         s->dgram_dst = saddr;
-        snprintf(nc->info_str, sizeof(nc->info_str),
-                 "socket: fd=%d (cloned mcast=%s:%d)",
-                 fd, inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
     } else {
         if (sa_type == SOCKET_ADDRESS_TYPE_UNIX) {
             s->dgram_dst.sin_family = AF_UNIX;
         }
-
-        snprintf(nc->info_str, sizeof(nc->info_str),
-                 "socket: fd=%d %s", fd, SocketAddressType_str(sa_type));
     }
 
     return s;
@@ -444,8 +437,6 @@ static NetSocketState *net_socket_fd_init_stream(NetClientState *peer,
 
     nc = qemu_new_net_client(&net_socket_info, peer, model, name);
 
-    snprintf(nc->info_str, sizeof(nc->info_str), "socket: fd=%d", fd);
-
     s = DO_UPCAST(NetSocketState, nc, nc);
 
     s->fd = fd;
@@ -527,10 +518,6 @@ static void net_socket_accept(void *opaque)
 
     stored->has_fd = true;
     stored->fd = g_strdup_printf("%d", fd);
-
-    snprintf(s->nc.info_str, sizeof(s->nc.info_str),
-             "socket: connection from %s:%d",
-             inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
 }
 
 static int net_socket_listen_init(NetClientState *peer,
@@ -645,9 +632,6 @@ static int net_socket_connect_init(NetClientState *peer,
     stored->has_connect = true;
     stored->connect = g_strdup(host_str);
 
-    snprintf(s->nc.info_str, sizeof(s->nc.info_str),
-             "socket: connect to %s:%d",
-             inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
     return 0;
 }
 
@@ -704,9 +688,6 @@ static int net_socket_mcast_init(NetClientState *peer,
         stored->localaddr = g_strdup(localaddr_str);
     }
 
-    snprintf(s->nc.info_str, sizeof(s->nc.info_str),
-             "socket: mcast=%s:%d",
-             inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
     return 0;
 
 }
@@ -769,9 +750,6 @@ static int net_socket_udp_init(NetClientState *peer,
     stored->has_udp = true;
     stored->udp = g_strdup(rhost);
 
-    snprintf(s->nc.info_str, sizeof(s->nc.info_str),
-             "socket: udp=%s:%d",
-             inet_ntoa(raddr.sin_addr), ntohs(raddr.sin_port));
     return 0;
 }
 
diff --git a/net/tap-win32.c b/net/tap-win32.c
index b60933bd1a..21e451107b 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -787,9 +787,6 @@ static int tap_win32_init(NetClientState *peer, const char *model,
     stored->has_ifname = true;
     stored->ifname = g_strdup(ifname);
 
-    snprintf(s->nc.info_str, sizeof(s->nc.info_str),
-             "tap: ifname=%s", ifname);
-
     s->handle = handle;
 
     qemu_add_wait_object(s->handle->tap_semaphore, tap_win32_send, s);
diff --git a/net/tap.c b/net/tap.c
index 57af49ad51..908cb8e7bd 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -625,9 +625,6 @@ int net_init_bridge(const Netdev *netdev, const char *name,
         stored->helper = g_strdup(helper);
     }
 
-    snprintf(s->nc.info_str, sizeof(s->nc.info_str), "helper=%s,br=%s", helper,
-             br);
-
     return 0;
 }
 
@@ -713,8 +710,6 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
             stored->fds = g_strdup_printf("%s:%d", stored->fds, fd);
             g_free(tmp_s);
         }
-
-        snprintf(s->nc.info_str, sizeof(s->nc.info_str), "fd=%d", fd);
     } else if (tap->has_helper) {
         if (!stored->has_helper) {
             stored->has_helper = true;
@@ -726,9 +721,6 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
             stored->br = tap->has_br ? g_strdup(tap->br) :
                                        g_strdup(DEFAULT_BRIDGE_INTERFACE);
         }
-
-        snprintf(s->nc.info_str, sizeof(s->nc.info_str), "helper=%s",
-                 tap->helper);
     } else {
         if (ifname && !stored->has_ifname) {
             stored->has_ifname = true;
@@ -745,10 +737,6 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
             stored->downscript = g_strdup(downscript);
         }
 
-        snprintf(s->nc.info_str, sizeof(s->nc.info_str),
-                 "ifname=%s,script=%s,downscript=%s", ifname, script,
-                 downscript);
-
         if (strcmp(downscript, "no") != 0) {
             snprintf(s->down_script, sizeof(s->down_script), "%s", downscript);
             snprintf(s->down_script_arg, sizeof(s->down_script_arg),
diff --git a/net/vde.c b/net/vde.c
index 041eadbcf9..bda8444d1a 100644
--- a/net/vde.c
+++ b/net/vde.c
@@ -100,9 +100,6 @@ static int net_vde_init(NetClientState *peer, const char *model,
 
     nc = qemu_new_net_client(&net_vde_info, peer, model, name);
 
-    snprintf(nc->info_str, sizeof(nc->info_str), "sock=%s,fd=%d",
-             sock, vde_datafd(vde));
-
     s = DO_UPCAST(VDEState, nc, nc);
 
     s->vde = vde;
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 5b7056be25..e443c4b2b5 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -327,8 +327,6 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
     user = g_new0(struct VhostUserState, 1);
     for (i = 0; i < queues; i++) {
         nc = qemu_new_net_client(&net_vhost_user_info, peer, device, name);
-        snprintf(nc->info_str, sizeof(nc->info_str), "vhost-user%d to %s",
-                 i, chr->label);
         nc->queue_index = i;
         if (!nc0) {
             nc0 = nc;
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 8c27ea0142..5a28bbcd7b 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -200,7 +200,6 @@ static int net_vhost_vdpa_init(NetClientState *peer, const char *device,
     stored->has_queues = true;
     stored->queues = 1; /* TODO: change when support multiqueue */
 
-    snprintf(nc->info_str, sizeof(nc->info_str), TYPE_VHOST_VDPA);
     nc->queue_index = 0;
     s = DO_UPCAST(VhostVDPAState, nc, nc);
     vdpa_device_fd = qemu_open_old(vhostdev, O_RDWR);
-- 
2.25.1


