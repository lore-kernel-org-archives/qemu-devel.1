Received: from eggs.gnu.org ([2001:4830:134:3::10]:33307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewir6-0005c3-8V
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 02:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewir2-0007rS-T4
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 02:28:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33968 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ewir2-0007rE-N1
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 02:28:40 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 16 Mar 2018 14:28:21 +0800
Message-Id: <20180316062822.15425-2-famz@redhat.com>
In-Reply-To: <20180316062822.15425-1-famz@redhat.com>
References: <20180316062822.15425-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.13 v3 1/2] slirp: Add "query-usernet" QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>

HMP "info usernet" has been available but it isn't ideal for programmed
use cases. This closes the gap in QMP by adding a counterpart
"query-usernet" command. It is basically translated from
the HMP slirp_connection_info() loop, which now calls the QMP
implementation and prints the data, just like other HMP info_* commands.

The TCPS_* macros are now defined as a QAPI enum.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 net/slirp.c      |  26 +++++++
 qapi/net.json    | 201 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 slirp/libslirp.h |   2 +
 slirp/misc.c     | 156 +++++++++++++++++++++++++++++-------------
 slirp/tcp.h      |  15 -----
 5 files changed, 340 insertions(+), 60 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 8991816bbf..4b14900dbd 100644
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
+        int vlan;
+        UsernetInfoList *il = g_new0(UsernetInfoList, 1);
+        UsernetInfo *info = il->value = g_new0(UsernetInfo, 1);
+
+        info->id = g_strdup(s->nc.name);
+        if (!net_hub_id_for_client(&s->nc, &vlan)) {
+            info->vlan = vlan;
+        } else {
+            info->vlan = -1;
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
index 9117c56972..6a6b36e73f 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -689,3 +689,204 @@
 ##
 { 'event': 'NIC_RX_FILTER_CHANGED',
   'data': { '*name': 'str', 'path': 'str' } }
+
+##
+# @TCPS:
+#
+# TCP States of a SLIRP connection.
+#
+# - States where connections are not established: none, closed, listen, syn-sent,
+#   syn-received
+#
+# - States where user has closed: fin-wait-1, closing, last-ack, fin-wait-2,
+#   time-wait
+#
+# - States awaiting ACK of FIN: fin-wait-1, closing, last-ack
+#
+# 'none' state is used only when host forwarding
+#
+# Since 2.13
+#
+##
+{ 'enum': 'TCPS',
+  'data':
+   ['closed',
+    'listen',
+    'syn-sent',
+    'syn-received',
+    'established',
+    'close-wait',
+    'fin-wait-1',
+    'closing',
+    'last-ack',
+    'fin-wait-2',
+    'time-wait',
+    'none'
+   ] }
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
+    'state': 'TCPS',
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
+    'vlan':            'int',
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
+#         {
+#             "promiscuous": true,
+#             "name": "vnet0"
+#         }
+#       ]
+#    }
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
index 260187b6b6..78fb15c464 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -205,39 +205,28 @@ fork_exec(struct socket *so, const char *ex, int do_pty)
 }
 #endif
 
-void slirp_connection_info(Slirp *slirp, Monitor *mon)
+void usernet_get_info(Slirp *slirp, UsernetInfo *info)
 {
-    const char * const tcpstates[] = {
-        [TCPS_CLOSED]       = "CLOSED",
-        [TCPS_LISTEN]       = "LISTEN",
-        [TCPS_SYN_SENT]     = "SYN_SENT",
-        [TCPS_SYN_RECEIVED] = "SYN_RCVD",
-        [TCPS_ESTABLISHED]  = "ESTABLISHED",
-        [TCPS_CLOSE_WAIT]   = "CLOSE_WAIT",
-        [TCPS_FIN_WAIT_1]   = "FIN_WAIT_1",
-        [TCPS_CLOSING]      = "CLOSING",
-        [TCPS_LAST_ACK]     = "LAST_ACK",
-        [TCPS_FIN_WAIT_2]   = "FIN_WAIT_2",
-        [TCPS_TIME_WAIT]    = "TIME_WAIT",
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
+            tcp->state = TCPS_NONE;
         }
         if (so->so_state & (SS_HOSTFWD | SS_INCOMING)) {
             src_len = sizeof(src);
@@ -250,46 +239,123 @@ void slirp_connection_info(Slirp *slirp, Monitor *mon)
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
+    }
+}
+
+
+void slirp_connection_info(Slirp *slirp, Monitor *mon)
+{
+    const char *state;
+    char buf[64];
+    UsernetInfo info = { };
+    UsernetConnectionList *cl;
+
+    monitor_printf(mon, "  Protocol[State]    FD  Source Address  Port   "
+                        "Dest. Address  Port RecvQ SendQ\n");
+
+    usernet_get_info(slirp, &info);
+    for (cl = info.connections; cl && cl->value; cl = cl->next) {
+        UsernetConnection *conn = cl->value;
+
+        if (conn->type == USERNET_TYPE_TCP) {
+            UsernetTCPConnection *tcp = &conn->u.tcp;
+
+            if (tcp->hostfwd) {
+                state = "HOST_FORWARD";
+            } else {
+                state = TCPS_str(tcp->state);
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
     }
 }
diff --git a/slirp/tcp.h b/slirp/tcp.h
index 174d3d960c..155569f380 100644
--- a/slirp/tcp.h
+++ b/slirp/tcp.h
@@ -133,21 +133,6 @@ struct tcphdr {
 
 #define TCP_NSTATES     11
 
-#define TCPS_CLOSED             0       /* closed */
-#define TCPS_LISTEN             1       /* listening for connection */
-#define TCPS_SYN_SENT           2       /* active, have sent syn */
-#define TCPS_SYN_RECEIVED       3       /* have send and received syn */
-/* states < TCPS_ESTABLISHED are those where connections not established */
-#define TCPS_ESTABLISHED        4       /* established */
-#define TCPS_CLOSE_WAIT         5       /* rcvd fin, waiting for close */
-/* states > TCPS_CLOSE_WAIT are those where user has closed */
-#define TCPS_FIN_WAIT_1         6       /* have closed, sent fin */
-#define TCPS_CLOSING            7       /* closed xchd FIN; await FIN ACK */
-#define TCPS_LAST_ACK           8       /* had fin and close; await FIN ACK */
-/* states > TCPS_CLOSE_WAIT && < TCPS_FIN_WAIT_2 await ACK of FIN */
-#define TCPS_FIN_WAIT_2         9       /* have closed, fin is acked */
-#define TCPS_TIME_WAIT          10      /* in 2*msl quiet wait after close */
-
 #define TCPS_HAVERCVDSYN(s)     ((s) >= TCPS_SYN_RECEIVED)
 #define TCPS_HAVEESTABLISHED(s) ((s) >= TCPS_ESTABLISHED)
 #define TCPS_HAVERCVDFIN(s)     ((s) >= TCPS_TIME_WAIT)
-- 
2.14.3
