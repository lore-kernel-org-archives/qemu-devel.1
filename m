Received: from eggs.gnu.org ([2001:4830:134:3::10]:41767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fEVMV-0001gp-5Y
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fEVMS-0007x2-Ln
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:42:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49014 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fEVMS-0007w4-GW
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:42:36 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  4 May 2018 15:42:05 +0800
Message-Id: <20180504074207.22634-3-famz@redhat.com>
In-Reply-To: <20180504074207.22634-1-famz@redhat.com>
References: <20180504074207.22634-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 2/4] slirp: Use QAPI enum to replace TCPS_*
 macros
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

This is a mechanical patch that does search-and-replace and adding
necessary "#include" for pulling in the QAPI enum definition. The string
lookup could use the QAPI helper, and is left for the next patch.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 slirp/misc.c      |  23 ++++++------
 slirp/tcp.h       |  21 ++---------
 slirp/tcp_input.c | 103 +++++++++++++++++++++++++++---------------------------
 slirp/tcp_subr.c  |  25 ++++++-------
 slirp/tcp_timer.c |   7 ++--
 5 files changed, 84 insertions(+), 95 deletions(-)

diff --git a/slirp/misc.c b/slirp/misc.c
index 260187b6b6..ee617bc3c4 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -11,6 +11,7 @@
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qapi/qapi-commands-net.h"
 
 #ifdef DEBUG
 int slirp_debug = DBG_CALL|DBG_MISC|DBG_ERROR;
@@ -208,17 +209,17 @@ fork_exec(struct socket *so, const char *ex, int do_pty)
 void slirp_connection_info(Slirp *slirp, Monitor *mon)
 {
     const char * const tcpstates[] = {
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
+        [USERNET_TCP_STATE_CLOSED]       = "CLOSED",
+        [USERNET_TCP_STATE_LISTEN]       = "LISTEN",
+        [USERNET_TCP_STATE_SYN_SENT]     = "SYN_SENT",
+        [USERNET_TCP_STATE_SYN_RECEIVED] = "SYN_RCVD",
+        [USERNET_TCP_STATE_ESTABLISHED]  = "ESTABLISHED",
+        [USERNET_TCP_STATE_CLOSE_WAIT]   = "CLOSE_WAIT",
+        [USERNET_TCP_STATE_FIN_WAIT_1]   = "FIN_WAIT_1",
+        [USERNET_TCP_STATE_CLOSING]      = "CLOSING",
+        [USERNET_TCP_STATE_LAST_ACK]     = "LAST_ACK",
+        [USERNET_TCP_STATE_FIN_WAIT_2]   = "FIN_WAIT_2",
+        [USERNET_TCP_STATE_TIME_WAIT]    = "TIME_WAIT",
     };
     struct in_addr dst_addr;
     struct sockaddr_in src;
diff --git a/slirp/tcp.h b/slirp/tcp.h
index 174d3d960c..f766e684e6 100644
--- a/slirp/tcp.h
+++ b/slirp/tcp.h
@@ -133,24 +133,9 @@ struct tcphdr {
 
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
-#define TCPS_HAVERCVDSYN(s)     ((s) >= TCPS_SYN_RECEIVED)
-#define TCPS_HAVEESTABLISHED(s) ((s) >= TCPS_ESTABLISHED)
-#define TCPS_HAVERCVDFIN(s)     ((s) >= TCPS_TIME_WAIT)
+#define TCPS_HAVERCVDSYN(s)     ((s) >= USERNET_TCP_STATE_SYN_RECEIVED)
+#define TCPS_HAVEESTABLISHED(s) ((s) >= USERNET_TCP_STATE_ESTABLISHED)
+#define TCPS_HAVERCVDFIN(s)     ((s) >= USERNET_TCP_STATE_TIME_WAIT)
 
 /*
  * TCP sequence numbers are 32 bit integers operated
diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
index 07bcbdb2dd..c8b0c9db03 100644
--- a/slirp/tcp_input.c
+++ b/slirp/tcp_input.c
@@ -41,6 +41,7 @@
 #include "qemu/osdep.h"
 #include "slirp.h"
 #include "ip_icmp.h"
+#include "qapi/qapi-commands-net.h"
 
 #define	TCPREXMTTHRESH 3
 
@@ -64,7 +65,7 @@
 #define TCP_REASS(tp, ti, m, so, flags) {\
        if ((ti)->ti_seq == (tp)->rcv_nxt && \
            tcpfrag_list_empty(tp) && \
-           (tp)->t_state == TCPS_ESTABLISHED) {\
+           (tp)->t_state == USERNET_TCP_STATE_ESTABLISHED) {\
                if (ti->ti_flags & TH_PUSH) \
                        tp->t_flags |= TF_ACKNOW; \
                else \
@@ -84,7 +85,7 @@
 #define	TCP_REASS(tp, ti, m, so, flags) { \
 	if ((ti)->ti_seq == (tp)->rcv_nxt && \
         tcpfrag_list_empty(tp) && \
-	    (tp)->t_state == TCPS_ESTABLISHED) { \
+	    (tp)->t_state == USERNET_TCP_STATE_ESTABLISHED) { \
 		tp->t_flags |= TF_DELACK; \
 		(tp)->rcv_nxt += (ti)->ti_len; \
 		flags = (ti)->ti_flags & TH_FIN; \
@@ -189,7 +190,7 @@ present:
 	ti = tcpfrag_list_first(tp);
 	if (tcpfrag_list_end(ti, tp) || ti->ti_seq != tp->rcv_nxt)
 		return (0);
-	if (tp->t_state == TCPS_SYN_RECEIVED && ti->ti_len)
+	if (tp->t_state == USERNET_TCP_STATE_SYN_RECEIVED && ti->ti_len)
 		return (0);
 	do {
 		tp->rcv_nxt += ti->ti_len;
@@ -456,7 +457,7 @@ findso:
 	  }
 
 	  tp = sototcpcb(so);
-	  tp->t_state = TCPS_LISTEN;
+	  tp->t_state = USERNET_TCP_STATE_LISTEN;
 	}
 
         /*
@@ -472,7 +473,7 @@ findso:
 	/* XXX Should never fail */
         if (tp == NULL)
 		goto dropwithreset;
-	if (tp->t_state == TCPS_CLOSED)
+	if (tp->t_state == USERNET_TCP_STATE_CLOSED)
 		goto drop;
 
 	tiwin = ti->ti_win;
@@ -491,7 +492,7 @@ findso:
 	 * Process options if not in LISTEN state,
 	 * else do it below (after getting remote address).
 	 */
-	if (optp && tp->t_state != TCPS_LISTEN)
+	if (optp && tp->t_state != USERNET_TCP_STATE_LISTEN)
 		tcp_dooptions(tp, (u_char *)optp, optlen, ti);
 
 	/*
@@ -512,7 +513,7 @@ findso:
 	 * eg: the tiwin == tp->snd_wnd prevents many more
 	 * predictions.. with no *real* advantage..
 	 */
-	if (tp->t_state == TCPS_ESTABLISHED &&
+	if (tp->t_state == USERNET_TCP_STATE_ESTABLISHED &&
 	    (tiflags & (TH_SYN|TH_FIN|TH_RST|TH_URG|TH_ACK)) == TH_ACK &&
 	    ti->ti_seq == tp->rcv_nxt &&
 	    tiwin && tiwin == tp->snd_wnd &&
@@ -614,7 +615,7 @@ findso:
 	 * Enter SYN_RECEIVED state, and process any other fields of this
 	 * segment in this state.
 	 */
-	case TCPS_LISTEN: {
+	case USERNET_TCP_STATE_LISTEN: {
 
 	  if (tiflags & TH_RST)
 	    goto drop;
@@ -725,7 +726,7 @@ findso:
 	    so->so_m = m;
 	    so->so_ti = ti;
 	    tp->t_timer[TCPT_KEEP] = TCPTV_KEEP_INIT;
-	    tp->t_state = TCPS_SYN_RECEIVED;
+	    tp->t_state = USERNET_TCP_STATE_SYN_RECEIVED;
 	    /*
 	     * Initialize receive sequence numbers now so that we can send a
 	     * valid RST if the remote end rejects our connection.
@@ -759,10 +760,10 @@ findso:
 	  tcp_sendseqinit(tp);
 	  tcp_rcvseqinit(tp);
 	  tp->t_flags |= TF_ACKNOW;
-	  tp->t_state = TCPS_SYN_RECEIVED;
+	  tp->t_state = USERNET_TCP_STATE_SYN_RECEIVED;
 	  tp->t_timer[TCPT_KEEP] = TCPTV_KEEP_INIT;
 	  goto trimthenstep6;
-	} /* case TCPS_LISTEN */
+	} /* case USERNET_TCP_STATE_LISTEN */
 
 	/*
 	 * If the state is SYN_SENT:
@@ -776,7 +777,7 @@ findso:
 	 *	arrange for segment to be acked (eventually)
 	 *	continue processing rest of data/controls, beginning with URG
 	 */
-	case TCPS_SYN_SENT:
+	case USERNET_TCP_STATE_SYN_SENT:
 		if ((tiflags & TH_ACK) &&
 		    (SEQ_LEQ(ti->ti_ack, tp->iss) ||
 		     SEQ_GT(ti->ti_ack, tp->snd_max)))
@@ -803,7 +804,7 @@ findso:
 		tp->t_flags |= TF_ACKNOW;
 		if (tiflags & TH_ACK && SEQ_GT(tp->snd_una, tp->iss)) {
 			soisfconnected(so);
-			tp->t_state = TCPS_ESTABLISHED;
+			tp->t_state = USERNET_TCP_STATE_ESTABLISHED;
 
 			(void) tcp_reass(tp, (struct tcpiphdr *)0,
 				(struct mbuf *)0);
@@ -814,7 +815,7 @@ findso:
 			if (tp->t_rtt)
 				tcp_xmit_timer(tp, tp->t_rtt);
 		} else
-			tp->t_state = TCPS_SYN_RECEIVED;
+			tp->t_state = USERNET_TCP_STATE_SYN_RECEIVED;
 
 trimthenstep6:
 		/*
@@ -884,7 +885,7 @@ trimthenstep6:
 	 * user processes are gone, then RST the other end.
 	 */
 	if ((so->so_state & SS_NOFDREF) &&
-	    tp->t_state > TCPS_CLOSE_WAIT && ti->ti_len) {
+	    tp->t_state > USERNET_TCP_STATE_CLOSE_WAIT && ti->ti_len) {
 		tp = tcp_close(tp);
 		goto dropwithreset;
 	}
@@ -903,7 +904,7 @@ trimthenstep6:
 			 * are above the previous ones.
 			 */
 			if (tiflags & TH_SYN &&
-			    tp->t_state == TCPS_TIME_WAIT &&
+			    tp->t_state == USERNET_TCP_STATE_TIME_WAIT &&
 			    SEQ_GT(ti->ti_seq, tp->rcv_nxt)) {
 				iss = tp->rcv_nxt + TCP_ISSINCR;
 				tp = tcp_close(tp);
@@ -939,18 +940,18 @@ trimthenstep6:
 	 */
 	if (tiflags&TH_RST) switch (tp->t_state) {
 
-	case TCPS_SYN_RECEIVED:
-	case TCPS_ESTABLISHED:
-	case TCPS_FIN_WAIT_1:
-	case TCPS_FIN_WAIT_2:
-	case TCPS_CLOSE_WAIT:
-		tp->t_state = TCPS_CLOSED;
+	case USERNET_TCP_STATE_SYN_RECEIVED:
+	case USERNET_TCP_STATE_ESTABLISHED:
+	case USERNET_TCP_STATE_FIN_WAIT_1:
+	case USERNET_TCP_STATE_FIN_WAIT_2:
+	case USERNET_TCP_STATE_CLOSE_WAIT:
+		tp->t_state = USERNET_TCP_STATE_CLOSED;
                 tcp_close(tp);
 		goto drop;
 
-	case TCPS_CLOSING:
-	case TCPS_LAST_ACK:
-	case TCPS_TIME_WAIT:
+	case USERNET_TCP_STATE_CLOSING:
+	case USERNET_TCP_STATE_LAST_ACK:
+	case USERNET_TCP_STATE_TIME_WAIT:
                 tcp_close(tp);
 		goto drop;
 	}
@@ -978,12 +979,12 @@ trimthenstep6:
 	 * ESTABLISHED state and continue processing, otherwise
 	 * send an RST.  una<=ack<=max
 	 */
-	case TCPS_SYN_RECEIVED:
+	case USERNET_TCP_STATE_SYN_RECEIVED:
 
 		if (SEQ_GT(tp->snd_una, ti->ti_ack) ||
 		    SEQ_GT(ti->ti_ack, tp->snd_max))
 			goto dropwithreset;
-		tp->t_state = TCPS_ESTABLISHED;
+		tp->t_state = USERNET_TCP_STATE_ESTABLISHED;
 		/*
 		 * The sent SYN is ack'ed with our sequence number +1
 		 * The first data byte already in the buffer will get
@@ -1003,7 +1004,7 @@ trimthenstep6:
 		    so->so_state |= SS_NOFDREF; /* CTL_CMD */
 		  } else {
 		    needoutput = 1;
-		    tp->t_state = TCPS_FIN_WAIT_1;
+		    tp->t_state = USERNET_TCP_STATE_FIN_WAIT_1;
 		  }
 		} else {
 		  soisfconnected(so);
@@ -1023,13 +1024,13 @@ trimthenstep6:
 	 * data from the retransmission queue.  If this ACK reflects
 	 * more up to date window information we update our window information.
 	 */
-	case TCPS_ESTABLISHED:
-	case TCPS_FIN_WAIT_1:
-	case TCPS_FIN_WAIT_2:
-	case TCPS_CLOSE_WAIT:
-	case TCPS_CLOSING:
-	case TCPS_LAST_ACK:
-	case TCPS_TIME_WAIT:
+	case USERNET_TCP_STATE_ESTABLISHED:
+	case USERNET_TCP_STATE_FIN_WAIT_1:
+	case USERNET_TCP_STATE_FIN_WAIT_2:
+	case USERNET_TCP_STATE_CLOSE_WAIT:
+	case USERNET_TCP_STATE_CLOSING:
+	case USERNET_TCP_STATE_LAST_ACK:
+	case USERNET_TCP_STATE_TIME_WAIT:
 
 		if (SEQ_LEQ(ti->ti_ack, tp->snd_una)) {
 			if (ti->ti_len == 0 && tiwin == tp->snd_wnd) {
@@ -1160,7 +1161,7 @@ trimthenstep6:
 		 * for the ESTABLISHED state if our FIN is now acknowledged
 		 * then enter FIN_WAIT_2.
 		 */
-		case TCPS_FIN_WAIT_1:
+		case USERNET_TCP_STATE_FIN_WAIT_1:
 			if (ourfinisacked) {
 				/*
 				 * If we can't receive any more
@@ -1172,7 +1173,7 @@ trimthenstep6:
 				if (so->so_state & SS_FCANTRCVMORE) {
 					tp->t_timer[TCPT_2MSL] = TCP_MAXIDLE;
 				}
-				tp->t_state = TCPS_FIN_WAIT_2;
+				tp->t_state = USERNET_TCP_STATE_FIN_WAIT_2;
 			}
 			break;
 
@@ -1182,9 +1183,9 @@ trimthenstep6:
 		 * then enter the TIME-WAIT state, otherwise ignore
 		 * the segment.
 		 */
-		case TCPS_CLOSING:
+		case USERNET_TCP_STATE_CLOSING:
 			if (ourfinisacked) {
-				tp->t_state = TCPS_TIME_WAIT;
+				tp->t_state = USERNET_TCP_STATE_TIME_WAIT;
 				tcp_canceltimers(tp);
 				tp->t_timer[TCPT_2MSL] = 2 * TCPTV_MSL;
 			}
@@ -1196,7 +1197,7 @@ trimthenstep6:
 		 * If our FIN is now acknowledged, delete the TCB,
 		 * enter the closed state and return.
 		 */
-		case TCPS_LAST_ACK:
+		case USERNET_TCP_STATE_LAST_ACK:
 			if (ourfinisacked) {
                                 tcp_close(tp);
 				goto drop;
@@ -1208,7 +1209,7 @@ trimthenstep6:
 		 * is a retransmission of the remote FIN.  Acknowledge
 		 * it and restart the finack timer.
 		 */
-		case TCPS_TIME_WAIT:
+		case USERNET_TCP_STATE_TIME_WAIT:
 			tp->t_timer[TCPT_2MSL] = 2 * TCPTV_MSL;
 			goto dropafterack;
 		}
@@ -1316,7 +1317,7 @@ dodata:
                          * Shutdown the socket if there is no rx data in the
 			 * buffer.
 			 * soread() is called on completion of shutdown() and
-			 * will got to TCPS_LAST_ACK, and use tcp_output()
+			 * will got to USERNET_TCP_STATE_LAST_ACK, and use tcp_output()
 			 * to send the FIN.
 			 */
 			sofwdrain(so);
@@ -1330,20 +1331,20 @@ dodata:
 		 * In SYN_RECEIVED and ESTABLISHED STATES
 		 * enter the CLOSE_WAIT state.
 		 */
-		case TCPS_SYN_RECEIVED:
-		case TCPS_ESTABLISHED:
+		case USERNET_TCP_STATE_SYN_RECEIVED:
+		case USERNET_TCP_STATE_ESTABLISHED:
 		  if(so->so_emu == EMU_CTL)        /* no shutdown on socket */
-		    tp->t_state = TCPS_LAST_ACK;
+		    tp->t_state = USERNET_TCP_STATE_LAST_ACK;
 		  else
-		    tp->t_state = TCPS_CLOSE_WAIT;
+		    tp->t_state = USERNET_TCP_STATE_CLOSE_WAIT;
 		  break;
 
 	 	/*
 		 * If still in FIN_WAIT_1 STATE FIN has not been acked so
 		 * enter the CLOSING state.
 		 */
-		case TCPS_FIN_WAIT_1:
-			tp->t_state = TCPS_CLOSING;
+		case USERNET_TCP_STATE_FIN_WAIT_1:
+			tp->t_state = USERNET_TCP_STATE_CLOSING;
 			break;
 
 	 	/*
@@ -1351,8 +1352,8 @@ dodata:
 		 * starting the time-wait timer, turning off the other
 		 * standard timers.
 		 */
-		case TCPS_FIN_WAIT_2:
-			tp->t_state = TCPS_TIME_WAIT;
+		case USERNET_TCP_STATE_FIN_WAIT_2:
+			tp->t_state = USERNET_TCP_STATE_TIME_WAIT;
 			tcp_canceltimers(tp);
 			tp->t_timer[TCPT_2MSL] = 2 * TCPTV_MSL;
 			break;
@@ -1360,7 +1361,7 @@ dodata:
 		/*
 		 * In TIME_WAIT state restart the 2 MSL time_wait timer.
 		 */
-		case TCPS_TIME_WAIT:
+		case USERNET_TCP_STATE_TIME_WAIT:
 			tp->t_timer[TCPT_2MSL] = 2 * TCPTV_MSL;
 			break;
 		}
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index da0d53743f..8dd5a70044 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -40,6 +40,7 @@
 
 #include "qemu/osdep.h"
 #include "slirp.h"
+#include "qapi/qapi-commands-net.h"
 
 /* patchable/settable parameters for tcp */
 /* Don't do rfc1323 performance enhancements */
@@ -282,7 +283,7 @@ tcp_newtcpcb(struct socket *so)
 
 	tp->snd_cwnd = TCP_MAXWIN << TCP_MAX_WINSHIFT;
 	tp->snd_ssthresh = TCP_MAXWIN << TCP_MAX_WINSHIFT;
-	tp->t_state = TCPS_CLOSED;
+	tp->t_state = USERNET_TCP_STATE_CLOSED;
 
 	so->so_tcpcb = tp;
 
@@ -301,7 +302,7 @@ struct tcpcb *tcp_drop(struct tcpcb *tp, int err)
 	DEBUG_ARG("errno = %d", errno);
 
 	if (TCPS_HAVERCVDSYN(tp->t_state)) {
-		tp->t_state = TCPS_CLOSED;
+		tp->t_state = USERNET_TCP_STATE_CLOSED;
 		(void) tcp_output(tp);
 	}
 	return (tcp_close(tp));
@@ -371,20 +372,20 @@ tcp_sockclosed(struct tcpcb *tp)
 
 	switch (tp->t_state) {
 
-	case TCPS_CLOSED:
-	case TCPS_LISTEN:
-	case TCPS_SYN_SENT:
-		tp->t_state = TCPS_CLOSED;
+	case USERNET_TCP_STATE_CLOSED:
+	case USERNET_TCP_STATE_LISTEN:
+	case USERNET_TCP_STATE_SYN_SENT:
+		tp->t_state = USERNET_TCP_STATE_CLOSED;
 		tp = tcp_close(tp);
 		break;
 
-	case TCPS_SYN_RECEIVED:
-	case TCPS_ESTABLISHED:
-		tp->t_state = TCPS_FIN_WAIT_1;
+	case USERNET_TCP_STATE_SYN_RECEIVED:
+	case USERNET_TCP_STATE_ESTABLISHED:
+		tp->t_state = USERNET_TCP_STATE_FIN_WAIT_1;
 		break;
 
-	case TCPS_CLOSE_WAIT:
-		tp->t_state = TCPS_LAST_ACK;
+	case USERNET_TCP_STATE_CLOSE_WAIT:
+		tp->t_state = USERNET_TCP_STATE_LAST_ACK;
 		break;
 	}
 	tcp_output(tp);
@@ -513,7 +514,7 @@ void tcp_connect(struct socket *inso)
 
     tcp_template(tp);
 
-    tp->t_state = TCPS_SYN_SENT;
+    tp->t_state = USERNET_TCP_STATE_SYN_SENT;
     tp->t_timer[TCPT_KEEP] = TCPTV_KEEP_INIT;
     tp->iss = slirp->tcp_iss;
     slirp->tcp_iss += TCP_ISSINCR/2;
diff --git a/slirp/tcp_timer.c b/slirp/tcp_timer.c
index 52ef5f9100..d45dfe2da8 100644
--- a/slirp/tcp_timer.c
+++ b/slirp/tcp_timer.c
@@ -32,6 +32,7 @@
 
 #include "qemu/osdep.h"
 #include "slirp.h"
+#include "qapi/qapi-commands-net.h"
 
 static struct tcpcb *tcp_timers(register struct tcpcb *tp, int timer);
 
@@ -135,7 +136,7 @@ tcp_timers(register struct tcpcb *tp, int timer)
 	 * control block.  Otherwise, check again in a bit.
 	 */
 	case TCPT_2MSL:
-		if (tp->t_state != TCPS_TIME_WAIT &&
+		if (tp->t_state != USERNET_TCP_STATE_TIME_WAIT &&
 		    tp->t_idle <= TCP_MAXIDLE)
 			tp->t_timer[TCPT_2MSL] = TCPTV_KEEPINTVL;
 		else
@@ -259,10 +260,10 @@ tcp_timers(register struct tcpcb *tp, int timer)
 	 * or drop connection if idle for too long.
 	 */
 	case TCPT_KEEP:
-		if (tp->t_state < TCPS_ESTABLISHED)
+		if (tp->t_state < USERNET_TCP_STATE_ESTABLISHED)
 			goto dropit;
 
-		if ((SO_OPTIONS) && tp->t_state <= TCPS_CLOSE_WAIT) {
+		if ((SO_OPTIONS) && tp->t_state <= USERNET_TCP_STATE_CLOSE_WAIT) {
 		    	if (tp->t_idle >= TCPTV_KEEP_IDLE + TCP_MAXIDLE)
 				goto dropit;
 			/*
-- 
2.14.3
