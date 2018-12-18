Received: from eggs.gnu.org ([2001:4830:134:3::10]:40786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORB-0000Ok-KF
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOR9-00052Q-BT
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:05 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:41876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOR8-0004ax-NT
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:03 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:15 +0100
Message-Id: <20181218230442.27887-38-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 37/64] slirp: remove #if notdef dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip_input.c  | 200 ----------------------------------------------
 slirp/tcp_input.c |  39 ---------
 2 files changed, 239 deletions(-)

diff --git a/slirp/ip_input.c b/slirp/ip_input.c
index 348e1dca5a..6831526320 100644
--- a/slirp/ip_input.c
+++ b/slirp/ip_input.c
@@ -447,206 +447,6 @@ ip_slowtimo(Slirp *slirp)
     }
 }
=20
-/*
- * Do option processing on a datagram,
- * possibly discarding it if bad options are encountered,
- * or forwarding it if source-routed.
- * Returns 1 if packet has been forwarded/freed,
- * 0 if the packet should be processed further.
- */
-
-#ifdef notdef
-
-int
-ip_dooptions(m)
-	struct mbuf *m;
-{
-	register struct ip *ip =3D mtod(m, struct ip *);
-	register u_char *cp;
-	register struct ip_timestamp *ipt;
-	register struct in_ifaddr *ia;
-	int opt, optlen, cnt, off, code, type, forward =3D 0;
-	struct in_addr *sin, dst;
-typedef uint32_t n_time;
-	n_time ntime;
-
-	dst =3D ip->ip_dst;
-	cp =3D (u_char *)(ip + 1);
-	cnt =3D (ip->ip_hl << 2) - sizeof (struct ip);
-	for (; cnt > 0; cnt -=3D optlen, cp +=3D optlen) {
-		opt =3D cp[IPOPT_OPTVAL];
-		if (opt =3D=3D IPOPT_EOL)
-			break;
-		if (opt =3D=3D IPOPT_NOP)
-			optlen =3D 1;
-		else {
-			optlen =3D cp[IPOPT_OLEN];
-			if (optlen <=3D 0 || optlen > cnt) {
-				code =3D &cp[IPOPT_OLEN] - (u_char *)ip;
-				goto bad;
-			}
-		}
-		switch (opt) {
-
-		default:
-			break;
-
-		/*
-		 * Source routing with record.
-		 * Find interface with current destination address.
-		 * If none on this machine then drop if strictly routed,
-		 * or do nothing if loosely routed.
-		 * Record interface address and bring up next address
-		 * component.  If strictly routed make sure next
-		 * address is on directly accessible net.
-		 */
-		case IPOPT_LSRR:
-		case IPOPT_SSRR:
-			if ((off =3D cp[IPOPT_OFFSET]) < IPOPT_MINOFF) {
-				code =3D &cp[IPOPT_OFFSET] - (u_char *)ip;
-				goto bad;
-			}
-			ipaddr.sin_addr =3D ip->ip_dst;
-			ia =3D (struct in_ifaddr *)
-				ifa_ifwithaddr((struct sockaddr *)&ipaddr);
-			if (ia =3D=3D 0) {
-				if (opt =3D=3D IPOPT_SSRR) {
-					type =3D ICMP_UNREACH;
-					code =3D ICMP_UNREACH_SRCFAIL;
-					goto bad;
-				}
-				/*
-				 * Loose routing, and not at next destination
-				 * yet; nothing to do except forward.
-				 */
-				break;
-			}
-                        off--; /* 0 origin */
-			if (off > optlen - sizeof(struct in_addr)) {
-				/*
-				 * End of source route.  Should be for us.
-				 */
-				save_rte(cp, ip->ip_src);
-				break;
-			}
-			/*
-			 * locate outgoing interface
-			 */
-			bcopy((caddr_t)(cp + off), (caddr_t)&ipaddr.sin_addr,
-			    sizeof(ipaddr.sin_addr));
-			if (opt =3D=3D IPOPT_SSRR) {
-#define	INA	struct in_ifaddr *
-#define	SA	struct sockaddr *
- 			    if ((ia =3D (INA)ifa_ifwithdstaddr((SA)&ipaddr)) =3D=3D 0)
-				ia =3D (INA)ifa_ifwithnet((SA)&ipaddr);
-			} else
-				ia =3D ip_rtaddr(ipaddr.sin_addr);
-			if (ia =3D=3D 0) {
-				type =3D ICMP_UNREACH;
-				code =3D ICMP_UNREACH_SRCFAIL;
-				goto bad;
-			}
-			ip->ip_dst =3D ipaddr.sin_addr;
-			bcopy((caddr_t)&(IA_SIN(ia)->sin_addr),
-			    (caddr_t)(cp + off), sizeof(struct in_addr));
-			cp[IPOPT_OFFSET] +=3D sizeof(struct in_addr);
-			/*
-			 * Let ip_intr's mcast routing check handle mcast pkts
-			 */
-			forward =3D !IN_MULTICAST(ntohl(ip->ip_dst.s_addr));
-			break;
-
-		case IPOPT_RR:
-			if ((off =3D cp[IPOPT_OFFSET]) < IPOPT_MINOFF) {
-				code =3D &cp[IPOPT_OFFSET] - (u_char *)ip;
-				goto bad;
-			}
-			/*
-			 * If no space remains, ignore.
-			 */
-                        off--; /* 0 origin */
-			if (off > optlen - sizeof(struct in_addr))
-				break;
-			bcopy((caddr_t)(&ip->ip_dst), (caddr_t)&ipaddr.sin_addr,
-			    sizeof(ipaddr.sin_addr));
-			/*
-			 * locate outgoing interface; if we're the destination,
-			 * use the incoming interface (should be same).
-			 */
-			if ((ia =3D (INA)ifa_ifwithaddr((SA)&ipaddr)) =3D=3D 0 &&
-			    (ia =3D ip_rtaddr(ipaddr.sin_addr)) =3D=3D 0) {
-				type =3D ICMP_UNREACH;
-				code =3D ICMP_UNREACH_HOST;
-				goto bad;
-			}
-			bcopy((caddr_t)&(IA_SIN(ia)->sin_addr),
-			    (caddr_t)(cp + off), sizeof(struct in_addr));
-			cp[IPOPT_OFFSET] +=3D sizeof(struct in_addr);
-			break;
-
-		case IPOPT_TS:
-			code =3D cp - (u_char *)ip;
-			ipt =3D (struct ip_timestamp *)cp;
-			if (ipt->ipt_len < 5)
-				goto bad;
-			if (ipt->ipt_ptr > ipt->ipt_len - sizeof (int32_t)) {
-				if (++ipt->ipt_oflw =3D=3D 0)
-					goto bad;
-				break;
-			}
-			sin =3D (struct in_addr *)(cp + ipt->ipt_ptr - 1);
-			switch (ipt->ipt_flg) {
-
-			case IPOPT_TS_TSONLY:
-				break;
-
-			case IPOPT_TS_TSANDADDR:
-				if (ipt->ipt_ptr + sizeof(n_time) +
-				    sizeof(struct in_addr) > ipt->ipt_len)
-					goto bad;
-				ipaddr.sin_addr =3D dst;
-				ia =3D (INA)ifaof_ i f p foraddr((SA)&ipaddr,
-							    m->m_pkthdr.rcvif);
-				if (ia =3D=3D 0)
-					continue;
-				bcopy((caddr_t)&IA_SIN(ia)->sin_addr,
-				    (caddr_t)sin, sizeof(struct in_addr));
-				ipt->ipt_ptr +=3D sizeof(struct in_addr);
-				break;
-
-			case IPOPT_TS_PRESPEC:
-				if (ipt->ipt_ptr + sizeof(n_time) +
-				    sizeof(struct in_addr) > ipt->ipt_len)
-					goto bad;
-				bcopy((caddr_t)sin, (caddr_t)&ipaddr.sin_addr,
-				    sizeof(struct in_addr));
-				if (ifa_ifwithaddr((SA)&ipaddr) =3D=3D 0)
-					continue;
-				ipt->ipt_ptr +=3D sizeof(struct in_addr);
-				break;
-
-			default:
-				goto bad;
-			}
-			ntime =3D iptime();
-			bcopy((caddr_t)&ntime, (caddr_t)cp + ipt->ipt_ptr - 1,
-			    sizeof(n_time));
-			ipt->ipt_ptr +=3D sizeof(n_time);
-		}
-	}
-	if (forward) {
-		ip_forward(m, 1);
-		return (1);
-	}
-	return (0);
-bad:
-	icmp_send_error(m, type, code, 0, 0);
-
-	return (1);
-}
-
-#endif /* notdef */
-
 /*
  * Strip out IP options, at higher
  * level protocol in the kernel.
diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
index e33fb83df5..5b5355dd99 100644
--- a/slirp/tcp_input.c
+++ b/slirp/tcp_input.c
@@ -1441,45 +1441,6 @@ tcp_dooptions(struct tcpcb *tp, u_char *cp, int cn=
t, struct tcpiphdr *ti)
 	}
 }
=20
-
-/*
- * Pull out of band byte out of a segment so
- * it doesn't appear in the user's data queue.
- * It is still reflected in the segment length for
- * sequencing purposes.
- */
-
-#ifdef notdef
-
-void
-tcp_pulloutofband(so, ti, m)
-	struct socket *so;
-	struct tcpiphdr *ti;
-	register struct mbuf *m;
-{
-	int cnt =3D ti->ti_urp - 1;
-
-	while (cnt >=3D 0) {
-		if (m->m_len > cnt) {
-			char *cp =3D mtod(m, caddr_t) + cnt;
-			struct tcpcb *tp =3D sototcpcb(so);
-
-			tp->t_iobc =3D *cp;
-			tp->t_oobflags |=3D TCPOOB_HAVEDATA;
-			memcpy(sp, cp+1, (unsigned)(m->m_len - cnt - 1));
-			m->m_len--;
-			return;
-		}
-		cnt -=3D m->m_len;
-		m =3D m->m_next; /* XXX WRONG! Fix it! */
-		if (m =3D=3D 0)
-			break;
-	}
-	panic("tcp_pulloutofband");
-}
-
-#endif /* notdef */
-
 /*
  * Collect new round-trip time estimate
  * and update averages and current timeout.
--=20
2.19.2
