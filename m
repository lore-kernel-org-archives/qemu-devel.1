Received: from eggs.gnu.org ([2001:4830:134:3::10]:43160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ce4Ar-0001eN-OW
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:19:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ce4Ap-0006Yr-JQ
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:19:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ce4Ap-0006YJ-AB
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:19:27 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 15 Feb 2017 18:19:18 +0000
Message-Id: <20170215181922.11624-2-dgilbert@redhat.com>
In-Reply-To: <20170215181922.11624-1-dgilbert@redhat.com>
References: <20170215181922.11624-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/5] slirp: VMState conversion; tcpcb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com
Cc: quintela@redhat.com, lvivier@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Convert the migration of the struct tcpcb to use a VMStateDescription,
the rest of it will come later.

Mostly mechanical, except for conversion of some 'char' to uint8_t
to ensure portability.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 slirp/slirp.c   | 149 ++++++++++++++++++++------------------------------------
 slirp/tcp_var.h |   6 +--
 2 files changed, 57 insertions(+), 98 deletions(-)

diff --git a/slirp/slirp.c b/slirp/slirp.c
index 60539de..276d8cb 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1129,53 +1129,62 @@ void slirp_socket_recv(Slirp *slirp, struct in_addr guest_addr, int guest_port,
         tcp_output(sototcpcb(so));
 }
 
-static void slirp_tcp_save(QEMUFile *f, struct tcpcb *tp)
+static int slirp_tcp_post_load(void *opaque, int version)
 {
-    int i;
+    tcp_template((struct tcpcb *)opaque);
 
-    qemu_put_sbe16(f, tp->t_state);
-    for (i = 0; i < TCPT_NTIMERS; i++)
-        qemu_put_sbe16(f, tp->t_timer[i]);
-    qemu_put_sbe16(f, tp->t_rxtshift);
-    qemu_put_sbe16(f, tp->t_rxtcur);
-    qemu_put_sbe16(f, tp->t_dupacks);
-    qemu_put_be16(f, tp->t_maxseg);
-    qemu_put_sbyte(f, tp->t_force);
-    qemu_put_be16(f, tp->t_flags);
-    qemu_put_be32(f, tp->snd_una);
-    qemu_put_be32(f, tp->snd_nxt);
-    qemu_put_be32(f, tp->snd_up);
-    qemu_put_be32(f, tp->snd_wl1);
-    qemu_put_be32(f, tp->snd_wl2);
-    qemu_put_be32(f, tp->iss);
-    qemu_put_be32(f, tp->snd_wnd);
-    qemu_put_be32(f, tp->rcv_wnd);
-    qemu_put_be32(f, tp->rcv_nxt);
-    qemu_put_be32(f, tp->rcv_up);
-    qemu_put_be32(f, tp->irs);
-    qemu_put_be32(f, tp->rcv_adv);
-    qemu_put_be32(f, tp->snd_max);
-    qemu_put_be32(f, tp->snd_cwnd);
-    qemu_put_be32(f, tp->snd_ssthresh);
-    qemu_put_sbe16(f, tp->t_idle);
-    qemu_put_sbe16(f, tp->t_rtt);
-    qemu_put_be32(f, tp->t_rtseq);
-    qemu_put_sbe16(f, tp->t_srtt);
-    qemu_put_sbe16(f, tp->t_rttvar);
-    qemu_put_be16(f, tp->t_rttmin);
-    qemu_put_be32(f, tp->max_sndwnd);
-    qemu_put_byte(f, tp->t_oobflags);
-    qemu_put_byte(f, tp->t_iobc);
-    qemu_put_sbe16(f, tp->t_softerror);
-    qemu_put_byte(f, tp->snd_scale);
-    qemu_put_byte(f, tp->rcv_scale);
-    qemu_put_byte(f, tp->request_r_scale);
-    qemu_put_byte(f, tp->requested_s_scale);
-    qemu_put_be32(f, tp->ts_recent);
-    qemu_put_be32(f, tp->ts_recent_age);
-    qemu_put_be32(f, tp->last_ack_sent);
+    return 0;
 }
 
+static const VMStateDescription vmstate_slirp_tcp = {
+    .name = "slirp-tcp",
+    .version_id = 0,
+    .post_load = slirp_tcp_post_load,
+    .fields = (VMStateField[]) {
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
 static void slirp_sbuf_save(QEMUFile *f, struct sbuf *sbuf)
 {
     uint32_t off;
@@ -1218,7 +1227,7 @@ static void slirp_socket_save(QEMUFile *f, struct socket *so)
     qemu_put_be32(f, so->so_state);
     slirp_sbuf_save(f, &so->so_rcv);
     slirp_sbuf_save(f, &so->so_snd);
-    slirp_tcp_save(f, so->so_tcpcb);
+    vmstate_save_state(f, &vmstate_slirp_tcp, so->so_tcpcb, 0);
 }
 
 static void slirp_bootp_save(QEMUFile *f, Slirp *slirp)
@@ -1254,54 +1263,6 @@ static void slirp_state_save(QEMUFile *f, void *opaque)
     slirp_bootp_save(f, slirp);
 }
 
-static void slirp_tcp_load(QEMUFile *f, struct tcpcb *tp)
-{
-    int i;
-
-    tp->t_state = qemu_get_sbe16(f);
-    for (i = 0; i < TCPT_NTIMERS; i++)
-        tp->t_timer[i] = qemu_get_sbe16(f);
-    tp->t_rxtshift = qemu_get_sbe16(f);
-    tp->t_rxtcur = qemu_get_sbe16(f);
-    tp->t_dupacks = qemu_get_sbe16(f);
-    tp->t_maxseg = qemu_get_be16(f);
-    tp->t_force = qemu_get_sbyte(f);
-    tp->t_flags = qemu_get_be16(f);
-    tp->snd_una = qemu_get_be32(f);
-    tp->snd_nxt = qemu_get_be32(f);
-    tp->snd_up = qemu_get_be32(f);
-    tp->snd_wl1 = qemu_get_be32(f);
-    tp->snd_wl2 = qemu_get_be32(f);
-    tp->iss = qemu_get_be32(f);
-    tp->snd_wnd = qemu_get_be32(f);
-    tp->rcv_wnd = qemu_get_be32(f);
-    tp->rcv_nxt = qemu_get_be32(f);
-    tp->rcv_up = qemu_get_be32(f);
-    tp->irs = qemu_get_be32(f);
-    tp->rcv_adv = qemu_get_be32(f);
-    tp->snd_max = qemu_get_be32(f);
-    tp->snd_cwnd = qemu_get_be32(f);
-    tp->snd_ssthresh = qemu_get_be32(f);
-    tp->t_idle = qemu_get_sbe16(f);
-    tp->t_rtt = qemu_get_sbe16(f);
-    tp->t_rtseq = qemu_get_be32(f);
-    tp->t_srtt = qemu_get_sbe16(f);
-    tp->t_rttvar = qemu_get_sbe16(f);
-    tp->t_rttmin = qemu_get_be16(f);
-    tp->max_sndwnd = qemu_get_be32(f);
-    tp->t_oobflags = qemu_get_byte(f);
-    tp->t_iobc = qemu_get_byte(f);
-    tp->t_softerror = qemu_get_sbe16(f);
-    tp->snd_scale = qemu_get_byte(f);
-    tp->rcv_scale = qemu_get_byte(f);
-    tp->request_r_scale = qemu_get_byte(f);
-    tp->requested_s_scale = qemu_get_byte(f);
-    tp->ts_recent = qemu_get_be32(f);
-    tp->ts_recent_age = qemu_get_be32(f);
-    tp->last_ack_sent = qemu_get_be32(f);
-    tcp_template(tp);
-}
-
 static int slirp_sbuf_load(QEMUFile *f, struct sbuf *sbuf)
 {
     uint32_t off, sb_cc, sb_datalen;
@@ -1367,9 +1328,7 @@ static int slirp_socket_load(QEMUFile *f, struct socket *so, int version_id)
         return -ENOMEM;
     if (slirp_sbuf_load(f, &so->so_snd) < 0)
         return -ENOMEM;
-    slirp_tcp_load(f, so->so_tcpcb);
-
-    return 0;
+    return vmstate_load_state(f, &vmstate_slirp_tcp, so->so_tcpcb, 0);
 }
 
 static void slirp_bootp_load(QEMUFile *f, Slirp *slirp)
diff --git a/slirp/tcp_var.h b/slirp/tcp_var.h
index 0f8f187..895ef6d 100644
--- a/slirp/tcp_var.h
+++ b/slirp/tcp_var.h
@@ -48,7 +48,7 @@ struct tcpcb {
 	short	t_rxtcur;		/* current retransmit value */
 	short	t_dupacks;		/* consecutive dup acks recd */
 	u_short	t_maxseg;		/* maximum segment size */
-	char	t_force;		/* 1 if forcing out a byte */
+	uint8_t t_force;		/* 1 if forcing out a byte */
 	u_short	t_flags;
 #define	TF_ACKNOW	0x0001		/* ack peer immediately */
 #define	TF_DELACK	0x0002		/* ack, but try to delay it */
@@ -109,8 +109,8 @@ struct tcpcb {
 	uint32_t max_sndwnd;		/* largest window peer has offered */
 
 /* out-of-band data */
-	char	t_oobflags;		/* have some */
-	char	t_iobc;			/* input character */
+	uint8_t	t_oobflags;		/* have some */
+	uint8_t	t_iobc;			/* input character */
 #define	TCPOOB_HAVEDATA	0x01
 #define	TCPOOB_HADDATA	0x02
 	short	t_softerror;		/* possible error not yet reported */
-- 
2.9.3
