Received: from eggs.gnu.org ([2001:4830:134:3::10]:40184)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<SRS0=P3nY=72=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dl1lw-0001Vp-Li
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 19:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<SRS0=P3nY=72=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dl1lt-0007ER-Iv
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 19:42:48 -0400
Received: from sonata.ens-lyon.org ([140.77.166.138]:59873)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from
	<SRS0=P3nY=72=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dl1lt-0007Du-Bp
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 19:42:45 -0400
Date: Fri, 25 Aug 2017 01:42:41 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170824234241.5cfnuic3lmcea6xc@var.youpi.perso.aquilenet.fr>
References: <alpine.LFD.2.20.1708031718030.16909@wniryva>
	<20170823202728.dsmitbqt7bsezfgq@var.youpi.perso.aquilenet.fr>
	<alpine.LFD.2.20.1708241020570.29123@wniryva>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1708241020570.29123@wniryva>
Subject: Re: [Qemu-devel] A use-after-free in slirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, wjjzhang <wjjzhang@tencent.com>, thuth@redhat.com, qemu-devel@nongnu.org

Hello,

Thanks for the reproducer you sent me offline. Here is a fix which makes
a lot of sense and fixes the reproducer.  Could you try it with your
whole testcase?

Could somebody also review the patch?

Samuel

commit 1a3a763509fad895c907e6978ea034a5c19ee370
Author: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date:   Fri Aug 25 01:35:53 2017 +0200

    slirp: fix clearing ifq_so from pending packets
    
    The if_fastq and if_batchq contain not only packets, but queues of packets
    for the same socket. When sofree frees a socket, it thus has to clear ifq_so
    from all the packets from the queues, not only the first.
    
    Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/slirp/socket.c b/slirp/socket.c
index ecec0295a9..4203b80542 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -66,21 +66,29 @@ void
 sofree(struct socket *so)
 {
   Slirp *slirp = so->slirp;
-  struct mbuf *ifm;
-
-  for (ifm = (struct mbuf *) slirp->if_fastq.qh_link;
-       (struct quehead *) ifm != &slirp->if_fastq;
-       ifm = ifm->ifq_next) {
-    if (ifm->ifq_so == so) {
-      ifm->ifq_so = NULL;
+  struct mbuf *ifq;
+
+  for (ifq = (struct mbuf *) slirp->if_fastq.qh_link;
+       (struct quehead *) ifq != &slirp->if_fastq;
+       ifq = ifq->ifq_next) {
+    if (ifq->ifq_so == so) {
+      struct mbuf *ifm;
+      ifq->ifq_so = NULL;
+      for (ifm = ifq->ifs_next; ifm != ifq; ifm = ifm->ifs_next) {
+        ifm->ifq_so = NULL;
+      }
     }
   }
 
-  for (ifm = (struct mbuf *) slirp->if_batchq.qh_link;
-       (struct quehead *) ifm != &slirp->if_batchq;
-       ifm = ifm->ifq_next) {
-    if (ifm->ifq_so == so) {
-      ifm->ifq_so = NULL;
+  for (ifq = (struct mbuf *) slirp->if_batchq.qh_link;
+       (struct quehead *) ifq != &slirp->if_batchq;
+       ifq = ifq->ifq_next) {
+    if (ifq->ifq_so == so) {
+      struct mbuf *ifm;
+      ifq->ifq_so = NULL;
+      for (ifm = ifq->ifs_next; ifm != ifq; ifm = ifm->ifs_next) {
+        ifm->ifq_so = NULL;
+      }
     }
   }
 
