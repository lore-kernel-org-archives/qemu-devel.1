Received: from eggs.gnu.org ([2001:4830:134:3::10]:40407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cft2d-0006mr-4P
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:50:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cft2b-0002TV-Sn
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:50:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cft2b-0002Sx-JO
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:50:29 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 20 Feb 2017 18:50:19 +0000
Message-Id: <20170220185020.774-5-dgilbert@redhat.com>
In-Reply-To: <20170220185020.774-1-dgilbert@redhat.com>
References: <20170220185020.774-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 4/5] slirp: VMStatify socket level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com
Cc: quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Working up the stack, this replaces the slirp_socket_load/save
with VMState definitions.

A place holder for IPv6 support is added as a comment; it needs
testing once the rest of the IPv6 code is there.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 slirp/slirp.c  | 170 ++++++++++++++++++++++++++++++---------------------------
 slirp/socket.h |   6 +-
 2 files changed, 93 insertions(+), 83 deletions(-)

diff --git a/slirp/slirp.c b/slirp/slirp.c
index 178c2b6..6583de8 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1250,40 +1250,99 @@ static const VMStateDescription vmstate_slirp_sbuf = {
     }
 };
 
+static bool slirp_older_than_v4(void *opaque, int version_id)
+{
+    return version_id < 4;
+}
 
-static void slirp_socket_save(QEMUFile *f, struct socket *so)
+static bool slirp_family_inet(void *opaque, int version_id)
 {
-    qemu_put_be32(f, so->so_urgc);
-    qemu_put_be16(f, so->so_ffamily);
-    switch (so->so_ffamily) {
-    case AF_INET:
-        qemu_put_be32(f, so->so_faddr.s_addr);
-        qemu_put_be16(f, so->so_fport);
-        break;
-    default:
-        error_report("so_ffamily unknown, unable to save so_faddr and"
-                     " so_fport");
-    }
-    qemu_put_be16(f, so->so_lfamily);
-    switch (so->so_lfamily) {
-    case AF_INET:
-        qemu_put_be32(f, so->so_laddr.s_addr);
-        qemu_put_be16(f, so->so_lport);
-        break;
-    default:
-        error_report("so_ffamily unknown, unable to save so_laddr and"
-                     " so_lport");
+    union slirp_sockaddr *ssa = (union slirp_sockaddr *)opaque;
+    return ssa->ss.ss_family == AF_INET;
+}
+
+static int slirp_socket_pre_load(void *opaque)
+{
+    struct socket *so = opaque;
+    if (tcp_attach(so) < 0) {
+        return -ENOMEM;
     }
-    qemu_put_byte(f, so->so_iptos);
-    qemu_put_byte(f, so->so_emu);
-    qemu_put_byte(f, so->so_type);
-    qemu_put_be32(f, so->so_state);
-    /* TODO: Build vmstate at this level */
-    vmstate_save_state(f, &vmstate_slirp_sbuf, &so->so_rcv, 0);
-    vmstate_save_state(f, &vmstate_slirp_sbuf, &so->so_snd, 0);
-    vmstate_save_state(f, &vmstate_slirp_tcp, so->so_tcpcb, 0);
+    /* Older versions don't load these fields */
+    so->so_ffamily = AF_INET;
+    so->so_lfamily = AF_INET;
+    return 0;
 }
 
+#ifndef _WIN32
+#define VMSTATE_SS_FAMILY(f, s) VMSTATE_UINT16(f, s)
+#define VMSTATE_SIN4_ADDR(f, s, t) VMSTATE_UINT32_TEST(f, s, t)
+#else
+/* Win has a signed family number */
+#define VMSTATE_SS_FAMILY(f, s) VMSTATE_INT16(f, s)
+/* Win uses u_long rather than uint32_t - but it's still 32bits long */
+#define VMSTATE_SIN4_ADDR(f, s, t) VMSTATE_SINGLE_TEST(f, s, t, 0, \
+                                       vmstate_info_uint32, u_long)
+#endif
+
+static const VMStateDescription vmstate_slirp_socket_addr = {
+    .name = "slirp-socket-addr",
+    .version_id = 4,
+    .fields = (VMStateField[]) {
+        VMSTATE_SS_FAMILY(ss.ss_family, union slirp_sockaddr),
+        VMSTATE_SIN4_ADDR(sin.sin_addr.s_addr, union slirp_sockaddr,
+                            slirp_family_inet),
+        VMSTATE_UINT16_TEST(sin.sin_port, union slirp_sockaddr,
+                            slirp_family_inet),
+
+#if 0
+        /* Untested: Needs checking by someone with IPv6 test */
+        VMSTATE_BUFFER_TEST(sin6.sin6_addr, union slirp_sockaddr,
+                            slirp_family_inet6),
+        VMSTATE_UINT16_TEST(sin6.sin6_port, union slirp_sockaddr,
+                            slirp_family_inet6),
+        VMSTATE_UINT32_TEST(sin6.sin6_flowinfo, union slirp_sockaddr,
+                            slirp_family_inet6),
+        VMSTATE_UINT32_TEST(sin6.sin6_scope_id, union slirp_sockaddr,
+                            slirp_family_inet6),
+#endif
+
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_slirp_socket = {
+    .name = "slirp-socket",
+    .version_id = 4,
+    .pre_load = slirp_socket_pre_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(so_urgc, struct socket),
+        /* Pre-v4 versions */
+        VMSTATE_SIN4_ADDR(so_faddr.s_addr, struct socket,
+                            slirp_older_than_v4),
+        VMSTATE_SIN4_ADDR(so_laddr.s_addr, struct socket,
+                            slirp_older_than_v4),
+        VMSTATE_UINT16_TEST(so_fport, struct socket, slirp_older_than_v4),
+        VMSTATE_UINT16_TEST(so_lport, struct socket, slirp_older_than_v4),
+        /* v4 and newer */
+        VMSTATE_STRUCT(fhost, struct socket, 4, vmstate_slirp_socket_addr,
+                       union slirp_sockaddr),
+        VMSTATE_STRUCT(lhost, struct socket, 4, vmstate_slirp_socket_addr,
+                       union slirp_sockaddr),
+
+        VMSTATE_UINT8(so_iptos, struct socket),
+        VMSTATE_UINT8(so_emu, struct socket),
+        VMSTATE_UINT8(so_type, struct socket),
+        VMSTATE_INT32(so_state, struct socket),
+        VMSTATE_STRUCT(so_rcv, struct socket, 0, vmstate_slirp_sbuf,
+                       struct sbuf),
+        VMSTATE_STRUCT(so_snd, struct socket, 0, vmstate_slirp_sbuf,
+                       struct sbuf),
+        VMSTATE_STRUCT_POINTER(so_tcpcb, struct socket, vmstate_slirp_tcp,
+                       struct tcpcb),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void slirp_bootp_save(QEMUFile *f, Slirp *slirp)
 {
     int i;
@@ -1308,7 +1367,7 @@ static void slirp_state_save(QEMUFile *f, void *opaque)
                 continue;
 
             qemu_put_byte(f, 42);
-            slirp_socket_save(f, so);
+            vmstate_save_state(f, &vmstate_slirp_socket, so, NULL);
         }
     qemu_put_byte(f, 0);
 
@@ -1317,55 +1376,6 @@ static void slirp_state_save(QEMUFile *f, void *opaque)
     slirp_bootp_save(f, slirp);
 }
 
-static int slirp_socket_load(QEMUFile *f, struct socket *so, int version_id)
-{
-    int ret = 0;
-    if (tcp_attach(so) < 0)
-        return -ENOMEM;
-
-    so->so_urgc = qemu_get_be32(f);
-    if (version_id <= 3) {
-        so->so_ffamily = AF_INET;
-        so->so_faddr.s_addr = qemu_get_be32(f);
-        so->so_laddr.s_addr = qemu_get_be32(f);
-        so->so_fport = qemu_get_be16(f);
-        so->so_lport = qemu_get_be16(f);
-    } else {
-        so->so_ffamily = qemu_get_be16(f);
-        switch (so->so_ffamily) {
-        case AF_INET:
-            so->so_faddr.s_addr = qemu_get_be32(f);
-            so->so_fport = qemu_get_be16(f);
-            break;
-        default:
-            error_report(
-                "so_ffamily unknown, unable to restore so_faddr and so_lport");
-        }
-        so->so_lfamily = qemu_get_be16(f);
-        switch (so->so_lfamily) {
-        case AF_INET:
-            so->so_laddr.s_addr = qemu_get_be32(f);
-            so->so_lport = qemu_get_be16(f);
-            break;
-        default:
-            error_report(
-                "so_ffamily unknown, unable to restore so_laddr and so_lport");
-        }
-    }
-    so->so_iptos = qemu_get_byte(f);
-    so->so_emu = qemu_get_byte(f);
-    so->so_type = qemu_get_byte(f);
-    so->so_state = qemu_get_be32(f);
-    /* TODO: VMState at this level */
-    ret = vmstate_load_state(f, &vmstate_slirp_sbuf, &so->so_rcv, 0);
-    if (!ret) {
-        ret = vmstate_load_state(f, &vmstate_slirp_sbuf, &so->so_snd, 0);
-    }
-    if (!ret) {
-        ret = vmstate_load_state(f, &vmstate_slirp_tcp, so->so_tcpcb, 0);
-    }
-    return ret;
-}
 
 static void slirp_bootp_load(QEMUFile *f, Slirp *slirp)
 {
@@ -1389,7 +1399,7 @@ static int slirp_state_load(QEMUFile *f, void *opaque, int version_id)
         if (!so)
             return -ENOMEM;
 
-        ret = slirp_socket_load(f, so, version_id);
+        ret = vmstate_load_state(f, &vmstate_slirp_socket, so, version_id);
 
         if (ret < 0)
             return ret;
diff --git a/slirp/socket.h b/slirp/socket.h
index c1be77e..2f224bc 100644
--- a/slirp/socket.h
+++ b/slirp/socket.h
@@ -36,7 +36,7 @@ struct socket {
 				    * PING reply's */
   struct tcpiphdr *so_ti;	   /* Pointer to the original ti within
 				    * so_mconn, for non-blocking connections */
-  int so_urgc;
+  uint32_t      so_urgc;
   union slirp_sockaddr fhost;      /* Foreign host */
 #define so_faddr fhost.sin.sin_addr
 #define so_fport fhost.sin.sin_port
@@ -54,8 +54,8 @@ struct socket {
   uint8_t	so_iptos;	/* Type of service */
   uint8_t	so_emu;		/* Is the socket emulated? */
 
-  u_char	so_type;		/* Type of socket, UDP or TCP */
-  int	so_state;		/* internal state flags SS_*, below */
+  uint8_t       so_type;        /* Type of socket, UDP or TCP */
+  int32_t       so_state;       /* internal state flags SS_*, below */
 
   struct 	tcpcb *so_tcpcb;	/* pointer to TCP protocol control block */
   u_int	so_expire;		/* When the socket will expire */
-- 
2.9.3
