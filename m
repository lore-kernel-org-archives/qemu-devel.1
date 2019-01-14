Received: from eggs.gnu.org ([209.51.188.92]:51309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipkB-000335-GH
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipk3-0006Og-I4
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:41 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gipk3-0006KQ-03
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:35 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 01:02:29 +0100
Message-Id: <20190114000326.29847-9-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
References: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/65] slirp: remove Monitor dependency,
 return a string for info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

There is nothing performance-sensitive in returning an allocated
string for info, and handling the monitor_printf() on the caller side.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 net/slirp.c      |  7 ++++---
 slirp/libslirp.h |  2 +-
 slirp/misc.c     | 23 +++++++++++++----------
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 58d880de8d..b7319ca6b2 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -828,10 +828,11 @@ void hmp_info_usernet(Monitor *mon, const QDict *qd=
ict)
     QTAILQ_FOREACH(s, &slirp_stacks, entry) {
         int id;
         bool got_hub_id =3D net_hub_id_for_client(&s->nc, &id) =3D=3D 0;
-        monitor_printf(mon, "Hub %d (%s):\n",
+        char *info =3D slirp_connection_info(s->slirp);
+        monitor_printf(mon, "Hub %d (%s):\n%s",
                        got_hub_id ? id : -1,
-                       s->nc.name);
-        slirp_connection_info(s->slirp, mon);
+                       s->nc.name, info);
+        g_free(info);
     }
 }
=20
diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index a4f390ee89..04b6db9f49 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -35,7 +35,7 @@ int slirp_remove_hostfwd(Slirp *slirp, int is_udp,
 int slirp_add_exec(Slirp *slirp, void *chardev, const char *cmdline,
                    struct in_addr *guest_addr, int guest_port);
=20
-void slirp_connection_info(Slirp *slirp, Monitor *mon);
+char *slirp_connection_info(Slirp *slirp);
=20
 void slirp_socket_recv(Slirp *slirp, struct in_addr guest_addr,
                        int guest_port, const uint8_t *buf, int size);
diff --git a/slirp/misc.c b/slirp/misc.c
index 2784fc420f..ce323ef92e 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -8,7 +8,6 @@
 #include "qemu/osdep.h"
 #include "slirp.h"
 #include "libslirp.h"
-#include "monitor/monitor.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
=20
@@ -198,8 +197,9 @@ fork_exec(struct socket *so, const char *ex)
 }
 #endif
=20
-void slirp_connection_info(Slirp *slirp, Monitor *mon)
+char *slirp_connection_info(Slirp *slirp)
 {
+    GString *str =3D g_string_new(NULL);
     const char * const tcpstates[] =3D {
         [TCPS_CLOSED]       =3D "CLOSED",
         [TCPS_LISTEN]       =3D "LISTEN",
@@ -221,8 +221,9 @@ void slirp_connection_info(Slirp *slirp, Monitor *mon=
)
     const char *state;
     char buf[20];
=20
-    monitor_printf(mon, "  Protocol[State]    FD  Source Address  Port  =
 "
-                        "Dest. Address  Port RecvQ SendQ\n");
+    g_string_append_printf(str,
+        "  Protocol[State]    FD  Source Address  Port   "
+        "Dest. Address  Port RecvQ SendQ\n");
=20
     for (so =3D slirp->tcb.so_next; so !=3D &slirp->tcb; so =3D so->so_n=
ext) {
         if (so->so_state & SS_HOSTFWD) {
@@ -244,10 +245,10 @@ void slirp_connection_info(Slirp *slirp, Monitor *m=
on)
             dst_port =3D so->so_fport;
         }
         snprintf(buf, sizeof(buf), "  TCP[%s]", state);
-        monitor_printf(mon, "%-19s %3d %15s %5d ", buf, so->s,
+        g_string_append_printf(str, "%-19s %3d %15s %5d ", buf, so->s,
                        src.sin_addr.s_addr ? inet_ntoa(src.sin_addr) : "=
*",
                        ntohs(src.sin_port));
-        monitor_printf(mon, "%15s %5d %5d %5d\n",
+        g_string_append_printf(str, "%15s %5d %5d %5d\n",
                        inet_ntoa(dst_addr), ntohs(dst_port),
                        so->so_rcv.sb_cc, so->so_snd.sb_cc);
     }
@@ -267,10 +268,10 @@ void slirp_connection_info(Slirp *slirp, Monitor *m=
on)
             dst_addr =3D so->so_faddr;
             dst_port =3D so->so_fport;
         }
-        monitor_printf(mon, "%-19s %3d %15s %5d ", buf, so->s,
+        g_string_append_printf(str, "%-19s %3d %15s %5d ", buf, so->s,
                        src.sin_addr.s_addr ? inet_ntoa(src.sin_addr) : "=
*",
                        ntohs(src.sin_port));
-        monitor_printf(mon, "%15s %5d %5d %5d\n",
+        g_string_append_printf(str, "%15s %5d %5d %5d\n",
                        inet_ntoa(dst_addr), ntohs(dst_port),
                        so->so_rcv.sb_cc, so->so_snd.sb_cc);
     }
@@ -280,9 +281,11 @@ void slirp_connection_info(Slirp *slirp, Monitor *mo=
n)
                      (so->so_expire - curtime) / 1000);
         src.sin_addr =3D so->so_laddr;
         dst_addr =3D so->so_faddr;
-        monitor_printf(mon, "%-19s %3d %15s  -    ", buf, so->s,
+        g_string_append_printf(str, "%-19s %3d %15s  -    ", buf, so->s,
                        src.sin_addr.s_addr ? inet_ntoa(src.sin_addr) : "=
*");
-        monitor_printf(mon, "%15s  -    %5d %5d\n", inet_ntoa(dst_addr),
+        g_string_append_printf(str, "%15s  -    %5d %5d\n", inet_ntoa(ds=
t_addr),
                        so->so_rcv.sb_cc, so->so_snd.sb_cc);
     }
+
+    return g_string_free(str, FALSE);
 }
--=20
2.20.1
