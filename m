Received: from eggs.gnu.org ([2001:4830:134:3::10]:41900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fEVMh-0001rE-Vo
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fEVMd-00085w-0r
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:42:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58348 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fEVMc-00085C-Qr
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:42:46 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  4 May 2018 15:42:06 +0800
Message-Id: <20180504074207.22634-4-famz@redhat.com>
In-Reply-To: <20180504074207.22634-1-famz@redhat.com>
References: <20180504074207.22634-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 3/4] slirp: Add "query-usernet" QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, berrange@redhat.com, Fam Zheng <famz@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

HMP "info usernet" has been available but it isn't ideal for programmed
use cases. This closes the gap in QMP by adding a counterpart
"query-usernet" command. It is basically translated from
the HMP slirp_connection_info() loop, which now calls the QMP
implementation and prints the data, just like other HMP info_* commands.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 net/slirp.c      |  26 ++++++++
 qapi/net.json    | 180 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 slirp/libslirp.h |   2 +
 slirp/misc.c     | 158 ++++++++++++++++++++++++++++++++++--------------
 4 files changed, 321 insertions(+), 45 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 8991816bbf..9c48a882ec 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -36,6 +36,7 @@
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
+#include "slirp/slirp.h"
 #include "slirp/libslirp.h"
 #include "slirp/ip6.h"
 #include "chardev/char-fe.h"
@@ -43,6 +44,7 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qapi-commands-net.h"
 
 static int get_str_sep(char *buf, int buf_size, const char **pp, int sep)
 {
@@ -864,6 +866,30 @@ static int slirp_guestfwd(SlirpState *s, const char *config_str,
     return -1;
 }
 
+UsernetInfoList *qmp_query_usernet(Error **errp)
+{
+    SlirpState *s;
+    UsernetInfoList *list = NULL;
+    UsernetInfoList **p = &list;
+
+    QTAILQ_FOREACH(s, &slirp_stacks, entry) {
+        int hub;
+        UsernetInfoList *il = g_new0(UsernetInfoList, 1);
+        UsernetInfo *info = il->value = g_new0(UsernetInfo, 1);
+
+        info->id = g_strdup(s->nc.name);
+        if (!net_hub_id_for_client(&s->nc, &hub)) {
+            info->hub = hub;
+        } else {
+            info->hub = -1;
+        }
+        usernet_get_info(s->slirp, info);
+        *p = il;
+        p = &il->next;
+    }
+    return list;
+}
+
 void hmp_info_usernet(Monitor *mon, const QDict *qdict)
 {
     SlirpState *s;
diff --git a/qapi/net.json b/qapi/net.json
index fcddce62d6..3cdcda125d 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -723,3 +723,183 @@
     'time-wait',
     'none'
    ] }
+
+##
+# @UsernetTCPConnection:
+#
+# SLIRP TCP information.
+#
+# @state: tcp connection state
+#
+# @hostfwd: whether this connection has host port forwarding
+#
+# @fd: the file descriptor of the connection
+#
+# @src-addr: source address of host port forwarding
+#
+# @src-port: source port of host port forwarding
+#
+# @dest-addr: destination address of host port forwarding
+#
+# @dest-port: destination port of host port forwarding
+#
+# @recv-buffered: number of bytes queued in the receive buffer
+#
+# @send-buffered: number of bytes queued in the send buffer
+#
+# Since: 2.13
+##
+{ 'struct': 'UsernetTCPConnection',
+  'data': {
+    'state': 'UsernetTcpState',
+    'hostfwd': 'bool',
+    'fd': 'int',
+    'src-addr': 'str',
+    'src-port': 'int',
+    'dest-addr': 'str',
+    'dest-port': 'int',
+    'recv-buffered': 'int',
+    'send-buffered': 'int'
+  } }
+
+##
+# @UsernetUDPConnection:
+#
+# SLIRP UDP information.
+#
+# @hostfwd: whether this connection has host port forwarding
+#
+# @expire-time-ms: time in microseconds after which this connection will expire
+#
+# @fd: the file descriptor of the connection
+#
+# @src-addr: source address of host port forwarding
+#
+# @src-port: source port of host port forwarding
+#
+# @dest-addr: destination address of host port forwarding
+#
+# @dest-port: destination port of host port forwarding
+#
+# @recv-buffered: number of bytes queued in the receive buffer
+#
+# @send-buffered: number of bytes queued in the send buffer
+#
+# Since: 2.13
+##
+{ 'struct': 'UsernetUDPConnection',
+  'data': {
+    'hostfwd': 'bool',
+    'expire-time-ms': 'int',
+    'fd': 'int',
+    'src-addr': 'str',
+    'src-port': 'int',
+    'dest-addr': 'str',
+    'dest-port': 'int',
+    'recv-buffered': 'int',
+    'send-buffered': 'int'
+    } }
+
+##
+# @UsernetICMPConnection:
+#
+# SLIRP ICMP information.
+#
+# @expire-time-ms: time in microseconds after which this connection will expire
+#
+# @fd: the file descriptor of the connection
+#
+# @src-addr: source address of host port forwarding
+#
+# @dest-addr: destination address of host port forwarding
+#
+# @recv-buffered: number of bytes queued in the receive buffer
+#
+# @send-buffered: number of bytes queued in the send buffer
+#
+# Since: 2.13
+##
+{ 'struct': 'UsernetICMPConnection',
+  'data': {
+    'expire-time-ms': 'int',
+    'fd': 'int',
+    'src-addr': 'str',
+    'dest-addr': 'str',
+    'recv-buffered': 'int',
+    'send-buffered': 'int'
+    } }
+
+##
+# @UsernetType:
+#
+# Available netdev drivers.
+#
+# Since: 2.13
+##
+{ 'enum': 'UsernetType',
+  'data': [ 'tcp', 'udp', 'icmp' ] }
+
+##
+# @UsernetConnection:
+#
+# SLIRP usernet connection information.
+#
+# Since: 2.13
+##
+{ 'union': 'UsernetConnection',
+  'discriminator': 'type',
+  'base': { 'type': 'UsernetType' },
+  'data': {
+    'tcp':     'UsernetTCPConnection',
+    'udp':     'UsernetUDPConnection',
+    'icmp':    'UsernetICMPConnection'
+    } }
+
+##
+# @UsernetInfo:
+#
+# SLIRP usernet information.
+#
+# Since: 2.13
+##
+{ 'struct': 'UsernetInfo',
+  'data': {
+    'id':              'str',
+    'hub':             'int',
+    'connections':     ['UsernetConnection']
+} }
+
+##
+# @query-usernet:
+#
+# Return SLIRP network information.
+#
+# Since: 2.13
+#
+# Example:
+#
+# -> { "execute": "query-usernet", "arguments": { } }
+# <- { "return": [
+#      {
+#        "hub": -1,
+#        "connections": [
+#          {
+#            "dest-addr": "10.0.2.15",
+#            "recv-buffered": 0,
+#            "src-port": 10022,
+#            "state": "closed",
+#            "fd": 16,
+#            "src-addr": "*",
+#            "send-buffered": 0,
+#            "dest-port": 22,
+#            "type": "tcp",
+#            "hostfwd": true
+#          }
+#        ],
+#        "id": "vnet"
+#      }
+#   ]}
+#
+##
+{ 'command': 'query-usernet',
+  'returns': ['UsernetInfo'] }
diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 540b3e5903..3ba361ea41 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -2,6 +2,7 @@
 #define LIBSLIRP_H
 
 #include "qemu-common.h"
+#include "qapi/qapi-commands-net.h"
 
 typedef struct Slirp Slirp;
 
@@ -37,6 +38,7 @@ int slirp_add_exec(Slirp *slirp, int do_pty, const void *args,
                    struct in_addr *guest_addr, int guest_port);
 
 void slirp_connection_info(Slirp *slirp, Monitor *mon);
+void usernet_get_info(Slirp *slirp, UsernetInfo *info);
 
 void slirp_socket_recv(Slirp *slirp, struct in_addr guest_addr,
                        int guest_port, const uint8_t *buf, int size);
diff --git a/slirp/misc.c b/slirp/misc.c
index ee617bc3c4..1d310d7d1f 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -206,39 +206,28 @@ fork_exec(struct socket *so, const char *ex, int do_pty)
 }
 #endif
 
-void slirp_connection_info(Slirp *slirp, Monitor *mon)
+void usernet_get_info(Slirp *slirp, UsernetInfo *info)
 {
-    const char * const tcpstates[] = {
-        [USERNET_TCP_STATE_CLOSED]       = "CLOSED",
-        [USERNET_TCP_STATE_LISTEN]       = "LISTEN",
-        [USERNET_TCP_STATE_SYN_SENT]     = "SYN_SENT",
-        [USERNET_TCP_STATE_SYN_RECEIVED] = "SYN_RCVD",
-        [USERNET_TCP_STATE_ESTABLISHED]  = "ESTABLISHED",
-        [USERNET_TCP_STATE_CLOSE_WAIT]   = "CLOSE_WAIT",
-        [USERNET_TCP_STATE_FIN_WAIT_1]   = "FIN_WAIT_1",
-        [USERNET_TCP_STATE_CLOSING]      = "CLOSING",
-        [USERNET_TCP_STATE_LAST_ACK]     = "LAST_ACK",
-        [USERNET_TCP_STATE_FIN_WAIT_2]   = "FIN_WAIT_2",
-        [USERNET_TCP_STATE_TIME_WAIT]    = "TIME_WAIT",
-    };
     struct in_addr dst_addr;
     struct sockaddr_in src;
     socklen_t src_len;
     uint16_t dst_port;
     struct socket *so;
-    const char *state;
-    char buf[20];
-
-    monitor_printf(mon, "  Protocol[State]    FD  Source Address  Port   "
-                        "Dest. Address  Port RecvQ SendQ\n");
+    UsernetConnectionList **p_next = &info->connections;
 
     for (so = slirp->tcb.so_next; so != &slirp->tcb; so = so->so_next) {
+        UsernetConnection *conn = g_new0(UsernetConnection, 1);
+        UsernetTCPConnection *tcp = &conn->u.tcp;
+        UsernetConnectionList *list = g_new0(UsernetConnectionList, 1);
+
+        list->value = conn;
         if (so->so_state & SS_HOSTFWD) {
-            state = "HOST_FORWARD";
+            tcp->hostfwd = true;
+            tcp->state = so->so_tcpcb->t_state;
         } else if (so->so_tcpcb) {
-            state = tcpstates[so->so_tcpcb->t_state];
+            tcp->state = so->so_tcpcb->t_state;
         } else {
-            state = "NONE";
+            tcp->state = USERNET_TCP_STATE_NONE;
         }
         if (so->so_state & (SS_HOSTFWD | SS_INCOMING)) {
             src_len = sizeof(src);
@@ -251,46 +240,125 @@ void slirp_connection_info(Slirp *slirp, Monitor *mon)
             dst_addr = so->so_faddr;
             dst_port = so->so_fport;
         }
-        snprintf(buf, sizeof(buf), "  TCP[%s]", state);
-        monitor_printf(mon, "%-19s %3d %15s %5d ", buf, so->s,
-                       src.sin_addr.s_addr ? inet_ntoa(src.sin_addr) : "*",
-                       ntohs(src.sin_port));
-        monitor_printf(mon, "%15s %5d %5d %5d\n",
-                       inet_ntoa(dst_addr), ntohs(dst_port),
-                       so->so_rcv.sb_cc, so->so_snd.sb_cc);
+        tcp->fd = so->s;
+        tcp->src_addr =
+            g_strdup(src.sin_addr.s_addr ? inet_ntoa(src.sin_addr) : "*");
+        tcp->src_port = ntohs(src.sin_port);
+        tcp->dest_addr = g_strdup(inet_ntoa(dst_addr));
+        tcp->dest_port = ntohs(dst_port);
+        tcp->recv_buffered = so->so_rcv.sb_cc;
+        tcp->send_buffered = so->so_snd.sb_cc;
+        *p_next = list;
+        p_next = &list->next;
     }
-
     for (so = slirp->udb.so_next; so != &slirp->udb; so = so->so_next) {
+        UsernetConnection *conn = g_new0(UsernetConnection, 1);
+        UsernetUDPConnection *udp = &conn->u.udp;
+        UsernetConnectionList *list = g_new0(UsernetConnectionList, 1);
+
+        list->value = conn;
         if (so->so_state & SS_HOSTFWD) {
-            snprintf(buf, sizeof(buf), "  UDP[HOST_FORWARD]");
+            udp->hostfwd = true;
             src_len = sizeof(src);
             getsockname(so->s, (struct sockaddr *)&src, &src_len);
             dst_addr = so->so_laddr;
             dst_port = so->so_lport;
         } else {
-            snprintf(buf, sizeof(buf), "  UDP[%d sec]",
-                         (so->so_expire - curtime) / 1000);
+            udp->expire_time_ms = so->so_expire - curtime;
             src.sin_addr = so->so_laddr;
             src.sin_port = so->so_lport;
             dst_addr = so->so_faddr;
             dst_port = so->so_fport;
         }
-        monitor_printf(mon, "%-19s %3d %15s %5d ", buf, so->s,
-                       src.sin_addr.s_addr ? inet_ntoa(src.sin_addr) : "*",
-                       ntohs(src.sin_port));
-        monitor_printf(mon, "%15s %5d %5d %5d\n",
-                       inet_ntoa(dst_addr), ntohs(dst_port),
-                       so->so_rcv.sb_cc, so->so_snd.sb_cc);
+        udp->fd = so->s;
+        udp->src_addr =
+            g_strdup(src.sin_addr.s_addr ? inet_ntoa(src.sin_addr) : "*");
+        udp->src_port = ntohs(src.sin_port);
+        udp->dest_addr = g_strdup(inet_ntoa(dst_addr));
+        udp->dest_port = ntohs(dst_port);
+        udp->recv_buffered = so->so_rcv.sb_cc;
+        udp->send_buffered = so->so_snd.sb_cc;
+        *p_next = list;
+        p_next = &list->next;
     }
 
     for (so = slirp->icmp.so_next; so != &slirp->icmp; so = so->so_next) {
-        snprintf(buf, sizeof(buf), "  ICMP[%d sec]",
-                     (so->so_expire - curtime) / 1000);
+        UsernetConnection *conn = g_new0(UsernetConnection, 1);
+        UsernetICMPConnection *icmp = &conn->u.icmp;
+        UsernetConnectionList *list = g_new0(UsernetConnectionList, 1);
+
+        icmp->expire_time_ms = so->so_expire - curtime;
         src.sin_addr = so->so_laddr;
         dst_addr = so->so_faddr;
-        monitor_printf(mon, "%-19s %3d %15s  -    ", buf, so->s,
-                       src.sin_addr.s_addr ? inet_ntoa(src.sin_addr) : "*");
-        monitor_printf(mon, "%15s  -    %5d %5d\n", inet_ntoa(dst_addr),
-                       so->so_rcv.sb_cc, so->so_snd.sb_cc);
+        icmp->fd = so->s;
+        icmp->src_addr =
+            g_strdup(src.sin_addr.s_addr ? inet_ntoa(src.sin_addr) : "*");
+        icmp->dest_addr = g_strdup(inet_ntoa(dst_addr));
+        icmp->recv_buffered = so->so_rcv.sb_cc;
+        icmp->send_buffered = so->so_snd.sb_cc;
+        *p_next = list;
+        p_next = &list->next;
     }
 }
+
+
+void slirp_connection_info(Slirp *slirp, Monitor *mon)
+{
+    const char *state;
+    char buf[64];
+    UsernetInfo *info = g_new0(UsernetInfo, 1);
+    UsernetConnectionList *cl;
+
+    monitor_printf(mon, "  Protocol[State]    FD  Source Address  Port   "
+                        "Dest. Address  Port RecvQ SendQ\n");
+
+    usernet_get_info(slirp, info);
+    for (cl = info->connections; cl && cl->value; cl = cl->next) {
+        UsernetConnection *conn = cl->value;
+
+        if (conn->type == USERNET_TYPE_TCP) {
+            UsernetTCPConnection *tcp = &conn->u.tcp;
+
+            if (tcp->hostfwd) {
+                state = "HOST_FORWARD";
+            } else {
+                state = UsernetTcpState_str(tcp->state);
+            }
+            snprintf(buf, sizeof(buf), "  TCP[%s]", state);
+            monitor_printf(mon, "%-19s %3" PRId64 " %15s %5" PRId64 " ",
+                           buf, tcp->fd,
+                           tcp->src_addr, tcp->src_port);
+            monitor_printf(mon, "%15s %5" PRId64 " %5" PRId64 " %5" PRId64 "\n",
+                           tcp->dest_addr, tcp->dest_port,
+                           tcp->recv_buffered, tcp->send_buffered);
+        } else if (conn->type == USERNET_TYPE_UDP) {
+            UsernetUDPConnection *udp = &conn->u.udp;
+
+            if (udp->hostfwd) {
+                snprintf(buf, sizeof(buf), "  UDP[HOST_FORWARD]");
+            } else {
+                snprintf(buf, sizeof(buf), "  UDP[%" PRId64 " sec]",
+                         udp->expire_time_ms / 1000);
+            }
+            monitor_printf(mon, "%-19s %3" PRId64 " %15s %5" PRId64 " ",
+                           buf, udp->fd,
+                           udp->src_addr, udp->src_port);
+            monitor_printf(mon, "%15s %5" PRId64 " %5" PRId64 " %5" PRId64 "\n",
+                           udp->dest_addr, udp->dest_port,
+                           udp->recv_buffered, udp->send_buffered);
+        } else {
+            UsernetICMPConnection *icmp = &conn->u.icmp;
+
+            assert(conn->type == USERNET_TYPE_ICMP);
+            snprintf(buf, sizeof(buf), "  ICMP[%" PRId64 " sec]",
+                     icmp->expire_time_ms / 1000);
+            monitor_printf(mon, "%-19s %3" PRId64 " %15s  -    ", buf, icmp->fd,
+                           icmp->src_addr);
+            monitor_printf(mon, "%15s  -    %5" PRId64 " %5" PRId64 "\n",
+                           icmp->dest_addr,
+                           icmp->recv_buffered, icmp->send_buffered);
+        }
+    }
+
+    qapi_free_UsernetInfo(info);
+}
-- 
2.14.3
