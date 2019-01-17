Received: from eggs.gnu.org ([209.51.188.92]:57982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk67Z-0006lF-DF
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk67V-0005vj-DS
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:46:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk67T-0005uH-At
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:59 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:53 +0400
Message-Id: <20190117114359.5164-22-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 21/27] slirp: prefer c99 types over BSD kind
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

Replace:
- u_char -> uint8_t
- u_short -> uint16_t
- u_long -> uint32_t
- u_int -> unsigned
- caddr_t -> char *

(indentation mess is hopefully going to be fixed when slirp is made a
separate project and clang-format is applied over the history)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/ip_icmp.h    | 18 +++++++++---------
 slirp/main.h       |  2 +-
 slirp/mbuf.h       |  2 +-
 slirp/slirp.h      |  8 +++-----
 slirp/socket.h     |  4 ++--
 slirp/tcp_var.h    | 14 +++++++-------
 slirp/udp.h        |  2 +-
 slirp/ip_icmp.c    |  6 +++---
 slirp/ip_input.c   |  4 ++--
 slirp/slirp.c      | 12 ++++++------
 slirp/socket.c     |  6 +++---
 slirp/tcp_input.c  | 22 +++++++++++-----------
 slirp/tcp_output.c | 12 ++++++------
 slirp/tcp_subr.c   | 18 +++++++++---------
 slirp/tcp_timer.c  |  2 +-
 slirp/udp.c        |  6 +++---
 util/osdep.c       |  2 +-
 17 files changed, 69 insertions(+), 71 deletions(-)

diff --git a/slirp/ip_icmp.h b/slirp/ip_icmp.h
index d88ab34c1ba..a4e5b8b2657 100644
--- a/slirp/ip_icmp.h
+++ b/slirp/ip_icmp.h
@@ -44,22 +44,22 @@ typedef uint32_t n_time;
  * Structure of an icmp header.
  */
 struct icmp {
-	u_char	icmp_type;		/* type of message, see below */
-	u_char	icmp_code;		/* type sub code */
-	u_short	icmp_cksum;		/* ones complement cksum of struct */
+	uint8_t	icmp_type;		/* type of message, see below */
+	uint8_t	icmp_code;		/* type sub code */
+	uint16_t	icmp_cksum;		/* ones complement cksum of struct */
 	union {
-		u_char ih_pptr;			/* ICMP_PARAMPROB */
+		uint8_t ih_pptr;			/* ICMP_PARAMPROB */
 		struct in_addr ih_gwaddr;	/* ICMP_REDIRECT */
 		struct ih_idseq {
-			u_short	icd_id;
-			u_short	icd_seq;
+			uint16_t	icd_id;
+			uint16_t	icd_seq;
 		} ih_idseq;
 		int ih_void;
=20
 		/* ICMP_UNREACH_NEEDFRAG -- Path MTU Discovery (RFC1191) */
 		struct ih_pmtu {
-			u_short ipm_void;
-			u_short ipm_nextmtu;
+			uint16_t ipm_void;
+			uint16_t ipm_nextmtu;
 		} ih_pmtu;
 	} icmp_hun;
 #define	icmp_pptr	icmp_hun.ih_pptr
@@ -156,7 +156,7 @@ struct icmp {
 void icmp_init(Slirp *slirp);
 void icmp_cleanup(Slirp *slirp);
 void icmp_input(struct mbuf *, int);
-void icmp_send_error(struct mbuf *msrc, u_char type, u_char code, int mi=
nsize,
+void icmp_send_error(struct mbuf *msrc, uint8_t type, uint8_t code, int =
minsize,
                      const char *message);
 void icmp_reflect(struct mbuf *);
 void icmp_receive(struct socket *so);
diff --git a/slirp/main.h b/slirp/main.h
index 4bc05fb904b..f11d4572b76 100644
--- a/slirp/main.h
+++ b/slirp/main.h
@@ -8,7 +8,7 @@
 #ifndef SLIRP_MAIN_H
 #define SLIRP_MAIN_H
=20
-extern u_int curtime;
+extern unsigned curtime;
 extern struct in_addr loopback_addr;
 extern unsigned long loopback_mask;
=20
diff --git a/slirp/mbuf.h b/slirp/mbuf.h
index cbf17e136b1..e2d443418ab 100644
--- a/slirp/mbuf.h
+++ b/slirp/mbuf.h
@@ -85,7 +85,7 @@ struct mbuf {
 	int	m_size;			/* Size of mbuf, from m_dat or m_ext */
 	struct	socket *m_so;
=20
-	caddr_t	m_data;			/* Current location of data */
+	char *m_data;			/* Current location of data */
 	int	m_len;			/* Amount of data in this mbuf, from m_data */
=20
 	Slirp *slirp;
diff --git a/slirp/slirp.h b/slirp/slirp.h
index 0e4d973c2ab..05b8364c07c 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -12,8 +12,6 @@
 #define WIN32_LEAN_AND_MEAN
 #endif
=20
-typedef char *caddr_t;
-
 # include <winsock2.h>
 # include <windows.h>
 # include <ws2tcpip.h>
@@ -124,8 +122,8 @@ bool ndp_table_search(Slirp *slirp, struct in6_addr i=
p_addr,
=20
 struct Slirp {
     QTAILQ_ENTRY(Slirp) entry;
-    u_int time_fasttimo;
-    u_int last_slowtimo;
+    unsigned time_fasttimo;
+    unsigned last_slowtimo;
     bool do_slowtimo;
=20
     bool in_enabled, in6_enabled;
@@ -245,7 +243,7 @@ int ip6_output(struct socket *, struct mbuf *, int fa=
st);
=20
 /* tcp_input.c */
 void tcp_input(register struct mbuf *, int, struct socket *, unsigned sh=
ort af);
-int tcp_mss(register struct tcpcb *, u_int);
+int tcp_mss(register struct tcpcb *, unsigned);
=20
 /* tcp_output.c */
 int tcp_output(register struct tcpcb *);
diff --git a/slirp/socket.h b/slirp/socket.h
index 1c1c8b5871c..e4d12cd5911 100644
--- a/slirp/socket.h
+++ b/slirp/socket.h
@@ -61,7 +61,7 @@ struct socket {
   int32_t       so_state;       /* internal state flags SS_*, below */
=20
   struct 	tcpcb *so_tcpcb;	/* pointer to TCP protocol control block */
-  u_int	so_expire;		/* When the socket will expire */
+  unsigned	so_expire;		/* When the socket will expire */
=20
   int	so_queued;		/* Number of packets queued from this socket */
   int	so_nqueued;		/* Number of packets queued in a row
@@ -144,7 +144,7 @@ int sosendoob(struct socket *);
 int sowrite(struct socket *);
 void sorecvfrom(struct socket *);
 int sosendto(struct socket *, struct mbuf *);
-struct socket * tcp_listen(Slirp *, uint32_t, u_int, uint32_t, u_int,
+struct socket * tcp_listen(Slirp *, uint32_t, unsigned, uint32_t, unsign=
ed,
                                int);
 void soisfconnecting(register struct socket *);
 void soisfconnected(register struct socket *);
diff --git a/slirp/tcp_var.h b/slirp/tcp_var.h
index 895ef6df1e4..27ef1a51cb4 100644
--- a/slirp/tcp_var.h
+++ b/slirp/tcp_var.h
@@ -47,9 +47,9 @@ struct tcpcb {
 	short	t_rxtshift;		/* log(2) of rexmt exp. backoff */
 	short	t_rxtcur;		/* current retransmit value */
 	short	t_dupacks;		/* consecutive dup acks recd */
-	u_short	t_maxseg;		/* maximum segment size */
+	uint16_t	t_maxseg;		/* maximum segment size */
 	uint8_t t_force;		/* 1 if forcing out a byte */
-	u_short	t_flags;
+	uint16_t	t_flags;
 #define	TF_ACKNOW	0x0001		/* ack peer immediately */
 #define	TF_DELACK	0x0002		/* ack, but try to delay it */
 #define	TF_NODELAY	0x0004		/* don't delay packets to coalesce */
@@ -105,7 +105,7 @@ struct tcpcb {
 	tcp_seq	t_rtseq;		/* sequence number being timed */
 	short	t_srtt;			/* smoothed round-trip time */
 	short	t_rttvar;		/* variance in round-trip time */
-	u_short	t_rttmin;		/* minimum rtt allowed */
+	uint16_t	t_rttmin;		/* minimum rtt allowed */
 	uint32_t max_sndwnd;		/* largest window peer has offered */
=20
 /* out-of-band data */
@@ -116,10 +116,10 @@ struct tcpcb {
 	short	t_softerror;		/* possible error not yet reported */
=20
 /* RFC 1323 variables */
-	u_char	snd_scale;		/* window scaling for send window */
-	u_char	rcv_scale;		/* window scaling for recv window */
-	u_char	request_r_scale;	/* pending window scaling */
-	u_char	requested_s_scale;
+	uint8_t	snd_scale;		/* window scaling for send window */
+	uint8_t	rcv_scale;		/* window scaling for recv window */
+	uint8_t	request_r_scale;	/* pending window scaling */
+	uint8_t	requested_s_scale;
 	uint32_t	ts_recent;		/* timestamp echo data */
 	uint32_t	ts_recent_age;		/* when last updated */
 	tcp_seq	last_ack_sent;
diff --git a/slirp/udp.h b/slirp/udp.h
index be657cf9229..3d29504caa6 100644
--- a/slirp/udp.h
+++ b/slirp/udp.h
@@ -78,7 +78,7 @@ void udp_cleanup(Slirp *);
 void udp_input(register struct mbuf *, int);
 int udp_attach(struct socket *, unsigned short af);
 void udp_detach(struct socket *);
-struct socket * udp_listen(Slirp *, uint32_t, u_int, uint32_t, u_int,
+struct socket * udp_listen(Slirp *, uint32_t, unsigned, uint32_t, unsign=
ed,
                            int);
 int udp_output(struct socket *so, struct mbuf *m,
                 struct sockaddr_in *saddr, struct sockaddr_in *daddr,
diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
index 6b6344b7769..7c5cb75ae51 100644
--- a/slirp/ip_icmp.c
+++ b/slirp/ip_icmp.c
@@ -240,7 +240,7 @@ end_error:
=20
 #define ICMP_MAXDATALEN (IP_MSS-28)
 void
-icmp_send_error(struct mbuf *msrc, u_char type, u_char code, int minsize=
,
+icmp_send_error(struct mbuf *msrc, uint8_t type, uint8_t code, int minsi=
ze,
            const char *message)
 {
   unsigned hlen, shlen, s_ip_len;
@@ -388,7 +388,7 @@ icmp_reflect(struct mbuf *m)
      * Strip out original options by copying rest of first
      * mbuf's data back, and adjust the IP length.
      */
-    memmove((caddr_t)(ip + 1), (caddr_t)ip + hlen,
+    memmove((char *)(ip + 1), (char *)ip + hlen,
 	    (unsigned )(m->m_len - hlen));
     hlen -=3D optlen;
     ip->ip_hl =3D hlen >> 2;
@@ -412,7 +412,7 @@ void icmp_receive(struct socket *so)
     struct mbuf *m =3D so->so_m;
     struct ip *ip =3D mtod(m, struct ip *);
     int hlen =3D ip->ip_hl << 2;
-    u_char error_code;
+    uint8_t error_code;
     struct icmp *icp;
     int id, len;
=20
diff --git a/slirp/ip_input.c b/slirp/ip_input.c
index 774ce662e60..e0b94b0e426 100644
--- a/slirp/ip_input.c
+++ b/slirp/ip_input.c
@@ -458,11 +458,11 @@ ip_stripoptions(register struct mbuf *m, struct mbu=
f *mopt)
 {
 	register int i;
 	struct ip *ip =3D mtod(m, struct ip *);
-	register caddr_t opts;
+	register char *opts;
 	int olen;
=20
 	olen =3D (ip->ip_hl<<2) - sizeof (struct ip);
-	opts =3D (caddr_t)(ip + 1);
+	opts =3D (char *)(ip + 1);
 	i =3D m->m_len - (sizeof (struct ip) + olen);
 	memcpy(opts, opts  + olen, (unsigned)i);
 	m->m_len -=3D olen;
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 2c0ccc621b4..c7e15e88c0c 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -46,7 +46,7 @@ static const uint8_t special_ethaddr[ETH_ALEN] =3D {
     0x52, 0x55, 0x00, 0x00, 0x00, 0x00
 };
=20
-u_int curtime;
+unsigned curtime;
=20
 static QTAILQ_HEAD(, Slirp) slirp_instances =3D
     QTAILQ_HEAD_INITIALIZER(slirp_instances);
@@ -55,9 +55,9 @@ static struct in_addr dns_addr;
 #ifndef _WIN32
 static struct in6_addr dns6_addr;
 #endif
-static u_int dns_addr_time;
+static unsigned dns_addr_time;
 #ifndef _WIN32
-static u_int dns6_addr_time;
+static unsigned dns6_addr_time;
 #endif
=20
 #define TIMEOUT_FAST 2  /* milliseconds */
@@ -92,7 +92,7 @@ int get_dns_addr(struct in_addr *pdns_addr)
     }
=20
     if ((ret =3D GetNetworkParams(FixedInfo, &BufLen)) !=3D ERROR_SUCCES=
S) {
-        printf("GetNetworkParams failed. ret =3D %08x\n", (u_int)ret );
+        printf("GetNetworkParams failed. ret =3D %08x\n", (unsigned)ret =
);
         if (FixedInfo) {
             GlobalFree(FixedInfo);
             FixedInfo =3D NULL;
@@ -126,7 +126,7 @@ static void winsock_cleanup(void)
=20
 static int get_dns_addr_cached(void *pdns_addr, void *cached_addr,
                                socklen_t addrlen,
-                               struct stat *cached_stat, u_int *cached_t=
ime)
+                               struct stat *cached_stat, unsigned *cache=
d_time)
 {
     struct stat old_stat;
     if (curtime - *cached_time < TIMEOUT_DEFAULT) {
@@ -149,7 +149,7 @@ static int get_dns_addr_cached(void *pdns_addr, void =
*cached_addr,
=20
 static int get_dns_addr_resolv_conf(int af, void *pdns_addr, void *cache=
d_addr,
                                     socklen_t addrlen, uint32_t *scope_i=
d,
-                                    u_int *cached_time)
+                                    unsigned *cached_time)
 {
     char buff[512];
     char buff2[257];
diff --git a/slirp/socket.c b/slirp/socket.c
index dea201f5ce9..c896fa6da33 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -506,7 +506,7 @@ sorecvfrom(struct socket *so)
 	  /* XXX Check if reply is "correct"? */
=20
 	  if(len =3D=3D -1 || len =3D=3D 0) {
-	    u_char code=3DICMP_UNREACH_PORT;
+	    uint8_t code=3DICMP_UNREACH_PORT;
=20
 	    if(errno =3D=3D EHOSTUNREACH) code=3DICMP_UNREACH_HOST;
 	    else if(errno =3D=3D ENETUNREACH) code=3DICMP_UNREACH_NET;
@@ -676,8 +676,8 @@ sosendto(struct socket *so, struct mbuf *m)
  * Listen for incoming TCP connections
  */
 struct socket *
-tcp_listen(Slirp *slirp, uint32_t haddr, u_int hport, uint32_t laddr,
-           u_int lport, int flags)
+tcp_listen(Slirp *slirp, uint32_t haddr, unsigned hport, uint32_t laddr,
+           unsigned lport, int flags)
 {
 	struct sockaddr_in addr;
 	struct socket *so;
diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
index 864da7d857d..6749b32f5d9 100644
--- a/slirp/tcp_input.c
+++ b/slirp/tcp_input.c
@@ -76,7 +76,7 @@
 	} \
 }
=20
-static void tcp_dooptions(struct tcpcb *tp, u_char *cp, int cnt,
+static void tcp_dooptions(struct tcpcb *tp, uint8_t *cp, int cnt,
                           struct tcpiphdr *ti);
 static void tcp_xmit_timer(register struct tcpcb *tp, int rtt);
=20
@@ -197,7 +197,7 @@ tcp_input(struct mbuf *m, int iphlen, struct socket *=
inso, unsigned short af)
 	struct ip save_ip, *ip;
 	struct ip6 save_ip6, *ip6;
 	register struct tcpiphdr *ti;
-	caddr_t optp =3D NULL;
+	char *optp =3D NULL;
 	int optlen =3D 0;
 	int len, tlen, off;
         register struct tcpcb *tp =3D NULL;
@@ -205,7 +205,7 @@ tcp_input(struct mbuf *m, int iphlen, struct socket *=
inso, unsigned short af)
         struct socket *so =3D NULL;
 	int todrop, acked, ourfinisacked, needoutput =3D 0;
 	int iss =3D 0;
-	u_long tiwin;
+	uint32_t tiwin;
 	int ret;
 	struct sockaddr_storage lhost, fhost;
 	struct sockaddr_in *lhost4, *fhost4;
@@ -327,7 +327,7 @@ tcp_input(struct mbuf *m, int iphlen, struct socket *=
inso, unsigned short af)
 	ti->ti_len =3D tlen;
 	if (off > sizeof (struct tcphdr)) {
 	  optlen =3D off - sizeof (struct tcphdr);
-	  optp =3D mtod(m, caddr_t) + sizeof (struct tcpiphdr);
+	  optp =3D mtod(m, char *) + sizeof (struct tcpiphdr);
 	}
 	tiflags =3D ti->ti_flags;
=20
@@ -469,7 +469,7 @@ findso:
 	 * else do it below (after getting remote address).
 	 */
 	if (optp && tp->t_state !=3D TCPS_LISTEN)
-		tcp_dooptions(tp, (u_char *)optp, optlen, ti);
+		tcp_dooptions(tp, (uint8_t *)optp, optlen, ti);
=20
 	/*
 	 * Header prediction: check for the two common cases
@@ -724,7 +724,7 @@ findso:
 	  tcp_template(tp);
=20
 	  if (optp)
-	    tcp_dooptions(tp, (u_char *)optp, optlen, ti);
+	    tcp_dooptions(tp, (uint8_t *)optp, optlen, ti);
=20
 	  if (iss)
 	    tp->iss =3D iss;
@@ -1039,7 +1039,7 @@ trimthenstep6:
 					tp->t_dupacks =3D 0;
 				else if (++tp->t_dupacks =3D=3D TCPREXMTTHRESH) {
 					tcp_seq onxt =3D tp->snd_nxt;
-					u_int win =3D
+					unsigned win =3D
                                                 MIN(tp->snd_wnd, tp->snd=
_cwnd) /
                                                 2 / tp->t_maxseg;
=20
@@ -1108,8 +1108,8 @@ trimthenstep6:
 		 * (maxseg^2 / cwnd per packet).
 		 */
 		{
-		  register u_int cw =3D tp->snd_cwnd;
-		  register u_int incr =3D tp->t_maxseg;
+		  register unsigned cw =3D tp->snd_cwnd;
+		  register unsigned incr =3D tp->t_maxseg;
=20
 		  if (cw > tp->snd_ssthresh)
 		    incr =3D incr * incr / cw;
@@ -1381,7 +1381,7 @@ drop:
 }
=20
 static void
-tcp_dooptions(struct tcpcb *tp, u_char *cp, int cnt, struct tcpiphdr *ti=
)
+tcp_dooptions(struct tcpcb *tp, uint8_t *cp, int cnt, struct tcpiphdr *t=
i)
 {
 	uint16_t mss;
 	int opt, optlen;
@@ -1511,7 +1511,7 @@ tcp_xmit_timer(register struct tcpcb *tp, int rtt)
  */
=20
 int
-tcp_mss(struct tcpcb *tp, u_int offer)
+tcp_mss(struct tcpcb *tp, unsigned offer)
 {
 	struct socket *so =3D tp->t_socket;
 	int mss;
diff --git a/slirp/tcp_output.c b/slirp/tcp_output.c
index 2b4335eb34a..e9674df1216 100644
--- a/slirp/tcp_output.c
+++ b/slirp/tcp_output.c
@@ -40,7 +40,7 @@
=20
 #include "slirp.h"
=20
-static const u_char  tcp_outflags[TCP_NSTATES] =3D {
+static const uint8_t  tcp_outflags[TCP_NSTATES] =3D {
 	TH_RST|TH_ACK, 0,      TH_SYN,        TH_SYN|TH_ACK,
 	TH_ACK,        TH_ACK, TH_FIN|TH_ACK, TH_FIN|TH_ACK,
 	TH_FIN|TH_ACK, TH_ACK, TH_ACK,
@@ -63,7 +63,7 @@ tcp_output(struct tcpcb *tp)
 	register struct tcpiphdr *ti, tcpiph_save;
 	struct ip *ip;
 	struct ip6 *ip6;
-	u_char opt[MAX_TCPOPTLEN];
+	uint8_t opt[MAX_TCPOPTLEN];
 	unsigned optlen, hdrlen;
 	int idle, sendalot;
=20
@@ -271,7 +271,7 @@ send:
 			opt[0] =3D TCPOPT_MAXSEG;
 			opt[1] =3D 4;
 			mss =3D htons((uint16_t) tcp_mss(tp, 0));
-			memcpy((caddr_t)(opt + 2), (caddr_t)&mss, sizeof(mss));
+			memcpy((char *)(opt + 2), (char *)&mss, sizeof(mss));
 			optlen =3D 4;
 		}
 	}
@@ -301,7 +301,7 @@ send:
 		m->m_data +=3D IF_MAXLINKHDR;
 		m->m_len =3D hdrlen;
=20
-		sbcopy(&so->so_snd, off, (int) len, mtod(m, caddr_t) + hdrlen);
+		sbcopy(&so->so_snd, off, (int) len, mtod(m, char *) + hdrlen);
 		m->m_len +=3D len;
=20
 		/*
@@ -324,7 +324,7 @@ send:
=20
 	ti =3D mtod(m, struct tcpiphdr *);
=20
-	memcpy((caddr_t)ti, &tp->t_template, sizeof (struct tcpiphdr));
+	memcpy((char *)ti, &tp->t_template, sizeof (struct tcpiphdr));
=20
 	/*
 	 * Fill in fields, remembering maximum advertised
@@ -353,7 +353,7 @@ send:
 		ti->ti_seq =3D htonl(tp->snd_max);
 	ti->ti_ack =3D htonl(tp->rcv_nxt);
 	if (optlen) {
-		memcpy((caddr_t)(ti + 1), (caddr_t)opt, optlen);
+		memcpy((char *)(ti + 1), (char *)opt, optlen);
 		ti->ti_off =3D (sizeof (struct tcphdr) + optlen) >> 2;
 	}
 	ti->ti_flags =3D flags;
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index 879a7dcd296..e35628a892a 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -163,7 +163,7 @@ tcp_respond(struct tcpcb *tp, struct tcpiphdr *ti, st=
ruct mbuf *m,
 		 * ti points into m so the next line is just making
 		 * the mbuf point to ti
 		 */
-		m->m_data =3D (caddr_t)ti;
+		m->m_data =3D (char *)ti;
=20
 		m->m_len =3D sizeof (struct tcpiphdr);
 		tlen =3D 0;
@@ -182,7 +182,7 @@ tcp_respond(struct tcpcb *tp, struct tcpiphdr *ti, st=
ruct mbuf *m,
 		}
 #undef xchg
 	}
-	ti->ti_len =3D htons((u_short)(sizeof (struct tcphdr) + tlen));
+	ti->ti_len =3D htons((uint16_t)(sizeof (struct tcphdr) + tlen));
 	tlen +=3D sizeof (struct tcpiphdr);
 	m->m_len =3D tlen;
=20
@@ -613,10 +613,10 @@ int
 tcp_emu(struct socket *so, struct mbuf *m)
 {
 	Slirp *slirp =3D so->slirp;
-	u_int n1, n2, n3, n4, n5, n6;
+	unsigned n1, n2, n3, n4, n5, n6;
         char buff[257];
 	uint32_t laddr;
-	u_int lport;
+	unsigned lport;
 	char *bptr;
=20
 	DEBUG_CALL("tcp_emu");
@@ -853,7 +853,7 @@ tcp_emu(struct socket *so, struct mbuf *m)
=20
 		bptr =3D m->m_data;
 		while (bptr < m->m_data + m->m_len) {
-			u_short p;
+			uint16_t p;
 			static int ra =3D 0;
 			char ra_tbl[4];
=20
@@ -909,8 +909,8 @@ tcp_emu(struct socket *so, struct mbuf *m)
 				/* This is the field containing the port
 				 * number that RA-player is listening to.
 				 */
-				lport =3D (((u_char*)bptr)[0] << 8)
-				+ ((u_char *)bptr)[1];
+				lport =3D (((uint8_t*)bptr)[0] << 8)
+				+ ((uint8_t *)bptr)[1];
 				if (lport < 6970)
 				   lport +=3D 256;   /* don't know why */
 				if (lport < 6970 || lport > 7170)
@@ -928,8 +928,8 @@ tcp_emu(struct socket *so, struct mbuf *m)
 				}
 				if (p =3D=3D 7071)
 				   p =3D 0;
-				*(u_char *)bptr++ =3D (p >> 8) & 0xff;
-                                *(u_char *)bptr =3D p & 0xff;
+				*(uint8_t *)bptr++ =3D (p >> 8) & 0xff;
+                                *(uint8_t *)bptr =3D p & 0xff;
 				ra =3D 0;
 				return 1;   /* port redirected, we're done */
 				break;
diff --git a/slirp/tcp_timer.c b/slirp/tcp_timer.c
index 703907eb37a..7be54570af0 100644
--- a/slirp/tcp_timer.c
+++ b/slirp/tcp_timer.c
@@ -232,7 +232,7 @@ tcp_timers(register struct tcpcb *tp, int timer)
 		 * to go below this.)
 		 */
 		{
-                u_int win =3D MIN(tp->snd_wnd, tp->snd_cwnd) / 2 / tp->t=
_maxseg;
+                unsigned win =3D MIN(tp->snd_wnd, tp->snd_cwnd) / 2 / tp=
->t_maxseg;
 		if (win < 2)
 			win =3D 2;
 		tp->snd_cwnd =3D tp->t_maxseg;
diff --git a/slirp/udp.c b/slirp/udp.c
index ac42be0d8e9..5baa604b33a 100644
--- a/slirp/udp.c
+++ b/slirp/udp.c
@@ -92,7 +92,7 @@ udp_input(register struct mbuf *m, int iphlen)
 	 * Get IP and UDP header together in first mbuf.
 	 */
 	ip =3D mtod(m, struct ip *);
-	uh =3D (struct udphdr *)((caddr_t)ip + iphlen);
+	uh =3D (struct udphdr *)((char *)ip + iphlen);
=20
 	/*
 	 * Make mbuf data length reflect UDP length.
@@ -319,8 +319,8 @@ udp_tos(struct socket *so)
 }
=20
 struct socket *
-udp_listen(Slirp *slirp, uint32_t haddr, u_int hport, uint32_t laddr,
-           u_int lport, int flags)
+udp_listen(Slirp *slirp, uint32_t haddr, unsigned hport, uint32_t laddr,
+           unsigned lport, int flags)
 {
 	struct sockaddr_in addr;
 	struct socket *so;
diff --git a/util/osdep.c b/util/osdep.c
index 4b5dc7287db..3f04326040d 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -29,7 +29,7 @@
 #include <sys/statvfs.h>
 /* See MySQL bug #7156 (http://bugs.mysql.com/bug.php?id=3D7156) for
    discussion about Solaris header problems */
-extern int madvise(caddr_t, size_t, int);
+extern int madvise(char *, size_t, int);
 #endif
=20
 #include "qemu-common.h"
--=20
2.20.1.98.gecbdaf0899
