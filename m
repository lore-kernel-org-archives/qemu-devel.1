Received: from eggs.gnu.org ([2001:4830:134:3::10]:33921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dwBKp-0004Z2-7o
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 14:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dwBKm-00058O-PO
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 14:08:55 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:49414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1dwBKm-00057g-F8
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 14:08:52 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 24 Sep 2017 20:08:47 +0200
Message-Id: <20170924180848.19168-3-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170924180848.19168-1-samuel.thibault@ens-lyon.org>
References: <20170924180848.19168-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 2/3] slirp: Fix intermittent send queue hangs on
 a socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Cernekee <cernekee@chromium.org>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Kevin Cernekee <cernekee@chromium.org>

if_output() originally sent one mbuf per call and used the slirp->next_m
variable to keep track of where it left off.  But nowadays it tries to
send all of the mbufs from the fastq, and one mbuf from each session on
the batchq.  The next_m variable is both redundant and harmful: there is
a case[0] involving delayed packets in which next_m ends up pointing
to &slirp->if_batchq when an active session still exists, and this
blocks all traffic for that session until qemu is restarted.

The test case was created to reproduce a problem that was seen on
long-running Chromium OS VM tests[1] which rapidly create and
destroy ssh connections through hostfwd.

[0] https://pastebin.com/NNy6LreF
[1] https://bugs.chromium.org/p/chromium/issues/detail?id=766323

Signed-off-by: Kevin Cernekee <cernekee@chromium.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/if.c    | 51 +++++++++++++++++----------------------------------
 slirp/slirp.h |  1 -
 2 files changed, 17 insertions(+), 35 deletions(-)

diff --git a/slirp/if.c b/slirp/if.c
index 51ae0d0e9a..6262d77495 100644
--- a/slirp/if.c
+++ b/slirp/if.c
@@ -30,7 +30,6 @@ if_init(Slirp *slirp)
 {
     slirp->if_fastq.qh_link = slirp->if_fastq.qh_rlink = &slirp->if_fastq;
     slirp->if_batchq.qh_link = slirp->if_batchq.qh_rlink = &slirp->if_batchq;
-    slirp->next_m = (struct mbuf *) &slirp->if_batchq;
 }
 
 /*
@@ -100,10 +99,6 @@ if_output(struct socket *so, struct mbuf *ifm)
 		}
         } else {
 		ifq = (struct mbuf *) slirp->if_batchq.qh_rlink;
-                /* Set next_m if the queue was empty so far */
-                if ((struct quehead *) slirp->next_m == &slirp->if_batchq) {
-                    slirp->next_m = ifm;
-                }
         }
 
 	/* Create a new doubly linked list for this session */
@@ -143,21 +138,18 @@ diddit:
 }
 
 /*
- * Send a packet
- * We choose a packet based on its position in the output queues;
+ * Send one packet from each session.
  * If there are packets on the fastq, they are sent FIFO, before
- * everything else.  Otherwise we choose the first packet from the
- * batchq and send it.  the next packet chosen will be from the session
- * after this one, then the session after that one, and so on..  So,
- * for example, if there are 3 ftp session's fighting for bandwidth,
+ * everything else.  Then we choose the first packet from each
+ * batchq session (socket) and send it.
+ * For example, if there are 3 ftp sessions fighting for bandwidth,
  * one packet will be sent from the first session, then one packet
- * from the second session, then one packet from the third, then back
- * to the first, etc. etc.
+ * from the second session, then one packet from the third.
  */
 void if_start(Slirp *slirp)
 {
     uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-    bool from_batchq, next_from_batchq;
+    bool from_batchq = false;
     struct mbuf *ifm, *ifm_next, *ifqt;
 
     DEBUG_CALL("if_start");
@@ -167,26 +159,29 @@ void if_start(Slirp *slirp)
     }
     slirp->if_start_busy = true;
 
+    struct mbuf *batch_head = NULL;
+    if (slirp->if_batchq.qh_link != &slirp->if_batchq) {
+        batch_head = (struct mbuf *) slirp->if_batchq.qh_link;
+    }
+
     if (slirp->if_fastq.qh_link != &slirp->if_fastq) {
         ifm_next = (struct mbuf *) slirp->if_fastq.qh_link;
-        next_from_batchq = false;
-    } else if ((struct quehead *) slirp->next_m != &slirp->if_batchq) {
-        /* Nothing on fastq, pick up from batchq via next_m */
-        ifm_next = slirp->next_m;
-        next_from_batchq = true;
+    } else if (batch_head) {
+        /* Nothing on fastq, pick up from batchq */
+        ifm_next = batch_head;
+        from_batchq = true;
     } else {
         ifm_next = NULL;
     }
 
     while (ifm_next) {
         ifm = ifm_next;
-        from_batchq = next_from_batchq;
 
         ifm_next = ifm->ifq_next;
         if ((struct quehead *) ifm_next == &slirp->if_fastq) {
             /* No more packets in fastq, switch to batchq */
-            ifm_next = slirp->next_m;
-            next_from_batchq = true;
+            ifm_next = batch_head;
+            from_batchq = true;
         }
         if ((struct quehead *) ifm_next == &slirp->if_batchq) {
             /* end of batchq */
@@ -199,11 +194,6 @@ void if_start(Slirp *slirp)
             continue;
         }
 
-        if (ifm == slirp->next_m) {
-            /* Set which packet to send on next iteration */
-            slirp->next_m = ifm->ifq_next;
-        }
-
         /* Remove it from the queue */
         ifqt = ifm->ifq_prev;
         remque(ifm);
@@ -214,15 +204,8 @@ void if_start(Slirp *slirp)
 
             insque(next, ifqt);
             ifs_remque(ifm);
-
             if (!from_batchq) {
-                /* Next packet in fastq is from the same session */
                 ifm_next = next;
-                next_from_batchq = false;
-            } else if ((struct quehead *) slirp->next_m == &slirp->if_batchq) {
-                /* Set next_m and ifm_next if the session packet is now the
-                 * only one on batchq */
-                slirp->next_m = ifm_next = next;
             }
         }
 
diff --git a/slirp/slirp.h b/slirp/slirp.h
index 5af4f482b5..898ec9516d 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -183,7 +183,6 @@ struct Slirp {
     /* if states */
     struct quehead if_fastq;   /* fast queue (for interactive data) */
     struct quehead if_batchq;  /* queue for non-interactive data */
-    struct mbuf *next_m;    /* pointer to next mbuf to output */
     bool if_start_busy;     /* avoid if_start recursion */
 
     /* ip states */
-- 
2.14.1
