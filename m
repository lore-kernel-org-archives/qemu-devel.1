Received: from eggs.gnu.org ([2001:4830:134:3::10]:51738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPahO-0006od-VP
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPahK-0005Rd-Ih
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:10:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPahI-0004xN-Hj
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:10:13 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 02:06:41 +0400
Message-Id: <20181121220647.18844-25-marcandre.lureau@redhat.com>
In-Reply-To: <20181121220647.18844-1-marcandre.lureau@redhat.com>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-3.2 v2 24/30] slirp: call into g_debug()
 for DEBUG macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Make slirp use GLib logging, instead of fprintf(), so that
applications can filter log, process it etc.

With recent versions of glib, G_MESSAGES_DEBUG must be set to "all" or
"Slirp" to see slirp debug messages.

Reformat DEBUG_MISC & DEBUG_ERROR calls to not need \n ending.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/debug.h      | 17 ++++-------------
 slirp/cksum.c      |  4 ++--
 slirp/dhcpv6.c     |  6 +++---
 slirp/ip_icmp.c    | 10 +++++-----
 slirp/slirp.c      | 10 ++++------
 slirp/socket.c     | 24 ++++++++++++------------
 slirp/tcp_input.c  |  7 +++----
 slirp/tcp_output.c |  2 +-
 slirp/tcp_subr.c   |  2 +-
 slirp/udp.c        |  5 ++---
 slirp/udp6.c       |  5 ++---
 11 files changed, 39 insertions(+), 53 deletions(-)

diff --git a/slirp/debug.h b/slirp/debug.h
index 50f30898fb..25a5d59439 100644
--- a/slirp/debug.h
+++ b/slirp/debug.h
@@ -12,38 +12,29 @@
 #define DBG_MISC 0x2
 #define DBG_ERROR 0x4
=20
-#define dfd stderr
-
 extern int slirp_debug;
=20
 #define DEBUG_CALL(fmt, ...) do {               \
     if (slirp_debug & DBG_CALL) {               \
-        fprintf(dfd, fmt, ##__VA_ARGS__);       \
-        fprintf(dfd, "...\n");                  \
-        fflush(dfd);                            \
+        g_debug(fmt "...", ##__VA_ARGS__);      \
     }                                           \
 } while (0)
=20
 #define DEBUG_ARG(fmt, ...) do {                \
     if (slirp_debug & DBG_CALL) {               \
-        fputc(' ', dfd);                        \
-        fprintf(dfd, fmt, ##__VA_ARGS__);       \
-        fputc('\n', dfd);                       \
-        fflush(dfd);                            \
+        g_debug(" " fmt, ##__VA_ARGS__);        \
     }                                           \
 } while (0)
=20
 #define DEBUG_MISC(fmt, ...) do {               \
     if (slirp_debug & DBG_MISC) {               \
-        fprintf(dfd, fmt, ##__VA_ARGS__);       \
-        fflush(dfd);                            \
+        g_debug(fmt, ##__VA_ARGS__);            \
     }                                           \
 } while (0)
=20
 #define DEBUG_ERROR(fmt, ...) do {              \
     if (slirp_debug & DBG_ERROR) {              \
-        fprintf(dfd, fmt, ##__VA_ARGS__);       \
-        fflush(dfd);                            \
+        g_debug(fmt, ##__VA_ARGS__);            \
     }                                           \
 } while (0)
=20
diff --git a/slirp/cksum.c b/slirp/cksum.c
index 0a988b845d..84c858fafb 100644
--- a/slirp/cksum.c
+++ b/slirp/cksum.c
@@ -121,8 +121,8 @@ int cksum(struct mbuf *m, int len)
=20
 cont:
 	if (len) {
-		DEBUG_ERROR("cksum: out of data\n");
-		DEBUG_ERROR(" len =3D %d\n", len);
+		DEBUG_ERROR("cksum: out of data");
+		DEBUG_ERROR(" len =3D %d", len);
 	}
 	if (mlen =3D=3D -1) {
 		/* The last mbuf has odd # of bytes. Follow the
diff --git a/slirp/dhcpv6.c b/slirp/dhcpv6.c
index 5d703e8ae6..752df40536 100644
--- a/slirp/dhcpv6.c
+++ b/slirp/dhcpv6.c
@@ -92,13 +92,13 @@ static int dhcpv6_parse_info_request(Slirp *slirp, ui=
nt8_t *odata, int olen,
                     ri->want_boot_url =3D true;
                     break;
                 default:
-                    DEBUG_MISC("dhcpv6: Unsupported option request %d\n"=
,
+                    DEBUG_MISC("dhcpv6: Unsupported option request %d",
                                req_opt);
                 }
             }
             break;
         default:
-            DEBUG_MISC("dhcpv6 info req: Unsupported option %d, len=3D%d=
\n",
+            DEBUG_MISC("dhcpv6 info req: Unsupported option %d, len=3D%d=
",
                        option, len);
         }
=20
@@ -203,6 +203,6 @@ void dhcpv6_input(struct sockaddr_in6 *srcsas, struct=
 mbuf *m)
         dhcpv6_info_request(m->slirp, srcsas, xid, &data[4], data_len - =
4);
         break;
     default:
-        DEBUG_MISC("dhcpv6_input: Unsupported message type 0x%x\n", data=
[0]);
+        DEBUG_MISC("dhcpv6_input: Unsupported message type 0x%x", data[0=
]);
     }
 }
diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
index cd2faeacb6..7c7e042049 100644
--- a/slirp/ip_icmp.c
+++ b/slirp/ip_icmp.c
@@ -103,7 +103,7 @@ static int icmp_send(struct socket *so, struct mbuf *=
m, int hlen)
=20
     if (sendto(so->s, m->m_data + hlen, m->m_len - hlen, 0,
                (struct sockaddr *)&addr, sizeof(addr)) =3D=3D -1) {
-        DEBUG_MISC("icmp_input icmp sendto tx errno =3D %d-%s\n",
+        DEBUG_MISC("icmp_input icmp sendto tx errno =3D %d-%s",
                    errno, strerror(errno));
         icmp_send_error(m, ICMP_UNREACH, ICMP_UNREACH_NET, 0, strerror(e=
rrno));
         icmp_detach(so);
@@ -169,7 +169,7 @@ icmp_input(struct mbuf *m, int hlen)
         return;
       }
       if (udp_attach(so, AF_INET) =3D=3D -1) {
-	DEBUG_MISC("icmp_input udp_attach errno =3D %d-%s\n",
+	DEBUG_MISC("icmp_input udp_attach errno =3D %d-%s",
                errno,strerror(errno));
 	sofree(so);
 	m_free(m);
@@ -192,7 +192,7 @@ icmp_input(struct mbuf *m, int hlen)
=20
       if(sendto(so->s, icmp_ping_msg, strlen(icmp_ping_msg), 0,
 		(struct sockaddr *)&addr, sockaddr_size(&addr)) =3D=3D -1) {
-	DEBUG_MISC("icmp_input udp sendto tx errno =3D %d-%s\n",
+	DEBUG_MISC("icmp_input udp sendto tx errno =3D %d-%s",
                errno,strerror(errno));
 	icmp_send_error(m, ICMP_UNREACH, ICMP_UNREACH_NET, 0, strerror(errno));
 	udp_detach(so);
@@ -261,7 +261,7 @@ icmp_send_error(struct mbuf *msrc, u_char type, u_cha=
r code, int minsize,
     char bufa[20], bufb[20];
     strcpy(bufa, inet_ntoa(ip->ip_src));
     strcpy(bufb, inet_ntoa(ip->ip_dst));
-    DEBUG_MISC(" %.16s to %.16s\n", bufa, bufb);
+    DEBUG_MISC(" %.16s to %.16s", bufa, bufb);
   }
   if(ip->ip_off & IP_OFFMASK) goto end_error;    /* Only reply to fragme=
nt 0 */
=20
@@ -458,7 +458,7 @@ void icmp_receive(struct socket *so)
         } else {
             error_code =3D ICMP_UNREACH_HOST;
         }
-        DEBUG_MISC(" udp icmp rx errno =3D %d-%s\n", errno,
+        DEBUG_MISC(" udp icmp rx errno =3D %d-%s", errno,
                    strerror(errno));
         icmp_send_error(so->so_m, ICMP_UNREACH, error_code, 0, strerror(=
errno));
     } else {
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 12aad702c2..f254a23a5a 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -165,7 +165,7 @@ static int get_dns_addr_resolv_conf(int af, void *pdn=
s_addr, void *cached_addr,
     if (!f)
         return -1;
=20
-    DEBUG_MISC("IP address of your DNS(s): ");
+    DEBUG_MISC("IP address of your DNS(s):");
     while (fgets(buff, 512, f) !=3D NULL) {
         if (sscanf(buff, "nameserver%*[ \t]%256s", buff2) =3D=3D 1) {
             char *c =3D strchr(buff2, '%');
@@ -187,20 +187,18 @@ static int get_dns_addr_resolv_conf(int af, void *p=
dns_addr, void *cached_addr,
                     *scope_id =3D if_index;
                 }
                 *cached_time =3D curtime;
-            } else {
-                DEBUG_MISC(", ");
             }
=20
             if (++found > 3) {
-                DEBUG_MISC("(more)");
+                DEBUG_MISC("  (more)");
                 break;
             } else if (slirp_debug & DBG_MISC) {
                 char s[INET6_ADDRSTRLEN];
                 const char *res =3D inet_ntop(af, tmp_addr, s, sizeof(s)=
);
                 if (!res) {
-                    res =3D "(string conversion error)";
+                    res =3D "  (string conversion error)";
                 }
-                DEBUG_MISC("%s", res);
+                DEBUG_MISC("  %s", res);
             }
         }
     }
diff --git a/slirp/socket.c b/slirp/socket.c
index 08a065f6a7..5ffbaa064a 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -208,7 +208,8 @@ soread(struct socket *so)
 				}
 			}
=20
-			DEBUG_MISC(" --- soread() disconnected, nn =3D %d, errno =3D %d-%s\n"=
, nn, errno,strerror(errno));
+			DEBUG_MISC(" --- soread() disconnected, nn =3D %d, errno =3D %d-%s",
+                       nn, errno,strerror(errno));
 			sofcantrcvmore(so);
=20
 			if (err =3D=3D ECONNRESET || err =3D=3D ECONNREFUSED
@@ -237,7 +238,7 @@ soread(struct socket *so)
                 nn +=3D ret;
         }
=20
-	DEBUG_MISC(" ... read nn =3D %d bytes\n", nn);
+	DEBUG_MISC(" ... read nn =3D %d bytes", nn);
=20
 	/* Update fields */
 	sb->sb_cc +=3D nn;
@@ -370,7 +371,7 @@ sosendoob(struct socket *so)
 		n =3D slirp_send(so, buff, len, (MSG_OOB)); /* |MSG_DONTWAIT)); */
 #ifdef DEBUG
 		if (n !=3D len) {
-			DEBUG_ERROR("Didn't send all data urgently XXXXX\n");
+			DEBUG_ERROR("Didn't send all data urgently XXXXX");
 		}
 #endif
 	}
@@ -379,7 +380,7 @@ sosendoob(struct socket *so)
 		return n;
 	}
 	so->so_urgc -=3D n;
-	DEBUG_MISC(" ---2 sent %d bytes urgent data, %d urgent bytes left\n", n=
, so->so_urgc);
+	DEBUG_MISC(" ---2 sent %d bytes urgent data, %d urgent bytes left", n, =
so->so_urgc);
=20
 	sb->sb_cc -=3D n;
 	sb->sb_rptr +=3D n;
@@ -460,7 +461,7 @@ sowrite(struct socket *so)
             if (ret > 0)
                 nn +=3D ret;
         }
-        DEBUG_MISC("  ... wrote nn =3D %d bytes\n", nn);
+        DEBUG_MISC("  ... wrote nn =3D %d bytes", nn);
=20
 	/* Update sbuf */
 	sb->sb_cc -=3D nn;
@@ -478,7 +479,7 @@ sowrite(struct socket *so)
 	return nn;
=20
 err_disconnected:
-	DEBUG_MISC(" --- sowrite disconnected, so->so_state =3D %x, errno =3D %=
d\n",
+	DEBUG_MISC(" --- sowrite disconnected, so->so_state =3D %x, errno =3D %=
d",
                so->so_state, errno);
 	sofcantsendmore(so);
 	tcp_sockclosed(sototcpcb(so));
@@ -512,7 +513,7 @@ sorecvfrom(struct socket *so)
 	    if(errno =3D=3D EHOSTUNREACH) code=3DICMP_UNREACH_HOST;
 	    else if(errno =3D=3D ENETUNREACH) code=3DICMP_UNREACH_NET;
=20
-	    DEBUG_MISC(" udp icmp rx errno =3D %d-%s\n",
+	    DEBUG_MISC(" udp icmp rx errno =3D %d-%s",
                    errno,strerror(errno));
 	    icmp_send_error(so->so_m, ICMP_UNREACH, code, 0, strerror(errno));
 	  } else {
@@ -564,7 +565,7 @@ sorecvfrom(struct socket *so)
=20
 	  m->m_len =3D recvfrom(so->s, m->m_data, len, 0,
 			      (struct sockaddr *)&addr, &addrlen);
-	  DEBUG_MISC(" did recvfrom %d, errno =3D %d-%s\n",
+	  DEBUG_MISC(" did recvfrom %d, errno =3D %d-%s",
                  m->m_len, errno,strerror(errno));
 	  if(m->m_len<0) {
 	    /* Report error as ICMP */
@@ -579,7 +580,7 @@ sorecvfrom(struct socket *so)
 		code =3D ICMP_UNREACH_NET;
 	      }
=20
-	      DEBUG_MISC(" rx error, tx icmp ICMP_UNREACH:%i\n", code);
+	      DEBUG_MISC(" rx error, tx icmp ICMP_UNREACH:%i", code);
 	      icmp_send_error(so->so_m, ICMP_UNREACH, code, 0, strerror(errno))=
;
 	      break;
 	    case AF_INET6:
@@ -591,7 +592,7 @@ sorecvfrom(struct socket *so)
 		code =3D ICMP6_UNREACH_NO_ROUTE;
 	      }
=20
-	      DEBUG_MISC(" rx error, tx icmp6 ICMP_UNREACH:%i\n", code);
+	      DEBUG_MISC(" rx error, tx icmp6 ICMP_UNREACH:%i", code);
 	      icmp6_send_error(so->so_m, ICMP6_UNREACH, code);
 	      break;
 	    default:
@@ -839,8 +840,7 @@ void sotranslate_out(struct socket *so, struct sockad=
dr_storage *addr)
             }
         }
=20
-        DEBUG_MISC(" addr.sin_port=3D%d, "
-                   "addr.sin_addr.s_addr=3D%.16s\n",
+        DEBUG_MISC(" addr.sin_port=3D%d, addr.sin_addr.s_addr=3D%.16s",
                    ntohs(sin->sin_port), inet_ntoa(sin->sin_addr));
         break;
=20
diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
index d24295813a..a6596b63ac 100644
--- a/slirp/tcp_input.c
+++ b/slirp/tcp_input.c
@@ -641,8 +641,7 @@ findso:
               (errno !=3D EINPROGRESS) && (errno !=3D EWOULDBLOCK)
           ) {
 	    uint8_t code;
-	    DEBUG_MISC(" tcp fconnect errno =3D %d-%s\n",
-                   errno,strerror(errno));
+	    DEBUG_MISC(" tcp fconnect errno =3D %d-%s", errno, strerror(errno))=
;
 	    if(errno =3D=3D ECONNREFUSED) {
 	      /* ACK the SYN, send RST to refuse the connection */
 	      tcp_respond(tp, ti, m, ti->ti_seq + 1, (tcp_seq) 0,
@@ -1011,7 +1010,7 @@ trimthenstep6:
=20
 		if (SEQ_LEQ(ti->ti_ack, tp->snd_una)) {
 			if (ti->ti_len =3D=3D 0 && tiwin =3D=3D tp->snd_wnd) {
-			  DEBUG_MISC(" dup ack  m =3D %p  so =3D %p\n", m, so);
+			  DEBUG_MISC(" dup ack  m =3D %p  so =3D %p", m, so);
 				/*
 				 * If we have outstanding data (other than
 				 * a window probe), this is a completely
@@ -1550,7 +1549,7 @@ tcp_mss(struct tcpcb *tp, u_int offer)
                                                (mss - (TCP_RCVSPACE % ms=
s)) :
                                                0));
=20
-	DEBUG_MISC(" returning mss =3D %d\n", mss);
+	DEBUG_MISC(" returning mss =3D %d", mss);
=20
 	return mss;
 }
diff --git a/slirp/tcp_output.c b/slirp/tcp_output.c
index 44da8a4e47..2f7f90d67e 100644
--- a/slirp/tcp_output.c
+++ b/slirp/tcp_output.c
@@ -92,7 +92,7 @@ again:
=20
 	flags =3D tcp_outflags[tp->t_state];
=20
-	DEBUG_MISC(" --- tcp_output flags =3D 0x%x\n", flags);
+	DEBUG_MISC(" --- tcp_output flags =3D 0x%x", flags);
=20
 	/*
 	 * If in persist timeout with window of 0, send 1 byte.
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index 042fa1e4fb..5dcf979c3c 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -964,7 +964,7 @@ int tcp_ctl(struct socket *so)
                     so->guestfwd =3D ex_ptr;
                     return 1;
                 }
-                DEBUG_MISC(" executing %s\n", ex_ptr->ex_exec);
+                DEBUG_MISC(" executing %s", ex_ptr->ex_exec);
                 return fork_exec(so, ex_ptr->ex_exec);
             }
         }
diff --git a/slirp/udp.c b/slirp/udp.c
index a45ad81dda..4cf0d34d64 100644
--- a/slirp/udp.c
+++ b/slirp/udp.c
@@ -172,8 +172,7 @@ udp_input(register struct mbuf *m, int iphlen)
 	   */
 	  so =3D socreate(slirp);
 	  if (udp_attach(so, AF_INET) =3D=3D -1) {
-	    DEBUG_MISC(" udp_attach errno =3D %d-%s\n",
-                   errno, strerror(errno));
+	    DEBUG_MISC(" udp_attach errno =3D %d-%s", errno, strerror(errno));
 	    sofree(so);
 	    goto bad;
 	  }
@@ -209,7 +208,7 @@ udp_input(register struct mbuf *m, int iphlen)
 	  m->m_len +=3D iphlen;
 	  m->m_data -=3D iphlen;
 	  *ip=3Dsave_ip;
-	  DEBUG_MISC("udp tx errno =3D %d-%s\n", errno, strerror(errno));
+	  DEBUG_MISC("udp tx errno =3D %d-%s", errno, strerror(errno));
 	  icmp_send_error(m, ICMP_UNREACH, ICMP_UNREACH_NET, 0,
 	                  strerror(errno));
 	  goto bad;
diff --git a/slirp/udp6.c b/slirp/udp6.c
index 8cdb1892e2..fa531e03c4 100644
--- a/slirp/udp6.c
+++ b/slirp/udp6.c
@@ -92,8 +92,7 @@ void udp6_input(struct mbuf *m)
         /* If there's no socket for this packet, create one. */
         so =3D socreate(slirp);
         if (udp_attach(so, AF_INET6) =3D=3D -1) {
-            DEBUG_MISC(" udp6_attach errno =3D %d-%s\n",
-                       errno, strerror(errno));
+            DEBUG_MISC(" udp6_attach errno =3D %d-%s", errno, strerror(e=
rrno));
             sofree(so);
             goto bad;
         }
@@ -119,7 +118,7 @@ void udp6_input(struct mbuf *m)
         m->m_len +=3D iphlen;
         m->m_data -=3D iphlen;
         *ip =3D save_ip;
-        DEBUG_MISC("udp tx errno =3D %d-%s\n", errno, strerror(errno));
+        DEBUG_MISC("udp tx errno =3D %d-%s", errno, strerror(errno));
         icmp6_send_error(m, ICMP6_UNREACH, ICMP6_UNREACH_NO_ROUTE);
         goto bad;
     }
--=20
2.20.0.rc1
