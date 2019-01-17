Received: from eggs.gnu.org ([209.51.188.92]:57572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk66u-00066N-Fh
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk66m-000561-11
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk66g-0004wG-Fy
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:12 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:44 +0400
Message-Id: <20190117114359.5164-13-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/27] slirp: move QEMU state saving to a
 separate unit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, pbonzini@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>

Make state saving optional: this will allow to build SLIRP without
QEMU. (eventually, the vmstate helpers will be extracted, so an
external project & process could save its state)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/slirp.h       |   3 +
 slirp/state.h       |   9 +
 slirp/slirp.c       | 372 ++---------------------------------------
 slirp/state.c       | 394 ++++++++++++++++++++++++++++++++++++++++++++
 slirp/Makefile.objs |   3 +-
 5 files changed, 419 insertions(+), 362 deletions(-)
 create mode 100644 slirp/state.h
 create mode 100644 slirp/state.c

diff --git a/slirp/slirp.h b/slirp/slirp.h
index 67ff4d610c4..8d9d72ca9d0 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -271,4 +271,7 @@ int tcp_emu(struct socket *, struct mbuf *);
 int tcp_ctl(struct socket *);
 struct tcpcb *tcp_drop(struct tcpcb *tp, int err);
=20
+struct socket *
+slirp_find_ctl_socket(Slirp *slirp, struct in_addr guest_addr, int guest=
_port);
+
 #endif
diff --git a/slirp/state.h b/slirp/state.h
new file mode 100644
index 00000000000..154866898f5
--- /dev/null
+++ b/slirp/state.h
@@ -0,0 +1,9 @@
+#ifndef SLIRP_STATE_H_
+#define SLIRP_STATE_H_
+
+#include "libslirp.h"
+
+void slirp_state_register(Slirp *slirp);
+void slirp_state_unregister(Slirp *slirp);
+
+#endif /* SLIRP_STATE_H_ */
diff --git a/slirp/slirp.c b/slirp/slirp.c
index fdf26d5e626..5450b52dbf4 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -30,6 +30,10 @@
 #include "hw/hw.h"
 #include "qemu/cutils.h"
=20
+#ifdef WITH_QEMU
+#include "state.h"
+#endif
+
 #ifndef _WIN32
 #include <net/if.h>
 #endif
@@ -278,14 +282,6 @@ static void slirp_init_once(void)
=20
 }
=20
-static void slirp_state_save(QEMUFile *f, void *opaque);
-static int slirp_state_load(QEMUFile *f, void *opaque, int version_id);
-
-static SaveVMHandlers savevm_slirp_state =3D {
-    .save_state =3D slirp_state_save,
-    .load_state =3D slirp_state_load,
-};
-
 Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwo=
rk,
                   struct in_addr vnetmask, struct in_addr vhost,
                   bool in6_enabled,
@@ -341,8 +337,9 @@ Slirp *slirp_init(int restricted, bool in_enabled, st=
ruct in_addr vnetwork,
=20
     slirp->opaque =3D opaque;
=20
-    register_savevm_live(NULL, "slirp", 0, 4, &savevm_slirp_state, slirp=
);
-
+#ifdef WITH_QEMU
+    slirp_state_register(slirp);
+#endif
     QTAILQ_INSERT_TAIL(&slirp_instances, slirp, entry);
=20
     return slirp;
@@ -359,9 +356,9 @@ void slirp_cleanup(Slirp *slirp)
     }
=20
     QTAILQ_REMOVE(&slirp_instances, slirp, entry);
-
-    unregister_savevm(NULL, "slirp", slirp);
-
+#ifdef WITH_QEMU
+    slirp_state_unregister(slirp);
+#endif
     ip_cleanup(slirp);
     ip6_cleanup(slirp);
     m_cleanup(slirp);
@@ -1115,7 +1112,7 @@ ssize_t slirp_send(struct socket *so, const void *b=
uf, size_t len, int flags)
     return send(so->s, buf, len, flags);
 }
=20
-static struct socket *
+struct socket *
 slirp_find_ctl_socket(Slirp *slirp, struct in_addr guest_addr, int guest=
_port)
 {
     struct socket *so;
@@ -1162,350 +1159,3 @@ void slirp_socket_recv(Slirp *slirp, struct in_ad=
dr guest_addr, int guest_port,
     if (ret > 0)
         tcp_output(sototcpcb(so));
 }
-
-static int slirp_tcp_post_load(void *opaque, int version)
-{
-    tcp_template((struct tcpcb *)opaque);
-
-    return 0;
-}
-
-static const VMStateDescription vmstate_slirp_tcp =3D {
-    .name =3D "slirp-tcp",
-    .version_id =3D 0,
-    .post_load =3D slirp_tcp_post_load,
-    .fields =3D (VMStateField[]) {
-        VMSTATE_INT16(t_state, struct tcpcb),
-        VMSTATE_INT16_ARRAY(t_timer, struct tcpcb, TCPT_NTIMERS),
-        VMSTATE_INT16(t_rxtshift, struct tcpcb),
-        VMSTATE_INT16(t_rxtcur, struct tcpcb),
-        VMSTATE_INT16(t_dupacks, struct tcpcb),
-        VMSTATE_UINT16(t_maxseg, struct tcpcb),
-        VMSTATE_UINT8(t_force, struct tcpcb),
-        VMSTATE_UINT16(t_flags, struct tcpcb),
-        VMSTATE_UINT32(snd_una, struct tcpcb),
-        VMSTATE_UINT32(snd_nxt, struct tcpcb),
-        VMSTATE_UINT32(snd_up, struct tcpcb),
-        VMSTATE_UINT32(snd_wl1, struct tcpcb),
-        VMSTATE_UINT32(snd_wl2, struct tcpcb),
-        VMSTATE_UINT32(iss, struct tcpcb),
-        VMSTATE_UINT32(snd_wnd, struct tcpcb),
-        VMSTATE_UINT32(rcv_wnd, struct tcpcb),
-        VMSTATE_UINT32(rcv_nxt, struct tcpcb),
-        VMSTATE_UINT32(rcv_up, struct tcpcb),
-        VMSTATE_UINT32(irs, struct tcpcb),
-        VMSTATE_UINT32(rcv_adv, struct tcpcb),
-        VMSTATE_UINT32(snd_max, struct tcpcb),
-        VMSTATE_UINT32(snd_cwnd, struct tcpcb),
-        VMSTATE_UINT32(snd_ssthresh, struct tcpcb),
-        VMSTATE_INT16(t_idle, struct tcpcb),
-        VMSTATE_INT16(t_rtt, struct tcpcb),
-        VMSTATE_UINT32(t_rtseq, struct tcpcb),
-        VMSTATE_INT16(t_srtt, struct tcpcb),
-        VMSTATE_INT16(t_rttvar, struct tcpcb),
-        VMSTATE_UINT16(t_rttmin, struct tcpcb),
-        VMSTATE_UINT32(max_sndwnd, struct tcpcb),
-        VMSTATE_UINT8(t_oobflags, struct tcpcb),
-        VMSTATE_UINT8(t_iobc, struct tcpcb),
-        VMSTATE_INT16(t_softerror, struct tcpcb),
-        VMSTATE_UINT8(snd_scale, struct tcpcb),
-        VMSTATE_UINT8(rcv_scale, struct tcpcb),
-        VMSTATE_UINT8(request_r_scale, struct tcpcb),
-        VMSTATE_UINT8(requested_s_scale, struct tcpcb),
-        VMSTATE_UINT32(ts_recent, struct tcpcb),
-        VMSTATE_UINT32(ts_recent_age, struct tcpcb),
-        VMSTATE_UINT32(last_ack_sent, struct tcpcb),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-/* The sbuf has a pair of pointers that are migrated as offsets;
- * we calculate the offsets and restore the pointers using
- * pre_save/post_load on a tmp structure.
- */
-struct sbuf_tmp {
-    struct sbuf *parent;
-    uint32_t roff, woff;
-};
-
-static int sbuf_tmp_pre_save(void *opaque)
-{
-    struct sbuf_tmp *tmp =3D opaque;
-    tmp->woff =3D tmp->parent->sb_wptr - tmp->parent->sb_data;
-    tmp->roff =3D tmp->parent->sb_rptr - tmp->parent->sb_data;
-
-    return 0;
-}
-
-static int sbuf_tmp_post_load(void *opaque, int version)
-{
-    struct sbuf_tmp *tmp =3D opaque;
-    uint32_t requested_len =3D tmp->parent->sb_datalen;
-
-    /* Allocate the buffer space used by the field after the tmp */
-    sbreserve(tmp->parent, tmp->parent->sb_datalen);
-
-    if (tmp->parent->sb_datalen !=3D requested_len) {
-        return -ENOMEM;
-    }
-    if (tmp->woff >=3D requested_len ||
-        tmp->roff >=3D requested_len) {
-        g_critical("invalid sbuf offsets r/w=3D%u/%u len=3D%u",
-                   tmp->roff, tmp->woff, requested_len);
-        return -EINVAL;
-    }
-
-    tmp->parent->sb_wptr =3D tmp->parent->sb_data + tmp->woff;
-    tmp->parent->sb_rptr =3D tmp->parent->sb_data + tmp->roff;
-
-    return 0;
-}
-
-
-static const VMStateDescription vmstate_slirp_sbuf_tmp =3D {
-    .name =3D "slirp-sbuf-tmp",
-    .post_load =3D sbuf_tmp_post_load,
-    .pre_save  =3D sbuf_tmp_pre_save,
-    .version_id =3D 0,
-    .fields =3D (VMStateField[]) {
-        VMSTATE_UINT32(woff, struct sbuf_tmp),
-        VMSTATE_UINT32(roff, struct sbuf_tmp),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static const VMStateDescription vmstate_slirp_sbuf =3D {
-    .name =3D "slirp-sbuf",
-    .version_id =3D 0,
-    .fields =3D (VMStateField[]) {
-        VMSTATE_UINT32(sb_cc, struct sbuf),
-        VMSTATE_UINT32(sb_datalen, struct sbuf),
-        VMSTATE_WITH_TMP(struct sbuf, struct sbuf_tmp, vmstate_slirp_sbu=
f_tmp),
-        VMSTATE_VBUFFER_UINT32(sb_data, struct sbuf, 0, NULL, sb_datalen=
),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static bool slirp_older_than_v4(void *opaque, int version_id)
-{
-    return version_id < 4;
-}
-
-static bool slirp_family_inet(void *opaque, int version_id)
-{
-    union slirp_sockaddr *ssa =3D (union slirp_sockaddr *)opaque;
-    return ssa->ss.ss_family =3D=3D AF_INET;
-}
-
-static int slirp_socket_pre_load(void *opaque)
-{
-    struct socket *so =3D opaque;
-    if (tcp_attach(so) < 0) {
-        return -ENOMEM;
-    }
-    /* Older versions don't load these fields */
-    so->so_ffamily =3D AF_INET;
-    so->so_lfamily =3D AF_INET;
-    return 0;
-}
-
-#ifndef _WIN32
-#define VMSTATE_SIN4_ADDR(f, s, t) VMSTATE_UINT32_TEST(f, s, t)
-#else
-/* Win uses u_long rather than uint32_t - but it's still 32bits long */
-#define VMSTATE_SIN4_ADDR(f, s, t) VMSTATE_SINGLE_TEST(f, s, t, 0, \
-                                       vmstate_info_uint32, u_long)
-#endif
-
-/* The OS provided ss_family field isn't that portable; it's size
- * and type varies (16/8 bit, signed, unsigned)
- * and the values it contains aren't fully portable.
- */
-typedef struct SS_FamilyTmpStruct {
-    union slirp_sockaddr    *parent;
-    uint16_t                 portable_family;
-} SS_FamilyTmpStruct;
-
-#define SS_FAMILY_MIG_IPV4   2  /* Linux, BSD, Win... */
-#define SS_FAMILY_MIG_IPV6  10  /* Linux */
-#define SS_FAMILY_MIG_OTHER 0xffff
-
-static int ss_family_pre_save(void *opaque)
-{
-    SS_FamilyTmpStruct *tss =3D opaque;
-
-    tss->portable_family =3D SS_FAMILY_MIG_OTHER;
-
-    if (tss->parent->ss.ss_family =3D=3D AF_INET) {
-        tss->portable_family =3D SS_FAMILY_MIG_IPV4;
-    } else if (tss->parent->ss.ss_family =3D=3D AF_INET6) {
-        tss->portable_family =3D SS_FAMILY_MIG_IPV6;
-    }
-
-    return 0;
-}
-
-static int ss_family_post_load(void *opaque, int version_id)
-{
-    SS_FamilyTmpStruct *tss =3D opaque;
-
-    switch (tss->portable_family) {
-    case SS_FAMILY_MIG_IPV4:
-        tss->parent->ss.ss_family =3D AF_INET;
-        break;
-    case SS_FAMILY_MIG_IPV6:
-    case 23: /* compatibility: AF_INET6 from mingw */
-    case 28: /* compatibility: AF_INET6 from FreeBSD sys/socket.h */
-        tss->parent->ss.ss_family =3D AF_INET6;
-        break;
-    default:
-        g_critical("invalid ss_family type %x", tss->portable_family);
-        return -EINVAL;
-    }
-
-    return 0;
-}
-
-static const VMStateDescription vmstate_slirp_ss_family =3D {
-    .name =3D "slirp-socket-addr/ss_family",
-    .pre_save  =3D ss_family_pre_save,
-    .post_load =3D ss_family_post_load,
-    .fields =3D (VMStateField[]) {
-        VMSTATE_UINT16(portable_family, SS_FamilyTmpStruct),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static const VMStateDescription vmstate_slirp_socket_addr =3D {
-    .name =3D "slirp-socket-addr",
-    .version_id =3D 4,
-    .fields =3D (VMStateField[]) {
-        VMSTATE_WITH_TMP(union slirp_sockaddr, SS_FamilyTmpStruct,
-                            vmstate_slirp_ss_family),
-        VMSTATE_SIN4_ADDR(sin.sin_addr.s_addr, union slirp_sockaddr,
-                            slirp_family_inet),
-        VMSTATE_UINT16_TEST(sin.sin_port, union slirp_sockaddr,
-                            slirp_family_inet),
-
-#if 0
-        /* Untested: Needs checking by someone with IPv6 test */
-        VMSTATE_BUFFER_TEST(sin6.sin6_addr, union slirp_sockaddr,
-                            slirp_family_inet6),
-        VMSTATE_UINT16_TEST(sin6.sin6_port, union slirp_sockaddr,
-                            slirp_family_inet6),
-        VMSTATE_UINT32_TEST(sin6.sin6_flowinfo, union slirp_sockaddr,
-                            slirp_family_inet6),
-        VMSTATE_UINT32_TEST(sin6.sin6_scope_id, union slirp_sockaddr,
-                            slirp_family_inet6),
-#endif
-
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static const VMStateDescription vmstate_slirp_socket =3D {
-    .name =3D "slirp-socket",
-    .version_id =3D 4,
-    .pre_load =3D slirp_socket_pre_load,
-    .fields =3D (VMStateField[]) {
-        VMSTATE_UINT32(so_urgc, struct socket),
-        /* Pre-v4 versions */
-        VMSTATE_SIN4_ADDR(so_faddr.s_addr, struct socket,
-                            slirp_older_than_v4),
-        VMSTATE_SIN4_ADDR(so_laddr.s_addr, struct socket,
-                            slirp_older_than_v4),
-        VMSTATE_UINT16_TEST(so_fport, struct socket, slirp_older_than_v4=
),
-        VMSTATE_UINT16_TEST(so_lport, struct socket, slirp_older_than_v4=
),
-        /* v4 and newer */
-        VMSTATE_STRUCT(fhost, struct socket, 4, vmstate_slirp_socket_add=
r,
-                       union slirp_sockaddr),
-        VMSTATE_STRUCT(lhost, struct socket, 4, vmstate_slirp_socket_add=
r,
-                       union slirp_sockaddr),
-
-        VMSTATE_UINT8(so_iptos, struct socket),
-        VMSTATE_UINT8(so_emu, struct socket),
-        VMSTATE_UINT8(so_type, struct socket),
-        VMSTATE_INT32(so_state, struct socket),
-        VMSTATE_STRUCT(so_rcv, struct socket, 0, vmstate_slirp_sbuf,
-                       struct sbuf),
-        VMSTATE_STRUCT(so_snd, struct socket, 0, vmstate_slirp_sbuf,
-                       struct sbuf),
-        VMSTATE_STRUCT_POINTER(so_tcpcb, struct socket, vmstate_slirp_tc=
p,
-                       struct tcpcb),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static const VMStateDescription vmstate_slirp_bootp_client =3D {
-    .name =3D "slirp_bootpclient",
-    .fields =3D (VMStateField[]) {
-        VMSTATE_UINT16(allocated, BOOTPClient),
-        VMSTATE_BUFFER(macaddr, BOOTPClient),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static const VMStateDescription vmstate_slirp =3D {
-    .name =3D "slirp",
-    .version_id =3D 4,
-    .fields =3D (VMStateField[]) {
-        VMSTATE_UINT16_V(ip_id, Slirp, 2),
-        VMSTATE_STRUCT_ARRAY(bootp_clients, Slirp, NB_BOOTP_CLIENTS, 3,
-                             vmstate_slirp_bootp_client, BOOTPClient),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void slirp_state_save(QEMUFile *f, void *opaque)
-{
-    Slirp *slirp =3D opaque;
-    struct gfwd_list *ex_ptr;
-
-    for (ex_ptr =3D slirp->guestfwd_list; ex_ptr; ex_ptr =3D ex_ptr->ex_=
next)
-        if (ex_ptr->write_cb) {
-            struct socket *so;
-            so =3D slirp_find_ctl_socket(slirp, ex_ptr->ex_addr,
-                                       ntohs(ex_ptr->ex_fport));
-            if (!so)
-                continue;
-
-            qemu_put_byte(f, 42);
-            vmstate_save_state(f, &vmstate_slirp_socket, so, NULL);
-        }
-    qemu_put_byte(f, 0);
-
-    vmstate_save_state(f, &vmstate_slirp, slirp, NULL);
-}
-
-
-static int slirp_state_load(QEMUFile *f, void *opaque, int version_id)
-{
-    Slirp *slirp =3D opaque;
-    struct gfwd_list *ex_ptr;
-
-    while (qemu_get_byte(f)) {
-        int ret;
-        struct socket *so =3D socreate(slirp);
-
-        ret =3D vmstate_load_state(f, &vmstate_slirp_socket, so, version=
_id);
-
-        if (ret < 0)
-            return ret;
-
-        if ((so->so_faddr.s_addr & slirp->vnetwork_mask.s_addr) !=3D
-            slirp->vnetwork_addr.s_addr) {
-            return -EINVAL;
-        }
-        for (ex_ptr =3D slirp->guestfwd_list; ex_ptr; ex_ptr =3D ex_ptr-=
>ex_next) {
-            if (ex_ptr->write_cb &&
-                so->so_faddr.s_addr =3D=3D ex_ptr->ex_addr.s_addr &&
-                so->so_fport =3D=3D ex_ptr->ex_fport) {
-                break;
-            }
-        }
-        if (!ex_ptr)
-            return -EINVAL;
-    }
-
-    return vmstate_load_state(f, &vmstate_slirp, slirp, version_id);
-}
diff --git a/slirp/state.c b/slirp/state.c
new file mode 100644
index 00000000000..0e5a706e877
--- /dev/null
+++ b/slirp/state.c
@@ -0,0 +1,394 @@
+/*
+ * libslirp
+ *
+ * Copyright (c) 2004-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+
+#include "slirp.h"
+#include "state.h"
+#include "migration/vmstate.h"
+#include "migration/qemu-file-types.h"
+#include "migration/register.h"
+
+static int slirp_tcp_post_load(void *opaque, int version)
+{
+    tcp_template((struct tcpcb *)opaque);
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_slirp_tcp =3D {
+    .name =3D "slirp-tcp",
+    .version_id =3D 0,
+    .post_load =3D slirp_tcp_post_load,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_INT16(t_state, struct tcpcb),
+        VMSTATE_INT16_ARRAY(t_timer, struct tcpcb, TCPT_NTIMERS),
+        VMSTATE_INT16(t_rxtshift, struct tcpcb),
+        VMSTATE_INT16(t_rxtcur, struct tcpcb),
+        VMSTATE_INT16(t_dupacks, struct tcpcb),
+        VMSTATE_UINT16(t_maxseg, struct tcpcb),
+        VMSTATE_UINT8(t_force, struct tcpcb),
+        VMSTATE_UINT16(t_flags, struct tcpcb),
+        VMSTATE_UINT32(snd_una, struct tcpcb),
+        VMSTATE_UINT32(snd_nxt, struct tcpcb),
+        VMSTATE_UINT32(snd_up, struct tcpcb),
+        VMSTATE_UINT32(snd_wl1, struct tcpcb),
+        VMSTATE_UINT32(snd_wl2, struct tcpcb),
+        VMSTATE_UINT32(iss, struct tcpcb),
+        VMSTATE_UINT32(snd_wnd, struct tcpcb),
+        VMSTATE_UINT32(rcv_wnd, struct tcpcb),
+        VMSTATE_UINT32(rcv_nxt, struct tcpcb),
+        VMSTATE_UINT32(rcv_up, struct tcpcb),
+        VMSTATE_UINT32(irs, struct tcpcb),
+        VMSTATE_UINT32(rcv_adv, struct tcpcb),
+        VMSTATE_UINT32(snd_max, struct tcpcb),
+        VMSTATE_UINT32(snd_cwnd, struct tcpcb),
+        VMSTATE_UINT32(snd_ssthresh, struct tcpcb),
+        VMSTATE_INT16(t_idle, struct tcpcb),
+        VMSTATE_INT16(t_rtt, struct tcpcb),
+        VMSTATE_UINT32(t_rtseq, struct tcpcb),
+        VMSTATE_INT16(t_srtt, struct tcpcb),
+        VMSTATE_INT16(t_rttvar, struct tcpcb),
+        VMSTATE_UINT16(t_rttmin, struct tcpcb),
+        VMSTATE_UINT32(max_sndwnd, struct tcpcb),
+        VMSTATE_UINT8(t_oobflags, struct tcpcb),
+        VMSTATE_UINT8(t_iobc, struct tcpcb),
+        VMSTATE_INT16(t_softerror, struct tcpcb),
+        VMSTATE_UINT8(snd_scale, struct tcpcb),
+        VMSTATE_UINT8(rcv_scale, struct tcpcb),
+        VMSTATE_UINT8(request_r_scale, struct tcpcb),
+        VMSTATE_UINT8(requested_s_scale, struct tcpcb),
+        VMSTATE_UINT32(ts_recent, struct tcpcb),
+        VMSTATE_UINT32(ts_recent_age, struct tcpcb),
+        VMSTATE_UINT32(last_ack_sent, struct tcpcb),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+/* The sbuf has a pair of pointers that are migrated as offsets;
+ * we calculate the offsets and restore the pointers using
+ * pre_save/post_load on a tmp structure.
+ */
+struct sbuf_tmp {
+    struct sbuf *parent;
+    uint32_t roff, woff;
+};
+
+static int sbuf_tmp_pre_save(void *opaque)
+{
+    struct sbuf_tmp *tmp =3D opaque;
+    tmp->woff =3D tmp->parent->sb_wptr - tmp->parent->sb_data;
+    tmp->roff =3D tmp->parent->sb_rptr - tmp->parent->sb_data;
+
+    return 0;
+}
+
+static int sbuf_tmp_post_load(void *opaque, int version)
+{
+    struct sbuf_tmp *tmp =3D opaque;
+    uint32_t requested_len =3D tmp->parent->sb_datalen;
+
+    /* Allocate the buffer space used by the field after the tmp */
+    sbreserve(tmp->parent, tmp->parent->sb_datalen);
+
+    if (tmp->parent->sb_datalen !=3D requested_len) {
+        return -ENOMEM;
+    }
+    if (tmp->woff >=3D requested_len ||
+        tmp->roff >=3D requested_len) {
+        g_critical("invalid sbuf offsets r/w=3D%u/%u len=3D%u",
+                   tmp->roff, tmp->woff, requested_len);
+        return -EINVAL;
+    }
+
+    tmp->parent->sb_wptr =3D tmp->parent->sb_data + tmp->woff;
+    tmp->parent->sb_rptr =3D tmp->parent->sb_data + tmp->roff;
+
+    return 0;
+}
+
+
+static const VMStateDescription vmstate_slirp_sbuf_tmp =3D {
+    .name =3D "slirp-sbuf-tmp",
+    .post_load =3D sbuf_tmp_post_load,
+    .pre_save  =3D sbuf_tmp_pre_save,
+    .version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(woff, struct sbuf_tmp),
+        VMSTATE_UINT32(roff, struct sbuf_tmp),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_slirp_sbuf =3D {
+    .name =3D "slirp-sbuf",
+    .version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(sb_cc, struct sbuf),
+        VMSTATE_UINT32(sb_datalen, struct sbuf),
+        VMSTATE_WITH_TMP(struct sbuf, struct sbuf_tmp, vmstate_slirp_sbu=
f_tmp),
+        VMSTATE_VBUFFER_UINT32(sb_data, struct sbuf, 0, NULL, sb_datalen=
),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool slirp_older_than_v4(void *opaque, int version_id)
+{
+    return version_id < 4;
+}
+
+static bool slirp_family_inet(void *opaque, int version_id)
+{
+    union slirp_sockaddr *ssa =3D (union slirp_sockaddr *)opaque;
+    return ssa->ss.ss_family =3D=3D AF_INET;
+}
+
+static int slirp_socket_pre_load(void *opaque)
+{
+    struct socket *so =3D opaque;
+    if (tcp_attach(so) < 0) {
+        return -ENOMEM;
+    }
+    /* Older versions don't load these fields */
+    so->so_ffamily =3D AF_INET;
+    so->so_lfamily =3D AF_INET;
+    return 0;
+}
+
+#ifndef _WIN32
+#define VMSTATE_SIN4_ADDR(f, s, t) VMSTATE_UINT32_TEST(f, s, t)
+#else
+/* Win uses u_long rather than uint32_t - but it's still 32bits long */
+#define VMSTATE_SIN4_ADDR(f, s, t) VMSTATE_SINGLE_TEST(f, s, t, 0, \
+                                       vmstate_info_uint32, u_long)
+#endif
+
+/* The OS provided ss_family field isn't that portable; it's size
+ * and type varies (16/8 bit, signed, unsigned)
+ * and the values it contains aren't fully portable.
+ */
+typedef struct SS_FamilyTmpStruct {
+    union slirp_sockaddr    *parent;
+    uint16_t                 portable_family;
+} SS_FamilyTmpStruct;
+
+#define SS_FAMILY_MIG_IPV4   2  /* Linux, BSD, Win... */
+#define SS_FAMILY_MIG_IPV6  10  /* Linux */
+#define SS_FAMILY_MIG_OTHER 0xffff
+
+static int ss_family_pre_save(void *opaque)
+{
+    SS_FamilyTmpStruct *tss =3D opaque;
+
+    tss->portable_family =3D SS_FAMILY_MIG_OTHER;
+
+    if (tss->parent->ss.ss_family =3D=3D AF_INET) {
+        tss->portable_family =3D SS_FAMILY_MIG_IPV4;
+    } else if (tss->parent->ss.ss_family =3D=3D AF_INET6) {
+        tss->portable_family =3D SS_FAMILY_MIG_IPV6;
+    }
+
+    return 0;
+}
+
+static int ss_family_post_load(void *opaque, int version_id)
+{
+    SS_FamilyTmpStruct *tss =3D opaque;
+
+    switch (tss->portable_family) {
+    case SS_FAMILY_MIG_IPV4:
+        tss->parent->ss.ss_family =3D AF_INET;
+        break;
+    case SS_FAMILY_MIG_IPV6:
+    case 23: /* compatibility: AF_INET6 from mingw */
+    case 28: /* compatibility: AF_INET6 from FreeBSD sys/socket.h */
+        tss->parent->ss.ss_family =3D AF_INET6;
+        break;
+    default:
+        g_critical("invalid ss_family type %x", tss->portable_family);
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_slirp_ss_family =3D {
+    .name =3D "slirp-socket-addr/ss_family",
+    .pre_save  =3D ss_family_pre_save,
+    .post_load =3D ss_family_post_load,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT16(portable_family, SS_FamilyTmpStruct),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_slirp_socket_addr =3D {
+    .name =3D "slirp-socket-addr",
+    .version_id =3D 4,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_WITH_TMP(union slirp_sockaddr, SS_FamilyTmpStruct,
+                            vmstate_slirp_ss_family),
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
+static const VMStateDescription vmstate_slirp_socket =3D {
+    .name =3D "slirp-socket",
+    .version_id =3D 4,
+    .pre_load =3D slirp_socket_pre_load,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(so_urgc, struct socket),
+        /* Pre-v4 versions */
+        VMSTATE_SIN4_ADDR(so_faddr.s_addr, struct socket,
+                            slirp_older_than_v4),
+        VMSTATE_SIN4_ADDR(so_laddr.s_addr, struct socket,
+                            slirp_older_than_v4),
+        VMSTATE_UINT16_TEST(so_fport, struct socket, slirp_older_than_v4=
),
+        VMSTATE_UINT16_TEST(so_lport, struct socket, slirp_older_than_v4=
),
+        /* v4 and newer */
+        VMSTATE_STRUCT(fhost, struct socket, 4, vmstate_slirp_socket_add=
r,
+                       union slirp_sockaddr),
+        VMSTATE_STRUCT(lhost, struct socket, 4, vmstate_slirp_socket_add=
r,
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
+        VMSTATE_STRUCT_POINTER(so_tcpcb, struct socket, vmstate_slirp_tc=
p,
+                       struct tcpcb),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_slirp_bootp_client =3D {
+    .name =3D "slirp_bootpclient",
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT16(allocated, BOOTPClient),
+        VMSTATE_BUFFER(macaddr, BOOTPClient),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_slirp =3D {
+    .name =3D "slirp",
+    .version_id =3D 4,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT16_V(ip_id, Slirp, 2),
+        VMSTATE_STRUCT_ARRAY(bootp_clients, Slirp, NB_BOOTP_CLIENTS, 3,
+                             vmstate_slirp_bootp_client, BOOTPClient),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void slirp_state_save(QEMUFile *f, void *opaque)
+{
+    Slirp *slirp =3D opaque;
+    struct gfwd_list *ex_ptr;
+
+    for (ex_ptr =3D slirp->guestfwd_list; ex_ptr; ex_ptr =3D ex_ptr->ex_=
next)
+        if (ex_ptr->write_cb) {
+            struct socket *so;
+            so =3D slirp_find_ctl_socket(slirp, ex_ptr->ex_addr,
+                                       ntohs(ex_ptr->ex_fport));
+            if (!so) {
+                continue;
+            }
+
+            qemu_put_byte(f, 42);
+            vmstate_save_state(f, &vmstate_slirp_socket, so, NULL);
+        }
+    qemu_put_byte(f, 0);
+
+    vmstate_save_state(f, &vmstate_slirp, slirp, NULL);
+}
+
+
+static int slirp_state_load(QEMUFile *f, void *opaque, int version_id)
+{
+    Slirp *slirp =3D opaque;
+    struct gfwd_list *ex_ptr;
+
+    while (qemu_get_byte(f)) {
+        int ret;
+        struct socket *so =3D socreate(slirp);
+
+        ret =3D vmstate_load_state(f, &vmstate_slirp_socket, so, version=
_id);
+        if (ret < 0) {
+            return ret;
+        }
+
+        if ((so->so_faddr.s_addr & slirp->vnetwork_mask.s_addr) !=3D
+            slirp->vnetwork_addr.s_addr) {
+            return -EINVAL;
+        }
+        for (ex_ptr =3D slirp->guestfwd_list; ex_ptr; ex_ptr =3D ex_ptr-=
>ex_next) {
+            if (ex_ptr->write_cb &&
+                so->so_faddr.s_addr =3D=3D ex_ptr->ex_addr.s_addr &&
+                so->so_fport =3D=3D ex_ptr->ex_fport) {
+                break;
+            }
+        }
+        if (!ex_ptr) {
+            return -EINVAL;
+        }
+    }
+
+    return vmstate_load_state(f, &vmstate_slirp, slirp, version_id);
+}
+
+void slirp_state_register(Slirp *slirp)
+{
+    static SaveVMHandlers savevm_slirp_state =3D {
+        .save_state =3D slirp_state_save,
+        .load_state =3D slirp_state_load,
+    };
+
+    register_savevm_live(NULL, "slirp", 0, 4, &savevm_slirp_state, slirp=
);
+}
+
+void slirp_state_unregister(Slirp *slirp)
+{
+    unregister_savevm(NULL, "slirp", slirp);
+}
diff --git a/slirp/Makefile.objs b/slirp/Makefile.objs
index 38ebdb416e3..61cdcc6877f 100644
--- a/slirp/Makefile.objs
+++ b/slirp/Makefile.objs
@@ -20,6 +20,7 @@ slirp.mo-objs =3D \
 	sbuf.o \
 	slirp.o \
 	socket.o \
+	state.o \
 	tcp_input.o \
 	tcp_output.o \
 	tcp_subr.o \
@@ -30,4 +31,4 @@ slirp.mo-objs =3D \
 	util.o \
 	$(NULL)
=20
-slirp.mo-cflags =3D -DG_LOG_DOMAIN=3D\"Slirp\"
+slirp.mo-cflags =3D -DG_LOG_DOMAIN=3D\"Slirp\" -DWITH_QEMU=3D1
--=20
2.20.1.98.gecbdaf0899
